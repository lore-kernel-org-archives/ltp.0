From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 20 May 2016 10:41:57 +0800
Subject: [LTP] [PATCH 1/2] network/xinetd: source test_net.sh for
 tst_retry
In-Reply-To: <1461937540-568-1-git-send-email-haliu@redhat.com>
References: <1461937540-568-1-git-send-email-haliu@redhat.com>
Message-ID: <20160520024157.GJ19992@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Would you like to help review this patch set?

Thanks
Hangbin
On Fri, Apr 29, 2016 at 09:45:39PM +0800, Hangbin Liu wrote:
> Fix error: xinetd_tests.sh: line 323: tst_retry: command not found.
> tst_retry was defined in test.sh. Since this is a network test, source
> test_net.sh directly.
> 
> Signed-off-by: Hangbin Liu <haliu@redhat.com>
> ---
>  testcases/network/xinetd/xinetd_tests.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
> index e50a511..58fb98e 100755
> --- a/testcases/network/xinetd/xinetd_tests.sh
> +++ b/testcases/network/xinetd/xinetd_tests.sh
> @@ -63,6 +63,7 @@ init()
>      export TST_TOTAL=2
>      export TCID="xinetd"
>      export TST_COUNT=0
> +    . test_net.sh
>      . daemonlib.sh
>  
>      if [ -f "/usr/lib/systemd/system/telnet.socket" ]; then
> -- 
> 2.5.5
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
