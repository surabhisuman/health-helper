# class Person < ApplicationRecord
#   has_many :consents
#   has_many :notifications
#   has_many :health_reports
#
#   has_many :insurance_policies
# end
#
# =begin
# ###Patient Insurance Claim History:
# Insurance Provider: Pragati Health Insurance, India
# Claim 1 - 2022
# - Date of Service: 10th March, 2022
# - Provider: Ruby Hall Clinic, Pune
# - Diagnosis: Pregnancy
# - Procedure: Caesarean section, Hospitalization (for 3 days)
# - Claim Amount: ₹1,80,000
# - Paid by Insurance: ₹1,62,000
# - Out of Pocket: ₹18,000
# Total Claim Amount from 2007 to 2022: ₹3,47,000
# - Total Paid by Insurance: ₹3,12,000
# - Total Out of Pocket: ₹35,000
# ###Patient Medical History:
# Primary Care Provider: Dr. Prakash Joshi, Harmony Clinic, Pune
# 2007:
# - Diagnosed with type 2 diabetes; prescribed lifestyle modifications and oral hypoglycemic agents.
# 2009 - 2021:
# - Regular check-ups for diabetes; medication adjusted as necessary.
# 2022:
# - Underwent Caesarean section for the delivery of her third child at Ruby Hall Clinic, Pune.
# - Diagnosed with cataract in the right eye; underwent cataract surgery at H.V. Desai Eye Hospital, Pune.
# - Regular diabetes check-ups continued; good glycemic control maintained.
# ###Doctor-Patient Transcript:
# Patient: “I've been taking the Glycomet-GP 1 as you prescribed, doctor, but I'm still feeling quite unwell. My blood pressure readings are all over the place and my sugar levels are high.”
# Doctor: “I see, we may need to adjust your medications. Let's add Jalra-OD and Telmis to your regimen and see how you respond.”
# Doctor's Hint: The patient has uncontrolled diabetes and hypertension despite adherence to the Glycomet-GP 1.
# ###Doctor's Prescription:
# Clinical Note:
# Diagnosis: Uncontrolled Diabetes and Hypertension
# History of Presenting Illness: The patient has been adhering to their current medication regimen but the diabetes and hypertension seem uncontrolled.
# Medications (Prescribed):
# [Continue] Glycomet-GP 1 (tablet) | Glimepiride and Metformin
# [Added] Jalra-OD 100mg (tablet) | Vildagliptin
# [Added] Telmis 20 (Tablet)
# Lab Tests (Ordered): None
# =end
#
# class Consultation < ApplicationRecord
#   belongs_to :health_report
#   has_many :claims
#   has_many :invoices
#   has_many :prescriptions
# end
#
# class InsurancePolicy < ApplicationRecord
#   belongs_to :person
#
#   has_many :claims
# end
#
# class Claim < ApplicationRecord
#   belongs_to :consultation
#   belongs_to :insurance_policy
#   has_many :claim_status_histories
# end
#
# class ClaimStatusHistory < ApplicationRecord
#   belongs_to :claim
# end
#
# class Invoice < ApplicationRecord
#   belongs_to :consultation
# end
#
# class Prescription < ApplicationRecord
#   belongs_to :consultation
# end
#
# class Consent < ApplicationRecord
#   belongs_to :person
# end
#
# class Notification < ApplicationRecord
#   belongs_to :person
# end