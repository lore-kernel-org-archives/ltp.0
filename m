Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1ZDCwq-0007vt-Sq
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 14:37:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDCwn-0007mH-EE
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 14:37:12 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id DBE2E2B9DCF
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 Jul 2015 14:37:02 +0000 (UTC)
Received: from tarantula.localdomain (ovpn-113-174.phx2.redhat.com
	[10.3.113.174])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t69Eb0gR009926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 10:37:02 -0400
Date: Thu, 9 Jul 2015 09:37:00 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20150709143700.GQ17625@tarantula.localdomain>
References: <20150708194114.GA20060@tarantula.localdomain>
	<904998018.14796051.1436425198776.JavaMail.zimbra@redhat.com>
	<431985009.14827500.1436429949621.JavaMail.zimbra@redhat.com>
	<20150709124503.GM17625@tarantula.localdomain>
	<1737674583.15006076.1436449194123.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline
In-Reply-To: <1737674583.15006076.1436449194123.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] syslog/syslog-lib.sh: support systemd journal
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 09:39:54AM -0400, Jan Stancek wrote:
> Do the testcases pass for you with this patch? They still fail for me with
> rsyslog-7.4.7-7.el7_0 and systemd-219-5.el7.
...
> which fails for me unless I add "$WorkDirectory" option.

Hmm, it worked in my tests last night, but it's failing today.  You're
right, the $WorkDirectory option fixed it.  Fortunately that's just a
minor tweak to the regex in the patch; see attached for a new version of
the patch.

::::::::::::
:: Before ::
::::::::::::
[root@localhost bin]# grep -i journal syslog-lib.sh
[root@localhost bin]# syslog01 ; echo $?
syslog01    0  TINFO  :  Send messages to syslogd at some level
syslog01    0  TINFO  :  and facility and grep for those messages.
syslog01    0  TINFO  :  testing whether messages are logged into log file
syslog01    0  TINFO  :  restarting syslog daemon
syslog01    0  TINFO  :  restarting syslog daemon
1

:::::::::::
:: After ::
:::::::::::
[root@localhost bin]# grep -i journal syslog-lib.sh
                systemd_journal=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r /etc/rsyslog.conf /etc/rsyslog.d/)
$systemd_journal
[root@localhost bin]# syslog01 ; echo $?
syslog01    0  TINFO  :  Send messages to syslogd at some level 
syslog01    0  TINFO  :  and facility and grep for those messages.
syslog01    0  TINFO  :  testing whether messages are logged into log file
syslog01    0  TINFO  :  restarting syslog daemon
syslog01    0  TINFO  :  restarting syslog daemon
0



> > I think it's ok to leave both modules enabled, though.  The default
> > rsyslog.conf in Fedora (up to F21) had both enabled:
> 
> It seems to duplicate messages for me in quite unpredictable way.
> After running syslog02:

With the updated patch, it looks ok for me:

[root@localhost bin]# systemctl stop rsyslog
[root@localhost bin]# cat /dev/null >/var/log/maillog
[root@localhost bin]# systemctl start rsyslog
[root@localhost bin]# syslog02
...
root@localhost bin]# cat /var/log/maillog
2015-07-09T10:32:10.383470-04:00 localhost syslogtst: syslogtst: mail emerg test.
2015-07-09T10:32:14.403420-04:00 localhost syslogtst: syslogtst: mail alert test.
2015-07-09T10:32:18.422884-04:00 localhost syslogtst: syslogtst: mail crit test.
2015-07-09T10:32:22.442509-04:00 localhost syslogtst: syslogtst: mail err test.
2015-07-09T10:32:26.461447-04:00 localhost syslogtst: syslogtst: mail warning test.
2015-07-09T10:32:30.480587-04:00 localhost syslogtst: syslogtst: mail notice test.
2015-07-09T10:32:34.499815-04:00 localhost syslogtst: syslogtst: mail info test.
2015-07-09T10:32:38.518913-04:00 localhost syslogtst: syslogtst: mail debug test.

-- 
Jeff Bastian

--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="syslog-lib.sh-support-systemd-journal.patch"

commit 4caed564ffbf2f1ac1d889d598e0fa8269562929 (HEAD, rsyslog-imjournal)
Author: Jeffrey Bastian <jbastian@redhat.com>
Date:   Wed Jul 8 14:06:48 2015 -0500

    syslog/syslog-lib.sh: support systemd journal
    
    rsyslog needs to use the imjournal module to communicate with
    systemd-journald. Copy the imjournal lines from the system's
    /etc/rsyslog.conf if they exist.
    
    Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index ef33517aa92b..d2a47112b493 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -72,8 +72,10 @@ setup()
 	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
 		CONFIG_FILE="/etc/rsyslog.conf"
 		log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf /etc/rsyslog.d/ | head -1)
+		systemd_journal=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r /etc/rsyslog.conf /etc/rsyslog.d/)
 		RSYSLOG_CONFIG=$(cat <<EOF
 \$ModLoad imuxsock.so
+$systemd_journal
 $log_socket
 EOF
 )

--sHrvAb52M6C8blB9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
--sHrvAb52M6C8blB9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--sHrvAb52M6C8blB9--

