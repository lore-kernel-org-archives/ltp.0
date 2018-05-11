From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 May 2018 17:40:27 +0200
Subject: [LTP] [PATCH ltp] connectors/connector_test.sh: Return 32 for
 TCONF
In-Reply-To: <20180511201638.20872-1-yixin.zhang@intel.com>
References: <20180511201638.20872-1-yixin.zhang@intel.com>
Message-ID: <20180511154027.nsxbqa5xdchzdo6g@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
> ---
>  testcases/kernel/connectors/connector_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/connectors/connector_test.sh b/testcases/kernel/connectors/connector_test.sh
> index 0742a1b78..f92e10b85 100644
> --- a/testcases/kernel/connectors/connector_test.sh
> +++ b/testcases/kernel/connectors/connector_test.sh
> @@ -2,7 +2,7 @@

>  if [ ! -f /proc/net/connector ];then
>  	echo "Connectors 0 CONF : system doesn't support execution of the test"
> -	exit 0
> +	exit 32
>  fi

>  $LTPROOT/testcases/bin/run_pec_test

Merged, thanks a lot!
As it's obviously correct I dared to merge it in git freeze, hope nobody mind.

Kind regards,
Petr
