Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XwSB2-0006dE-7x
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 08:54:20 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XwSB1-0003dG-AE
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 08:54:20 +0000
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Thu, 4 Dec 2014 03:54:13 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
	[9.57.198.23])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A0F576E803C
	for <ltp-list@lists.sourceforge.net>;
	Thu,  4 Dec 2014 03:45:59 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sB48s5LQ27918364
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 08:54:05 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sB48s4WY017029
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 03:54:04 -0500
Received: from localhost.localdomain ([9.125.7.6])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sB48s39H017000
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Dec 2014 03:54:04 -0500
Date: Thu, 4 Dec 2014 16:34:00 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20141204083400.GA2704@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] syscalls/getgroups/getgroups01: set supplementary
 groups to prevent TCONF
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

Hi,

On our systems, root belongs to only one group. getgroups01 has this
result:

getgroups01    1  TPASS  :  getgroups failed as expected with EINVAL
getgroups01    2  TPASS  :  getgroups did not modify the gidset array
getgroups01    3  TCONF  :  getgroups01.c:129: getgroups returned 1; unable to test that using ngrps >=1 but less than number of grps
getgroups01    4  TPASS  :  getgroups(NGROUPS,gidset) returned 1 contains gid 0 (from getgid)

Looks like we can set supplementary groups by setgroups() in setup(),
then 3# will succeed if running as privileged user. If we call
setgroups(), then initgroups() can be left out. With this patch, when
running as root:

getgroups01    1  TPASS  :  getgroups failed as expected with EINVAL
getgroups01    2  TPASS  :  getgroups did not modify the gidset array
getgroups01    3  TPASS  :  getgroups failed as expected with EINVAL
getgroups01    4  TPASS  :  getgroups(NGROUPS,gidset) returned 3 contains gid 0 (from getgid)

running as unprivileged user:

getgroups01    1  TPASS  :  getgroups failed as expected with EINVAL
getgroups01    2  TPASS  :  getgroups did not modify the gidset array
getgroups01    3  TCONF  :  getgroups01.c:127: getgroups returned 1; unable to test that using ngrps >=1 but less than number of grps
getgroups01    4  TPASS  :  getgroups(NGROUPS,gidset) returned 1 contains gid 1001 (from getgid)


From caf7b59519b0f9323805aae9d6a607a30ea3ba4e Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 4 Dec 2014 16:07:25 +0800
Subject: [PATCH] set supplementary groups instead of relying on system setting

On a system where root belongs to only one group, the 3# test of
getgroups01 will fail by TCONF. But if we call setgroups() to set
supplementary groups, the test can succeed if run as privileged user.

With this patch, it'll still fail by TCONF when being run by
unprivileged user.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/getgroups/getgroups01.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
index 9fb4c98..28559d3 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups01.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
@@ -74,8 +74,6 @@ int main(int ac, char **av)
 	int i;
 	int entries;
 
-	initgroups("root", 0);
-
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
@@ -183,6 +181,9 @@ static void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
+
+	GID_T init_gidset[3] = {0, 1, 2};
+	setgroups(3, init_gidset);
 }
 
 static void cleanup(void)
-- 
1.9.3


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
