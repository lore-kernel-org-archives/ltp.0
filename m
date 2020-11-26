From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Nov 2020 22:41:15 +0100
Subject: [LTP] [PATCH v4 0/6] Introduce SAFE_FANOTIFY_MARK() macro + cleanup
Message-ID: <20201126214121.6836-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

another cleanup version, hopefully the last.
Sorry for lengthy comments.

Changes v3->v4:
* fixed unwanted tst_brk() (quitting the test too early). In the end it
was problem just in fanotify01.c and fanotify03.c.

In fanotify13.c it was already

tst_test.c:1316: TINFO: Testing on exfat
fanotify.h:209: TCONF: filesystem exfat does not support file handles
...
tst_test.c:859: TINFO: Trying FUSE...
fanotify13.c:161: TINFO: Test #0: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #1: FAN_REPORT_FID with mark flag: FAN_MARK_INODE
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #2: FAN_REPORT_FID with mark flag: FAN_MARK_MOUNT
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #3: FAN_REPORT_FID with mark flag: FAN_MARK_MOUNT
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #4: FAN_REPORT_FID with mark flag: FAN_MARK_FILESYSTEM
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs
fanotify13.c:161: TINFO: Test #5: FAN_REPORT_FID with mark flag: FAN_MARK_FILESYSTEM
fanotify13.c:130: TCONF: FAN_REPORT_FID not supported on filesystem type ntfs

* new commit fanotify: Check for FAN_REPORT_FID support on fs
This one I hesitated, whether keep EOPNOTSUPP also as fallback in fanotify.h
On all but one test (fanotify01.c) FAN_REPORT_FID was used in all tests.

The only check I kept untouched is this one from fanotify16.c:
	fd_notify = fanotify_init(group->flag, 0);
	if (fd_notify == -1) {
		if (errno == EINVAL) {
			tst_res(TCONF,
				"%s not supported by kernel", group->name);
			return;
		}

		tst_brk(TBROK | TERRNO,
			"fanotify_init(%s, 0) failed", group->name);
	}

Because this:
fanotify16.c:160: TINFO: Test #0: FAN_REPORT_DFID_NAME monitor filesystem for create/delete/move/open/close
fanotify16.c:166: TCONF: FAN_REPORT_DFID_NAME not supported by kernel
fanotify16.c:160: TINFO: Test #1: FAN_REPORT_DFID_NAME monitor directories for create/delete/move/open/close
fanotify16.c:166: TCONF: FAN_REPORT_DFID_NAME not supported by kernel
fanotify16.c:160: TINFO: Test #2: FAN_REPORT_DIR_FID monitor filesystem for create/delete/move/open/close
fanotify16.c:166: TCONF: FAN_REPORT_DIR_FID not supported by kernel
fanotify16.c:160: TINFO: Test #3: FAN_REPORT_DIR_FID monitor directories for create/delete/move/open/close
fanotify16.c:166: TCONF: FAN_REPORT_DIR_FID not supported by kernel
fanotify16.c:160: TINFO: Test #4: FAN_REPORT_DFID_FID monitor filesystem for create/delete/move/open/close
fanotify16.c:166: TCONF: FAN_REPORT_DFID_FID not supported by kernel
fanotify16.c:160: TINFO: Test #5: FAN_REPORT_DFID_FID monitor directories for create/delete/move/open/close
fanotify16.c:166: TCONF: FAN_REPORT_DFID_FID not supported by kernel
fanotify16.c:160: TINFO: Test #6: FAN_REPORT_DFID_NAME_FID monitor filesystem for create/delete/move/open/close
fanotify16.c:166: TCONF: FAN_REPORT_DFID_NAME_FID not supported by kernel
fanotify16.c:160: TINFO: Test #7: FAN_REPORT_DFID_NAME_FID monitor directories for create/delete/move/open/close
fanotify16.c:166: TCONF: FAN_REPORT_DFID_NAME_FID not supported by kernel

