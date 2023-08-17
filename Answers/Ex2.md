# Goal: to study a system through statistical methods to infer some information about its behaviour.
Consider a system as a black box: the system accepts some numeric values v1,...,vm as input (where m ∼ 15/20 parameters) and it produces a numeric value as output. Describe a realistic and “mature” statistical strategy to find (or to approximate) the parameters that maximise the output, assuming that:
- executing the system for each combination is too expensive;
- some parameters are more expensive to control than others;
- the internal behaviour of the system is unknown (e.g. randomise the internal behaviour to some extent to produce some output data to analyse).

### Answer1:
The secnario expalined here involves an optimization model of a black box where the cost is the determiestic parateter. Given the limitations discussed above, there exist some statestical options such as:
1. Bayesian Optimization:
   1.  Bayesian optimization is a highly efficient approach to optimizing objective functions which are expensive to query. These objectives are typically represented by Gaussian process (GP) surrogate models which are easy to optimize and support exact inference. \ref{arXiv:2305.20028} 
   2. Bayesian optimization (BO) is an indispensable tool to optimize objective functions that either do not have known functional forms or are expensive to evaluate. Currently, optimal experimental design is always conducted within the workflow of BO leading to more efficient exploration of the design space compared to traditional strategies. This can have a significant impact on modern scientific discovery, in particular autonomous materials discovery, which can be viewed as an optimization problem aimed at looking for the maximum (or minimum) point for the desired materials properties. The performance of BO-based experimental design depends not only on the adopted acquisition function but also on the surrogate models that help to approximate underlying objective functions @[https://doi.org/10.1038/s41524-021-00662-x]
2. Cost considaration:
   Since the parameters are expensive to control, then we need a to consider cost. Therefore, a const function that considers both the output and the cost of evaluating specefic parameters. 
3. Some parameters are more expensive than others:
   To solve this problem, maybe a PCA analysis can be interesting, because we can understand which one of parameters are more important to the model and then use those for the optimization. Other acquisition functions can be intresting as well such as choocing a Upper Confidence Bound, or expected improvement can be helpful without being too costly to compute. 

**Introduce some additional assumptions that are interesting to study from the statistical viewpoint (e.g. about the response function, the involved distributions, the impacts of some variables, etc.)**

### Answer2:
Introducing additional assumption can cause complication to the model, while providing new prespectives. Some of assumptions which I think might be intresting are:
- Noisy observations: These observations can create noise on the system output. Noise have several sources suchas measrment noise, etc. Therefore, if we could model the noise, we can overcome the challenge. 
- If we assume that the system is non-stationary: then the system's response will change over time. I think maybe for the problem of Sofia Genetics, this is not the case. (?)
- Physical constraints: Certain parameters have physical constraints or limitations. For example, the age of a person mightb never be more than 120 or certain biological parameters perhaps have an specefic ranges. Therefore, we can add them to the model. 
- Correlation between the parameters: Assuming that some parameters are correlated is not far for many bilogical cases. For example, for the problem of breast cancer, it is proven that there is a corelation between certain genes and the probaility of occuring breast cancer in a person. Another example, is the corealation of hight and weight with the gender and ... therefore, understanding these impacts can improve the model. (Maybe just like PCA we can intoduce a mautal parameter insteat of 2 or more separte ones)
- Missing data: handling the missing data due to several reasons is also important in any statestical model. 
- Multi-objective optimization: Assuming to optimize multiple confilicting objectives. For a real-case this can happen. Then we should be able to optimize the model based on the conflicting objectives. 
As a result, we need to analize the sensitivity of the model. 

'''
import random
import numpy as np
from skopt import BayesSearchCV
from skopt.space import Real

# Simulate the black-box system
def simulate_system(parameters):
    output = sum(p ** 2 for p in parameters) + random.uniform(-0.1, 0.1)
    return output

# Define parameter search space
param_space = [Real(-1, 1, name=f'param_{i}') for i in range(num_parameters)]

# Perform Bayesian Optimization with surrogate model
def bayesian_optimization(simulate_fn, num_iterations):
    optimizer = BayesSearchCV(
        simulate_fn,
        {'param_' + str(i): (-1, 1) for i in range(num_parameters)},
        n_iter=num_iterations,
        n_points=1,
        verbose=0,
        n_jobs=-1
    )
    optimizer.fit(np.zeros((1, num_parameters)), [0])  # Initial data point
    best_params = optimizer.best_params_
    best_output = -optimizer.best_score_  # Minus sign because BayesSearchCV minimizes
    return best_params, best_output

# Example configuration
num_parameters = 15
num_iterations = 50

# Perform Bayesian Optimization
best_params, best_output = bayesian_optimization(simulate_system, num_iterations)
print("Best Parameters:", best_params)
print("Maximized Output:", best_output)
'''

In this code, the 'simulate_system' function serves as the objective function that we're trying to maximize. The parameter search space is defined using the 'Real' class from 'skopt.space'. The 'bayesian_optimization' function initializes the Bayesian optimizer and performs the optimization. 'BayesSearchCV' class is from 'scikit-optimize'. 

**Elaborate on the methodology and on its robustness from the statistical point of view.**
### Methodlogy:
Bayesian Optimization is a surrogate model that approximates the behavior of the expensive-to-evaluate black-box function. Common surrogate models include Gaussian Processes (GP), Random Forests, and Bayesian Neural Networks. The references speak about this model in depth. 
### Rubustness:
Bayesian sensitivity analysis, investigates the robustness of answers from a Bayesian analysis to uncertainty about the precise details of the analysis. An answer is robust if it does not depend sensitively on the assumptions and calculation inputs on which it is based. Robust Bayes methods acknowledge that it is sometimes very difficult to come up with precise distributions to be used as priors. \\
Although robust Bayes methods are clearly inconsistent with the Bayesian idea that uncertainty should be measured by a single additive probability measure and that personal attitudes and values should always be measured by a precise utility function, they are often accepted as a matter of convenience (e.g., because the cost or schedule do not allow the more painstaking effort needed to get a precise measure and function). @[Walley, P. (1991). Statistical Reasoning with Imprecise Probabilities. Chapman and Hall, London] 