namespace OpenBrisk.Runtime.Fetcher.Controllers
{
	using System;
	using Microsoft.AspNetCore.Mvc;
	using OpenBrisk.Runtime.Fetcher.Model;

	public class FetcherController : Controller
    {
        [HttpPost("/")]
        public IActionResult Fetch(FetchRequest request)
        {
            DateTime startTime = DateTime.UtcNow;



            return this.Ok();
        }

        [HttpPost("/upload")]
        public IActionResult Upload() 
        {
            return this.Ok();
        }


        [HttpGet("/healthz")]
        public IActionResult Health() => this.Ok();
    }
}
