namespace OpenBrisk.Runtime.Fetcher.Model
{
	public class FetchRequest 
	{
		public int FetchType { get; set; }

		public object Package { get; set; } // TODO

		public string Url { get; set; }

		public string StorageServiceUrl { get; set; }

		public string Filename { get; set; }
	}
}