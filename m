Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1VKQCp-0007eM-Gs
	for ltp-list@lists.sourceforge.net; Fri, 13 Sep 2013 10:02:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VKQCn-00089p-8P
	for ltp-list@lists.sourceforge.net; Fri, 13 Sep 2013 10:02:27 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r8DA2JBw022243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Sep 2013 06:02:19 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 13 Sep 2013 18:00:52 +0800
Message-Id: <1379066452-5943-1-git-send-email-zliu@redhat.com>
Subject: [LTP] [PATCH] syscalls/setgid: fixed a compiling error
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
To: LTP List <ltp-list@lists.sourceforge.net>

commit 7dc42c97 did some clean up, but brought some typos:
 1. getpwnam() is defined in /usr/include/pwd.h,
    it doesn't need 'static', or remove getpwnam() declaration.
 2. added duplicated 'static' key word.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/syscalls/setgid/setgid03.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/setgid/setgid03.c b/testcases/kernel/syscalls/setgid/setgid03.c
index 8b71401..8c76556 100644
--- a/testcases/kernel/syscalls/setgid/setgid03.c
+++ b/testcases/kernel/syscalls/setgid/setgid03.c
@@ -33,11 +33,11 @@ int TST_TOTAL = 1;
 
 static char ltpuser1[] = "nobody";
 static char root[] = "root";
-static struct passwd *getpwnam(), *ltpuser1pwent, *rootpwent;
+static struct passwd *ltpuser1pwent, *rootpwent;
 static gid_t mygid;
 
-static static void setup(void);
-static static void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
 int main(int ac, char **av)
 {
-- 
1.7.11.7


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. Consolidate legacy IT systems to a single system of record for IT
2. Standardize and globalize service processes across IT
3. Implement zero-touch automation to replace manual, redundant tasks
http://pubads.g.doubleclick.net/gampad/clk?id=51271111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
