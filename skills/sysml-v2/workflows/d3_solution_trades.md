# Stage 4 Playbook: Domain 3 — Progressive Execution of $N$-Candidate Trade Space & Pugh Selection

**Target File**: `D3_SolutionCandidates.sysml`  
**Package Name**: `package D3_SolutionCandidates`

---

## 1. CRITICAL EXECUTION RULE: Strict Micro-Step Sequentiality

Domain 3 consists of **2 strictly sequential micro-steps**:
$$\text{4.1 } N\text{-Candidate Generation & COTS Grounding} \xrightarrow{\text{commit + spec42}} \text{4.2 Pugh Selection, Integrated Baseline & Satisfy Matrix}$$

* **NEVER** start Step 4.1 until `D2_Capabilities.sysml` (with all Functionalities and Requirements) has been committed and validated by `spec42 check .` with 0 errors!
* **NEVER** synthesize the Integrated System Baseline (Step 4.2) until all $N$ candidates per functionality from Step 4.1 have been evaluated, written to `D3_SolutionCandidates.sysml`, and validated by `spec42 check .`!

---

## 2. Progressive Micro-Step Sequence

### Micro-Step 4.1: Generate & Persist $N$ Candidates per Functionality + COTS BoMs
1. **Spawn (Horizontal Parallelism Allowed — Up to 3 Concurrent Subagents)**:
   * Passing the validated Functionalities and Requirements from `D2_Capabilities.sysml`, spawn up to 3 **Solution Architecture & COTS Trade Specialist** subagents in parallel (e.g., Agent 1 for `GSF-01..02`, Agent 2 for `GSF-03..04`, Agent 3 for `GSF-05..06`).
   * Wait for all subagents in the batch to finish before proceeding.
2. **Process Output**:
   * For each generalized functionality, generate **$N$ distinct solution candidates** (default $N = 6$ per functionality, or any user-specified $N$).
   * Persist **all $N$ candidates** as `part def <CandidateName> :> SolutionCandidate` with:
     * `candidateId`, `candidateName`, `status` (`Winner`, `RunnerUp`, `Pruned`, `Rejected`), `primaryFunctionality`
     * `bomCostUsd`, `diyAssemblyTimeMinutes`, `maturityTrl`, `verifiedDatasheetLink`, `rationale`
     * Environmental sensitivity profiles (`sensitivityMiddaySun`, `sensitivityFreezingFogNight`, `sensitivityHighWindStorm`, `sensitivityEmergencyEvacuation`)
     * Quantitative Pugh scores (`pughPerformanceScore`, `pughCostScore`, `pughFeasibilityScore`, `pughMaintenanceScore`, `tradeScore`)
   * For `Winner` and `RunnerUp` candidates, include nested `part <partUsage> : COTSComponent` blocks with real MPNs, distributors, unit prices, and clickable product links.
3. **Commit to `D3_SolutionCandidates.sysml` & Run Hard Gate 4.1**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors.** Only after this passes may you start Micro-Step 4.2.

---

### Micro-Step 4.2: Integrated System Baseline & Formal `satisfy` Traceability Matrix
1. **Synthesize & Commit**:
   * Define `part def Integrated<System>Candidate :> SolutionCandidate` (`primaryFunctionality = "IntegratedSystem"`) composing the winning modular sub-assemblies from Micro-Step 4.1, rolling up total BoM CapEx, 5-year LCC, and total DIY assembly time against `RG-06`.
   * Instantiate candidate part usages (`part <candUsage> : <CandDef> { perform <funcUsage>; }`) and declare explicit `satisfy <requirementUsage> by <candidateUsage>;` statements for every requirement each candidate satisfies.
2. **Hard Gate 4.2 (Validate Complete Workspace)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors and 0 warnings.**

---

## 3. Final Printable Vector PDF Architecture Atlas Gate

Once Gate 4.2 passes with 0 errors, run the bundled Atlas Generator:
```powershell
python "C:\Users\yurie\.gemini\config\plugins\sysml-v2\skills\sysml-v2\scripts\sysml_atlas_generator.py" `
  --model-dir "." `
  --output-pdf "architecture_atlas_canonical.pdf" `
  --diagrams-dir "diagrams_canonical"
```
Confirm **100.0% Node Coverage**, **100.0% Edge Coverage**, **0 Unrefined Error Blocks**, and all **$N$-Candidate Trade Matrices (Rule 34) & Master Pugh Matrix (Rule 35)** in the compiled PDF.
