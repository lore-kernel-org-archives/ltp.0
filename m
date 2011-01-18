Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pf7it-0000Yv-Fo
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:19:31 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pf7is-0004fG-Gs
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:19:31 +0000
Date: Tue, 18 Jan 2011 04:19:23 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1147194460.28452.1295342363604.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <307686026.100796.1293758695307.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] hugemmap05: fix pathname to remove underscore
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Garrett, any feedback/comment to merge this as well?

----- Original Message -----
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c | 68
> ++++++++++----------
> 1 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> index bce9fe6..85fee4d 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> @@ -51,18 +51,18 @@
> #include "usctest.h"
> 
> #define PROTECTION (PROT_READ | PROT_WRITE)
> -#define _PATH_MEMINFO "/proc/meminfo"
> -#define _PATH_SYS_HUGE "/sys/kernel/mm/hugepages"
> -#define _PATH_SYS_2M _PATH_SYS_HUGE "/hugepages-2048kB/"
> -#define _PATH_SYS_2M_OVER _PATH_SYS_2M "nr_overcommit_hugepages"
> -#define _PATH_SYS_2M_FREE _PATH_SYS_2M "free_hugepages"
> -#define _PATH_SYS_2M_RESV _PATH_SYS_2M "resv_hugepages"
> -#define _PATH_SYS_2M_SURP _PATH_SYS_2M "surplus_hugepages"
> -#define _PATH_SYS_2M_HUGE _PATH_SYS_2M "nr_hugepages"
> -#define _PATH_PROC_VM "/proc/sys/vm/"
> -#define _PATH_PROC_OVER _PATH_PROC_VM "nr_overcommit_hugepages"
> -#define _PATH_PROC_HUGE _PATH_PROC_VM "nr_hugepages"
> -#define _PATH_SHMMAX "/proc/sys/kernel/shmmax"
> +#define PATH_MEMINFO "/proc/meminfo"
> +#define PATH_SYS_HUGE "/sys/kernel/mm/hugepages"
> +#define PATH_SYS_2M PATH_SYS_HUGE "/hugepages-2048kB/"
> +#define PATH_SYS_2M_OVER PATH_SYS_2M "nr_overcommit_hugepages"
> +#define PATH_SYS_2M_FREE PATH_SYS_2M "free_hugepages"
> +#define PATH_SYS_2M_RESV PATH_SYS_2M "resv_hugepages"
> +#define PATH_SYS_2M_SURP PATH_SYS_2M "surplus_hugepages"
> +#define PATH_SYS_2M_HUGE PATH_SYS_2M "nr_hugepages"
> +#define PATH_PROC_VM "/proc/sys/vm/"
> +#define PATH_PROC_OVER PATH_PROC_VM "nr_overcommit_hugepages"
> +#define PATH_PROC_HUGE PATH_PROC_VM "nr_hugepages"
> +#define PATH_SHMMAX "/proc/sys/kernel/shmmax"
> #define MB (1024 * 1024)
> 
> /* Only ia64 requires this */
> @@ -116,15 +116,15 @@ int main(int argc, char *argv[])
> if (msg != NULL)
> tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
> if (opt_sysfs) {
> - strncpy(path, _PATH_SYS_2M_HUGE,
> - strlen(_PATH_SYS_2M_HUGE) + 1);
> - strncpy(pathover, _PATH_SYS_2M_OVER,
> - strlen(_PATH_SYS_2M_OVER) + 1);
> + strncpy(path, PATH_SYS_2M_HUGE,
> + strlen(PATH_SYS_2M_HUGE) + 1);
> + strncpy(pathover, PATH_SYS_2M_OVER,
> + strlen(PATH_SYS_2M_OVER) + 1);
> } else {
> - strncpy(path, _PATH_PROC_HUGE,
> - strlen(_PATH_PROC_HUGE) + 1);
> - strncpy(pathover, _PATH_PROC_OVER,
> - strlen(_PATH_PROC_OVER) + 1);
> + strncpy(path, PATH_PROC_HUGE,
> + strlen(PATH_PROC_HUGE) + 1);
> + strncpy(pathover, PATH_PROC_OVER,
> + strlen(PATH_PROC_OVER) + 1);
> }
> if (opt_alloc) {
> size = atoi(opt_allocstr);
> @@ -147,7 +147,7 @@ static void overcommit(void)
> 
> if (shmid != -1) {
> /* Use /proc/meminfo to generate an IPC key. */
> - key = ftok(_PATH_MEMINFO, strlen(_PATH_MEMINFO));
> + key = ftok(PATH_MEMINFO, strlen(PATH_MEMINFO));
> if (key == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "ftok");
> shmid = shmget(key, (long)(length * MB),
> @@ -167,22 +167,22 @@ static void overcommit(void)
> 
> if (opt_sysfs) {
> tst_resm(TINFO, "check sysfs before allocation.");
> - if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
> + if (checksys(PATH_SYS_2M_HUGE, "HugePages_Total",
> length / 2) != 0)
> return;
> - if (checksys(_PATH_SYS_2M_FREE, "HugePages_Free",
> + if (checksys(PATH_SYS_2M_FREE, "HugePages_Free",
> length / 2) != 0)
> return;
> - if (checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
> + if (checksys(PATH_SYS_2M_SURP, "HugePages_Surp",
> length / 2 - size) != 0)
> return;
> - if (checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd",
> + if (checksys(PATH_SYS_2M_RESV, "HugePages_Rsvd",
> length / 2) != 0)
> return;
> } else {
> tst_resm(TINFO,
> "check /proc/meminfo before allocation.");
> - fp = fopen(_PATH_MEMINFO, "r");
> + fp = fopen(PATH_MEMINFO, "r");
> if (fp == NULL)
> tst_brkm(TBROK|TERRNO, cleanup, "fopen");
> if (checkproc(fp, "HugePages_Total", length / 2) != 0)
> @@ -209,21 +209,21 @@ static void overcommit(void)
> }
> if (opt_sysfs) {
> tst_resm(TINFO, "check sysfs.");
> - if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
> + if (checksys(PATH_SYS_2M_HUGE, "HugePages_Total",
> length / 2) != 0)
> return;
> - if (checksys(_PATH_SYS_2M_FREE, "HugePages_Free", 0)
> + if (checksys(PATH_SYS_2M_FREE, "HugePages_Free", 0)
> != 0)
> return;
> - if (checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
> + if (checksys(PATH_SYS_2M_SURP, "HugePages_Surp",
> length / 2 - size) != 0)
> return;
> - if (checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd", 0)
> + if (checksys(PATH_SYS_2M_RESV, "HugePages_Rsvd", 0)
> != 0)
> return;
> } else {
> tst_resm(TINFO, "check /proc/meminfo.");
> - fp = fopen(_PATH_MEMINFO, "r");
> + fp = fopen(PATH_MEMINFO, "r");
> if (fp == NULL)
> tst_brkm(TBROK|TERRNO, cleanup, "fopen");
> if (checkproc(fp, "HugePages_Total", length / 2) != 0)
> @@ -253,7 +253,7 @@ static void cleanup(void)
> 
> TEST_CLEANUP;
> if (restore_shmmax) {
> - fd = open(_PATH_SHMMAX, O_WRONLY);
> + fd = open(PATH_SHMMAX, O_WRONLY);
> if (fd == -1)
> tst_resm(TWARN|TERRNO, "open");
> if (write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
> @@ -297,7 +297,7 @@ static void setup(void)
> tst_sig(FORK, DEF_HANDLER, cleanup);
> TEST_PAUSE;
> if (shmid != -1) {
> - fp = fopen(_PATH_SHMMAX, "r");
> + fp = fopen(PATH_SHMMAX, "r");
> if (fp == NULL)
> tst_brkm(TBROK|TERRNO, cleanup, "fopen");
> if (fgets(shmmax, BUFSIZ, fp) == NULL)
> @@ -306,7 +306,7 @@ static void setup(void)
> 
> if (atol(shmmax) < (long)(length * MB)) {
> restore_shmmax = 1;
> - fd = open(_PATH_SHMMAX, O_RDWR);
> + fd = open(PATH_SHMMAX, O_RDWR);
> if (fd == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "open");
> snprintf(buf, BUFSIZ, "%ld", (long)(length * MB));
> --
> 1.7.3.2

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
