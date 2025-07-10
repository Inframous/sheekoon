namespace HelloWorldApp
{
    public static class Program
    {
        public static string GetMessage() => "Hello World";

        public static void Main(string[] args)
        {
            Console.WriteLine(GetMessage());
        }
    }
}
