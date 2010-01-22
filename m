Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NYHhE-000818-9p
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 11:29:00 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NYHhD-00042A-13
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 11:29:00 +0000
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id A25E014C54E1B
	for <ltp-list@lists.sourceforge.net>;
	Fri, 22 Jan 2010 12:28:51 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314) id 1NYHh5-0005gJ-00
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 12:28:51 +0100
Date: Fri, 22 Jan 2010 13:28:12 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u6xoy4w5cfnueu@debian>
Subject: [LTP] [PATCH] Fix a probable typo in ftp03
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20100122122812.ZVGq-i5FIR1db82LZ-xZqIFDnYTh9T7EIu6Lhe8TQQA@z>

Hello,

there is no 'vftpd' mentioned in the script elsewhere, so I guess this is just a typo.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/network/tcp_cmds/ftp/ftp03 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/tcp_cmds/ftp/ftp03 b/testcases/network/tcp_cmds/ftp/ftp03
index e85a985..c934f85 100755
--- a/testcases/network/tcp_cmds/ftp/ftp03
+++ b/testcases/network/tcp_cmds/ftp/ftp03
@@ -48,7 +48,7 @@ do_setup()
 
     tst_setup
 
-    exists ftp useradd userdel vftpd
+    exists ftp useradd userdel vsftpd
 
     for vsftp_conf in /etc/vsftpd /etc; do
 
-- 
1.6.4.3




------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
