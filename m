From: Li Wang <liwang@redhat.com>
Date: Fri, 11 May 2018 15:43:58 +0800
Subject: [LTP] [PATCH] migrate_pages02: update for 4.15
In-Reply-To: <beeaa6fe1b73872ebe59b55c1fac419d37bc0b03.1515676244.git.jstancek@redhat.com>
References: <beeaa6fe1b73872ebe59b55c1fac419d37bc0b03.1515676244.git.jstancek@redhat.com>
Message-ID: <CAEemH2cJxf2rWjgXru3sTdNUyjJ1A2bVbq0bMjZyZO5SvObc=g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Ping~

I think this patch make sense for the tests, how about applying it?


On Thu, Jan 11, 2018 at 9:16 PM, Jan Stancek <jstancek@redhat.com> wrote:

> commit 313674661925 ("Unify migrate_pages and move_pages access checks")
> tightened checks for unprivileged user. It requires that callers real
> uid/gid matches target [es]uig/[es]gid and target to be dumpable
> (see __ptrace_may_access()).
>
> It broke the test, because change of only euid is no longer
> sufficient.
>
> This patch updates test to use setuid(), which sets all user IDs.
> Since we can't change uid back to 0, we fork additional child
> process for "caller", which is now free to drop privileges.
>
> This change should be backwards-compatible with kernels < 4.15.
> Tested on 4.15-rc6 and 4.14.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>
> Note: So far this is only in 4.15-rcX kernels and could still change
> before release.
>
>  .../syscalls/migrate_pages/migrate_pages02.c       | 72
> ++++++++++++----------
>  1 file changed, 41 insertions(+), 31 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> index faf96b6b79ee..8a5ff158c901 100644
> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> @@ -34,6 +34,7 @@
>  #include <sys/syscall.h>
>  #include <sys/wait.h>
>  #include <sys/mman.h>
> +#include <sys/prctl.h>
>  #include <errno.h>
>  #if HAVE_NUMA_H
>  #include <numa.h>
> @@ -159,12 +160,12 @@ static int check_addr_on_node(void *addr, int
> exp_node)
>         if (node == exp_node) {
>                 tst_resm(TPASS, "pid(%d) addr %p is on expected node: %d",
>                          getpid(), addr, exp_node);
> -               return 0;
> +               return TPASS;
>         } else {
>                 tst_resm(TFAIL, "pid(%d) addr %p not on expected node: %d "
>                          ", expected %d", getpid(), addr, node, exp_node);
>                 print_mem_stats(0, exp_node);
> -               return 1;
> +               return TFAIL;
>         }
>  }
>
> @@ -235,13 +236,13 @@ static void test_migrate_current_process(int node1,
> int node2, int cap_sys_nice)
>  static void test_migrate_other_process(int node1, int node2, int
> cap_sys_nice)
>  {
>         char *testp;
> -       int status, ret, tmp;
> -       pid_t child;
> -       int child_ready[2];
> +       int ret, tmp;
> +       pid_t child1, child2;
> +       int child1_ready[2];
>         int pages_migrated[2];
>
> -       /* setup pipes to synchronize child/parent */
> -       if (pipe(child_ready) == -1)
> +       /* setup pipes to synchronize child1/child2 */
> +       if (pipe(child1_ready) == -1)
>                 tst_resm(TBROK | TERRNO, "pipe #1 failed");
>         if (pipe(pages_migrated) == -1)
>                 tst_resm(TBROK | TERRNO, "pipe #2 failed");
> @@ -249,13 +250,13 @@ static void test_migrate_other_process(int node1,
> int node2, int cap_sys_nice)
>         tst_resm(TINFO, "other_process, cap_sys_nice: %d", cap_sys_nice);
>
>         fflush(stdout);
> -       child = fork();
> -       switch (child) {
> +       child1 = fork();
> +       switch (child1) {
>         case -1:
>                 tst_brkm(TBROK | TERRNO, cleanup, "fork");
>                 break;
>         case 0:
> -               close(child_ready[0]);
> +               close(child1_ready[0]);
>                 close(pages_migrated[1]);
>
>                 testp = SAFE_MALLOC(NULL, getpagesize());
> @@ -265,47 +266,56 @@ static void test_migrate_other_process(int node1,
> int node2, int cap_sys_nice)
>                 migrate_to_node(0, node1);
>                 check_addr_on_node(testp, node1);
>
> -               SAFE_SETEUID(NULL, ltpuser->pw_uid);
> +               SAFE_SETUID(NULL, ltpuser->pw_uid);
>
> -               /* signal parent it's OK to migrate child and wait */
> -               if (write(child_ready[1], &tmp, 1) != 1)
> +               /* commit_creds() will clear dumpable, restore it */
> +               if (prctl(PR_SET_DUMPABLE, 1))
> +                       tst_brkm(TBROK | TERRNO, NULL, "prctl");
> +
> +               /* signal child2 it's OK to migrate child1 and wait */
> +               if (write(child1_ready[1], &tmp, 1) != 1)
>                         tst_brkm(TBROK | TERRNO, NULL, "write #1 failed");
>                 if (read(pages_migrated[0], &tmp, 1) != 1)
>                         tst_brkm(TBROK | TERRNO, NULL, "read #1 failed");
>
> -               /* parent can migrate child process with same euid */
> -               /* parent can migrate child process with CAP_SYS_NICE */
> +               /* child2 can migrate child1 process if it's privileged */
> +               /* child2 can migrate child1 process if it has same uid */
>                 ret = check_addr_on_node(testp, node2);
>
>                 free(testp);
> -               close(child_ready[1]);
> +               close(child1_ready[1]);
>                 close(pages_migrated[0]);
>                 exit(ret);
> -       default:
> -               close(child_ready[1]);
> -               close(pages_migrated[0]);
> +       }
> +
> +       close(child1_ready[1]);
> +       close(pages_migrated[0]);
>
> +       fflush(stdout);
> +       child2 = fork();
> +       switch (child2) {
> +       case -1:
> +               tst_brkm(TBROK | TERRNO, cleanup, "fork");
> +               break;
> +       case 0:
>                 if (!cap_sys_nice)
> -                       SAFE_SETEUID(NULL, ltpuser->pw_uid);
> +                       SAFE_SETUID(NULL, ltpuser->pw_uid);
>
> -               /* wait until child is ready on node1, then migrate and
> +               /* wait until child1 is ready on node1, then migrate and
>                  * signal to check current node */
> -               if (read(child_ready[0], &tmp, 1) != 1)
> +               if (read(child1_ready[0], &tmp, 1) != 1)
>                         tst_brkm(TBROK | TERRNO, NULL, "read #2 failed");
> -               migrate_to_node(child, node2);
> +               migrate_to_node(child1, node2);
>                 if (write(pages_migrated[1], &tmp, 1) != 1)
>                         tst_brkm(TBROK | TERRNO, NULL, "write #2 failed");
>
> -               SAFE_WAITPID(cleanup, child, &status, 0);
> -               if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
> -                       tst_resm(TFAIL, "child returns %d", status);
> -               close(child_ready[0]);
> +               close(child1_ready[0]);
>                 close(pages_migrated[1]);
> -
> -               /* reset euid, so this testcase can be used in loop */
> -               if (!cap_sys_nice)
> -                       SAFE_SETEUID(NULL, 0);
> +               exit(TPASS);
>         }
> +
> +       tst_record_childstatus(NULL, child2);
> +       tst_record_childstatus(NULL, child1);
>  }
>
>  int main(int argc, char *argv[])
> --
> 1.8.3.1
>
>


-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180511/5e0c37ec/attachment-0001.html>
