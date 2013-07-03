Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UuL3L-0007sI-Qp
	for ltp-list@lists.sourceforge.net; Wed, 03 Jul 2013 11:16:51 +0000
Date: Wed, 3 Jul 2013 13:18:23 +0200
From: chrubis@suse.cz
Message-ID: <20130703111823.GC2906@rei>
References: <1372389039-32494-1-git-send-email-penght@cn.fujitsu.com>
	<20130701141242.GA28876@rei.suse.cz>
	<51D386E8.8090603@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D386E8.8090603@cn.fujitsu.com>
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
> ...
> >> +if [ -n "$SYSLOG_NAME" ]; then
> >> +	if [ $HAVE_SYSTEMCTL == 1 ]; then
> >> +		status_daemon $SYSLOG_NAME
> >> +		if [ $? -ne 0 ]; then
> >> +			restart_daemon $SYSLOG_NAME
> >> +			FLAG=1
> >> +		fi
> ...
> >> +if [ $FLAG -eq 1 ]; then
> >> +	if [ $HAVE_SYSTEMCTL == 1 ]; then
> >> +		stop_daemon $SYSLOG_NAME
> >> +	else
> >> +		$SYSLOG_NAME stop >/dev/null 2>&1
> >> +	fi
> >> +fi
> >> +
> > 
> > We have similar code to restart cron in cron/cron02 and to restart nscd
> > in sssd/sssd-libs.sh.
> > 
> > What about we create a short library with a common code to restart
> > system daemons? So that any new testcase would just need to source the
> 
> A short library is in cmdlib.sh.
> stop_daemon, status_daemon and restart_daemon is used in the patch.

Then I do not understand why the patch adds systemctl detection
code to the cron_tests.sh. It is allready present in the cmdlib.sh

> The syslog daemon may be syslog, rsyslog, syslog-ng etc, 
> so I make the patch which is similar to syslog-lib.sh.

Which is why I object to the patch, it copies code from library to the
testcase, which is wrong in terms of longterm maintenance.

Ideal solution would be to move the syslog detection to the cmdlib.sh
and make a canonical name for syslog so that if you request to restart
the daemon in test with:

daemon_restart syslog

Everything is detected automatically, the syslog binary, systemd vs
system V init, etc. And everythig is kept in one file, no code
duplications.

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
