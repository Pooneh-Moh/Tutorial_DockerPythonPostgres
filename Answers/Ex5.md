# Goal: to define an algorithm by elaborating on its temporal and spatial complexity
I think for this specefic problem, both linear and binary search are the wrong options and very bad idea. We need somthing fast and efficient. That's where hashing comes into the place. The same way the username and passords are being checked in the websites. So, I think maybe Bloom filter can be the kind of algorithm for this application. 

**what are bloom filters?**:
First, we need to know a hash function: input and outputs a unique identifier of fixed length which is used for identification of input. 
A Bloom filter is a space-efficient probabilistic data structure that is used to test whether an element is a member of a set. 

For example, checking availability of username is set membership problem, where the set is the list of all registered username. The price we pay for efficiency is that it is probabilistic in nature that means, there might be some False Positive results. False positive means, it might tell that given username is already taken but actually it’s not. For more infor pls check @[https://www.geeksforgeeks.org/bloom-filters-introduction-and-python-implementation/].BFs have been recently used to resolve biometric issues @[https://arxiv.org/pdf/1804.04777.pdf]

In this reference, you can see the implimentation of the algorithm in C++ and python as well as a deep overview about the advantages, limitations and applications of this algorithm. This is a result of my serach for this soecefic application. 

**Define also the spatial and temporal complexities of the proposed algorithm**

- Size of Bit Array: If expected number of elements n is known and desired false positive probability is p then the size of bit array m can be calculated as : $m = -n ln(p)/ (ln2)^2$

- Optimum number of hash functions: The number of hash functions k must be a positive integer. If m is size of bit array and n is number of elements to be inserted, then k can be calculated as : $m/n ln2$

Therefore we have:

- The Time Complexity associated with the Bloom filter data structure is O(k) during Insertion and Search Operation, where k is the number of the hash function implemented.

- Space Complexity associated with Bloom Filter Data Structure is O(m), where m is the array size.

Compared to a hash table where a single hash function is used, Bloom Filter uses multiple hash functions to avoid hash collisions.  @[https://www.iunera.com/kraken/fabric/a-gentle-introduction-to-bloom-filter/#:~:text=The%20Time%20Complexity%20associated%20with,m%20is%20the%20array%20size.]

### Describe a real infrastructure/platform that allows to execute the proposed algorithm, motivate the adoption of the infrastructure and detail it at the level of technologies and languages. Provide a network queue diagram describing the elaboration process, highlighting the computational resources (service nodes) and queues. The diagram should allow to identify the main sources of delays (e.g. networks) and the main services (e.g. computational units) affecting the performance of the algorithm.


**infrastructure/platform: Cloud-Based Architecture**

Here is a source representing the algorithm and the code in python : @cite[https://brilliant.org/wiki/bloom-filter/#:~:text=A%20bloom%20filter%20is%20a,is%20added%20to%20the%20set.] and @[https://courses.cs.washington.edu/courses/cse312/22wi/files/student_drive/9.4.pdf]

**Motivation**:
Why and where it is being used?
Bloom filters are the preferred lookup mechanism when a match address is not needed, and when (a limited number of) false positives are acceptable. This is the case in various network (security) applications, such as deep packet inspection. @[https://ieeexplore.ieee.org/document/1268997]
Optimizing large systems is incredibly satisfying. Very few things are more exciting than seeing a large baseline shift in your metrics after a clever new algorithm is deployed. Optimization can save money, make systems easier to operate, improve developer productivity, or sometimes unlock scale that wouldn’t be possible otherwise. @[https://betterprogramming.pub/bloom-filters-beyond-probabilistic-membership-in-practice-e25942ab6093]

- Motivation example:
Consider a load-balancing scenario where a few servers allocate a continuous influx of containers to a vast pool of worker nodes, creating an oversubscription of resources. Every container request is tied to a control-plane entity, like a function in FaaS, where clustering too many similar function containers in one node may result in sub-optimal workloads due to their correlated resource usage. \\
It’s crucial to avoid duplicating the same function on a single worker. Having a real-time list of functions across ~10k rapidly changing worker nodes, each running about ~1k functions, could resolve this, but fetching this information proves challenging due to the sheer volume of data that would need to be constantly transferred.\\
Now, let’s consider a different solution. Every few seconds, each worker node creates a ~1kb bloom filter incorporating all its active function names and transmits it to placement servers. This filter aids in determining where to assign new functions, minimizing correlated workloads. This approach needs only a fraction of the data transfer compared to the previous approach while negating the complexities of delta/anti-entropy protocols or database upkeep. Counting Bloom filters can also track the number of running copies per function if you can afford more memory. @[https://betterprogramming.pub/bloom-filters-beyond-probabilistic-membership-in-practice-e25942ab6093]\\

**Implementation**
Despite the feature of easy-deployable, when BF or its variants are employed, some implementation ingredients (e.g., memory access, space utilization, computa- tion overhead) may be the bottleneck of the applications. To query an element, the accessed bits can be arbitrarily located in the bit vector, which results in O(k) memory access. For a standard BF design, roughly only half of the bits are set to 1. Besides, high-performance hash functions (e.g., RSA, SHA-1, MD-5) calls for complex computation process which may be not possible for low-end or light-weight hardware. The above measurements get even worse when the dataset contains a large number of elements. @[https://arxiv.org/pdf/1804.04777.pdf], @[P. Jiang, Y. Ji, X. Wang, J. Zhu, Y. Cheng, “Design of a multiple Bloom filter for distributed navigation routing,” IEEE Transactions on SMC: Systems, vol. 44, no. 2, pp. 254-260, 2014.], @[https://www.researchgate.net/publication/260711849_Design_of_a_Multiple_Bloom_Filter_for_Distributed_Navigation_Routing]
**A network queue diagram:** 
Client --> [API Gateway] --> [Lambda] --> [SQS] --> [Worker EC2 Instances] --> [S3 / DynamoDB]

**Source of delay**
The most important components determining the speed of Bloom filters are hash functions. @[https://www.sciencedirect.com/science/article/abs/pii/S0141933122001582].  While hash functions in Bloom filters do not require strong cryptographic properties, they do need a minimized computational delay. In this paper, the authors focus on optimizing several aspects to improve the speed through an specefic FPGA. such as: 
- Hardware: This is especially relevant for achieving high-speed lookups in network applications, where hardware acceleration can provide significant performance gains.
- Algorithm Optimization: by enhancing their speed and accuracy while maintaining the probabilistic nature of the data structure
- Architectural Improvements: This includes techniques to reduce memory requirements, improve parallelism, and minimize access delays.


