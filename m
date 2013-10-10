Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VU4sf-0006CV-Ln
	for ltp-list@lists.sourceforge.net; Thu, 10 Oct 2013 01:17:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VU4se-0005gi-Cj
	for ltp-list@lists.sourceforge.net; Thu, 10 Oct 2013 01:17:33 +0000
Message-ID: <52560004.5060808@cn.fujitsu.com>
Date: Thu, 10 Oct 2013 09:16:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1381327865-9089-1-git-send-email-maxim.uvarov@linaro.com>
In-Reply-To: <1381327865-9089-1-git-send-email-maxim.uvarov@linaro.com>
Subject: Re: [LTP] [PATCH]  syslog-lib.sh bash posix compliance
Reply-To: gaowanlong@cn.fujitsu.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: ltp-list@lists.sourceforge.net, Maxim Uvarov <maxim.uvarov@linaro.com>, linaro-networking@linaro.org

On 10/09/2013 10:11 PM, Maxim Uvarov wrote:
> /opt/ltp/testcases/bin/syslog02: 69: [: syslog-ng: unexpected operator
> + [ syslog-ng == syslog-ng ]
> Accoding to:
> http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
> [ STRING1 == STRING2 ]  True if the strings are equal. "=" may be
> used instead of "==" for strict POSIX compliance.
> 
> Because of busybox and other bash like shells look for posix syntax
> make it so.
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  testcases/kernel/syscalls/syslog/syslog-lib.sh |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> index 0885805..6b19b8d 100755
> --- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> +++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> @@ -65,11 +65,11 @@ setup()
>  		tst_resm TBROK "Testing is terminating due to a signal"
>  		cleanup 1' $TRAP_SIGS || exit 1
>  
> -	if [ "$SYSLOG_DAEMON" == "syslog" ]; then
> +	if [ "$SYSLOG_DAEMON" = "syslog" ]; then
>  		CONFIG_FILE="/etc/syslog.conf"
> -	elif [ "$SYSLOG_DAEMON" == "syslog-ng" ]; then
> +	elif [ "$SYSLOG_DAEMON" = "syslog-ng" ]; then
>  		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
> -	elif [ "$SYSLOG_DAEMON" == "rsyslog" ]; then
> +	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
>  		CONFIG_FILE="/etc/rsyslog.conf"
>  		RSYSLOG_CONFIG='$ModLoad imuxsock.so'
>  	else
> 


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
