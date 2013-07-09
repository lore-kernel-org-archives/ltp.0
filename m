Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwWD8-0001TP-IL
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 11:35:58 +0000
Date: Tue, 9 Jul 2013 13:37:32 +0200
From: chrubis@suse.cz
Message-ID: <20130709113732.GC30721@rei>
References: <1373361927-18695-1-git-send-email-penght@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373361927-18695-1-git-send-email-penght@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] cron02: Use lib to restart crond service
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
> +# Check to see if cron or crond exists
> +CROND_DAEMON=""
> +if command -v crond >/dev/null 2>&1; then
> +	CROND_DAEMON="crond"
> +elif command -v cron >/dev/null 2>&1; then
> +	CROND_DAEMON="cron"
> +fi

This one is not going to work for Gentoo where you can install different
cron daemons and the init scripts are named accordingly to the package
names...

However the previous code did the same and this is a good cleanup so I'm
fine with the change.

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
