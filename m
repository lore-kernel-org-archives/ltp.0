From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 22 Feb 2019 09:22:29 +0200
Subject: [LTP] [PATCH 1/5] syscalls/fanotify03: defined additional tcase
 members for added control
In-Reply-To: <20190221164234.GD17813@rei.lan>
References: <20190122223526.GA32694@lithium.mbobrowski.org>
 <20190221164234.GD17813@rei.lan>
Message-ID: <CAOQ4uxhbWmS2_jOjenZA11jk_TNwBE8KNUs+Na-vC13gPt+_2g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Feb 21, 2019 at 6:43 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> I've finally started to look into this patchset (sorry for the long delay), the
> changes to fanotify03 looks good to me and I wanted to push them, but I'm
> getting rejects:
>
> Checking patch testcases/kernel/syscalls/fanotify/fanotify03.c...
> error: while searching for:
>
> static pid_t child_pid;
>
> static unsigned long long event_set[EVENT_MAX];
> static unsigned int event_resp[EVENT_MAX];
>
> static char event_buf[EVENT_BUF_LEN];
> static int support_perm_events;
>
> static struct tcase {
>         const char *tname;
>         struct fanotify_mark_type mark;
> } tcases[] = {
>         {
>                 "inode mark permission events",
>                 INIT_FANOTIFY_MARK_TYPE(INODE),
>         },
>         {
>                 "mount mark permission events",
>                 INIT_FANOTIFY_MARK_TYPE(MOUNT),
>         },
>         {
>                 "filesystem mark permission events",
>                 INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
>         },
> };
>
> static void generate_events(void)
>
> error: patch failed: testcases/kernel/syscalls/fanotify/fanotify03.c:42
> Hunk #3 succeeded at 147 (offset -21 lines).
> error: while searching for:
>                 }
>         } else {
>                 /*
>                  * To distigouish between perm event not supported and
>                  * filesystem mark not supported.
>                  */
>                 support_perm_events = 1;
>
>
> Is this based on some yet to be merged patchset?

I see the problem.
It is based on an older version of
syscalls/fanotify03: add test for FAN_MARK_FILESYSTEM permission events

You removed support_perm_events on commit or maybe I sent another
version based on your review - not sure.

Attached the missing prerequisite patch.

You may choose to drop support_perm_events again or add a test
for kernel permission events support in setup(), but we do need to
distinguish between support_exec_events (which comes in a later patch)
and FAN_MARK_FILESYSTEM support, as exec events may be backported
to distro stable kernels and FAN_MARK_FILESYSTEM is less likely to be
backported.

Thanks,
Amir.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-syscalls-fanotify03-add-test-for-FAN_MARK_FILESYSTEM.patch
Type: text/x-patch
Size: 1218 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190222/ac8e5842/attachment.bin>
