Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XMAl7-0003Ln-9U
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 07:01:37 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XMAl5-0002R3-LK
	for ltp-list@lists.sourceforge.net; Tue, 26 Aug 2014 07:01:37 +0000
Date: Tue, 26 Aug 2014 03:01:26 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <496745505.24280864.1409036486630.JavaMail.zimbra@redhat.com>
In-Reply-To: <53FAF335.7090506@oracle.com>
References: <1291208815.23057199.1408691123381.JavaMail.zimbra@redhat.com>
	<53FAF335.7090506@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v4 3/3] fcntl16: Skip fcntl16 test block2 and
 block3 on NFS
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net

According to nfs(5), NLM supports advisory file locks only. So skip
fcntl16 test block 1 if NFS.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl16.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index 44b6a80..5ba508c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -51,6 +51,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include "tst_fs_type.h"
+
 #define SKIPVAL 0x0f00
 //#define       SKIP    SKIPVAL, 0, 0L, 0L, IGNORED
 #define SKIP 0,0,0L,0L,0
@@ -62,6 +64,7 @@
 #define	NOBLOCK		2	/* immediate success */
 #define	WILLBLOCK	3	/* blocks, succeeds, parent unlocks records */
 #define	TIME_OUT	10
+int NO_NFS = 1;			/* Test on NFS or not */
 
 typedef struct {
 	struct flock parent_a;
@@ -412,6 +415,10 @@ void setup(void)
 
 	tst_tmpdir();
 
+	/* On NFS or not */
+	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC)
+		NO_NFS = 0;
+
 	/* set up temp filename */
 	sprintf(tmpname, "fcntl4.%d", parent);
 
@@ -689,13 +696,17 @@ int main(int ac, char **av)
 		 * locking
 		 */
 		tst_resm(TINFO, "Entering block 2");
-		if (run_test(O_CREAT | O_RDWR | O_TRUNC, S_ISGID |
+		if (NO_NFS && run_test(O_CREAT | O_RDWR | O_TRUNC, S_ISGID |
 			     S_IRUSR | S_IWUSR, 0, 11)) {
 			tst_resm(TINFO, "Test case 2: with mandatory record "
 				 "locking FAILED");
 		} else {
-			tst_resm(TINFO, "Test case 2: with mandatory record "
-				 "locking PASSED");
+			if (NO_NFS)
+				tst_resm(TINFO, "Test case 2: with mandatory"
+					 " record locking PASSED");
+			else
+				tst_resm(TCONF, "Test case 2: NFS does not"
+					 " support mandatory locking");
 		}
 		tst_resm(TINFO, "Exiting block 2");
 
@@ -705,13 +716,17 @@ int main(int ac, char **av)
 		 * and no delay
 		 */
 		tst_resm(TINFO, "Entering block 3");
-		if (run_test(O_CREAT | O_RDWR | O_TRUNC | O_NDELAY,
+		if (NO_NFS && run_test(O_CREAT | O_RDWR | O_TRUNC | O_NDELAY,
 			     S_ISGID | S_IRUSR | S_IWUSR, 0, 11)) {
 			tst_resm(TINFO, "Test case 3: mandatory locking with "
 				 "NODELAY FAILED");
 		} else {
-			tst_resm(TINFO, "Test case 3: mandatory locking with "
-				 "NODELAY PASSED");
+			if (NO_NFS)
+				tst_resm(TINFO, "Test case 3: mandatory"
+					 " locking with NODELAY PASSED");
+			else
+				tst_resm(TCONF, "Test case 3: NFS does not"
+					 " support mandatory locking");
 		}
 		tst_resm(TINFO, "Exiting block 3");
 	}
-- 
1.8.3.1



----- Original Message -----
> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
> To: "Xiong Zhou" <xzhou@redhat.com>, ltp-list@lists.sourceforge.net
> Sent: Monday, August 25, 2014 4:26:29 PM
> Subject: Re: [LTP][PATCH v4 3/3] fcntl16: Skip fcntl16 test block2 and block3 on NFS
> 
> 
> 
> On 08/22/2014 11:05 AM, Xiong Zhou wrote:
> >
> > According to nfs(5), NLM supports advisory file locks only. So skip
> > fcntl16 test block2 and block3 if NFS.
> >
> > Signed-off-by: Xiong Zhou <xzhou@redhat.com>
> > ---
> 
> The entire series looks good for me.
> 
> Just found removed spaces below, but there is no need to resend the
> patch/series because it can be fixed at commit time. :)
> 
> Thanks.
> 
> Reviewed-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> 
> 

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
