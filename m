From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 9 Nov 2016 14:26:38 +0300
Subject: [LTP] [PATCH 1/1] network: load test_net.sh after getopts
In-Reply-To: <20161107121952.24933-1-pvorel@suse.cz>
References: <20161107121952.24933-1-pvorel@suse.cz>
Message-ID: <582307EE.5060401@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 11/07/2016 03:19 PM, Petr Vorel wrote:
> We shouldn't ask rsh/ssh password or require having set ssh pub keys
> just for displaying help.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testscripts/network.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testscripts/network.sh b/testscripts/network.sh
> index 66bacef..fea2f68 100755
> --- a/testscripts/network.sh
> +++ b/testscripts/network.sh
> @@ -11,8 +11,6 @@ if [ $? -eq 0 ]; then
>   	export LTPROOT=${PWD}
>   fi
>   
> -. test_net.sh
> -
>   export TMPDIR=/tmp/netpan-$$
>   mkdir -p $TMPDIR
>   CMDFILE=${TMPDIR}/network.tests
> @@ -81,6 +79,8 @@ if [ "$OPTIND" -eq 1 ]; then
>   	exit 1
>   fi
>   
> +. test_net.sh
> +

Agree, but we should reset TCID and TST_TOTAL after test_net.sh 
inclusion (not before).
May be something like this where they were moved close to each other:

@@ -81,6 +79,8 @@ if [ "$OPTIND" -eq 1 ]; then
         exit 1
  fi

+TST_TOTAL=1
+TCID="network_settings"
+
+. test_net.sh
+
+# Reset variables.
+# Don't break the tests which are using 'testcases/lib/cmdlib.sh'
+export TCID=
+export TST_LIB_LOADED=
+
  rm -f $CMDFILE

Best regards,
Alexey

>   rm -f $CMDFILE
>   
>   for t in $TEST_CASES; do

