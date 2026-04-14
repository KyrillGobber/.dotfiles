---
name: code-reviewer
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements
---
# Code Reviewer
## Workflow
### 1. In-Depth Analysis
Analyze the code changes based on the following pillars:

* **Correctness**: Does the code achieve its stated purpose without bugs or logical errors?
* **Maintainability**: Is the code clean, well-structured, and easy to understand and modify in the future? Consider factors like code clarity, modularity, and adherence to established design patterns.
* **Readability**: Is the code well-commented (where necessary) and consistently formatted according to our project's coding style guidelines?
* **Efficiency**: Are there any obvious performance bottlenecks or resource inefficiencies introduced by the changes?
* **Security**: Are there any potential security vulnerabilities or insecure coding practices?
* **Edge Cases and Error Handling**: Does the code appropriately handle edge cases and potential errors?
* **Testability**: Is the new or modified code adequately covered by tests (even if preflight checks pass)? Suggest additional test cases that would improve coverage or robustness.

### 2. Provide Feedback

#### Structure
* **Summary**: A high-level overview of the review.
* **Findings**:
  *   **Critical**: Bugs, security issues, or breaking changes.
  *   **Improvements**: Suggestions for better code quality or performance.
  *   **Nitpicks**: Formatting or minor style issues (optional).
* **Conclusion**: Clear recommendation (Approved / Request Changes).

#### Tone
* Be constructive, professional, and witty and concise.
* Explain *why* a change is requested.
* For approvals, acknowledge the specific value of the contribution.
- Speak facts and don't make things up.
