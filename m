From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 22 Nov 2019 13:31:06 +0300
Subject: [LTP] [COMMITTED] [PATCH] network/sctp_big_chunk: Add linux git
 tag
In-Reply-To: <20191122100508.21265-1-chrubis@suse.cz>
References: <20191122100508.21265-1-chrubis@suse.cz>
Message-ID: <5c00ffaa-c639-52d9-6305-edc7790e1769@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,
On 22.11.2019 13:05, Cyril Hrubis wrote:
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/network/sctp/sctp_big_chunk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
> index 4ebdcb20f..ceb91c5b9 100644
> --- a/testcases/network/sctp/sctp_big_chunk.c
> +++ b/testcases/network/sctp/sctp_big_chunk.c
> @@ -182,5 +182,9 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.forks_child = 1,
>  	.test_all = run,
> -	.options = options
> +	.options = options,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "07f2c7ab6f8d"},

And {"CVE", "2018-5803"}, will add to the tags.

> +		{}
> +	}
>  };
> 

