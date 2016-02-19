From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 19 Feb 2016 07:18:27 -0500 (EST)
Subject: [LTP] [PATCH] mem/oom: do cleanup work for oom0{3,4,5}
In-Reply-To: <CAEemH2fnOp_FuXAbq9JPw6wtabCUQY5cxeCk0eGT9e041kx82g@mail.gmail.com>
References: <1454074573-5205-1-git-send-email-liwang@redhat.com>
 <CAEemH2fnOp_FuXAbq9JPw6wtabCUQY5cxeCk0eGT9e041kx82g@mail.gmail.com>
Message-ID: <731626733.22683827.1455884307705.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: ltp@lists.linux.it
> Sent: Wednesday, 17 February, 2016 2:51:09 AM
> Subject: Re: [LTP] [PATCH] mem/oom: do cleanup work for oom0{3,4,5}
> 
> sorry, ping~
> 
> On Fri, Jan 29, 2016 at 9:36 PM, Li Wang < liwang@redhat.com > wrote:
> 
> 
> oom03 should not test on aarch64 system which does not support NUMA, so I add
> the function to make sure it could be skiped.
> -----
> # ./oom03
> oom03 0 TINFO : set overcommit_memory to 1
> ...
> oom03 0 TINFO : expected victim is 29154.
> oom03 6 TPASS : victim signalled: (9) SIGKILL
> oom03 7 TCONF : numa_helper.c:86: syscall(236) __NR_get_mempolicy not
> supported on your arch
> oom03 8 TCONF : numa_helper.c:86: Remaining cases not appropriate for
> configuration
> 
> oom0{4,5} get fails on aarch64 system if run it in continuous twice(the
> first time skiped with TCONF, then the second time it will be failed).
> -----
> # ./oom05
> oom05 0 TINFO : set overcommit_memory to 1
> oom05 1 TCONF : numa_helper.c:86: syscall(236) __NR_get_mempolicy not
> supported on your arch
> oom05 2 TCONF : numa_helper.c:86: Remaining cases not appropriate for
> configuration
> 
> # ./oom05
> oom05 0 TINFO : set overcommit_memory to 1
> oom05 1 TBROK : mem.c:997: mkdir /dev/cgroup: errno=EEXIST(17): File exists
> oom05 2 TBROK : mem.c:997: Remaining cases broken
> oom05 0 TINFO : set overcommit_memory to 1
> 
> the reason is that it doesn't pass the cleanup to the tst_brkm() there.
> 
> Signed-off-by: Li Wang < liwang@redhat.com >

Li,

I pushed the part for oom04 and oom05.

As for oom03 changes, these should go in separately, because
it's not about cleanup.

Can you explain why first testoom() call on line 65 can't run on
aarch64? There doesn't seem to be anything NUMA specific.

It seems to me your problem is that is_numa() causes TCONF, which
it shouldn't. So, I'm thinking we should fix that:

diff --git a/testcases/kernel/lib/numa_helper.c b/testcases/kernel/lib/numa_helper.c
index 0074180991ec..91214fcd85d9 100644
--- a/testcases/kernel/lib/numa_helper.c
+++ b/testcases/kernel/lib/numa_helper.c
@@ -76,14 +76,22 @@ static int filter_nodemask_mem(nodemask_t * nodemask, unsigned long max_node)
 {
 #if MPOL_F_MEMS_ALLOWED
        unsigned long nodemask_size = max_node / 8;
+       int ret;
+
        memset(nodemask, 0, nodemask_size);
        /*
         * avoid numa_get_mems_allowed(), because of bug in getpol()
         * utility function in older versions:
         * http://www.spinics.net/lists/linux-numa/msg00849.html
         */
-       if (ltp_syscall(__NR_get_mempolicy, NULL, nodemask->n,
-                   max_node, 0, MPOL_F_MEMS_ALLOWED) < 0)
+       ret = syscall(__NR_get_mempolicy, NULL, nodemask->n,
+                   max_node, 0, MPOL_F_MEMS_ALLOWED);
+       /*
+        * If we don't have __NR_get_mempolicy assume we can use all
+        * present nodes. It is likely this is a system, that doesn't
+        * support NUMA and there's just 1 node.
+        */
+       if (ret < 0 && errno != ENOSYS)
                return -2;
 #else
        int i;

I'll look into trying this patch on aarch64 with oom03.

Regards,
Jan
