# Credit Scoring Analysis

## Bagian A – SQL Analytics 

**Tujuan:** Analisis pelanggan menggunakan teknik RFM, deteksi anomali, dan analisis repeat-purchase.

### Langkah & Output:
| Langkah                                | Output File           |
|----------------------------------------|-----------------------|
| Hitung RFM + segmentasi ≥ 6 segmen     | `analysis.sql`        |
| Deteksi ≥ 2 anomali dari `decoy_noise` | `A_findings.md`       |
| Query repeat-purchase bulanan          | `analysis.sql`        |

## Bagian B – Python Modeling 

**Tujuan:** Membangun model prediksi risiko kredit menggunakan Logistic Regression dan Gradient Boosting, serta membuat scorecard.

### Langkah & Output:
| Langkah                                          | Output File                  |
|--------------------------------------------------|------------------------------|
| EDA + drop fitur leakage                         |      `B_modeling.ipynb`      |
| Baseline Logistic Regression & Gradient Boosting |      `B_modeling.ipynb`      |
| Fungsi `scorecard(prob)`                         |      `B_modeling.ipynb`      |
| SHAP top-10 fitur                                |      `B_modeling.ipynb`      |
| Slide keputusan untuk pengajuan IDR 5 juta       |     `decision_slide.pdf`     |

## Bagian C – R Statistical Check (15 poin | ± 1 jam)

**Tujuan:** Validasi dan kalibrasi model dengan pendekatan statistik.

### Langkah & Output:
| Langkah                                                              | Output File            |
|----------------------------------------------------------------------|------------------------|
| Hosmer-Lemeshow test                                                 | `validation.R`         |
| Calibration curve                                                    | `calibration_curve.png`|
| Cut-off skor untuk expected default ≤ 5% + ringkasan keputusan       | `C_summary.md`         |


## Petunjuk Penggunaan

1. Jalankan SQL pada file `analysis.sql` di environment data warehouse Anda.
2. Eksekusi `B_mode.ipynb` untuk melakukan modeling.
3. Untuk validasi statistik, buka dan jalankan `validation.R` di RStudio.