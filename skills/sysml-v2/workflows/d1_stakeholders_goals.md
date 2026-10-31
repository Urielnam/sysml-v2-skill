# Stage 1 Playbook: Domain 1 — Progressive Execution of Stakeholders $\rightarrow$ Goals $\rightarrow$ Gaps $\rightarrow$ Needs

**Target File**: `D1_StakeholdersAndNeeds.sysml`  
**Package Name**: `package D1_StakeholdersAndNeeds`

---

## 1. CRITICAL EXECUTION RULE: Strict Micro-Step Sequentiality

Domain 1 consists of **4 strictly sequential micro-steps** (`1.1 Stakeholders` $\rightarrow$ `1.2 Goals` $\rightarrow$ `1.3 Gaps` $\rightarrow$ `1.4 Needs`).

> **WARNING — DO NOT SPAWN SUBAGENTS ACROSS DIFFERENT STEPS AT THE SAME TIME:**
> * **NEVER** spawn a Goal Specialist while the Stakeholder Specialist is still running!
> * **NEVER** spawn a Gap Analyst while the Goal Specialist is still running!
> * **NEVER** spawn a Need Architect while the Gap Analyst is still running!
> * Each micro-step **MUST** finish its subagent(s), write its Tier 1 and Tier 2 definitions to `D1_StakeholdersAndNeeds.sysml`, and pass `spec42 check .` (0 errors) **before** you spawn the subagent(s) for the next micro-step!
> * **Horizontal Parallelism (Up to 3 Subagents)**: You may only spawn 2–3 concurrent subagents *within the same micro-step* (for example, in Step 1.2, after the 6 Generalized Stakeholders are already written to `D1_StakeholdersAndNeeds.sysml` and validated, you can spawn up to 3 Goal subagents in parallel where each handles 2 of the validated Stakeholders).

---

## 2. Progressive Micro-Step Sequence

### Micro-Step 1.1: Stakeholders ONLY (Specific $\rightarrow$ 5–7 Generalized Groups)
1. **Spawn**: Launch **only** the **Stakeholder Discovery Specialist** subagent with the framing sentence:
   `[Beneficiary] derives value when [System] executes [Process]`.
   *(Do NOT spawn Goals, Gaps, or Needs agents yet! Stop and wait for the Stakeholder subagent to finish.)*
2. **Process Output**:
   * Ensure 20–35 specific stakeholders are generated across the full lifecycle and clustered into **5–7 Generalized Stakeholder Groups** (`STK-01`..`STK-07`).
   * Ensure lifecycle stakeholders (**Purchaser / Budget Holder**, **DIY Fabricator / Installer**, **Maintenance / Service Operator**, **Regulatory / Property Governance Authority**) are represented alongside operational users.
3. **Commit to `D1_StakeholdersAndNeeds.sysml`**:
   * Write the base metaclasses (`Stakeholder`, `OperationalGoal`, `OperationalGap`, `OperationalNeed`), the 5–7 Tier 1 Generalized Stakeholders (`part def <Group> :> Stakeholder`), and all Tier 2 Specific Stakeholders (`part def <Specific> :> <Group>`).
4. **Hard Gate 1.1 (Validate Before Proceeding)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors.** Only after this passes may you start Micro-Step 1.2.

---

### Micro-Step 1.2: Operational Goals ONLY (Derived from Validated Stakeholders)
1. **Spawn**: Passing the **exact 5–7 Generalized Stakeholders committed in Micro-Step 1.1**, spawn 1–3 **Stakeholder Goal Specialist** subagents to generate specific goals for each generalized stakeholder and cluster them into **5–7 Generalized Operational Goals** (`GOAL-01`..`GOAL-06`).
   *(Do NOT spawn Gaps or Needs agents yet! Stop and wait for the Goal subagent(s) to finish.)*
2. **Process Output**:
   * Mandate at least one **Economic / Life Cycle Cost Goal** (e.g., Total Ownership Cost, CapEx ceiling, annual OpEx ceiling) and one **Feasibility / Adoption Goal** (e.g., DIY Assembly time ceiling using standard hand tools, zero-permit non-invasive installation).
3. **Commit to `D1_StakeholdersAndNeeds.sysml`**:
   * Append the 5–7 Tier 1 Generalized Operational Goals (`requirement def <Goal> :> OperationalGoal`), linked to their stakeholders via `stakeholder <role> : <GeneralizedStakeholder>;`, and all Tier 2 Specific Goals (`requirement def <SpecificGoal> :> <Goal>`).
4. **Hard Gate 1.2 (Validate Before Proceeding)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors.** Only after this passes may you start Micro-Step 1.3.

---

### Micro-Step 1.3: Operational Gaps ONLY (Derived from Validated Goals)
1. **Spawn**: Passing the **exact 5–7 Generalized Goals committed in Micro-Step 1.2**, spawn 1–3 **Operational Gap Analyst** subagents to generate specific gaps for each goal and cluster them into **5–7 Generalized Operational Gaps** (`GAP-01`..`GAP-06`).
   *(Do NOT spawn Needs agents yet! Stop and wait for the Gap subagent(s) to finish.)*
2. **Commit to `D1_StakeholdersAndNeeds.sysml`**:
   * Append the 5–7 Tier 1 Generalized Operational Gaps (`concern def <Gap> :> OperationalGap`) with `attribute :>> obstructedGoal = "<GeneralizedGoalName>";`, plus all Tier 2 Specific Gaps (`concern def <SpecificGap> :> <Gap>`).
3. **Hard Gate 1.3 (Validate Before Proceeding)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors.** Only after this passes may you start Micro-Step 1.4.

---

### Micro-Step 1.4: Operational Needs ONLY (Derived from Validated Gaps)
1. **Spawn**: Passing the **exact 5–7 Generalized Gaps committed in Micro-Step 1.3**, spawn 1–3 **Operational Need Architect** subagents to generate specific operational needs for each gap and cluster them into **5–7 Generalized Operational Needs** (`OP-NEED-01`..`OP-NEED-06`).
   *(Wait for the Need subagent(s) to finish.)*
2. **Commit to `D1_StakeholdersAndNeeds.sysml`**:
   * Append the 5–7 Tier 1 Generalized Operational Needs (`requirement def <Need> :> OperationalNeed`) with `attribute :>> mitigatedGap = "<GeneralizedGapName>";` and `stakeholder <role> : <GeneralizedStakeholder>;`, plus all Tier 2 Specific Needs (`requirement def <SpecificNeed> :> <Need>`), and instantiate the domain usages at the bottom of `D1_StakeholdersAndNeeds.sysml`.
3. **Hard Gate 1.4 (Validate Before Proceeding to Domain 5)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors and 0 warnings.**
