From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Nov 2018 14:35:28 +0100
Subject: [LTP] [PATCH] lib/tst_test.sh: setup timeout per test run for
 the shell tests
In-Reply-To: <1539867130-14299-1-git-send-email-alexey.kodanev@oracle.com>
References: <1539867130-14299-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20181127133528.GB31527@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Use LTP_TIMEOUT_MUL environment variable, similar to what we have
> in the C library.

> Basically, the patch puts the child process with kill command to
> the background to signal the test process group processes after
> the certain timeout, which is controlled by LTP_TIMEOUT_MUL.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/lib/tst_test.sh |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 7a41309..a7aa608 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -42,6 +42,11 @@ _tst_do_exit()
>  {
>  	local ret=0

> +	if [ -n "$_tst_setup_timer_pid" ]; then
> +		kill $_tst_setup_timer_pid
> +		wait $_tst_setup_timer_pid 2>/dev/null

STDERR redirection to /dev/null must be on kill, not on wait:
	   kill $_tst_setup_timer_pid 2>/dev/null
	   wait $_tst_setup_timer_pid

Otherwise warning is issued when timeout occurs:
udp_ipsec 1 TINFO: run client 'netstress -l -T udp -H 10.0.0.1 -n 100 -N 100 -a 2 -r 500 -d tst_netload.res -g 49072'
udp_ipsec 1 TBROK: test interrupted
/opt/ltp/testcases/bin/udp_ipsec.sh: 46: kill: No such process

Kind regards,
Petr
