# Goal: to define a project plan (from the software engineering viewpoint) to design and implement a real system, providing examples of the produced deliberables
![Alt text](Desktop/sdlc.jpeg)

As presented in the above picture, these are the common software development life cycle.
For more in depth information, please check this link:
@[https://www.tutorialspoint.com/sdlc/sdlc_overview.htm#]

**Risk-Oriented Approach:**
The Spiral Model is a systems development lifecycle (SDLC) that is the best method for risk management.
@[https://www.geeksforgeeks.org/integrating-risk-management-in-sdlc-set-1/]
**Requirements Gathering and Analysis:**
- Define and understand the problem scope, constraints, and user requirements.
- Identify potential risks related to scalability, false positives, and performance.

**System Design:**
- Design the Bloom filter structure: choose bit array size, number of hash functions, and hash function algorithms.
- Develop algorithms for adding vectors to the Bloom filter and checking membership.
- Create risk assessment reports: identify high-priority risks, their potential impact, and mitigation strategies.

**Implementation:**
- Develop and test the Bloom filter component.
- Implement mechanisms to add vectors to the Bloom filter and perform membership checks.
- Design and implement validation protocols: automated tests for accuracy, performance, and scalability.

**Testing and Validation:**
- Perform validation tests using a wide range of test cases.
- Conduct verification: ensure that the system meets the specified requirements and passes all validation tests.
- Generate validation reports: document test results, including false positive rates and system performance.

**Deployment:**
- Deploy the system in a controlled environment.
- Monitor system performance and address any unforeseen issues.
- Update risk reports based on observed behavior and performance.

**Agile Approach:**
![Alt text](Desktop/agile_SOFTWARE.png)

Agile software development uses an iterative approach to design and development. 
In Agile, teams break down lengthy requirements, build, and test phases into smaller work segments, 
which allows them to deliver software more frequently.

Agile software development is a more flexible approach than the Waterfall model's strictly set phases. As a result, 
many teams are moving toward Agile's adaptive methodology and moving away from the predictive Waterfall methodology 
when developing software. 

The conventional Waterfall development method follows strict phases, sticking to the original requirements and 
design plan created at the beginning of the project. A project manager spends time negotiating milestones, features, 
resources, working at length in the planning stages of a project, usually developing a full-blown project plan that 
details how the work will be moved through many gates to completion.
@[https://www.smartsheet.com/understanding-agile-software-development-lifecycle-and-process-workflow]
**Initial Planning:**
- Identify the core features required for a Minimum Viable Product (MVP).
- Define user stories and tasks for these features.
- Prioritize features based on user value and risk.

**Sprints:**
- Divide the development into time-boxed sprints (e.g., 2 weeks each).
- In each sprint, select user stories from the backlog for implementation.
- Implement, test, and review these user stories within the sprint.
- Conduct daily stand-up meetings to discuss progress and address any roadblocks.

**Iterative Development:**
- Regularly gather feedback from stakeholders and end-users after each sprint.
- Use feedback to refine and adjust features, ensuring they meet user needs.
- Adapt the project plan based on evolving requirements and new insights.

**Risk Management in Agile:**
- Continuously identify and prioritize risks within each sprint.
- Incorporate risk mitigation tasks as part of sprint planning.
- Address high-priority risks through iterative improvements.

**Key Decisions and Changes:**

**Risk-Oriented Approach:**
- Major Decisions: Choose the appropriate Bloom filter parameters, such as bit array size and number of hash functions, 
based on risk assessment and performance trade-offs.
- Change Scenario: If a significant risk arises during development (e.g., excessive false positives), 
the project plan might need to be revised to incorporate new mitigation strategies.

**Agile Approach:**
- Major Decisions: Prioritize features based on user value and risk. Adjust the project plan based on feedback and evolving requirements.
- Change Scenario: If user feedback reveals that certain features are less critical than anticipated, the project plan can be adapted in subsequent sprints to focus on more valuable features.

In summary, the risk-oriented approach focuses on mitigating potential issues early on, 
while the Agile approach emphasizes iterative development, user feedback, and adaptability. 
Both approaches have their merits, and the choice depends on factors like project complexity, stakeholder preferences, and the level of uncertainty. 
It's essential to carefully assess risks and engage stakeholders to make informed decisions throughout the project's lifecycle.