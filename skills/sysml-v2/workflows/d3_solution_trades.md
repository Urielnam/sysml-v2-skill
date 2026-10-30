# Stage 4 Playbook: Domain 3 — $N$-Candidate Trade Space, COTS Grounding, & Pugh Selection

**Target File**: `D3_SolutionCandidates.sysml`  
**Package Name**: `package D3_SolutionCandidates`

---

## 1. Full $N$-Candidate Trade Space Persistence Rule

When exploring ways to fulfill each generalized functionality (`GSF-01`..`GSF-06`):
* Generate **$N$ distinct solution candidates per functionality** (typically $N = 6$ candidates per functionality, or any user-specified $N$).
* **Persist all $N$ candidates in `D3_SolutionCandidates.sysml`** as `part def <CandidateName> :> SolutionCandidate` so that `sysml_atlas_generator.py` renders all $N$ columns in the Architectural Trade Comparison Matrices (View Rule 34).
* Assign each candidate an explicit `CandidateStatus`:
  * `CandidateStatus::Winner` (Top-scoring selected baseline for this functionality)
  * `CandidateStatus::RunnerUp` (Second-place viable alternative)
  * `CandidateStatus::Pruned` (Conceptually viable but outscored on cost/complexity/power)
  * `CandidateStatus::Rejected` (Violates hard safety, regulatory, or physical requirement)

---

## 2. Step-by-Step Execution Sequence

### Step 4.1: Generate & Evaluate $N$ Candidates per Functionality
1. Spawn **Solution Architecture & COTS Trade Specialist** subagents (up to 3 concurrently, e.g., 1 per 2 functionalities).
2. For each generalized functionality, model all $N$ candidates (`part def <Name> :> SolutionCandidate`) with:
   * `candidateId` (e.g., `"CAND-01-WIN"`, `"CAND-01-RUN"`, `"CAND-01-C3"`, etc.)
   * `candidateName`, `status`, `primaryFunctionality`
   * `bomCostUsd`, `diyAssemblyTimeMinutes`, `maturityTrl`, `verifiedDatasheetLink`
   * `rationale` (Why it won, or specific technical/economic deficit why it was pruned/rejected)
   * Environmental sensitivity profiles: `sensitivityMiddaySun`, `sensitivityFreezingFogNight`, `sensitivityHighWindStorm`, `sensitivityEmergencyEvacuation`
   * Quantitative Pugh scores (`0–100`): `pughPerformanceScore`, `pughCostScore`, `pughFeasibilityScore`, `pughMaintenanceScore`, and weighted `tradeScore`.

### Step 4.2: COTS Bill of Materials Breakdown
1. For the **Winner** and **RunnerUp** candidates (and optionally pruned candidates), declare nested `part <partUsage> : COTSComponent` blocks with real, in-stock commercial off-the-shelf hardware:
   * `partName`, `manufacturerPartNumber`, `manufacturer`, `distributor`
   * `verifiedProductLink` (Clickable URL to DigiKey, Mouser, McMaster-Carr, Adafruit, etc.)
   * `unitCostUsd`, `maturityTrl`, `assemblyTimeMinutes`, `keyTechnicalSpec`

### Step 4.3: Integrated System Baseline & Formal `satisfy` Matrix Links
1. Define the resulting integrated system (`part def Integrated<System>Candidate :> SolutionCandidate`) with `primaryFunctionality = "IntegratedSystem";` composing the winning sub-assemblies and verifying total BoM CapEx, 5-year LCC, and total DIY assembly time against `RG-06` constraints.
2. Instantiate part usages and declare explicit `satisfy <requirementUsage> by <candidateUsage>;` statements for every requirement each candidate satisfies.
   * The dynamic matrix engine in `sysml_atlas_generator.py` uses these `satisfy` statements to populate `PASS (Selected)`, `PASS (Compliant)`, and `DEFICIT / PRUNED` cells across all $N$ candidate columns in View Rule 34!

---

## 3. Final Compiler & Printable PDF Atlas Verification Gate

1. Run Spec42 validation:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
2. Run the Canonical Architecture Atlas Generator:
   ```powershell
   python "<skill_dir>/scripts/sysml_atlas_generator.py" --model-dir . --output-pdf architecture_atlas_canonical.pdf
   ```
3. Verify in the audit report:
   * **100.0% Node Coverage** and **100.0% Edge Coverage**
   * **0 Unrefined Error Blocks** (all Tier 1 abstractions have Tier 2 specializations)
   * **All $N$-Candidate Trade Matrices (Rule 34) and Master Pugh Matrix (Rule 35)** rendered with live clickable links.
