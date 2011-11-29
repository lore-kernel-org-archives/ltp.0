Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <salvatore.cro@st.com>) id 1RVP4p-0003tm-KB
	for ltp-list@lists.sourceforge.net; Tue, 29 Nov 2011 14:54:31 +0000
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RVP4o-0000q5-7D
	for ltp-list@lists.sourceforge.net; Tue, 29 Nov 2011 14:54:31 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75CD1151
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Nov 2011 14:54:22 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0AC1227C8
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Nov 2011 14:54:22 +0000 (GMT)
From: "Salvatore CRO'" <salvatore.cro@st.com>
Date: Tue, 29 Nov 2011 15:54:09 +0100
Message-Id: <1322578449-16716-1-git-send-email-salvatore.cro@st.com>
Subject: [LTP] [PATCH] creat08: fall back to nogroup if nobody unavailable.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Salvatore Cro <salvatore.cro@st.com>

From: Salvatore Cro <salvatore.cro@st.com>

Partially revert commit 87bc45c477f1dc9114ec3bceab05693de8b07180
which assumes nobody is always available when doing getgrnam.
Patch give chance to fall back to using nogroup instead.

Signed-off-by: Salvatore Cro <salvatore.cro@st.com>
---
 testcases/kernel/syscalls/creat/creat08.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index 30b451a..8d5d520 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -123,8 +123,10 @@ int main(int ac, char **av)
 		 * Get the group IDs of group1 and group2.
 		 */
 		if ((group = getgrnam("nobody")) == NULL) {
-			tst_brkm(TBROK|TERRNO, cleanup,
-				 "getgrnam(\"nobody\") failed");
+			if ((group = getgrnam("nogroup")) == NULL) {
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"getgrnam(\"nobody\") failed");
+			}
 		}
 		group1_gid = group->gr_gid;
 		if ((group = getgrnam("bin")) == NULL) {
-- 
1.7.4.4


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
