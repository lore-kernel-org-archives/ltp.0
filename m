Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1ZCvDf-00043k-CN
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 19:41:23 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZCvDe-0008GM-8X
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2015 19:41:23 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 0CEF32932F4
	for <ltp-list@lists.sourceforge.net>;
	Wed,  8 Jul 2015 19:41:16 +0000 (UTC)
Received: from tarantula.localdomain (ovpn-113-174.phx2.redhat.com
	[10.3.113.174])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t68JfEVM000607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 8 Jul 2015 15:41:15 -0400
Date: Wed, 8 Jul 2015 14:41:14 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20150708194114.GA20060@tarantula.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] syslog/syslog-lib.sh: support systemd journal
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
systemd-journald. Copy the imjournal lines from the system's
/etc/rsyslog.conf if they exist.

Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>
---
 testcases/kernel/syscalls/syslog/syslog-lib.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
index ef33517aa92b..4a6514a3114e 100755
--- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
+++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
@@ -72,8 +72,10 @@ setup()
 	elif [ "$SYSLOG_DAEMON" = "rsyslog" ]; then
 		CONFIG_FILE="/etc/rsyslog.conf"
 		log_socket=$(grep -ho "^\$SystemLogSocketName .*" -r /etc/rsyslog.conf /etc/rsyslog.d/ | head -1)
+		systemd_journal=$(grep -hoi "^[^#].*imjournal.*" -r /etc/rsyslog.conf /etc/rsyslog.d/)
 		RSYSLOG_CONFIG=$(cat <<EOF
 \$ModLoad imuxsock.so
+$systemd_journal
 $log_socket
 EOF
 )
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
