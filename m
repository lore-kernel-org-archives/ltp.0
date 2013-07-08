Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwBfQ-0006rw-FG
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 13:39:48 +0000
Date: Mon, 8 Jul 2013 15:41:26 +0200
From: chrubis@suse.cz
Message-ID: <20130708134126.GA24245@rei.suse.cz>
References: <1372905726-3944-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1372905726-3944-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] cron_tests.sh: fix a bug of syslog daemon is
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
> The case will check the /var/log/messages to see if there is a record of
> any crontab activity, so make sure syslog daemon is enabld.
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
>  testcases/commands/cron/cron_tests.sh | 15 +++++++++++++++
>  testcases/lib/cmdlib.sh               | 10 ++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/testcases/commands/cron/cron_tests.sh b/testcases/commands/cron/cron_tests.sh
> index b53a53a..339eda1 100644
> --- a/testcases/commands/cron/cron_tests.sh
> +++ b/testcases/commands/cron/cron_tests.sh
> @@ -57,6 +57,17 @@ else
>      LTPBIN=$LTPROOT/testcases/bin
>  fi
>  
> +. cmdlib.sh
> +FLAG=0
> +
> +if [ -n "$SYSLOG_DAEMON" ]; then
> +	status_daemon $SYSLOG_DAEMON
> +	if [ $? -ne 0 ]; then
> +		restart_daemon $SYSLOG_DAEMON
> +		FLAG=1
> +	fi
> +fi
> +
>  # Set return code RC variable to 0, it will be set with a non-zero return code
>  # in case of error. Set TFAILCNT to 0, increment if there occures a failure.
>  
> @@ -400,4 +411,8 @@ else
>  	TFAILCNT=$(( $TFAILCNT+1 ))
>  fi
>  
> +if [ $FLAG -eq 1 ]; then
> +	stop_daemon $SYSLOG_DAEMON
> +fi

I would rename the FLAG variable to something that actually defines its
purpose, for example SYSLOG_STARTED, the rest looks fine.

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
