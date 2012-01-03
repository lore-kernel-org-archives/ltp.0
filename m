Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri4Nd-0006KW-GG
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:26:17 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri4Nc-0008L5-Qs
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 13:26:17 +0000
Message-ID: <4F0301F2.7070809@imgtec.com>
Date: Tue, 3 Jan 2012 13:26:10 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000509020408080705040001"
Subject: [LTP] [PATCH 21/21] network/nfsv4/acl: Second argument is execl
 should be a null-terminated array
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

--------------000509020408080705040001
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please review the attached patch

-- 
markos

--------------000509020408080705040001
Content-Type: text/plain;
	name="0021-network-nfsv4-acl-Second-argument-is-execl-should-be.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0021-network-nfsv4-acl-Second-argument-is-execl-should-be.pa";
	filename*1="tch"

From d83355aa7d9c197a60a1f1c5e495fa049a2f1861 Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 15:25:03 +0000
Subject: [PATCH 21/21] network/nfsv4/acl: Second argument is execl should be a null-terminated array

From exec manpage:
"The  const char *arg and subsequent ellipses in the execl(), execlp(), and
execle() functions can be thought of as arg0, arg1, ...,  argn.   Together
they  describe  a  list of one or more pointers to null-terminated strings
that represent the argument list available to the executed  program". This
change will silence gcc warnings.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 testcases/network/nfsv4/acl/acl1.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/testcases/network/nfsv4/acl/acl1.c b/testcases/network/nfsv4/acl/acl1.c
index 18a92a0..5040eee 100644
--- a/testcases/network/nfsv4/acl/acl1.c
+++ b/testcases/network/nfsv4/acl/acl1.c
@@ -57,12 +57,13 @@ int do_file_op(char* filename) {
 	result = 0;
 	FILE *fptr;
 	char str[256] = "./";
+	const char execl_args[] = {'\0'};
 	fptr = malloc(sizeof(FILE));
 
 	uid = geteuid();
 	strcat(str, filename);
 
-	exe = execl(str,NULL,NULL);
+	exe = execl(str,execl_args,NULL);
 	if (exe == -1 && errno!=EACCES)
 		result = result + OP_EXEC;
 
-- 
1.7.1


--------------000509020408080705040001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------000509020408080705040001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000509020408080705040001--


