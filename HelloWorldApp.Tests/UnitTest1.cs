using Xunit;
using HelloWorldApp; 

public class UnitTest1
{
    [Fact]
    public void GetMessage_ReturnsHelloWorld()
    {
        Assert.Equal("Hello World", Program.GetMessage());
    }
}
