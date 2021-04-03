using BookShelf.Logic.Responses;

namespace BookShelf.Logic.Requests
{
    public class Login : BaseRequest<LoginResponse>
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }
}
