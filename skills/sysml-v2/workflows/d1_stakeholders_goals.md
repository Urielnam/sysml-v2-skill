# Stage 1 Playbook: Domain 1 — Stakeholders, Goals, Gaps, and Operational Needs

**Target File**: `D1_StakeholdersAndNeeds.sysml`  
**Package Name**: `package D1_StakeholdersAndNeeds`

---

## 1. Orchestration & Subagent Spawning Rules

* **Max 3 Concurrent Subagents**: Never spawn more than 3 subagents simultaneously. Wait for a slot to free up before launching the next specialist subagent.
* **Targeted Context**: Give each subagent only the required parent artifacts (e.g., pass the framing sentence to the Stakeholder agent; pass the generalized stakeholders to the Goals agent).
* **Two-Tier Formal Inheritance Invariant**: Every subagent that brainstorms specific items and clusters them into 5–7 generalized groups **MUST** return both tiers so both are committed to `D1_StakeholdersAndNeeds.sysml`:
  * **Tier 1 (Generalized Group, 5–7 items)**: Specializes the base metaclass (`:> Stakeholder`, `:> OperationalGoal`, `:> OperationalGap`, `:> OperationalNeed`).
  * **Tier 2 (Specific Items, 3–8 per group)**: Specializes the Tier 1 Generalized Group (`:> <GeneralizedGroupName>`).
  * *Why*: Omitting Tier 2 leaves unrefined abstractions in the model, which `sysml_atlas_generator.py` flags as red `«unrefinedElementError»` diagnostic blocks in Views 12, 15, 18, and 21.

---

## 2. Step-by-Step Execution Sequence

### Step 1.1: Stakeholders (Specific $\rightarrow$ 5–7 Generalized Groups)
1. Spawn a **Stakeholder Discovery Specialist** subagent with the framing sentence:
   `[Beneficiary] derives value when [System] executes [Process]`.
2. Brainstorm 20–35 specific stakeholders across the entire system lifecycle.
3. Group them into **5–7 Generalized Stakeholder Groups** (`STK-01`..`STK-07`).
4. **Mandatory Lifecycle Coverage**: Ensure lifecycle stakeholders (**Purchaser / Budget Holder**, **DIY Fabricator / Installer**, **Maintenance / Service Operator**, **Regulatory / Property Governance Authority**) are explicitly represented alongside operational users and bystanders.
5. Commit both Tier 1 (`:> Stakeholder`) and Tier 2 (`:> <GeneralizedStakeholder>`) definitions to `D1_StakeholdersAndNeeds.sysml`.

### Step 1.2: Operational Goals (Specific $\rightarrow$ 5–7 Generalized Goals)
1. Spawn a **Stakeholder Goal Specialist** subagent with the 5–7 Generalized Stakeholders.
2. Generate specific goals for each stakeholder group and cluster them into **5–7 Generalized Operational Goals** (`GOAL-01`..`GOAL-06`, modeled as `requirement def <GoalName> :> OperationalGoal`).
3. **Mandatory Economic & Feasibility Goals**:
   * Mandate at least one **Economic / Life Cycle Cost Goal** (e.g., Total Ownership Cost, CapEx ceiling, annual OpEx ceiling).
   * Mandate at least one **Feasibility / Adoption Goal** (e.g., DIY Assembly time ceiling using standard hand tools, zero-permit non-invasive installation).
4. Formally link every generalized goal to its holding stakeholders using `stakeholder <role> : <GeneralizedStakeholder>;`.
5. Commit both Tier 1 (`:> OperationalGoal`) and Tier 2 (`:> <GeneralizedGoal>`) definitions.

### Step 1.3: Operational Gaps (Specific $\rightarrow$ 5–7 Generalized Gaps)
1. Spawn an **Operational Gap Analyst** subagent with the 5–7 Generalized Goals.
2. Identify why current commercial or ad-hoc alternatives fail to achieve those goals (physical, economic, regulatory, maintenance, or usability barriers).
3. Cluster into **5–7 Generalized Operational Gaps** (`GAP-01`..`GAP-06`, modeled as `concern def <GapName> :> OperationalGap`).
4. Bind each gap to the goal it obstructs via `attribute :>> obstructedGoal = "<GeneralizedGoalName>";`.
5. Commit both Tier 1 (`:> OperationalGap`) and Tier 2 (`:> <GeneralizedGap>`) definitions.

### Step 1.4: Operational Needs (Specific $\rightarrow$ 5–7 Generalized Needs)
1. Spawn an **Operational Need Architect** subagent with the 5–7 Generalized Gaps.
2. Derive solution-neutral operational needs that overcome each gap.
3. Cluster into **5–7 Generalized Operational Needs** (`OP-NEED-01`..`OP-NEED-06`, modeled as `requirement def <NeedName> :> OperationalNeed`).
4. Bind each need to the gap it mitigates (`attribute :>> mitigatedGap = "<GeneralizedGapName>";`) and its stakeholders (`stakeholder <role> : <GeneralizedStakeholder>;`).
5. Commit both Tier 1 (`:> OperationalNeed`) and Tier 2 (`:> <GeneralizedNeed>`) definitions.

---

## 3. Stage 1 Validation Gate

Before proceeding to Domain 5 (ConOps), run the Spec42 compiler check:
```powershell
& "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
```
Confirm **0 errors and 0 warnings**.
