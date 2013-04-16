Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1US104-0008Oq-LX
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 08:12:24 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1US103-0005YS-Ln
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 08:12:24 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r3G8CGrQ015488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Apr 2013 08:12:17 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r3G8CGHd011690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Apr 2013 08:12:17 GMT
Received: from abhmt101.oracle.com (abhmt101.oracle.com [141.146.116.53])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r3G8CGAs017420
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Apr 2013 08:12:16 GMT
From: shuang.qiu@oracle.com
Date: Tue, 16 Apr 2013 16:09:51 +0800
Message-Id: <1366099791-14020-1-git-send-email-shuang.qiu@oracle.com>
In-Reply-To: <shuang.qiu@oracle.com>
References: <shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] Replace "-E" option for sed.
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

From: Shuang Qiu <shuang.qiu@oracle.com>

The '-E' option is obsoleted and is no longer supported by sed in most
Linux distributions.  Use '-r' instead.
---
 .../kernel/syscalls/utimensat/utimensat_tests.sh   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index 6776087..b8eba51 100755
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -260,7 +260,7 @@ fi
 pattern="[[:space:]]*Defaults[[:space:]]*requiretty.*"
 if grep -q "^${pattern}" $sudoers; then
 	tst_resm TINFO "Comment requiretty in $sudoers for automated testing systems"
-	if ! sed -E -i.$$ -e "s/^($pattern)/#\1/" $sudoers; then
+	if ! sed -r -i.$$ -e "s/^($pattern)/#\1/" $sudoers; then
 		tst_resm TBROK "failed to mangle $sudoers properly"
 		exit 1
 	fi
-- 
1.7.7


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
