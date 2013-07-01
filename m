Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Utep1-0007LO-Nr
	for ltp-list@lists.sourceforge.net; Mon, 01 Jul 2013 14:11:15 +0000
Date: Mon, 1 Jul 2013 16:12:43 +0200
From: chrubis@suse.cz
Message-ID: <20130701141242.GA28876@rei.suse.cz>
References: <1372389039-32494-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372389039-32494-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] cron_tests.sh: fix a bug of syslog daemon is
 disabled
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

Hi!
> +. cmdlib.sh
> +FLAG=0
> +SYSLOG_NAME=""
> +
> +if command -v systemctl >/dev/null 2>&1; then
> +	HAVE_SYSTEMCTL=1
> +else
> +	HAVE_SYSTEMCTL=0
> +fi
> +
> +if command -v syslogd >/dev/null 2>&1; then
> +	SYSLOG_INIT_SCRIPT="/etc/init.d/syslog"
> +elif command -v syslog-ng >/dev/null 2>&1; then
> +	SYSLOG_INIT_SCRIPT="/etc/init.d/syslog-ng"
> +elif command -v rsyslogd >/dev/null 2>&1; then
> +	SYSLOG_INIT_SCRIPT="/etc/init.d/rsyslog"
> +fi
> +
> +# make sure syslog daemon is enabled
> +SVCNAME=$(basename $SYSLOG_INIT_SCRIPT)
> +if [ $HAVE_SYSTEMCTL == 1 ]; then
> +	for svc in "$SVCNAME" "sysklogd"
> +	do
> +		if systemctl is-enabled $svc.service >/dev/null 2>&1; then
> +			SYSLOG_NAME=$svc
> +			break
> +		fi
> +	done
> +else
> +	for SYSLOG_INIT_SCRIPT in "$SYSLOG_INIT_SCRIPT" "/etc/init.d/sysklogd"
> +	do
> +		if [ -x "$SYSLOG_INIT_SCRIPT" ]; then
> +			SYSLOG_NAME=$SYSLOG_INIT_SCRIPT
> +			break
> +		fi
> +	done
> +fi
> +
> +if [ -n "$SYSLOG_NAME" ]; then
> +	if [ $HAVE_SYSTEMCTL == 1 ]; then
> +		status_daemon $SYSLOG_NAME
> +		if [ $? -ne 0 ]; then
> +			restart_daemon $SYSLOG_NAME
> +			FLAG=1
> +		fi
> +	else
> +		$SYSLOG_NAME status >/dev/null 2>&1
> +		if [ $? -ne 0 ]; then
> +			$SYSLOG_NAME restart >/dev/null 2>&1
> +			FLAG=1
> +		fi
> +	fi
> +fi
> +
>  # Set return code RC variable to 0, it will be set with a non-zero return code
>  # in case of error. Set TFAILCNT to 0, increment if there occures a failure.
>  
> @@ -400,4 +454,12 @@ else
>  	TFAILCNT=$(( $TFAILCNT+1 ))
>  fi
>  
> +if [ $FLAG -eq 1 ]; then
> +	if [ $HAVE_SYSTEMCTL == 1 ]; then
> +		stop_daemon $SYSLOG_NAME
> +	else
> +		$SYSLOG_NAME stop >/dev/null 2>&1
> +	fi
> +fi
> +

We have similar code to restart cron in cron/cron02 and to restart nscd
in sssd/sssd-libs.sh.

What about we create a short library with a common code to restart
system daemons? So that any new testcase would just need to source the
lib and call:

daemon_restart "cron"

or:

daemon_stop "syslog"

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
