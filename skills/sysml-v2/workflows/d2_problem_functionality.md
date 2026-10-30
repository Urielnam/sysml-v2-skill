# Stage 3 Playbook: Domain 2 — Capabilities, Functionalities, & Grounded Requirements

**Target File**: `D2_Capabilities.sysml`  
**Package Name**: `package D2_Capabilities`

---

## 1. Strict Model-as-Truth Rule (Zero Intermediate HTML)

All literature research, physics equations, industry standards, empirical benchmarks, compliance margins, and Crossref DOIs must be written **directly into `D2_Capabilities.sysml` attributes**. Never generate standalone `.html` research files.

---

## 2. Step-by-Step Execution Sequence

### Step 3.1: Solution-Neutral Capabilities (User Stories $\rightarrow$ 5–7 Generalized Capabilities)
1. Spawn a **Capability Architect** subagent with `D1` Goals and `D5` ConOps.
2. For each stakeholder goal, extract solution-neutral, stakeholder-oriented capabilities via user stories (`"As a <Stakeholder>, I need the system to be able to <Capability> so that <Goal>"`).
3. Cluster into **5–7 Generalized System Capabilities** (`CAP-01`..`CAP-06`, `action def <CapName> :> SystemCapability`).
4. Commit both Tier 1 (`:> SystemCapability`) and Tier 2 Specific Capabilities (`:> <GeneralizedCapability>`).
5. Bind each capability to its D1 Goal (`attribute :>> addressesGoal = "<GoalName>";`) and its downstream functionalities (`attribute :>> decomposesToFunctionalities = "<Func1> | <Func2>";`).

### Step 3.2: Problem-Solving System Functionalities (Specific $\rightarrow$ 5–7 Generalized Functionalities)
1. Spawn a **Functional Decomposition Specialist** subagent with the 5–7 Generalized Capabilities.
2. Decompose capabilities into specific problem-solving functions (`Verb + Noun` active syntax, e.g., `SenseAndClassifyAirspaceIntruder`, `ClampStructureWithoutPenetration`).
3. Cluster into **5–7 Generalized System Functionalities** (`GSF-01`..`GSF-06`, `action def <FuncName> :> SystemFunctionality`).
4. Commit both Tier 1 (`:> SystemFunctionality`) and Tier 2 Specific Functionalities (`:> <GeneralizedFunctionality>`).
5. Bind each functionality to its parent capability (`attribute :>> parentCapability = "<CapName>";`) and primary requirement group (`attribute :>> requirementGroup = "RG-01";`).

### Step 3.3: Quantitative System Requirements & Academic/Industrial Grounding
1. Define **5–7 Requirement Groups** (`RG-01`..`RG-06`, `requirement def <GroupName> :> RequirementGroup`), including a dedicated **System Feasibility, Life Cycle Cost & Ownership Group** (`RG-06`).
2. Spawn up to 3 **Requirements & Physics Research Specialist** subagents (in batches of $\le 3$) to formulate **5–9 testable quantitative requirements per group** (`REQ-TECH-01`..`REQ-FEAS-05`, `requirement def <ReqName> :> SystemRequirement`).
3. Every `SystemRequirement` **MUST** populate the complete 13-attribute contract:
   * `reqId`: Short identifier (e.g., `"REQ-TECH-01"`).
   * `statement`: ASD-STE100 imperative (`"The system shall <verb> <measurable target> under <operational condition>."`).
   * `quantitativeMetric`: Bounded numeric target with SI units and tolerances.
   * `verificationMethod`: `"Test"`, `"Analysis"`, `"Inspection"`, or `"Demonstration"`.
   * `standardOrCitation`: Governing ISO/IEC/MIL/IEEE standard or peer-reviewed paper.
   * `doiOrUrl`: Active clickable `https://doi.org/...` or manufacturer datasheet URL.
   * `atomicSpec`: Verified real-world hardware/physics parameters from literature.
   * `physicsFormula`: Governing mathematical equation proving physical feasibility.
   * `verifiedBenchmark`: Achieved performance of benchmark hardware.
   * `complianceMargin`: Quantitative headroom calculation ($\Delta = \text{Achieved} - \text{Required}$).
   * `requirementGroup`: Group ID (`"RG-01"`..`"RG-06"`).
   * `allocatedFunctionality`: Target functionality (`"SenseAndClassifyAirspaceIntruder"` or `"IntegratedSystem"`).
   * `parentNeed`: D1 Operational Need (`"NonHabituatingSpatialDeterrence"`).

---

## 3. Stage 3 Validation Gate

Run the Spec42 compiler check:
```powershell
& "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
```
Confirm **0 errors and 0 warnings** before proceeding to Domain 3.
