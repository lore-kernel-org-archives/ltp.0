From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 1 Mar 2018 18:49:32 +0300
Subject: [LTP] [RFC PATCH v2 2/2] tst_netload: Exit with TCONF when
 netstress exit with CONF
In-Reply-To: <20180301105943.5487-2-pvorel@suse.cz>
References: <20180301105943.5487-1-pvorel@suse.cz>
 <20180301105943.5487-2-pvorel@suse.cz>
Message-ID: <65377935-590d-6623-dafb-db85899e8f0c@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 03/01/2018 01:59 PM, Petr Vorel wrote:
> as some issues are configuration issues.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 95e13ee03..db9bb028d 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -453,7 +453,9 @@ tst_netload()
>  	tst_rhost_run -c "netstress $s_opts" > tst_netload.log 2>&1
>  	if [ $? -ne 0 ]; then
>  		cat tst_netload.log
> -		tst_brkm TFAIL "server failed"
> +		local ttype="TFAIL"
> +		grep -e 'CONF:' tst_netload.log && ttype="TCONF"


What about using the returned status instead of grep?

Thanks,
Alexey
