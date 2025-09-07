using Xunit;
using HelloWorldApp.Models;

namespace HelloWorldApp.Tests
{
    public class PeopleTests
    {
        [Fact]
        public void People_Constructor_Should_Set_Properties()
        {
            // Arrange
            int id = 1;
            string name = "Whale";
            string age = "78";

            // Act
            People person = new People
            {
                ID = id,
                Name = name,
                Age = age
            };

            // Assert
            Assert.Equal(id, person.ID);
            Assert.Equal(name, person.Name);
            Assert.Equal(age, person.Age);
        }
    }
}