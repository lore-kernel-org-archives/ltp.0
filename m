From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 18:49:02 +0200
Subject: [LTP] [PATCH 4/4] syscalls/fanotify: New test for FAN_MODIFY_DIR
In-Reply-To: <20200421065002.12417-5-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-5-amir73il@gmail.com>
Message-ID: <20200427164902.GA4544@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

thank you for this patchset!

...
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c

...

> +		} else if (memcmp(&event_fid->fsid, &expected->fid->fsid,
> +				  sizeof(event_fid->fsid)) != 0) {
> +			tst_res(TFAIL,
> +				"got event: mask=%llx pid=%u fd=%d name='%s' "
> +				"len=%d info_type=%d info_len=%d fh_len=%d "
> +				"fsid=%x.%x (expected %x.%x)",
> +				(unsigned long long)event->mask,
> +				(unsigned)event->pid, event->fd, filename,
> +				event->event_len, info_type,
> +				event_fid->hdr.len, fhlen,
> +				event_fid->fsid.val[0], event_fid->fsid.val[1],

This needs to be:
+				FSID_VAL_MEMBER(event_fid->fsid, 0),
+				FSID_VAL_MEMBER(event_fid->fsid, 1),

FSID_VAL_MEMBER() is a wrapper struct fanotify_event_info_fid, needed to fix
build on musl (and it shouldn't be used for struct event_t).

https://travis-ci.org/github/pevik/ltp/jobs/680149701

Also I got problems on FUSE:
safe_macros.c:754: INFO: Trying FUSE...
tst_test.c:1244: INFO: Timeout per run is 0h 05m 00s
fanotify16.c:112: INFO: Test #0: FAN_REPORT_FID with mark type: FAN_MARK_FILESYSTEM
fanotify16.c:138: BROK: fanotify_mark (3, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, FAN_DIR_MODIFY, AT_FDCWD, 'fs_mnt') failed: ENODEV (19)
tst_device.c:373: INFO: umount('fs_mnt') failed with EBUSY, try  1...
tst_device.c:377: INFO: Likely gvfsd-trash is probing newly mounted fs, kill it to speed up tests.

Skipping FUSE fixes it:
.dev_fs_flags = TST_FS_SKIP_FUSE,

Kind regards,
Petr
