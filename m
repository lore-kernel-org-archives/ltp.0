Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NjSWn-0004o1-VM
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:16:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjSWl-0001CD-23
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:16:25 +0000
Message-ID: <4B822F2E.9030609@cn.fujitsu.com>
Date: Mon, 22 Feb 2010 15:15:58 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B7BA24F.2010705@linux.vnet.ibm.com>
	<364299f41002170910i336abf6eh72acbcbec9b72e7b@mail.gmail.com>
	<20100218042532.GC13013@rishikesh.in.ibm.com>
In-Reply-To: <20100218042532.GC13013@rishikesh.in.ibm.com>
Subject: Re: [LTP] [PATCH] sysctl03: sysctl returns EACCES after 2.6.33-rc1
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

at 2010-2-18 12:25, Rishikesh K Rajak wrote:
> On Wed, Feb 17, 2010 at 09:10:48AM -0800, Garrett Cooper wrote:
>> On Wed, Feb 17, 2010 at 12:01 AM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
>>> Hi Shi,
>>>
>>> Thanks for your patch, still i am finding time to look into your patch.
>>> Will reply you soon.
>>>
>>> http://marc.info/?l=ltp-list&m=126502355614857&w=2
>>
>> I looked at the patch finally.
> 
> Thanks garret.
>>
>> Please use TTERRNO instead of strerror(...) for the reported value.
>> There's no reason why you should use strerror(...) there as that's
>> already done with tst_res(3).
> 
> Shi, can you please incorporate changes which garret has suggested and
> resend the patch again to ltp-list@ .

  Ok, i recreated the patch based on garret's suggestion.

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
--- testcases/kernel/syscalls/sysctl/sysctl03.c.orig	2010-02-22 14:38:26.000000000 -0500
+++ testcases/kernel/syscalls/sysctl/sysctl03.c	2010-02-22 15:08:03.000000000 -0500
@@ -22,15 +22,18 @@
  *	sysctl03.c
  *
  * DESCRIPTION
- *	Testcase to check that sysctl(2) sets errno to EPERM correctly.
+ *	Testcase to check that sysctl(2) sets errno to EPERM or EACCES 
+ *	correctly. But it will return EACCES on kernels that are 2.6.33-rc1 
+ *	and higher.  
  *
  * ALGORITHM
  *	a.	Call sysctl(2) as a root user, and attempt to write data
  *		to the kernel_table[]. Since the table does not have write
- *		permissions even for the root, it should fail EPERM.
+ *		permissions even for the root, it should fail EPERM or EACCES.
  *	b.	Call sysctl(2) as a non-root user, and attempt to write data
  *		to the kernel_table[]. Since the table does not have write
- *		permission for the regular user, it should fail with EPERM.
+ *		permission for the regular user, it should fail with EPERM 
+ *		or EACCES.
  *
  * USAGE:  <for command-line>
  *  sysctl03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
@@ -43,6 +46,7 @@
  *
  * HISTORY
  *	07/2001 Ported by Wayne Boyer
+ *	02/2010 Updated by shiwh@cn.fujitsu.com
  *
  * RESTRICTIONS
  *	Test must be run as root.
@@ -82,6 +86,7 @@ int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
+	int exp_eno;
 
 	char osname[OSNAMESZ];
 	int osnamelth, status;
@@ -96,6 +101,13 @@ int main(int ac, char **av)
 
 	setup();
 
+	if ((tst_kvercmp(2, 6, 32)) <= 0){
+		exp_eno = EPERM;
+	} else {
+		exp_eno = EACCES;
+		exp_enos[0] = EACCES;
+	}
+
 	TEST_EXP_ENOS(exp_enos);
 
 	/* check looping state if -i option is given */
@@ -114,13 +126,10 @@ int main(int ac, char **av)
 		} else {
 			TEST_ERROR_LOG(TEST_ERRNO);
 
-			if (TEST_ERRNO != EPERM) {
-				tst_resm(TFAIL,
-					 "Expected EPERM (%d), got %d: %s",
-					 EPERM, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+			if (TEST_ERRNO != exp_eno) {
+				tst_resm(TFAIL|TTERRNO, "Got unxpected error");
 			} else {
-				tst_resm(TPASS, "Got expected EPERM error");
+				tst_resm(TPASS|TTERRNO, "Got expected error");
 			}
 		}
 
@@ -147,12 +156,10 @@ int main(int ac, char **av)
 			} else {
 				TEST_ERROR_LOG(TEST_ERRNO);
 
-				if (TEST_ERRNO != EPERM) {
-					tst_resm(TFAIL, "Expected EPERM, got "
-						 "%d", TEST_ERRNO);
+				if (TEST_ERRNO != exp_eno) {
+					tst_resm(TFAIL|TTERRNO, "Got unxpected error");
 				} else {
-					tst_resm(TPASS, "Got expected EPERM "
-						 "error");
+					tst_resm(TPASS|TTERRNO, "Got expected error");
 				}
 			}
 

Thank you.
- Shi Weihua

> 
> Thanks for your support.
> - Rishi
> 
>> Thanks,
>> -Garrett
> 
> 

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
