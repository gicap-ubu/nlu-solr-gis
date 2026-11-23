# A Modular NLU-Solr Architecture with Dynamic GIS Visual Synchronization for Conversational Spatial Search

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python: 3.9+](https://img.shields.io/badge/Python-3.9%2B-blue.svg)](https://www.python.org/)
[![SoftwareX](https://img.shields.io/badge/Elsevier-SoftwareX-orange.svg)](https://www.sciencedirect.com/journal/softwarex)
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/gicap-ubu/nlu-solr-gis)
[![Reviewer Tests: 100% Passing](https://img.shields.io/badge/Reviewer_Tests-100%25_Passing-brightgreen.svg)]()
[![Data Sovereignty: EU Compliant](https://img.shields.io/badge/Data_Sovereignty-100%25_On--Premises-blueviolet.svg)]()

> **Reference software repository and replication package for the Elsevier *SoftwareX* journal article:**  
> **"A Modular NLU-Solr Architecture with Dynamic GIS Visual Synchronization for Conversational Spatial Search"**  
> *Félix de Miguel*, *Miguel Manzanedo*, *Raquel Redondo*, *Nuño Basurto*, *Francisco J. Iglesias*, *Daniel Urda*  
> **Grupo de Inteligencia Computacional Aplicada (GICAP)**, Universidad de Burgos, Spain & **Institute of Space Sciences and Technologies of Asturias (ICTEA)**, Universidad de Oviedo, Spain.

---

## 📌 Executive Summary

This repository presents an open-source, modular, domain-agnostic software architecture that bridges conversational Natural Language Understanding (NLU), Apache Solr spatial indexing, and dynamic cartographic Geographic Information System (GIS) visualization.

As a primary real-world demonstrator, the architecture is instantiated within the European research initiative **CRMsDataSpace** (*Building a Common European Data Space on Critical Raw Materials for the Green Deal*, EU Research Fund for Coal and Steel, Grant Agreement No. 101216677). The platform maps, filters, and analyzes 100 strategic extractive waste facilities (tailings dams and waste dumps) containing Critical Raw Materials (Lithium, Cobalt, Tungsten, Nickel, Rare Earth Elements, etc.) across 12 European countries.

Additionally, to allow reviewers and developers to test the **generality and reusability** of the framework beyond European mining, this repository includes a **General-Purpose GIS Template Sandbox** ([`template/`](template/)), featuring a domain-agnostic renewable infrastructure dataset and an in-browser **Filter Studio** to create custom filters by hand.

```
+---------------------------------------------------------------------------------------------------------+
|                                    4-STAGE PIPELINE ARCHITECTURE                                        |
+---------------------------------------------------------------------------------------------------------+
| [1] Sovereign NLU Engine    --> [2] Deterministic Normalizer --> [3] Spatial Indexing  --> [4] Dynamic   |
|     - Greedy (T=0.0) Few-Shot        - Pluggable Thesaurus           - Apache Solr Spatial      GIS UI  |
|     - Strict OpenAPI JSON            - Spanish/EU Multilingual       - Bounding Box & Facets    - Leaflet|
|     - Local GPU / CPU Standalone     - Boolean Query Builder         - Grounded Evidence RAG    - Badges |
+---------------------------------------------------------------------------------------------------------+
```

### Key Architectural Highlights
- **Bidirectional Visual Synchronization**: Real-time rendering of active filter badges, dynamic glowing pulse rings on matching facilities, live site counters, and floating interactive filter controls.
- **Zero Schema Hallucinations**: Combines Few-Shot domain exemplars with strict OpenAPI JSON Schema validation under greedy decoding ($T=0.0$).
- **Zero-Dependency Standalone Mode (Reviewer Ready)**: Runs entirely out-of-the-box on standard Python 3.9+ without needing GPU hardware, external cloud accounts, or third-party database servers.
- **100% European Data Sovereignty**: Designed for institutional on-premises deployment using open-weight foundation models (Qwen 2.5 7B, Llama 3.1 8B, Mistral 7B Instruct v0.2, Phi-3 Mini 4K) under Slurm, preventing data leakage under EU Regulation 2024/1252.

---

## 🚀 Reviewer Access & Quick Start Guide

Reviewers can access and evaluate the software through two complementary modalities:

### Method 1: One-Click Cloud Execution (GitHub Codespaces)

Reviewers can launch the entire replication environment in the cloud with zero setup. Clicking the button provisions a single unified Codespace running both applications simultaneously:

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/gicap-ubu/nlu-solr-gis)

Both web applications are automatically orchestrated in parallel in the background via `.devcontainer/devcontainer.json` and `run_codespace.py`:
- 🇪🇺 **Port 8080**: **CRMsDataSpace WebApp** — Official European Critical Raw Materials demonstrator (100 facilities across 12 EU countries, multi-model NLU).
- 🌍 **Port 8085**: **General GIS Template Sandbox** — Domain-agnostic sandbox across 5 global Areas of Interest (AOIs) with in-browser **Filter Studio** to create custom filters by hand and test framework generality.

> ⏳ **Please be patient during initial startup (~1–3 minutes)**: GitHub Codespaces needs a brief moment on first launch to provision the cloud container, set up the Python environment, and start both web servers in the background. Once initialization finishes, ports `8080` and `8085` will forward automatically and open in separate browser tabs. *(If a browser popup blocker intercepts them, open the **Ports** tab in VS Code and click the globe icon next to ports `8080` and `8085`.)*

---

### Method 2: Local Command-Line Execution (Zero Setup, No GPU Required)

Both applications run locally on Windows, macOS, or Linux using **standard Python 3.9+ only** (zero external `pip` dependencies required for Standalone Mock Mode):

```bash
# 1. Clone the repository
git clone https://github.com/gicap-ubu/nlu-solr-gis.git
cd nlu-solr-gis

# 2A. Launch the European Critical Raw Materials Demonstrator (Port 8080)
python run_app.py --port 8080
# Open in browser: http://localhost:8080

# 2B. (In another terminal) Launch the General-Purpose GIS Template Sandbox (Port 8085)
python run_template.py --port 8085
# Open in browser: http://localhost:8085
```

*(Shell shortcuts `./run_demo.sh` and `./run_template.sh` are also provided on Linux/macOS; running `python run_app.py` inside `code/` provides identical behavior).*

---

### Method 3: HPC Cluster with GPU Acceleration (NVIDIA A100 / Slurm)
For institutional environments equipped with compute nodes and NVIDIA CUDA GPUs:

```bash
cd code
chmod +x run_gpu.sh
./run_gpu.sh 8080
```
This automatically allocates a GPU node via Slurm inside Apptainer, exposes local open-weight LLMs (Qwen 2.5 7B, Llama 3.1 8B, Mistral 7B Instruct v0.2, Phi-3 Mini 4K), and sets up reverse proxy routing.

---

## 🖥️ Step-by-Step Manual Testing Instructions

Once the web application is loaded in your browser at `http://localhost:8080`:

### 1. Test Preset Benchmark Queries (Reviewer Test Bench)
At the top-left of the chat panel, click any of the preset test scenario buttons:
- **Test 1 (`Test 1: Active Li & Co`)**:
  - *Query*: *"Show active lithium and cobalt waste dumps in Spain and Finland"*
  - *Observed Feedback*:
    - Active Filter Badges: `[Countries: Spain, Finland]`, `[CRM Metal: Lithium, Cobalt]`, `[Status: Active]`.
    - Map View: Automatically pans to Western and Northern Europe; matching facilities display **emerald glowing pulse rings**.
    - Site Counter: Updates to show matching facilities (`Showing 2 / 100 European Sites`: *North Karelia Lithium & Cobalt Waste Dump #45* and *Extremadura Lithium & Cobalt Waste Dump #97*).
    - Assistant Narrative: Generates a factual summary citing deposit names, locations, and operational status.
    - PDF Evidence Cards: Shows grounded citations from technical reports with mineral and country tags.

- **Test 2 (`Test 2: Tungsten Ponds`)**:
  - *Query*: *"Unrestored tungsten tailings ponds in Germany"*
  - *Observed Feedback*: Filters for German facilities containing Tungsten with `restored=false`.

- **Test 3 (`Test 3: REE Deposits`)**:
  - *Query*: *"Rare Earth Elements (REE) facilities in Sweden and France"*
  - *Observed Feedback*: Synchronizes multi-country spatial filters for Critical Raw Materials across Sweden and France.

### 2. Test Free-Text Natural Language Queries
Type your own queries into the input bar at the bottom:
- Try colloquial phrasing or typos: *"escombreras de golfranio en galiza"* $\to$ The thesaurus maps *golfranio* $\to$ *Tungsten* and *galiza* $\to$ *Galicia, Spain*.
- Try negative constraints: *"balsas de mineral que no esten restauradas"* $\to$ maps to `restored=false`.

### 3. Inspect Solr Engine & OpenAPI Schema Telemetry
Click the bottom expandable bar **"Solr Engine Inspector & Telemetry"**:
- **Solr Filter Query (`fq`)**: Displays the deterministic Boolean query generated for Apache Solr.
- **Solr Dynamic Facets**: Real-time facet distributions calculated across the 100-site dataset.
- **Extracted JSON Schema**: The strict OpenAPI JSON object validated by Stage 2.

---

## 🧪 Automated Verification & Benchmark Reproduction

The repository includes fully automated test scripts corresponding to Section 3 of the manuscript:

### 1. Automated API & Engine Verification Suite
Validates request formatting, authentication handlers, and zero-crash fallbacks across Mock, Gemini, GPT-4o, and Claude:
```bash
python code/test_apis.py
```

### 2. Golden 100-Query Benchmark Reproduction
Evaluates intent classification accuracy and field-level F1-scores across all 100 ground-truth queries in `code/evaluation/test_battery_100.json`:
```bash
cd code/evaluation
python evaluate_100_tests.py
```

### 3. Multi-Turn Conversational DST Benchmark (NVIDIA A100 Testbed)
Evaluates expected filter accuracy (Macro F1) across 6 conversational test categories over 132 sequential turns and 30 dialogue episodes:
```bash
sbatch code/evaluation/run_dst_benchmark.sbatch
# Or execute locally with python:
python code/evaluation/benchmark_conversational_dst.py --models mock phi3 mistral llama qwen
```

#### Benchmark Summary on NVIDIA A100 (40GB VRAM) across 132 Conversational Turns
| Inference Model | Family / Vendor | Parameters | VRAM (GB) | Latency | Search | Expand | Refine | Remove | Context | Reset | Global Macro F1 | Data Sovereignty |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **Deterministic Baseline (Mock)** | Rule-based | N/A | 0.0 GB | 0.9 ms | 91.0% | 83.0% | 68.5% | 67.6% | 64.5% | 90.0% | **76.1%** | 100% On-Premises (Air-gapped) |
| **Phi-3 Mini 4K Instruct** | Microsoft | 3.82 B | 7.13 GB | 3.73 s | 61.4% | 36.5% | 32.2% | 13.3% | 30.6% | 90.0% | **36.9%** | 100% On-Premises (Private GPU) |
| **Mistral 7B Instruct v0.2** | Mistral AI | 7.24 B | 13.49 GB | 3.65 s | **96.2%** | 92.6% | 80.0% | 64.2% | 86.7% | **100.0%** | **80.7%** | 100% Sovereign (European LLM) |
| **Llama 3.1 8B Instruct** | Meta | 8.03 B | 14.96 GB | 2.47 s | 96.0% | 94.1% | 93.4% | 78.2% | 78.7% | **100.0%** | **88.8%** | 100% On-Premises (Private GPU) |
| **Qwen 2.5 7B Instruct** | Alibaba | 7.61 B | 14.19 GB | 2.02 s | 93.1% | **96.0%** | **97.5%** | **95.3%** | **90.2%** | **100.0%** | **95.0%** | 100% On-Premises (Private GPU) |

### 4. Consolidated Peer-Validated Benchmark (372 Units across 4 Suites)
Evaluates systemic extraction robustness, out-of-domain rejection, compound Boolean logic, and conversational state tracking across all 372 unified multi-author units:

```bash
# Verify test harness locally on CPU (mock baseline):
python3 code/evaluation/benchmark_unified.py --provider mock

# Or submit Slurm job on GPU cluster (e.g. Qwen 2.5 7B):
sbatch code/evaluation/run_cluster_gpu.sbatch qwen
```

#### Consolidated Empirical Benchmark across 372 Units (NVIDIA A100 Testbed)
| Model Architecture | OOD Rejection | Single-Turn Slot F1 | Boolean Op. Acc. | DST Macro F1 |
| :--- | :---: | :---: | :---: | :---: |
| **Deterministic Baseline (Mock)** | 87.5% | 89.8% | **96.1%** | 78.9% |
| **Phi-3 Mini 4K Instruct** | 87.5% | 86.9% | 94.8% | 56.6% |
| **Mistral 7B Instruct v0.2** | **100.0%** | 88.5% | 88.3% | 73.9% |
| **Llama 3.1 8B Instruct** | 87.5% | 88.8% | 92.2% | 85.1% |
| **Qwen 2.5 7B Instruct** | 95.8% | **92.1%** | 93.5% | **91.9%** |

> **Note on Methodological Rigor**: In addition to granular slot and operator F1 scores (85%–100%), the system was benchmarked under an all-or-nothing end-to-end Exact Match (EM) lower-bound metric, where Qwen 2.5 7B achieves 60.8% and Mistral 7B reaches 51.9%. Complete raw outputs and logs are available in [`code/evaluation/results/`](code/evaluation/results/). For details, see [`code/evaluation/README.md`](code/evaluation/README.md).


---

## 📁 Repository Structure

```
nlu-solr-gis/
├── .devcontainer/
│   └── devcontainer.json           # Unified Codespaces configuration (auto-forwards 8080 & 8085)
├── run_codespace.py                 # Codespaces background orchestrator for both web applications
├── code/                               # Reference software implementation (European CRMs)
│   ├── agent.py                        # Orchestrator coordinating Stages 1-4
│   ├── llm_client.py                   # Multi-engine NLU client (Mock, Local Transformers, Cloud APIs)
│   ├── mock_api.py                     # Apache Solr spatial simulator with facet engine
│   ├── nlu_pipeline.py                 # Normalization thesaurus, JSON validator, Solr builder
│   ├── run_app.py                      # Standalone HTTP web server (Port 8080)
│   ├── run_gpu.sh                      # Slurm execution script
│   ├── run_gpu_app.py                  # Slurm launcher & reverse proxy
│   ├── test_apis.py                    # Automated verification suite for all engines
│   ├── requirements.txt                # Python dependencies
│   ├── data/
│   │   └── synthetic_escombreras_europe.json # 100 European CRM waste facilities
│   ├── evaluation/
│   │   ├── test_battery_unified.json   # 372-unit unified multi-author benchmark battery
│   │   ├── benchmark_unified.py        # Unified multi-author benchmarking harness
│   │   ├── run_local_mock.sh           # Offline CPU verification script
│   │   ├── run_cluster_gpu.sbatch      # Slurm HPC GPU execution script
│   │   ├── results/                    # Pre-computed evaluation metrics and raw outputs
│   │   ├── test_battery_100.json       # 100 golden test queries with ground truth
│   │   ├── test_battery_conversational_dst.json # 132-turn sequential conversational benchmark
│   │   ├── evaluate_100_tests.py       # Baseline evaluation script
│   │   ├── benchmark_conversational_dst.py # Multi-model conversational DST benchmark suite
│   │   └── benchmark_all_models.py     # 100-query single-turn comparative benchmark script
│   └── static/
│       ├── favicon.ico                 # Application favicon
│       └── index.html                  # Dynamic Single-Page App (Leaflet.js + TailwindCSS)
├── template/                           # General-Purpose GIS Architecture Template & Sandbox
│   ├── README.md                       # Architectural guide & 3-step adaptation recipe
│   ├── filters_config.json             # Declarative filter definitions & thesaurus mapping
│   ├── run_template.py                 # Zero-dependency HTTP server & 4-stage orchestrator
│   ├── run_template.sh                 # Convenient shell launcher
│   ├── requirements.txt                # Zero-dependency specification (Python stdlib)
│   ├── data/
│   │   └── facilities.json             # Dynamically populated GIS dataset (starts clean for onboarding wizard)
│   └── static/
│       ├── favicon.ico                 # App icon
│       └── index.html                  # Reactive Leaflet GIS UI with Live Filter Studio
├── .gitignore                          # Git exclude rules
├── LICENSE                             # MIT Open-Source License
├── README.md                           # Main documentation & quickstart
├── run_app.py                          # Root standalone launcher for CRMs WebApp (Port 8080)
├── run_demo.sh                         # 1-Click shell launcher for CRMs WebApp
├── run_template.py                     # Root standalone launcher for GIS Template (Port 8085)
├── run_template.sh                     # 1-Click shell launcher for GIS Template
└── run_gpu_app.py                      # Slurm GPU launcher & reverse proxy
```

---

## 🛠️ General-Purpose GIS Template & Filter Customization Studio

The package in [`template/`](template/) allows reviewers to evaluate the framework's adaptability to **any geospatial domain**:

1. **Interactive In-Browser Filter Studio**:
   - Launch `python run_template.py --port 8085` and open the **"🛠️ Filter Studio"** tab.
   - Add new filter fields (multiselect, select, or numeric range) and define synonyms live.
   - The changes are instantly applied to the running application and reflected on the Leaflet map without restarting the server!

2. **Declarative Configuration ([`filters_config.json`](template/filters_config.json))**:
   - Define custom facets, validation types, and thesaurus synonyms declaratively in JSON.

3. **Adapting to Custom Datasets in 3 Steps**:
   - Replace or edit [`template/data/facilities.json`](template/data/facilities.json) with your own GeoJSON/JSON spatial records containing `latitude`, `longitude`, and your domain attributes.
   - Declare your filter fields in [`template/filters_config.json`](template/filters_config.json).
   - Run `python run_template.py` to explore your new GIS dashboard with conversational search and dynamic facet badges.

---

## 🛠️ Domain Customization & Developer Guide (CRMs Demonstrator)

- **Adapting to Other Domains**: Update the canonical dictionary in [`code/nlu_pipeline.py`](code/nlu_pipeline.py) under `DOMAIN_SYNONYMS` for your domain (e.g., cadastres, environmental hazards, forestry).

- **Connecting a Production Apache Solr / SolrCloud Cluster**: To connect to a live distributed SolrCloud collection or standalone Solr core, define the environment variable: `export SOLR_URL="http://your-solr-host:8983/solr/crms_collection"`. The search connector in [`code/mock_api.py`](code/mock_api.py) automatically routes queries via the Solr HTTP REST API (`/select`) with live faceting, falling back gracefully to the embedded synthetic dataset if omitted.

---

## 📄 License

This software is released under the **MIT License**. See [`LICENSE`](LICENSE) for complete details.

---

## 🤝 Acknowledgements

This research has received funding from the European Union's Research Fund for Coal and Steel (RFCS) under Grant Agreement No. 101216677 (**CRMsDataSpace**: *Building a Common European Data Space on Critical Raw Materials for the Green Deal*).

Developed by the **Grupo de Inteligencia Computacional Aplicada (GICAP)**, Departamento de Digitalización, Escuela Politécnica Superior, Universidad de Burgos, Spain, in collaboration with the **Institute of Space Sciences and Technologies of Asturias (ICTEA)**, Universidad de Oviedo, Spain.
