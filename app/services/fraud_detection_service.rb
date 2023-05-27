class FraudDetectionService
  # TODO: add env variable
  @@client = OpenAI::Client.new(access_token: ENV.fetch("OPEN_AI_TOKEN"))
  binding.pry

  MODEL = "gpt-3.5-turbo"

  PREFIX = "
Below is a Patient Insurance Claim History, Patient Medical History, Doctor-Patient Transcript, Doctor's Prescription it starts with <PatientMedicalHistory> and ends with </PatientMedicalHistory>
"

  INSTRUCTION = "
Based on the Patient Insurance Claim History, Patient Medical History, Doctor-Patient Transcript, Doctor's Prescription provided below, generate a fraud detection response in JSON format:
{
  \"approved\": <Yes/No>,
  \"confidence\": (0,1),
  \"explanation\": <string>
}
"

  TEXT = "
<PatientMedicalHistory>
%{medical_history}
</PatientMedicalHistory>
"

  def self.detect(medical_history)
    result = {
      success: false,
      approved: nil,
      confidence: nil,
      summary: nil,
      error_message: ""
    }

    prompt = (PREFIX + "\n" + TEXT + "\n" + INSTRUCTION) % {medical_history: medical_history}

    response = @@client.chat(
      parameters: {
        model: MODEL,
        messages: [{ role: "user", content: prompt}],
        temperature: 0.7
      })

    if response.dig("error", "message")
      result[:error_message] = response.dig("error", "message")
      return result
    end

    response_text = response.dig("choices", 0, "message", "content")
    begin
      parsed_response = JSON.parse(response_text)
    rescue StandardError => e
      puts("ChatGPT Error:", e.message)
      parsed_response = {}
    end

    result[:approved] = parsed_response["approved"]
    result[:confidence] = parsed_response["confidence"]
    result[:summary] = parsed_response["explanation"]

    result[:success] = !(result[:approved].nil? || result[:confidence].nil? || result[:summary].nil?)
    return result

    # binding.pry
    # split_response = response_text.split("\n")
    # result[:approved] = split_response.second if split_response.first.downcase == "approved:" && split_response.second.to_s.downcase.in?(["yes", "no"])
    # result[:confidence] = split_response.fourth.to_f if split_response.third.downcase == "confidence:" && split_response.fourth.to_s.to_f.to_s == split_response.fourth
    # result[:summary] = split_response.last if split_response.fifth.downcase == "explanation:" && split_response.last.to_s == split_response.last
    # result[:success] = !(result[:approved].nil? || result[:confidence].nil? || result[:summary].nil?)
    # return result
  end
end