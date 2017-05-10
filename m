From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 10 May 2017 10:14:58 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] move_pages12: Allocate and free hugepages
 prior	the test
In-Reply-To: <20170510130125.GE29838@rei.suse.de>
References: <20170509140458.26343-1-chrubis@suse.cz>
 <510505896.9544779.1494406598104.JavaMail.zimbra@redhat.com>
 <20170510130125.GE29838@rei.suse.de>
Message-ID: <1251960161.9665123.1494425698679.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> I've got a hint from our kernel devs that the problem may be that the
> per-node hugepage pool limits are set too low and increasing these
> seems to fix the issue for me. Apparently the /proc/sys/vm/nr_hugepages
> is global limit while the per-node limits are in sysfs.
> 
> Try increasing:
> 
> /sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages

I'm not sure how that explains why it fails mid-test and not immediately
after start. It reminds me of sporadic hugetlbfs testsuite failures
in "counters" testcase.

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 443b0c6..fe8384f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -84,6 +84,12 @@ static void do_child(void)
                        pages, nodes, status, MPOL_MF_MOVE_ALL));
                if (TEST_RETURN) {
                        tst_res(TFAIL | TTERRNO, "move_pages failed");
+                       system("cat /sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages");
+                       system("cat /sys/devices/system/node/node*/hugepages/hugepages-2048kB/free_hugepages");
                        break;
                }
        }

I have 2 huge pages on each node when it fails:

tst_test.c:847: INFO: Timeout per run is 0h 05m 00s
move_pages12.c:190: INFO: Free RAM 45745800 kB
move_pages12.c:86: FAIL: move_pages failed: ENOMEM
moving to node: 0
2
2
0
2

I'm trying now with 40 instead of 4 huge pages.

Regards,
Jan


> 
> Also if I write 0 to the nr_hugepages there while the test is running
> move_pages() fails with ENOMEM reproducibly.
> 
> I will prepare a patch that will increase these limits in the test setup
> temporarily.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
