using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using HelloWorldApp.Models;
using HelloWorldApp.Data;

namespace HelloWorldApp.Pages;

public class IndexModel : PageModel
{
    public string ExampleInputName = "DefaultName";
    public string ExampleInputAge = "DefaultAge";

    public List<People> ListPeople = new List<People>();
    private readonly ILogger<IndexModel> _logger;
    private readonly PeopleContext _context;

    public IndexModel(ILogger<IndexModel> logger, PeopleContext context)
    {
        _logger = logger;
        _context = context;
    }

    public void OnGet()
    {
        ListPeople.Add(new People
        {
            Name = ExampleInputName,
            Age = ExampleInputAge
        });
        var people = _context.PeopleList?.ToList() ?? new List<People>();
        ListPeople.AddRange(people);
    }
    public IActionResult OnPost(string name, string age)
    {
        _context.PeopleList.Add(new People
        {
            Name = name,
            Age = age
        });
        _context.SaveChanges();
        // Process the user input
        return RedirectToPage();
    }
}
