Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <wyang@windriver.com>) id 1OqNOq-0007QM-Id
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 09:45:04 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OqNOm-0005Mw-NX
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 09:45:04 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o7V9isR6029733
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 02:44:54 -0700 (PDT)
Message-ID: <4C7CD031.6060906@windriver.com>
Date: Tue, 31 Aug 2010 17:49:37 +0800
From: yangzi <wyang@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030805010508010901070901"
Subject: [LTP] [PATCH] [PATCH] Probe an bigger linear available address to
 attachment.
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

This is a multi-part message in MIME format.
--------------030805010508010901070901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

When running shmat01 on some platforms, it fails on
"addr = shmat(*(tc.shmid), base_addr + tc.offset,tc.flags);"
with a INVAL error. Look at codes in "setup()", it probes
an available address and align the address to SHMLBA. After
alignment, the new address is no guarantee to be available
any more. Here a bigger size is used to probe so that it's
still valid address after alignment.Pertaining to the function 
setup_tc(lc, &tc) ,when it outside of "for (i = 0; i < TST_TOTAL; 
i++)",and printf the tc.offset value is always 0,add correct a mistake
of original codes to move "setup_tc()" to right place.

Signed-off-by: Yang Wei <wei.yang@windriver.com>

wei yang
BR

--------------030805010508010901070901
Content-Type: text/x-patch;
	name="0001-Probe-an-bigger-linear-address-to-be-available-for-a.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-Probe-an-bigger-linear-address-to-be-available-for-a.pa";
	filename*1="tch"

From 13b73dc0cdd614273463959f6c6bbf460629168b Mon Sep 17 00:00:00 2001
From: Yang Wei <wyang@windriver.com>
Date: Tue, 31 Aug 2010 17:03:38 +0800
Subject: [PATCH] Probe an bigger linear available address to attachment.

When running shmat01 on some platforms, it fails on
"addr = shmat(*(tc.shmid), base_addr + tc.offset,tc.flags);"
with a EINVAL error. Look at codes in "setup()", it probes
an available address and align the address to SHMLBA. After
alignment, the new address is no guarantee to be available
any more. Here a bigger size is used to probe so that it's
still valid address after alignment.Add correct a mistake
of original codes to move "setup_tc()" to right place.

Signed-off-by: Yang Wei <wei.yang@windriver.com>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 4cb5eaf..f3bfe9d 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -120,11 +120,12 @@ int main(int ac, char **av)
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		/* setup test case paremeters */
-		setup_tc(lc, &tc);
 
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
+		
+			/* setup test case paremeters */
+			setup_tc(i, &tc);
 
 			/*
 			 * Use TEST macro to make the call
@@ -246,6 +247,8 @@ void check_functionality(int i)
  */
 void setup(void)
 {
+	int shm_id_2;
+
 	/* capture signals */
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
@@ -270,12 +273,18 @@ void setup(void)
 	}
 
 	/* Probe an available linear address for attachment */
-	if ((base_addr = shmat(shm_id_1, NULL, 0)) == (void *)-1) {
+	if ((shm_id_2 = shmget(shmkey++, INT_SIZE, SHM_RW | IPC_CREAT |
+			       IPC_EXCL)) == -1) {
+		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
+			 "resource 1 in setup()");
+	}
+	if ((base_addr = shmat(shm_id_2, NULL, 0)) == (void *)-1) {
 		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
 	}
 	if (shmdt((const void *)base_addr) == -1) {
 		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
 	}
+	rm_shm(shm_id_2);
 
 	/* some architectures (e.g. parisc) are strange, so better always align to
 	 * next SHMLBA address. */
-- 
1.6.0.4


--------------030805010508010901070901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--------------030805010508010901070901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030805010508010901070901--

