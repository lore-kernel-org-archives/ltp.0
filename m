Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1ZDK7C-0001w8-Fc
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 22:16:22 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZDK7A-00015k-Ml
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 22:16:22 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 8F6CC347DB0
	for <ltp-list@lists.sourceforge.net>;
	Thu,  9 Jul 2015 22:16:14 +0000 (UTC)
Received: from tarantula.localdomain (ovpn-113-174.phx2.redhat.com
	[10.3.113.174])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t69MGCnN020759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 9 Jul 2015 18:16:14 -0400
Date: Thu, 9 Jul 2015 17:16:12 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20150709221612.GV17625@tarantula.localdomain>
References: <20150708194114.GA20060@tarantula.localdomain>
	<904998018.14796051.1436425198776.JavaMail.zimbra@redhat.com>
	<431985009.14827500.1436429949621.JavaMail.zimbra@redhat.com>
	<20150709124503.GM17625@tarantula.localdomain>
	<1737674583.15006076.1436449194123.JavaMail.zimbra@redhat.com>
	<20150709143700.GQ17625@tarantula.localdomain>
	<1448931194.15074761.1436453202001.JavaMail.zimbra@redhat.com>
	<20150709163341.GU17625@tarantula.localdomain>
	<438616599.15156602.1436460575320.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <438616599.15156602.1436460575320.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v3] syslog/syslog-lib.sh: support systemd journal
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
To: ltp-list@lists.sourceforge.net

rsyslog needs to use the imjournal module to communicate with
systemd-journald instead of imuxsock.  Check the system's
/etc/rsyslog.conf to see if LTP should use imjournal or imuxsock

Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>
---
 testcases/kernel/syscalls/syslog/syslog-lib.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index ef33517aa92b..e166d3a45261 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -71,12 +71,20 @@ setup()
 		CONFIG_FILE="/etc/syslog-ng/syslog-ng.conf"
 	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
 		CONFIG_FILE="/etc/rsyslog.conf"
-		log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf /etc/rsyslog.d/ | head -1)
-		RSYSLOG_CONFIG=$(cat <<EOF
+		if grep -q -r '^\$ModLoad[[:space:]]*imjournal' /etc/rsyslog.conf /etc/rsyslog.d/ ; then
+			systemd_journal=$(grep -Ehoi "^[^#].*(imjournal|workdirectory).*" -r /etc/rsyslog.conf /etc/rsyslog.d/)
+			RSYSLOG_CONFIG=$(cat <<EOF
+$systemd_journal
+EOF
+)
+		else
+			log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf /etc/rsyslog.d/ | head -1)
+			RSYSLOG_CONFIG=$(cat <<EOF
 \$ModLoad imuxsock.so
 $log_socket
 EOF
 )
+		fi
 	else
 		tst_resm TBROK "Couldn't find syslogd, syslog-ng or rsyslogd"
 		cleanup 1
-- 
1.9.4

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
