Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UwWLi-0007sx-1G
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 11:44:50 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwWLg-0003Fn-14
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 11:44:50 +0000
Date: Tue, 9 Jul 2013 07:44:36 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1642200808.1073511.1373370276887.JavaMail.root@redhat.com>
In-Reply-To: <1373363472-19210-1-git-send-email-penght@cn.fujitsu.com>
References: <1373363472-19210-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] syslog-lib.sh: Use lib to restart syslog service
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
> Sent: Tuesday, 9 July, 2013 11:51:12 AM
> Subject: [LTP] [PATCH] syslog-lib.sh: Use lib to restart syslog service
> 
> Use restart_daemon() to restart syslog service.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/syslog/syslog-lib.sh | 74
>  +++++---------------------
>  testcases/lib/cmdlib.sh                        |  8 +++
>  2 files changed, 20 insertions(+), 62 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> index c912d61..9bd411a 100755
> --- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
> +++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
> @@ -23,22 +23,6 @@ readonly MAILLOG=/var/log/maillog
>  # Signals to trap.
>  readonly TRAP_SIGS="1 2 3 6 11 15"
>  
> -# configuration file for syslog or syslog-ng
> -CONFIG_FILE=""
> -
> -# rsyslogd .conf specific args.
> -RSYSLOG_CONFIG=
> -
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
> @@ -75,46 +59,6 @@ setup()
>  		tst_resm TBROK "Testing is terminating due to a signal"
>  		cleanup 1' $TRAP_SIGS || exit 1
>  
> -	# Check to see if syslogd or syslog-ng exists
> -	if [ -e /sbin/syslogd ]; then
> -		CONFIG_FILE="/etc/syslog.conf"
> -		SYSLOG_INIT_SCRIPT="/etc/init.d/sysklogd"
> -	elif command -v syslog-ng >/dev/null 2>&1; then
> -		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
> -		SYSLOG_INIT_SCRIPT="/etc/init.d/syslog-ng"
> -	elif command -v rsyslogd >/dev/null 2>&1; then
> -		CONFIG_FILE="/etc/rsyslog.conf"
> -		SYSLOG_INIT_SCRIPT="/etc/init.d/rsyslog"
> -		RSYSLOG_CONFIG='$ModLoad imuxsock.so'
> -	else
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
> -		cleanup 1
> -	fi
> -
>  	# Back up configuration file
>  	if [ -f "$CONFIG_FILE" ]; then
>  		# Pause if another LTP syslog test is running
> @@ -152,14 +96,20 @@ restart_syslog_daemon()
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
>  	else
> +		tst_resm TBROK "Couldn't find syslogd, syslog-ng or rsyslogd"
>  		$cleanup_command
>  	fi
>  }
> diff --git a/testcases/lib/cmdlib.sh b/testcases/lib/cmdlib.sh
> index d6f43d2..23d5723 100644
> --- a/testcases/lib/cmdlib.sh
> +++ b/testcases/lib/cmdlib.sh
> @@ -158,13 +158,21 @@ else
>  	HAVE_SYSTEMCTL=0
>  fi
>  
> +# Configuration file for syslog, syslog-ng or rsyslogd
> +CONFIG_FILE=""

Hi,

This looks too generic. What if library need to pass config files for 2 libraries?

> +# rsyslog.conf specific args.
> +RSYSLOG_CONFIG=""
>  # Check to see if syslogd, syslog-ng or rsyslogd exists
>  SYSLOG_DAEMON=""
>  if command -v syslogd >/dev/null 2>&1; then
> +	CONFIG_FILE="/etc/syslog.conf"
>  	SYSLOG_DAEMON="syslog"
>  elif command -v syslog-ng >/dev/null 2>&1; then
> +	CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
>  	SYSLOG_DAEMON="syslog-ng"
>  elif command -v rsyslogd >/dev/null 2>&1; then
> +	CONFIG_FILE="/etc/rsyslog.conf"
> +	RSYSLOG_CONFIG='$ModLoad imuxsock.so'

RSYSLOG_CONFIG is specific to syscalls/syslog tests. Is user of this library expected
to care about how minimum config looks like for rsyslog?

Regards,
Jan

>  	SYSLOG_DAEMON="rsyslog"
>  fi
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
