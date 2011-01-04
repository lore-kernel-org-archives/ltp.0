Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PZxH4-00046p-Dp
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 03:09:26 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZxH2-0001de-3H
	for ltp-list@lists.sourceforge.net; Tue, 04 Jan 2011 03:09:26 +0000
Date: Mon, 3 Jan 2011 22:09:16 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <474711911.119247.1294110556912.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <AANLkTi=PvGB+oDjF8D1sVtUrXgAHUuuL8JQ+nzvTqjTa@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] hugemmap05 issues
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi Garrett,

----- Original Message -----
> Looking over the code, there are a number of flawed assumptions in
> terms of how things are executed and it seems that the code is overly
> complex. Before I go and do something rash though, I wanted others to
> look at the code (in particular the areas I'm touching) and see
> whether or not I'm just blowing something out my rear.
> As-is the code doesn't compile due to warnings.
> This is a WIP patch (please ignore the whitespace and style to a
> small degree as I know gmail will fubar the formatting).
> Thanks,
> -Garrett
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> index 8893f84..2ea1363 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
> @@ -97,7 +97,7 @@ static option_t options[] = {
> { NULL, NULL, NULL}
> };
> static void setup(void);
> -static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
> +static void cleanup(void);
Cyril suggested me to change this way to use LTP_ATTRIBUTE_NORETURN, as
cleanup() will call tst_exit() anyway. What's the issues are you
facing?
> static void overcommit(void);
> static void write_bytes(void *addr);
> static void read_bytes(void *addr);
> @@ -135,6 +135,7 @@ int main(int argc, char *argv[])
> overcommit();
> }
> cleanup();
> + tst_exit();
This is not needed as mentioned before.
> }
> 
> static void overcommit(void)
> @@ -154,8 +155,15 @@ static void overcommit(void)
> if (shmid == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "shmget");
> } else {
> - snprintf(s, BUFSIZ, "%s/hugemmap05/file", get_tmp_tstdir());
> - fd = open(s, O_CREAT | O_RDWR, 0755);
I did not write those code. My code is this,
        } else {
                snprintf(s, BUFSIZ, "%s/hugemmap05/file", TESTDIR);
                fd = open(s, O_CREAT | O_RDWR, 0755);

Are you using the latest patch?
http://marc.info/?l=ltp-list&m=129170706228725&w=2

Again, what issues are your facing with this code?
> + char *tmp_tstdir;
> +
> + tmp_tstdir = get_tst_tmpdir();
> + if (tmp_tstdir == NULL)
> + tst_brkm(TBROK|TERRNO, cleanup, "get_tmp_tstdir failed");
> + snprintf(s, BUFSIZ, "%s/hugemmap05/file", tmp_tstdir);
> + free(tmp_tstdir);
> +
> + fd = open(s, O_CREAT|O_RDWR, 0755);
> if (fd == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "open");
> addr = mmap(ADDR, (long)(length * MB), PROTECTION, FLAGS, fd,
> @@ -195,19 +203,14 @@ static void overcommit(void)
> return;
> fclose(fp);
> }
> - if (shmid != -1) {
> - tst_resm(TINFO, "shmid: 0x%x", shmid);
> - shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
> - if (shmaddr == (void *)-1)
> - tst_brkm(TBROK|TERRNO, cleanup, "shmat");
> - write_bytes(shmaddr);
> - read_bytes(shmaddr);
> - } else {
> - write_bytes(addr);
> - read_bytes(addr);
> - }
As you can read from the help(), the test can allocate hugepages either
from shmget() or mmap(). In case of shmget(), a global variable shmid with
the default value -1 will be change to 1 via command-line,

static option_t options[] = {
        { "s", &opt_sysfs,      NULL},
        { "m", &shmid,          NULL},
        { "a:", &opt_alloc,     &opt_allocstr},
        { NULL, NULL,           NULL}
};

Therefore, there is a need to call shmat(). That is why it only call it
when shmid != -1. In case of mmap(), there is no need to call shmat().
> + tst_resm(TINFO, "shmid: 0x%x", shmid);
> + shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
> + if (shmaddr == (void *)-1)
> + tst_brkm(TBROK|TERRNO, cleanup, "shmat");
> + write_bytes(shmaddr);
> + read_bytes(shmaddr);
> if (opt_sysfs) {
> - tst_resm(TINFO, "check sysfs.");
> + tst_resm(TINFO, "checking sysfs.");
> if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
> length / 2) != 0)
> return;
> @@ -221,7 +224,7 @@ static void overcommit(void)
> != 0)
> return;
> } else {
> - tst_resm(TINFO, "check /proc/meminfo.");
> + tst_resm(TINFO, "checking /proc/meminfo.");
If you are going to change the syntax here, there are many other places
also need to changed to be consistent like,
"check sysfs."
"check /proc/meminfo before allocation."
etc
> fp = fopen(_PATH_MEMINFO, "r");
> if (fp == NULL)
> tst_brkm(TBROK|TERRNO, cleanup, "fopen");
> @@ -236,18 +239,17 @@ static void overcommit(void)
> return;
> fclose(fp);
> }
> - if (shmid != -1) {
> - if (shmdt(shmaddr) != 0)
> - tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
> - } else {
> - munmap(addr, (long)(length * MB));
> - close(fd);
> - unlink(s);
> - }
Same here. We call shmdt only in case of shmget(), and call munmap for
mmap().

