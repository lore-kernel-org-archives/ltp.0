From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 10 Apr 2018 15:37:28 +0300
Subject: [LTP] [RFC PATCH v6 3/7] network.sh: Migrate to new shell API
In-Reply-To: <20180406123118.21309-4-pvorel@suse.cz>
References: <20180406123118.21309-1-pvorel@suse.cz>
 <20180406123118.21309-4-pvorel@suse.cz>
Message-ID: <fcdbaf75-7003-ff02-4fb6-6acfc0b504a2@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/06/2018 03:31 PM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testscripts/network.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testscripts/network.sh b/testscripts/network.sh
> index cc2b2de72..b18f202d5 100755
> --- a/testscripts/network.sh
> +++ b/testscripts/network.sh
> @@ -89,7 +89,7 @@ shift $(($OPTIND - 1))
>  TST_TOTAL=1
>  TCID="network_settings"

Do we need these variables in the new API?


For TCID, I guess we would also need this change in tst_test.sh:

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 6c2ee6a..b7aa4a7 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -102,7 +102,7 @@ tst_res()

        tst_inc_res "$res"

-       printf "$TCID $TST_COUNT "
+       printf "$TST_ID $TST_COUNT "
        tst_print_colored $res "$res: "
        echo "$@"
 }


Thanks,
Alexey

>  
> -TST_USE_LEGACY_API=1
> +TST_NO_DEFAULT_RUN=1
>  . tst_net.sh
>  
>  # Reset variables.
> 

