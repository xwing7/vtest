void main (string[] args) {
    
    string cmd = "./";
    cmd += args[1];
    
    string output;
    
    try{
        Process.spawn_command_line_sync(cmd, out output);
    } catch (SpawnError e) {
        stdout.printf("error: %s\n", e.message);
        return;
    }
    stdout.printf("output:\n");
    stdout.printf(output);
    
    string outputName = args[2];
    if(outputName == "")
    {
        outputName = "unit.xml";
    }
    
    string[] tests = output.split("\n");
    
    var testStrings = new List<string>();
    
    int amount = 0;
    int failures = 0;
    foreach(string test in tests)
    {
        if(test.index_of("/") == 0)
        {
            amount++;
            testStrings.append(test);
            if(test.index_of("OK") == -1)
            {
                failures++;
            }
        }
    }
    
    var writer = new Xml.TextWriter.filename(outputName);
    writer.set_indent(true);
    writer.set_indent_string("\t");
    
    writer.start_document();
    writer.start_element("testsuites");
    
    writer.start_element("testsuite");
    writer.write_attribute("name", "testName");
    writer.write_attribute("tests", amount.to_string());
    writer.write_attribute("failures", failures.to_string());
    writer.write_attribute("timestamp", "0");
    
    foreach(string testString in testStrings)
    {
        string[] split = testString.split(":");
        writer.start_element("testcase");
        writer.write_attribute("name", split[0]);
        writer.write_attribute("classname", split[0]+"_test");
        writer.end_element();
    }
    
    
    writer.end_element();
    
    writer.end_element();
    
    writer.end_document();
    
    writer.flush();
    
    
    /*
    <testsuite name="Customer Demographics Tests" tests="9" failures="0" timestamp="2012-08-23T14:40:44.874443-05:00">
        <testcase name="Insert First Name" classname="CustomerDemographicsPKG.Name"/>
        <testcase name="Insert Last Name" classname="CustomerDemographicsPKG.Name"/>
        <testcase name="Change First Name" classname="CustomerDemographicsPKG.Name"/>
        <testcase name="Change Last Name" classname="CustomerDemographicsPKG.Name"/>
        <testcase name="Delete First Name" classname="CustomerDemographicsPKG.Name"/>
        <testcase name="Delete Last Name" classname="CustomerDemographicsPKG.Name"/>
        <testcase name="Insert DOB" classname="CustomerDemographicsPKG.Misc"/>
        <testcase name="Update DOB" classname="CustomerDemographicsPKG.Misc"/>
        <testcase name="Delete DOB" classname="CustomerDemographicsPKG.Misc"/>
    </testsuite>
    */
}