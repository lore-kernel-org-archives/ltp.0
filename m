From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 5 May 2020 03:28:34 -0400 (EDT)
Subject: [LTP] [bug?] clone(CLONE_IO) failing after kernel commit commit
 ef2c41cf38a7
In-Reply-To: <100149681.11244932.1588661282331.JavaMail.zimbra@redhat.com>
Message-ID: <1038674044.11248021.1588663714272.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm seeing an issue with CLONE_IO and libc' clone() on ppc64le,
where flags parameter appears to be sign extended before it's passed
to kernel syscall.

This is an issue since kernel commit ef2c41cf38a7 ("clone3: allow
spawning processes into cgroups"), because there's now a check for
flag that userspace didn't intend to pass:

static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
        __acquires(&cgroup_mutex) __acquires(&cgroup_threadgroup_rwsem)
        if (!(kargs->flags & CLONE_INTO_CGROUP)) {   // CLONE_INTO_CGROUP == 0x200000000ULL
                kargs->cset = cset;
                return 0;
        }

        f = fget_raw(kargs->cgroup);
        if (!f) {
                ret = -EBADF;
                goto err;
        }

Reproducer:

#define _GNU_SOURCE
#include <sched.h>
#include <stdio.h>
#include <sys/wait.h>

char stack[2*1024*1024];

static int do_child(void *arg)
{
        printf("hello");
        return 0;
}

int main(void)
{
        clone(do_child, stack+1024*1024, CLONE_IO|SIGCHLD, NULL, NULL, NULL, NULL);
        return 0;
}

reliably hits EBADF with glibc-2.31.9000-12.fc33.ppc64le and 5.7.0-0.rc2 kernel:
  clone(child_stack=0x1011ffe0, flags=CLONE_IO|0xffffffff00000000|SIGCHLD) = -1 EBADF (Bad file descriptor)

Regards,
Jan