would be replaced by single message which is misleading:
fanotify16.c:163: TCONF: FAN_REPORT_NAME not supported in kernel?
if I use
fd_notify = SAFE_FANOTIFY_INIT(group->flag, 0);
+ that problem with skipping what we don't want to skip (although here
are skipped all and on old kernel I get
fanotify.h:342: TCONF: FAN_REPORT_FID not supported in kernel?

and on new kernel problematic fs are skipped anyway:
fanotify.h:363: TCONF: FAN_REPORT_FID not supported on exfat filesystem

Feel free to suggest what to do or simply send a following patch.

In following commit "fanotify: Introduce SAFE_FANOTIFY_MARK() macro".
I'd prefer to keep it (fallback if we forget to add a check), but probably instead of
"some FAN_REPORT_* flag not supported on %s filesystem",
there should be
"FAN_REPORT_FID flag not supported on %s filesystem",
But on my machine with 5.10.0-rc4-1.gea0f69f-default, this failed on FAN_REPORT_DFID_NAME
(synonym for (FAN_REPORT_DIR_FID|FAN_REPORT_NAME) => no FAN_REPORT_FID,
so this would be misleading:
fanotify16.c:160: TINFO: Test #0: FAN_REPORT_DFID_NAME monitor filesystem for create/delete/move/open/close
fanotify16.c:177: TCONF: FAN_REPORT_FID not supported on exfat filesystem

* more cleanup in commit "fanotify: Check FAN_REPORT_{FID,NAME} support"

Other changes (suggested mostly by Cyril):
* rename s/support_exec_events/exec_events_unsupported/

* Add "require_" prefix for functions which use tst_brk()

* use tst_res_() and tst_brk_() for safe_*() functions

BTW fanotify16.c use .dev_fs_flags = TST_FS_SKIP_FUSE, this could be
added also into fanotify13.c (it'd avoid running ntfs).

If LTP had something like TST_FS_SKIP_MICROSOFT (TST_FS_SKIP_FUSE +
exfat), could get rid of "FAN_REPORT_FID not supported on foo
filesystem" testing. But it's already implemented, so it's just a note
to be ignored.

Kind regards,
Petr

Petr Vorel (6):
  fanotify12: Drop incorrect hint
  fanotify: Handle supported features checks in setup()
  fanotify: Check for FAN_REPORT_FID support on fs
  fanotify: Introduce SAFE_FANOTIFY_MARK() macro
  fanotify: Check FAN_REPORT_{FID,NAME} support
  fanotify: Add a pedantic check for return value

 testcases/kernel/syscalls/fanotify/fanotify.h | 173 +++++++++++++++---
 .../kernel/syscalls/fanotify/fanotify01.c     |  73 ++------
 .../kernel/syscalls/fanotify/fanotify02.c     |  22 +--
 .../kernel/syscalls/fanotify/fanotify03.c     |  55 ++----
 .../kernel/syscalls/fanotify/fanotify04.c     |  32 +---
 .../kernel/syscalls/fanotify/fanotify05.c     |   9 +-
 .../kernel/syscalls/fanotify/fanotify06.c     |  21 +--
 .../kernel/syscalls/fanotify/fanotify07.c     |  17 +-
 .../kernel/syscalls/fanotify/fanotify09.c     |  19 +-
 .../kernel/syscalls/fanotify/fanotify10.c     |  44 ++---
 .../kernel/syscalls/fanotify/fanotify11.c     |   5 +-
 .../kernel/syscalls/fanotify/fanotify12.c     |  57 ++----
 .../kernel/syscalls/fanotify/fanotify13.c     |  49 +----
 .../kernel/syscalls/fanotify/fanotify15.c     |  35 +---
 .../kernel/syscalls/fanotify/fanotify16.c     |  26 +--
 15 files changed, 249 insertions(+), 388 deletions(-)

-- 
2.29.2

