# 📦 HiveBox (V3) - Production-Grade On-Premise DevOps Automation & Infrastructure Monitoring Platform

## 📌 Project Architecture Overview

**HiveBox (V3)** is an enterprise-grade DevOps portfolio architecture engineered to demonstrate advanced competency in
declarative infrastructure provisioning, containerized orchestration, secure CI/CD pipelines, and continuous cluster
monitoring.

To showcase pure systems engineering and infrastructure automation, this ecosystem is fully abstracted from standard
public cloud dependencies and optimized for a zero-cloud, bare-metal local hardware virtualization workflow (On-Premise
Lab). The architecture governs the entire lifecycle of a containerized microservice—handling everything from
state-driven infrastructure provisioning to vulnerability posture remediation and live infrastructure monitoring.

---

## 🏗️ Core Architectural Pillars & Workflow

The platform implements a highly coupled, sequential, and fully automated multi-layer pipeline:

1. **Application Layer & Microservice Topology**
    * **Core Runtime:** The baseline workload consists of a custom Python microservice (`application.py`) developed to
      handle localized application logic.
    * **Network Constraints:** The runtime environment is bound dynamically, exposing its microservices locally and
      listening strictly on target host port `5001`.

2. **Secure Continuous Integration (CI/CD Automated Gateways)**
    * **Pipeline Master:** Orchestrated via an automated **Jenkins** automation server that governs source code
      fetching, runtime testing hooks, and container compilation.
    * **Shift-Left Security Enforcement:** Enforces a mandatory security guardrail by integrating a **Trivy**
      vulnerability scanner directly into the Jenkins runtime execution. The pipeline utilizes automated static analysis
      to audit layered images; any container exceeding the risk threshold triggers an immediate build block, mitigating
      downstream exploitation.

3. **Declarative Infrastructure as Code (IaC Engine)**
    * **State Mapping & Management:** Driven entirely by **Terraform** to enforce immutable infrastructure paradigms.
    * **Automated Manifest Provisioning:** Instead of manual object creation, Terraform manages cluster configuration
      manifests, lifecycle logic, environment configurations, and state mappings across the orchestration layer.

4. **Container Orchestration (Lightweight K3s Cluster topology)**
    * **Production-Grade Orchestration:** Workloads are completely migrated into a production-ready, resource-optimized
      **K3s Kubernetes Cluster**.
    * **Ephemeral Workload Lifecycle:** The application container runtimes are provisioned as scalable, native
      Kubernetes Pods, isolated within dedicated cluster namespaces to optimize local compute resource efficiency.

5. **Infrastructure & Cluster Monitoring Pipeline**
    * **Centralized Package Control:** Leverages **Helm Charts** to deploy and manage complex multi-resource cluster
      monitoring dependencies seamlessly.
    * **Metric Aggregation & Scraping:** **Prometheus** serves as the time-series data storage layer, actively executing
      continuous cluster-wide metric scraping to trace Pod operational histories and infrastructure resource status.
    * **Data Visualization:** **Grafana** hooks into Prometheus data streams to construct centralized graphical
      dashboards, delivering real-time monitoring panels on cluster node conditions and microservice performance.

---

## 🛠️ Unified System Technology Stack

| Architecture Layer             | Technology Selection      | Tactical Engineering Purpose                                                 |
|:-------------------------------|:--------------------------|:-----------------------------------------------------------------------------|
| **Infrastructure Environment** | On-Premise Lab            | Zero-cloud, bare-metal hardware virtualization & system isolation.           |
| **Microservice Application**   | Python (`application.py`) | Application logic exposing microservices locally on port `5001`.             |
| **Pipeline Automation Engine** | Jenkins                   | Full automation orchestration, webhook parsing, and build hooks.             |
| **Vulnerability Assessment**   | Trivy                     | Mandatory static container image scanning and security policy gating.        |
| **Containerization Runtime**   | Docker                    | Multistage, layered container builds and production runtimes.                |
| **Orchestration Layer**        | K3s Cluster               | Production-grade localized Kubernetes system resource control.               |
| **Declarative Provisioning**   | Terraform                 | Management of manifests, resource provisioning, and IaC state mappings.      |
| **Package Management**         | Helm                      | Structured chart management for composite monitoring software stacks.        |
| **Infrastructure Monitoring**  | Prometheus & Grafana      | High-fidelity metric scraping paired with advanced visual diagnostic panels. |

---

## ⚙️ Automated Execution & Deployment Stages

1. **Source Code Retrieval:** Jenkins fetches code changes from the centralized repository configuration.
2. **Static Image Verification:** Trivy performs deep vulnerability inspection before runtime compilation.
3. **Container Compilation:** Multi-stage Docker builds construct optimized, layered application images.
4. **Declarative State Sync:** Terraform applies underlying cluster changes, generating or rolling over deployment
   configurations safely.
5. **Continuous Monitoring:** Prometheus hooks ingest operational indicators, updating Grafana dashboards in real-time.