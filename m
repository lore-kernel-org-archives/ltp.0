Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UwzR1-0000uT-76
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 18:48:15 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwzQy-0005gZ-Sp
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 18:48:15 +0000
Date: Wed, 10 Jul 2013 14:48:04 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <267085751.2020967.1373482084934.JavaMail.root@redhat.com>
In-Reply-To: <1373424973-32151-1-git-send-email-penght@cn.fujitsu.com>
References: <1373424973-32151-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] syslog-lib.sh: Use lib to restart syslog
 service
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Peng Haitao" <penght@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Wednesday, 10 July, 2013 4:56:13 AM
> Subject: [LTP] [PATCH v2] syslog-lib.sh: Use lib to restart syslog service
> 
> Use restart_daemon() to restart syslog service.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

Hi,

looks good to me. I also ran all syslog testcases with this patch
on systemd/rsyslog based distro (RHEL7alpha) - all PASSed.

Regards,
Jan

> ---
>  testcases/kernel/syscalls/syslog/syslog-lib.sh | 65
>  ++++++--------------------
>  1 file changed, 15 insertions(+), 50 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> index c912d61..0885805 100755
> --- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> +++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> @@ -29,16 +29,6 @@ CONFIG_FILE=""
>  # rsyslogd .conf specific args.
>  RSYSLOG_CONFIG=
>  
> -# Command to restart syslog daemon.
> -SYSLOG_RESTART_COMMAND=
> -
> -# running under systemd?
> -if command -v systemctl >/dev/null 2>&1; then
> -	HAVE_SYSTEMCTL=1
> -else
> -	HAVE_SYSTEMCTL=0
> -fi
> -
>  # number of seconds to wait for another syslog test to complete
>  WAIT_COUNT=60
>  
> @@ -75,43 +65,15 @@ setup()
>  		tst_resm TBROK "Testing is terminating due to a signal"
>  		cleanup 1' $TRAP_SIGS || exit 1
>  
> -	# Check to see if syslogd or syslog-ng exists
> -	if [ -e /sbin/syslogd ]; then
> +	if [ "$SYSLOG_DAEMON" == "syslog" ]; then
>  		CONFIG_FILE="/etc/syslog.conf"
> -		SYSLOG_INIT_SCRIPT="/etc/init.d/sysklogd"
> -	elif command -v syslog-ng >/dev/null 2>&1; then
> +	elif [ "$SYSLOG_DAEMON" == "syslog-ng" ]; then
>  		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
> -		SYSLOG_INIT_SCRIPT="/etc/init.d/syslog-ng"
> -	elif command -v rsyslogd >/dev/null 2>&1; then
> +	elif [ "$SYSLOG_DAEMON" == "rsyslog" ]; then
>  		CONFIG_FILE="/etc/rsyslog.conf"
> -		SYSLOG_INIT_SCRIPT="/etc/init.d/rsyslog"
>  		RSYSLOG_CONFIG='$ModLoad imuxsock.so'
>  	else
> -		tst_resm TCONF "couldn't find syslogd, syslog-ng, or rsyslogd"
> -		cleanup	0
> -	fi
> -
> -	SVCNAME=$(basename $SYSLOG_INIT_SCRIPT)
> -	if [ $HAVE_SYSTEMCTL == 1 ]; then
> -		for svc in "$SVCNAME" "syslog"; do
> -			if systemctl is-enabled $svc.service >/dev/null 2>&1; then
> -				SYSLOG_RESTART_COMMAND="systemctl restart $svc.service"
> -				break
> -			fi
> -		done
> -	else
> -		# Fallback to /etc/init.d/syslog if $SYSLOG_INIT_SCRIPT
> -		# doesn't exist.
> -		for SYSLOG_INIT_SCRIPT in "$SYSLOG_INIT_SCRIPT" "/etc/init.d/syslog"; do
> -			if [ -x "$SYSLOG_INIT_SCRIPT" ]; then
> -				SYSLOG_RESTART_COMMAND="$SYSLOG_INIT_SCRIPT restart"
> -				break
> -			fi
> -		done
> -	fi
> -
> -	if [ -z "$SYSLOG_RESTART_COMMAND" ]; then
> -		tst_resm TBROK "Don't know how to restart $SVCNAME"
> +		tst_resm TBROK "Couldn't find syslogd, syslog-ng or rsyslogd"
>  		cleanup 1
>  	fi
>  
> @@ -152,15 +114,18 @@ restart_syslog_daemon()
>  		cleanup_command=$1
>  	fi
>  
> -	tst_resm TINFO "restarting syslog daemon via $SYSLOG_RESTART_COMMAND"
> +	tst_resm TINFO "restarting syslog daemon"
>  
> -	if $SYSLOG_RESTART_COMMAND >/dev/null 2>&1; then
> -		# XXX: this really shouldn't exist; if *syslogd isn't ready
> -		# once the restart directive has been issued, then it needs to
> -		# be fixed.
> -		sleep 2
> -	else
> -		$cleanup_command
> +	if [ -n "$SYSLOG_DAEMON" ]; then
> +		restart_daemon $SYSLOG_DAEMON
> +		if [ $? -eq 0 ]; then
> +			# XXX: this really shouldn't exist; if *syslogd isn't
> +			# ready once the restart directive has been issued,
> +			# then it needs to be fixed.
> +			sleep 2
> +		else
> +			$cleanup_command
> +		fi
>  	fi
>  }
>  
> --
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> See everything from the browser to the database with AppDynamics
> Get end-to-end visibility with application monitoring from AppDynamics
> Isolate bottlenecks and diagnose root cause in seconds.
> Start your free trial of AppDynamics Pro today!
> http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
