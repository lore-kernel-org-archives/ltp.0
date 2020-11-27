From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2020 17:36:02 +0200
Subject: [LTP] [PATCH v4 0/6] Introduce SAFE_FANOTIFY_MARK() macro +
 cleanup
In-Reply-To: <20201126214121.6836-1-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
Message-ID: <CAOQ4uxhbHmtTcub3KKOdtOC6JXm+5jThYMROFqhK6UpAps82NA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 26, 2020 at 11:41 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> another cleanup version, hopefully the last.
> Sorry for lengthy comments.

Don't be :)

>
> Changes v3->v4:
> * fixed unwanted tst_brk() (quitting the test too early). In the end it
> was problem just in fanotify01.c and fanotify03.c.
>
> In fanotify13.c it was already
>
> tst_test.c:1316: TINFO: Testing on exfat
> fanotify.h:209: TCONF: filesystem exfat does not support file handles
> ...
> tst_test.c:859: TINFO: Trying FUSE...
> fanotify13.c:161: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
> fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
> fanotify13.c:161: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
> fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
> fanotify13.c:161: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_MOUNT
> fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
> fanotify13.c:161: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_MOUNT
> fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
> fanotify13.c:161: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_FILESYSTEM
> fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
> fanotify13.c:161: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_FILESYSTEM
> fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
>
> * new commit fanotify: Check for FAN_REPORT_FID support on fs
> This one I hesitated, whether keep EOPNOTSUPP also as fallback in fanotify.h
> On all but one test (fanotify01.c) FAN_REPORT_FID was used in all tests.
>
> The only check I kept untouched is this one from fanotify16.c:
>         fd_notify = fanotify_init(group->flag, 0);
>         if (fd_notify == -1) {
>                 if (errno == EINVAL) {
>                         tst_res(TCONF,
>                                 "%s not supported by kernel", group->name);
>                         return;
>                 }
>
>                 tst_brk(TBROK | TERRNO,
>                         "fanotify_init(%s, 0) failed", group->name);
>         }
>
> Because this:
> fanotify16.c:160: TINFO: Test #0: FAN_REPORT_DFID_NAME monitor filesystem for create/delete/move/open/close
> fanotify16.c:166: TCONF: FAN_REPORT_DFID_NAME not supported by kernel
> fanotify16.c:160: TINFO: Test #1: FAN_REPORT_DFID_NAME monitor directories for create/delete/move/open/close
> fanotify16.c:166: TCONF: FAN_REPORT_DFID_NAME not supported by kernel
> fanotify16.c:160: TINFO: Test #2: FAN_REPORT_DIR_FID monitor filesystem for create/delete/move/open/close
> fanotify16.c:166: TCONF: FAN_REPORT_DIR_FID not supported by kernel
> fanotify16.c:160: TINFO: Test #3: FAN_REPORT_DIR_FID monitor directories for create/delete/move/open/close
> fanotify16.c:166: TCONF: FAN_REPORT_DIR_FID not supported by kernel
> fanotify16.c:160: TINFO: Test #4: FAN_REPORT_DFID_FID monitor filesystem for create/delete/move/open/close
> fanotify16.c:166: TCONF: FAN_REPORT_DFID_FID not supported by kernel
> fanotify16.c:160: TINFO: Test #5: FAN_REPORT_DFID_FID monitor directories for create/delete/move/open/close
> fanotify16.c:166: TCONF: FAN_REPORT_DFID_FID not supported by kernel
> fanotify16.c:160: TINFO: Test #6: FAN_REPORT_DFID_NAME_FID monitor filesystem for create/delete/move/open/close
> fanotify16.c:166: TCONF: FAN_REPORT_DFID_NAME_FID not supported by kernel
> fanotify16.c:160: TINFO: Test #7: FAN_REPORT_DFID_NAME_FID monitor directories for create/delete/move/open/close
> fanotify16.c:166: TCONF: FAN_REPORT_DFID_NAME_FID not supported by kernel
>
> would be replaced by single message which is misleading:
> fanotify16.c:163: TCONF: FAN_REPORT_NAME not supported in kernel?
> if I use
> fd_notify = SAFE_FANOTIFY_INIT(group->flag, 0);
> + that problem with skipping what we don't want to skip (although here
> are skipped all and on old kernel I get
> fanotify.h:342: TCONF: FAN_REPORT_FID not supported in kernel?

That's because you should have tested FAN_REPORT_NAME before
testing FAN_REPORT_FID.

Also, instead of testing FAN_REPORT_NAME you can test for
(flags & FAN_REPORT_DIR_FID) both flags were added together
in the same kernel but FAN_REPORT_NAME cannot be used without
FAN_REPORT_DIR_FID.

>
> and on new kernel problematic fs are skipped anyway:
> fanotify.h:363: TCONF: FAN_REPORT_FID not supported on exfat filesystem
>
> Feel free to suggest what to do or simply send a following patch.
>

I am not sure if my answers addressed all the problems you encountered
with fanotify16. Feel free to leave the remaining problem out of the cleanup
and I will fix it later.

> In following commit "fanotify: Introduce SAFE_FANOTIFY_MARK() macro".
> I'd prefer to keep it (fallback if we forget to add a check), but probably instead of
> "some FAN_REPORT_* flag not supported on %s filesystem",
> there should be
> "FAN_REPORT_FID flag not supported on %s filesystem",
> But on my machine with 5.10.0-rc4-1.gea0f69f-default, this failed on FAN_REPORT_DFID_NAME
> (synonym for (FAN_REPORT_DIR_FID|FAN_REPORT_NAME) => no FAN_REPORT_FID,
> so this would be misleading:
> fanotify16.c:160: TINFO: Test #0: FAN_REPORT_DFID_NAME monitor filesystem for create/delete/move/open/close
> fanotify16.c:177: TCONF: FAN_REPORT_FID not supported on exfat filesystem
>
> * more cleanup in commit "fanotify: Check FAN_REPORT_{FID,NAME} support"
>
> Other changes (suggested mostly by Cyril):
> * rename s/support_exec_events/exec_events_unsupported/
>
> * Add "require_" prefix for functions which use tst_brk()
>
> * use tst_res_() and tst_brk_() for safe_*() functions
>
> BTW fanotify16.c use .dev_fs_flags = TST_FS_SKIP_FUSE, this could be
> added also into fanotify13.c (it'd avoid running ntfs).
>
> If LTP had something like TST_FS_SKIP_MICROSOFT (TST_FS_SKIP_FUSE +
> exfat), could get rid of "FAN_REPORT_FID not supported on foo
> filesystem" testing. But it's already implemented, so it's just a note
> to be ignored.
>

It is better to check support by trying unless there is a very good reason
for special casing filesystems. I don't remember what was the special case
for ntfs that test support checks did not catch.

I guess the TST_FS_SKIP_FUSE flag may not be needed after your fixes?

Thanks,
Amir.
