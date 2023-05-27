class PriyaSharma

  TRANSCRIPT = "**Patient:** Ms. Priya Sharma, 34-year-old female\n\n**Doctor:** Dr. Ravi Verma, Ophthalmologist, VisionCare Hospital\n\n*Dr. Verma's office, VisionCare Hospital*\n\n**Dr. Verma:** (Confident, Expert) Good morning, Ms. Sharma. What brings you in today?\n\n**Ms. Sharma:** (Anxious, Novice) Good morning, doctor. I've been having some trouble with my vision, especially in my right eye.\n\n**Dr. Verma:** I see. Could you please tell me more about the issues you are experiencing?\n\n**Ms. Sharma:** It's like everything is a bit foggy. I can't see clearly as I used to. This has been going on for about two weeks.\n\n**Dr. Verma:** I understand. Are you experiencing this issue continuously, or does it come and go?\n\n**Ms. Sharma:** It's there all the time, but seems to be worse in the morning and at night.\n\n**Dr. Verma:** Alright. Are you seeing any bright circles or halos around lights?\n\n**Ms. Sharma:** Yes, I've noticed those especially when I'm driving at night.\n\n**Dr. Verma:** Have you noticed any changes in your color perception?\n\n**Ms. Sharma:** I think so. Colours seem a bit duller than before.\n\n**Dr. Verma:** Does your eye feel irritated or sensitive to light?\n\n**Ms. Sharma:** Yes, it does feel a bit sensitive to bright light.\n\n**Dr. Verma:** Have you noticed any sudden changes in your vision, such as sudden blurriness or loss of vision?\n\n**Ms. Sharma:** No sudden changes, it's been a gradual thing.\n\n**Dr. Verma:** That's good. Any history of eye diseases or surgeries in your family?\n\n**Ms. Sharma:** My father had cataract surgery a few years ago.\n\n**Dr. Verma:** Alright. Now, I'd like to conduct a physical examination.\n\n*(Dr. Verma conducts a thorough examination including a visual acuity test and a dilated eye exam.)*\n\n**Dr. Verma:** Thank you for your patience, Ms. Sharma. Based on your symptoms and the examination, I suspect that you might have a cataract in your right eye. It's a common condition that can cause the symptoms you're describing.\n\n**Ms. Sharma:** Oh, I see. So, what should I do now?\n\n**Dr. Verma:** Given the impact on your vision and daily activities, I would recommend a cataract surgery. It's a routine procedure and will significantly improve your vision.\n\n**Ms. Sharma:** (Anxious) Is it safe?\n\n**Dr. Verma:** Yes, it is quite safe. There might be mild discomfort post surgery, but that's temporary. As with any surgery, there are some risks, but serious complications are rare.\n\n**Ms. Sharma:** And how long will it take to recover?\n\n**Dr. Verma:** You should start seeing improvement within a few days of the surgery. Full recovery generally takes about 4 to 6 weeks.\n\n**Ms. Sharma:** And where can I purchase the required medicines?\n\n**Dr. Verma:** The required eye drops and medications can be purchased from the pharmacy at our hospital, or any well-stocked pharmacy. They're generally not very expensive.\n\n**Ms. Sharma:** Are there any side effects?\n\n**Dr. Verma:** Side effects can include mild irritation or redness, and sensitivity to light. These should subside within a week or so."
  PRESCRIPTION_DETAIL = "Patient Name: Ms. Priya Sharma\nAge: 34 years\nGender: Female\nDiagnosis: Cataract in the right eye\n\nMedications:\n\nEye Drops:\n[Prescription] Antibiotic Eye Drops: Instill 1 drop into the affected eye(s) 4 times a day for 1 week.\n[Prescription] Steroid Eye Drops: Instill 1 drop into the affected eye(s) 4 times a day for 4 weeks.\n[Prescription] Lubricating Eye Drops: Instill 1 to 2 drops into the affected eye(s) as needed for dryness or discomfort.\nTreatment Plan:\n\nCataract Surgery: A routine surgical procedure to remove the cataract in the right eye.\nSurgery will be performed by Dr. Ravi Verma at VisionCare Hospital.\nExpect improvement in vision within a few days post-surgery.\nFull recovery typically takes 4 to 6 weeks.\nMild discomfort, irritation, and sensitivity to light are common post-surgery and should subside within a week.\nPurchase the prescribed eye drops and medications from our hospital pharmacy or any well-stocked pharmacy.\nFollow the prescribed dosage and instructions for the eye drops.\nAttend follow-up appointments as scheduled for post-operative care and monitoring.\nNote: If you experience any severe pain, sudden vision changes, or concerning symptoms, please contact our clinic immediately.\n\nPlease follow the prescribed treatment plan and attend all scheduled appointments. If you have any further questions or concerns, do not hesitate to contact our clinic. Wishing you a successful cataract surgery and a swift recovery, Ms. Sharma!"

  def self.setup
    person = Person.create(name: "Priya Sharma", health_id: "priya.sharma@ndhm")
    health_report = HealthReport.create(person: person)
    insurance_policy_1 = InsurancePolicy.create(
      insurer: "Insurance Inc",
      start_date: Time.now,
      end_date: Time.now + 2.years,
      sum_insured: 50000,
      covers: "opd, dental",
      health_report: health_report,
      coverage: 50000
    )
    insurance_policy_2 = InsurancePolicy.create(
      insurer: "ACME Inc",
      start_date: Time.now,
      end_date: Time.now + 2.years,
      sum_insured: 50000,
      covers: "opd, dental, preventive_checkups, covid, maternity, vision, daycare",
      health_report: health_report,
      coverage: 50000
    )
    consultation = Consultation.create(
      health_report_id: health_report.id
    )
    prescription = Prescription.create(
      medicines: "Jalra-OD 100mg (tablet), Vildagliptin, Telmis 20 (Tablet)",
      lab_tests: "Cataract Test",
      transcript: TRANSCRIPT,
      prescription_detail: PRESCRIPTION_DETAIL,
      health_report_id: health_report.id,
      consultation: consultation
    )
    claim_1 = Claim.create(
      amount: 20000,
      person_id: person.id,
      insurance_policy_id: insurance_policy_1.id,
      status: "Processed",
      health_report_id: health_report.id,
      provider: "Ruby Hall Clinic, Pune",
      date_of_service: 2.years.ago,
      diagnosis: "Pregnancy",
      procedure: "Caesarean section, Hospitalization (for 3 days)",
      paid_by_insurance: 18000,
      out_of_pocket: 2000,
      consultation_id: consultation.id,
    )
    claim_2 = Claim.create(
      amount: 40000,
      person_id: person.id,
      insurance_policy_id: insurance_policy_2.id,
      status: "Processed",
      provider: "Netram",
      health_report_id: health_report.id,
      date_of_service: 2.years.ago,
      diagnosis: "Cataract, right eye",
      procedure: "Cataract surgery",
      paid_by_insurance: 30000,
      out_of_pocket: 10000,
      consultation_id: consultation.id,
      )

    invoice_1 = Invoice.create(
      amount: 40000,
      health_report_id: health_report.id,
      consultation_id: consultation.id
    )

    invoice_2 = Invoice.create(
      amount: 20000,
      health_report_id: health_report.id,
      consultation_id: consultation.id
    )
    consent = Consent.create(
      person: person,
      requested_by: "Insurance Inc",
      registered_on: Time.now
    )
  end
end
