From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 May 2017 17:08:08 +0200
Subject: [LTP] [RFC] [PATCH] move_pages12: Allocate and free hugepages
 prior	the test
In-Reply-To: <1251960161.9665123.1494425698679.JavaMail.zimbra@redhat.com>
References: <20170509140458.26343-1-chrubis@suse.cz>
 <510505896.9544779.1494406598104.JavaMail.zimbra@redhat.com>
 <20170510130125.GE29838@rei.suse.de>
 <1251960161.9665123.1494425698679.JavaMail.zimbra@redhat.com>
Message-ID: <20170510150807.GF29838@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I've got a hint from our kernel devs that the problem may be that the
> > per-node hugepage pool limits are set too low and increasing these
> > seems to fix the issue for me. Apparently the /proc/sys/vm/nr_hugepages
> > is global limit while the per-node limits are in sysfs.
> > 
> > Try increasing:
> > 
> > /sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages
> 
> I'm not sure how that explains why it fails mid-test and not immediately
> after start. It reminds me of sporadic hugetlbfs testsuite failures
> in "counters" testcase.

Probably some kind of lazy update / deffered freeing that still accounts
for freshly removed pages.

> diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
> index 443b0c6..fe8384f 100644
> --- a/testcases/kernel/syscalls/move_pages/move_pages12.c
> +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
> @@ -84,6 +84,12 @@ static void do_child(void)
>                         pages, nodes, status, MPOL_MF_MOVE_ALL));
>                 if (TEST_RETURN) {
>                         tst_res(TFAIL | TTERRNO, "move_pages failed");
> +                       system("cat /sys/devices/system/node/node*/hugepages/hugepages-2048kB/nr_hugepages");
> +                       system("cat /sys/devices/system/node/node*/hugepages/hugepages-2048kB/free_hugepages");
>                         break;
>                 }
>         }

Well that is a few forks away after the failure, if the race window is
small enough we will never see the real value but maybe doing open() and
read() directly would show us different values.

-- 
Cyril Hrubis
chrubis@suse.cz
