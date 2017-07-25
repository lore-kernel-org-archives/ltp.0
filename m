From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 25 Jul 2017 15:50:01 +0300
Subject: [LTP] [RFC PATCH v7 05/11] lib/test_net.sh: tst_rhost_run: Add
 testcases/bin into PATH for SSH/RSH
In-Reply-To: <20170721040407.868-6-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-6-pvorel@suse.cz>
Message-ID: <8fda8031-0621-3f93-e938-ef446b710013@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
On 07/21/2017 07:04 AM, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/test_net.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
> index 76e6b0a41..0cafe1514 100644
> --- a/testcases/lib/test_net.sh
> +++ b/testcases/lib/test_net.sh
> @@ -55,7 +55,6 @@ init_ltp_netspace()
>  # -b run in background
>  # -s safe option, if something goes wrong, will exit with TBROK
>  # -c specify command to run
> -
>  tst_rhost_run()
>  {
>  	local pre_cmd=
> @@ -91,15 +90,16 @@ tst_rhost_run()
>  
>  	local output=
>  	local ret=0
> +	local newpath="$LTPROOT/testcases/bin"

Why setting the PATH, LTPROOT can't be done before test run on remote
host? what if LTPROOT differs b/w machines?

>  	if [ -n "${TST_USE_SSH:-}" ]; then
> -		output=`ssh -n -q $user@$RHOST "sh -c \
> -			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
> +		output=`ssh -n -q $user@$RHOST "PATH=$newpath:\$PATH \
> +			sh -c '$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`

$PATH still expands on local machine with backticks

echo `echo "\$PATH"` vs echo `echo "\\$PATH"`

or better use POSIX $(...)

echo $(echo "\$PATH")

Thanks,
Alexey

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170725/0ce9f048/attachment-0001.html>
