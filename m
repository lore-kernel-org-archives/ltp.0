Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwWHU-000172-74
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 11:40:28 +0000
Date: Tue, 9 Jul 2013 13:42:06 +0200
From: chrubis@suse.cz
Message-ID: <20130709114206.GD30721@rei>
References: <1373363472-19210-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373363472-19210-1-git-send-email-penght@cn.fujitsu.com>
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

Hi!
> +# Configuration file for syslog, syslog-ng or rsyslogd
> +CONFIG_FILE=""
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
>  	SYSLOG_DAEMON="rsyslog"
>  fi

I think that the configuration related code should have
stayed in the testcase (as it is not a code to be reused).

So what I would do is to detect the syslog in the lib
and then use switch on the SYSLOG_DAEMON variable to set
the rest of the variables in the test code.

-- 
Cyril Hrubis
chrubis@suse.cz

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