Thanks.

CAI Qian
> + shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
> + if (shmaddr == (void *)-1)
> + tst_brkm(TBROK|TERRNO, cleanup, "shmat failed");
> + if (shmdt(shmaddr) != 0)
> + tst_brkm(TBROK|TERRNO, cleanup, "shmdt failed");
> }
> 
> static void cleanup(void)
> {
> + char *tmp_tstdir;
> + void *shmaddr;
> int fd;
> 
> TEST_CLEANUP;
> @@ -262,38 +264,49 @@ static void cleanup(void)
> fd = open(path, O_WRONLY);
> if (fd == -1)
> tst_resm(TWARN|TERRNO, "open");
> - tst_resm(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
> - if (write(fd, nr_hugepages,
> - strlen(nr_hugepages)) != strlen(nr_hugepages))
> + tst_resm(TINFO, "restoring nr_hugepages to %s", nr_hugepages);
> + if (write(fd, nr_hugepages, strlen(nr_hugepages)) !=
> + strlen(nr_hugepages))
> tst_resm(TWARN|TERRNO, "write");
> close(fd);
> 
> fd = open(pathover, O_WRONLY);
> if (fd == -1)
> tst_resm(TWARN|TERRNO, "open");
> - tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
> + tst_resm(TINFO, "restoring nr_overcommit_hugepages to %s.",
> nr_overcommit_hugepages);
> if (write(fd, nr_overcommit_hugepages,
> strlen(nr_overcommit_hugepages))
> != strlen(nr_overcommit_hugepages))
> tst_resm(TWARN|TERRNO, "write");
> close(fd);
> 
> - snprintf(buf, BUFSIZ, "%s/hugemmap05", get_tst_tmpdir());
> + tmp_tstdir = get_tst_tmpdir();
> + if (tmp_tstdir == NULL)
> + tst_brkm(TBROK|TERRNO, NULL, "tmp_tstdir failed");
> + snprintf(buf, BUFSIZ, "%s/hugemmap05", tmp_tstdir);
> + free(tmp_tstdir);
> + shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
> + if (shmaddr == (void *)-1)
> + tst_brkm(TBROK|TERRNO, cleanup, "shmat");
> + else if (shmdt(shmaddr) == -1)
> + tst_resm(TBROK|TERRNO, "shmdt failed");
> + else if (shmctl(shmid, IPC_RMID, NULL) == -1)
> + tst_resm(TBROK|TERRNO,
> + "shmctl(..., IPC_RMID, ...) failed");
> if (umount(buf) == -1)
> tst_resm(TWARN|TERRNO, "umount");
> - if (shmid != -1) {
> - tst_resm(TINFO|TERRNO, "shmdt");
> - shmctl(shmid, IPC_RMID, NULL);
> - }
> + tst_rmdir();
> 
> }
> 
> static void setup(void)
> {
> FILE *fp;
> + char *tmp_tstdir;
> int fd;
> 
> tst_sig(FORK, DEF_HANDLER, cleanup);
> + tst_tmpdir();
> TEST_PAUSE;
> if (shmid != -1) {
> fp = fopen(_PATH_SHMMAX, "r");
> @@ -332,7 +345,7 @@ static void setup(void)
> tst_brkm(TBROK|TERRNO, cleanup, "write");
> if (lseek(fd, 0, SEEK_SET) == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "lseek");
> - snprintf(buf, BUFSIZ, "%ld", size);
> + snprintf(buf, BUFSIZ, "%zd", size);
> if (write(fd, buf, strlen(buf)) != strlen(buf))
> tst_brkm(TBROK|TERRNO, cleanup,
> "failed to change nr_hugepages.");
> @@ -356,13 +369,18 @@ static void setup(void)
> tst_brkm(TBROK|TERRNO, cleanup, "write");
> if (lseek(fd, 0, SEEK_SET) == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "lseek");
> - snprintf(buf, BUFSIZ, "%ld", size);
> + snprintf(buf, BUFSIZ, "%zd", size);
> if (write(fd, buf, strlen(buf)) != strlen(buf))
> tst_brkm(TBROK|TERRNO, cleanup,
> "failed to change nr_hugepages.");
> close(fd);
> 
> - snprintf(buf, BUFSIZ, "%s/hugemmap05", get_tst_tmpdir());
> + tmp_tstdir = get_tst_tmpdir();
> + if (tmp_tstdir == NULL)
> + tst_brkm(TBROK|TERRNO, NULL, "tmp_tstdir failed");
> + snprintf(buf, BUFSIZ, "%s/hugemmap05", tmp_tstdir);
> + free(tmp_tstdir);
> +
> if (mkdir(buf, 0700) == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
> if (mount(NULL, buf, "hugetlbfs", 0, NULL) == -1)
> @@ -447,4 +465,4 @@ static int checkproc(FILE *fp, char *pattern, int
> value)
> return 1;
> }
> return 0;
> -}
> \ No newline at end of file
> +}

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
