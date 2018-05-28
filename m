From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 28 May 2018 16:48:06 +0300
Subject: [LTP] [PATCH 2/4] net: Allow to overwrite libraries getopts
	handlers
In-Reply-To: <20180526111545.20521-2-pvorel@suse.cz>
References: <20180526111545.20521-1-pvorel@suse.cz>
 <20180526111545.20521-2-pvorel@suse.cz>
Message-ID: <a751aab4-fbf4-91d1-90d6-047873441694@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/26/2018 02:15 PM, Petr Vorel wrote:
> Network libraries recently started to use TST_OPTS and TST_PARSE_ARGS:
> 89a83d8a0 ("net/ipsec_lib.sh: Process getopts parameters with TST_OPTS
> and TST_PARSE_ARGS")
> ce920a5a4 "network/virt_lib.sh: Process getopts parameters with TST_OPTS
> and TST_PARSE_ARGS"
> 5f088c3f4 ("nfs/nfs_lib.sh: Fix wrong getopts parameter handling")
> 
> This allows to test using these libs customize getopts.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Needed for rewriting into new API.
> ---

...

> diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
> index 480fe064a..28a2de5e8 100644
> --- a/testcases/network/stress/ipsec/ipsec_lib.sh
> +++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> @@ -67,8 +67,9 @@ ipsec_lib_parse_args()
>  	esac
>  }
>  
> -TST_OPTS="hl:m:p:s:S:k:A:e:a:c:r:"
> -TST_PARSE_ARGS=ipsec_lib_parse_args
> +TST_OPTS="${TST_OPTS:-hl:m:p:s:S:k:A:e:a:c:r:}"

So, to customize these options we would need to implement the original
library options as well or you are going to pass the rest of the options
to the library ipsec_lib_parse_args handler?

I think TST_OPTS should include the library ones and the new options
from the test.

It would be better to show the usage somewhere, i.e. when it is
really needed.
