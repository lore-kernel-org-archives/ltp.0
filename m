Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YdyTC-0002JS-Ff
	for ltp-list@lists.sourceforge.net; Fri, 03 Apr 2015 10:04:58 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YdyTA-0007Eu-RI
	for ltp-list@lists.sourceforge.net; Fri, 03 Apr 2015 10:04:58 +0000
Received: from zmail17.collab.prod.int.phx2.redhat.com
	(zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
	by mx5-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t33A4ob5029088
	for <ltp-list@lists.sourceforge.net>; Fri, 3 Apr 2015 06:04:50 -0400
Date: Fri, 3 Apr 2015 06:04:49 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1301134399.9357345.1428055489965.JavaMail.zimbra@redhat.com>
In-Reply-To: <214042481.9356038.1428054865150.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] mtest06 failures
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hi,

I'm seeing mtest06 occasionally failing:

<<<test_start>>>
tag=mtest06 stime=1427900338
cmdline="  mmap1 -x 0.05"
contacts=""
analysis=exit
<<<test_output>>>
mmap1       0  TINFO  :  created writing thread[70366651085264]
mmap1       0  TINFO  :  [70366651085264] - map, change contents, unmap files 1000 times
mmap1       0  TINFO  :  created reading thread[70366642696656]
mmap1       0  TINFO  :  [70366642696656] - read contents of memory (nil) 1000 times
mmap1       1  TFAIL  :  mmap1.c:400: thread [70366642696656] - process exited with -1
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=23 cstime=46
<<<test_end>>>

ret code -1 indicates, that it hit:
    if (map_address[j] != 'a')
        pthread_exit((void *)-1);

I think what happens is that map_write_unmap() unmaps the memory,
and something else mmaps into the same location. gdb breakpoints on
mmap found couple places which could be responsible, pthread_exit()
was one of them.

2 ideas came to mind:
1. clear map_address after munmap
   This however seems to go against what the testcase is trying to do
2. make sure mmap for map_address happens in place which is less likely
   to be used in future mmaps

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
index 5f13d48..2e9883c 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -64,6 +64,7 @@ static int verbose_print = 0;
 static char *volatile map_address;
 static jmp_buf jmpbuf;
 static volatile char read_lock = 0;
+static void *mmap_area;
 
 char *TCID = "mmap1";
 int TST_TOTAL = 1;
@@ -146,7 +147,7 @@ void *map_write_unmap(void *ptr)
 
        for (i = 0; i < args[2]; i++) {
 
-               map_address = mmap(0, (size_t) args[1], PROT_WRITE | PROT_READ,
+               map_address = mmap(mmap_area, (size_t) args[1], PROT_WRITE | PROT_READ,
                                   MAP_SHARED, (int)args[0], 0);
 
                if (map_address == (void *)-1) {
@@ -337,6 +338,13 @@ int main(int argc, char **argv)
                }
        }
 
+       mmap_area = mmap(0, 64*1024*1024, PROT_WRITE | PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+       if (mmap_area == (void *)-1)
+               perror("mmap_area: mmap()");
+       if (munmap(mmap_area, (size_t) 64*1024*1024) == -1)
+               perror("mmap_area: munmap()");
+       mmap_area += 32*1024*1024;
+
        if (verbose_print)
                tst_resm(TINFO, "Input parameters are: File size:  %d; "
                         "Scheduled to run:  %lf hours; "

I tested option 2 and it seems to have fixed the failure for me.
Any thoughts or comments? Is anyone else seeing failures from mtest06?

Regards,
Jan

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
