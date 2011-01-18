Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pf7kt-0003f5-QY
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:21:35 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pf7kr-0001sv-Fw
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 09:21:35 +0000
Date: Tue, 18 Jan 2011 04:21:27 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1490679386.28476.1295342487194.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <118966330.150220.1294295246942.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] oom: additonal fixes
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

Garrett, this is still pending for merging as well.

----- Original Message -----
> There are some bugs for the latest oom series and some cleanup.
> - oom01: with overcommit=2 is looping due to no check for return
> from mmap.
> - oom03: should not check for cpuset since it is a non-NUMA test.
> - oom02/oom04: fix cpuset prefix.
> 
> Signed-off-by: CAI Qian <caiqian@redhat.com>
> ---
> testcases/kernel/mem/oom/lib/oom.c | 20 +++++++++++++-------
> testcases/kernel/mem/oom/lib/oom.h | 4 ++--
> testcases/kernel/mem/oom/oom01.c | 10 ++--------
> testcases/kernel/mem/oom/oom02.c | 4 ++--
> testcases/kernel/mem/oom/oom03.c | 4 ++--
> testcases/kernel/mem/oom/oom04.c | 8 ++++----
> 6 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/testcases/kernel/mem/oom/lib/oom.c
> b/testcases/kernel/mem/oom/lib/oom.c
> index f0f1dac..ba37a7f 100644
> --- a/testcases/kernel/mem/oom/lib/oom.c
> +++ b/testcases/kernel/mem/oom/lib/oom.c
> @@ -22,7 +22,10 @@ void oom(int testcase, int mempolicy, int lite)
> {
> pid_t pid;
> int status;
> +#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
> + && HAVE_MPOL_CONSTANTS
> unsigned long nmask = 2;
> +#endif
> 
> switch(pid = fork()) {
> case -1:
> @@ -55,24 +58,24 @@ void oom(int testcase, int mempolicy, int lite)
> }
> }
> 
> -void testoom(int mempolicy, int lite)
> +void testoom(int mempolicy, int lite, int numa)
> {
> int fd;
> char buf[BUFSIZ] = "";
> char cpus[BUFSIZ] = "";
> 
> - if (!mempolicy) {
> + if (numa && !mempolicy) {
> gather_cpus(cpus);
> tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
> 
> - fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
> + fd = open(CPATH_NEW "/mems", O_WRONLY);
> if (fd == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> if (write(fd, "1", 1) != 1)
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> 
> - fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
> + fd = open(CPATH_NEW "/cpus", O_WRONLY);
> if (fd == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
> @@ -137,7 +140,7 @@ void gather_cpus(char *cpus)
> cpus[strlen(cpus) - 1] = '\0';
> }
> 
> -void alloc_mem(long int length, int testcase)
> +int alloc_mem(long int length, int testcase)
> {
> void *s;
> 
> @@ -146,7 +149,7 @@ void alloc_mem(long int length, int testcase)
> MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> if (s == MAP_FAILED) {
> if (testcase == OVERCOMMIT && errno == ENOMEM)
> - return;
> + return 1;
> else
> tst_brkm(TBROK|TERRNO, cleanup, "mmap");
> }
> @@ -156,6 +159,8 @@ void alloc_mem(long int length, int testcase)
> && madvise(s, length, MADV_MERGEABLE) == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "madvise");
> memset(s, '\a', length);
> +
> + return 0;
> }
> 
> void test_alloc(int testcase, int lite)
> @@ -164,7 +169,8 @@ void test_alloc(int testcase, int lite)
> alloc_mem(TESTMEM + MB, testcase);
> else
> while(1)
> - alloc_mem(LENGTH, testcase);
> + if (alloc_mem(LENGTH, testcase))
> + return;
> }
> 
> void umount_mem(char *path, char *path_new)
> diff --git a/testcases/kernel/mem/oom/lib/oom.h
> b/testcases/kernel/mem/oom/lib/oom.h
> index d40bc89..e7958bf 100644
> --- a/testcases/kernel/mem/oom/lib/oom.h
> +++ b/testcases/kernel/mem/oom/lib/oom.h
> @@ -19,10 +19,10 @@
> char overcommit[BUFSIZ];
> 
> void oom(int testcase, int mempolicy, int lite);
> -void testoom(int mempolicy, int lite);
> +void testoom(int mempolicy, int lite, int numa);
> long count_numa(void);
> int path_exist(const char *path, ...);
> -void alloc_mem(long int length, int testcase);
> +int alloc_mem(long int length, int testcase);
> void test_alloc(int testcase, int lite);
> void gather_cpus(char *cpus);
> void umount_mem(char *path, char *path_new);
> diff --git a/testcases/kernel/mem/oom/oom01.c
> b/testcases/kernel/mem/oom/oom01.c
> index 0076ada..8fb58c3 100644
> --- a/testcases/kernel/mem/oom/oom01.c
> +++ b/testcases/kernel/mem/oom/oom01.c
> @@ -79,18 +79,12 @@ int main(int argc, char *argv[])
> tst_brkm(TBROK|TERRNO, cleanup, "write");
> oom(OVERCOMMIT, 0, 0);
> 
> - tst_resm(TINFO, "start normal OOM testing.");
> if (lseek(fd, SEEK_SET, 0) == -1)
> tst_brkm(TBROK|TERRNO, cleanup, "lseek");
> if (write(fd, "1", 1) != 1)
> tst_brkm(TBROK|TERRNO, cleanup, "write");
> - oom(NORMAL, 0, 0);
> -
> - tst_resm(TINFO, "start OOM testing for mlocked pages.");
> - oom(MLOCK, 0, 0);
> -
> - tst_resm(TINFO, "start OOM testing for KSM pages.");
> - oom(KSM, 0, 0);
> + close(fd);
> + testoom(0, 0, 0);
> }
> cleanup();
> }
> diff --git a/testcases/kernel/mem/oom/oom02.c
> b/testcases/kernel/mem/oom/oom02.c
> index 22b811d..38533ef 100644
> --- a/testcases/kernel/mem/oom/oom02.c
> +++ b/testcases/kernel/mem/oom/oom02.c
> @@ -78,10 +78,10 @@ int main(int argc, char *argv[])
> close(fd);
> 
> tst_resm(TINFO, "process mempolicy.");
> - testoom(1, 0);
> + testoom(1, 0, 1);
> 
> tst_resm(TINFO, "process cpuset.");
> - testoom(0, 0);
> + testoom(0, 0, 1);
> }
> cleanup();
> }
> diff --git a/testcases/kernel/mem/oom/oom03.c
> b/testcases/kernel/mem/oom/oom03.c
> index cecaa9f..12c2063 100644
> --- a/testcases/kernel/mem/oom/oom03.c
> +++ b/testcases/kernel/mem/oom/oom03.c
> @@ -84,7 +84,7 @@ int main(int argc, char *argv[])
> if (write(fd, buf, strlen(buf)) != strlen(buf))
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> - testoom(0, 0);
> + testoom(0, 0, 0);
> 
> fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
> O_WRONLY);
> @@ -93,7 +93,7 @@ int main(int argc, char *argv[])
> if (write(fd, mem, strlen(mem)) != strlen(mem))
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> - testoom(0, 1);
> + testoom(0, 1, 0);
> }
> cleanup();
> }
> diff --git a/testcases/kernel/mem/oom/oom04.c
> b/testcases/kernel/mem/oom/oom04.c
> index 0f04591..5b403f4 100644
> --- a/testcases/kernel/mem/oom/oom04.c
> +++ b/testcases/kernel/mem/oom/oom04.c
> @@ -95,7 +95,7 @@ int main(int argc, char *argv[])
> close(fd);
> 
> tst_resm(TINFO, "process mempolicy.");
> - testoom(1, 0);
> + testoom(1, 0, 1);
> 
> fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
> O_WRONLY);
> @@ -104,7 +104,7 @@ int main(int argc, char *argv[])
> if (write(fd, mem, strlen(mem)) != strlen(mem))
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> - testoom(1, 1);
> + testoom(1, 1, 1);
> 
> tst_resm(TINFO, "process cpuset.");
> fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
> @@ -115,7 +115,7 @@ int main(int argc, char *argv[])
> if (write(fd, "-1", 2) != 2)
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> - testoom(0, 0);
> + testoom(0, 0, 1);
> 
> fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
> O_WRONLY);
> @@ -124,7 +124,7 @@ int main(int argc, char *argv[])
> if (write(fd, mem, strlen(mem)) != strlen(mem))
> tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> close(fd);
> - testoom(0, 1);
> + testoom(0, 1, 1);
> }
> cleanup();
> }
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
