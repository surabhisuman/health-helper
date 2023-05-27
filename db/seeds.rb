# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# byebug

person = Person.create(
  name: "Patient",
  health_id: "patient@adhm",
  email: "patient@gmail.com",
  phone: '9999999999',
  aadhar_number: "12332423",
)

health_report = HealthReport.create(
  person: person
)

policy = InsurancePolicy.create(
  insurer: "Insure Inc",
  start_date: Time.now,
  end_date: Time.now + 1.month,
  sum_insured: 500000,
  covers: "dental, opd, cancer, daibetes",
  coverage: 40000,
  health_report_id: health_report.id
)

consent = Consent.create(
  person: person,
  requested_by: "Insure Inc",
  registered_on: Time.now
)

prescription = Prescription.create(
  health_report: health_report,
  medicines: ["Jalra-OD 100mg (tablet) | Vildagliptin", "Telmis 20 (Tablet)"],
  lab_tests: []
)

invoice = Invoice.create(
  amount: 1000,
  health_report: health_report
)
