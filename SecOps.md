Here are the **best free and open-source DevSecOps tools** that you can use in your **Ubuntu Server GitLab CI/CD pipeline**:

---

## **🔹 1. Static Application Security Testing (SAST)**
✅ **Purpose:** Scans source code for vulnerabilities before deployment.  

### **🔹 Open-Source Tools**
- **[Semgrep](https://semgrep.dev/)** – Lightweight static code analysis.
- **[SonarQube Community](https://www.sonarqube.org/downloads/)** – Code quality and security scanner.
- **[Bandit](https://github.com/PyCQA/bandit)** – Python security scanner.
- **[Gosec](https://github.com/securego/gosec)** – Golang security scanner.
- **[CodeQL](https://codeql.github.com/)** – Security analysis from GitHub.

✅ **GitLab CI/CD Example for Semgrep**  
```yaml
stages:
  - security

semgrep_scan:
  image: returntocorp/semgrep
  stage: security
  script:
    - semgrep --config=auto --error .
```

---

## **🔹 2. Software Composition Analysis (SCA)**
✅ **Purpose:** Scans open-source dependencies for vulnerabilities.

### **🔹 Open-Source Tools**
- **[Trivy](https://github.com/aquasecurity/trivy)** – Scans dependencies, Docker images, and Git repos.
- **[Dependency-Check](https://jeremylong.github.io/DependencyCheck/)** – Finds vulnerable dependencies.
- **[OWASP Dependency Track](https://dependencytrack.org/)** – Manages software components.
- **[Syft](https://github.com/anchore/syft)** – Generates software bill of materials (SBOM).

✅ **GitLab CI/CD Example for Trivy**  
```yaml
stages:
  - security

trivy_scan:
  image: aquasec/trivy
  stage: security
  script:
    - trivy fs .
```

---

## **🔹 3. Dynamic Application Security Testing (DAST)**
✅ **Purpose:** Scans running applications for vulnerabilities.

### **🔹 Open-Source Tools**
- **[OWASP ZAP](https://www.zaproxy.org/)** – Best open-source DAST tool.
- **[Nikto](https://cirt.net/nikto2)** – Scans web servers.
- **[Wapiti](https://wapiti.sourceforge.io/)** – Black-box web app scanner.

✅ **GitLab CI/CD Example for OWASP ZAP**  
```yaml
stages:
  - security

zap_scan:
  image: owasp/zap2docker-stable
  stage: security
  script:
    - zap-baseline.py -t http://your-app-url
```

---

## **🔹 4. Infrastructure as Code (IaC) Security**
✅ **Purpose:** Scans Terraform, Kubernetes, and CloudFormation for security risks.

### **🔹 Open-Source Tools**
- **[Checkov](https://github.com/bridgecrewio/checkov)** – Terraform & Kubernetes security scanner.
- **[Terrascan](https://github.com/tenable/terrascan)** – IaC security analysis.
- **[KICS](https://github.com/Checkmarx/kics)** – Multi-cloud security scanner.

✅ **GitLab CI/CD Example for Checkov**  
```yaml
stages:
  - security

checkov_scan:
  image: bridgecrew/checkov
  stage: security
  script:
    - checkov -d .
```

---

## **🔹 5. Container Security (Docker & Kubernetes)**
✅ **Purpose:** Scans Docker images and Kubernetes clusters for security issues.

### **🔹 Open-Source Tools**
- **[Trivy](https://github.com/aquasecurity/trivy)** – Best for GitLab CI/CD.
- **[Grype](https://github.com/anchore/grype)** – Vulnerability scanner for container images.
- **[Kube-hunter](https://github.com/aquasecurity/kube-hunter)** – Kubernetes penetration testing tool.

✅ **GitLab CI/CD Example for Grype**  
```yaml
stages:
  - security

grype_scan:
  image: anchore/grype
  stage: security
  script:
    - grype my-app:latest
```

---

## **🔹 6. Secret Detection (Leaks Prevention)**
✅ **Purpose:** Detects hardcoded secrets (API keys, passwords, tokens).

### **🔹 Open-Source Tools**
- **[Gitleaks](https://github.com/gitleaks/gitleaks)** – Detects secrets in Git repos.
- **[TruffleHog](https://github.com/trufflesecurity/trufflehog)** – Finds API keys & credentials.
- **[GitGuardian CLI](https://github.com/GitGuardian/ggshield)** – Secret detection for Git repos.

✅ **GitLab CI/CD Example for Gitleaks**  
```yaml
stages:
  - security

gitleaks_scan:
  image: zricethezav/gitleaks
  stage: security
  script:
    - gitleaks detect --source .
```

---

## **🔹 7. Compliance & Policy-as-Code**
✅ **Purpose:** Ensures compliance with security policies (CIS, NIST, GDPR).

### **🔹 Open-Source Tools**
- **[Open Policy Agent (OPA)](https://www.openpolicyagent.org/)** – Policy enforcement tool.
- **[Regula](https://github.com/fugue/regula)** – Compliance for Terraform, AWS & Kubernetes.
- **[InSpec](https://github.com/inspec/inspec)** – Compliance automation framework.

✅ **GitLab CI/CD Example for OPA**  
```yaml
stages:
  - security

opa_scan:
  image: openpolicyagent/opa
  stage: security
  script:
    - opa eval --data policy.rego --input input.json 'data'
```

---

## **🔹 8. Runtime Security & Intrusion Detection**
✅ **Purpose:** Detects runtime security threats & suspicious activity.

### **🔹 Open-Source Tools**
- **[Falco](https://falco.org/)** – Kubernetes runtime security monitoring.
- **[Wazuh](https://wazuh.com/)** – SIEM and host intrusion detection.
- **[Osquery](https://osquery.io/)** – Endpoint security monitoring.

✅ **GitLab CI/CD Example for Falco**  
```yaml
stages:
  - security

falco_scan:
  image: falcosecurity/falco
  stage: security
  script:
    - falco -r /etc/falco/falco_rules.yaml
```

---

## **💡 Summary: Best Free Tools for GitLab CI/CD on Ubuntu**
| **Category**         | **Best Open-Source Tools** |
|----------------------|---------------------------|
| **SAST**            | Semgrep, SonarQube, Bandit, CodeQL |
| **SCA**             | Trivy, Dependency-Check, OWASP Dependency Track |
| **DAST**            | OWASP ZAP, Nikto, Wapiti |
| **IaC Security**    | Checkov, Terrascan, KICS |
| **Container Security** | Trivy, Grype, Clair |
| **Secret Detection** | Gitleaks, TruffleHog, GitGuardian CLI |
| **Compliance**      | OPA, Regula, InSpec |
| **Runtime Security** | Falco, Wazuh, Osquery |

---

## **🚀 Ready to Build a Secure GitLab CI/CD Pipeline?**
Would you like a **full GitLab CI/CD YAML file** integrating multiple security tools? Let me know! 🚀
