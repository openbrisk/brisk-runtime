using System;
using Microsoft.AspNetCore.Mvc;

namespace OpenBrisk.Runtime.Fetcher.Controllers
{
	[Route("fetcher")]
	public class HealthController : Controller
	{
		[HttpGet("healthz")]
		public IActionResult HealthCheck() => this.Ok();
	}
}
