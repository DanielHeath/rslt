class Excesselt::Stylesheet
  def self.transform(xml)
    <<-EXPECTED
        <p style="parent_content">
          <p style="child_content">SOME TEXT</p>
        </p>
    EXPECTED
  end
end