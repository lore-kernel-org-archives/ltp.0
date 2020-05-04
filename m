From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 4 May 2020 14:07:40 +0200
Subject: [LTP] [PATCH v2 3/4] syscalls/fanotify: New test for
 FAN_MODIFY_DIR
In-Reply-To: <20200502162744.9589-4-amir73il@gmail.com>
References: <20200502162744.9589-1-amir73il@gmail.com>
 <20200502162744.9589-4-amir73il@gmail.com>
Message-ID: <20200504120740.GA6452@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

while waiting for you and Jan to agree whether whole patchset should be merged
I have 2 fixes for v2.

> +static inline void fanotify_save_fid(const char *path,
> +				     struct fanotify_fid_t *fid)
> +{
> +	int *fh = (int *)(fid->handle.f_handle);
> +
> +	fh[0] = fh[1] = fh[2] = 0;
> +	fid->handle.handle_bytes = MAX_HANDLE_SZ;
> +	fanotify_get_fid(path, &fid->fsid, &fid->handle);
> +
> +	tst_res(TINFO,
> +		"fid(%s) = %x.%x.%x.%x.%x...", path,
> +		FSID_VAL_MEMBER(fid->fsid, 0), FSID_VAL_MEMBER(fid->fsid, 1),
> +		fh[0], fh[1], fh[2]);

We're using __kernel_fsid_t, which has val member on both libc and musl,
thus it must be:
-		"fid(%s) = %x.%x.%x.%x.%x...", path,
-		FSID_VAL_MEMBER(fid->fsid, 0), FSID_VAL_MEMBER(fid->fsid, 1),
-		fh[0], fh[1], fh[2]);
+		"fid(%s) = %x.%x.%x.%x.%x...", path, fid->fsid.val[0],
+		fid->fsid.val[1], fh[0], fh[1], fh[2]);

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
> +				FSID_VAL_MEMBER(event_fid->fsid, 0),
> +				FSID_VAL_MEMBER(event_fid->fsid, 1),
> +				FSID_VAL_MEMBER(expected->fid->fsid, 0),
> +				FSID_VAL_MEMBER(expected->fid->fsid, 1));

Also here 3rd and 4th access must be direct as it is event_t:
-				FSID_VAL_MEMBER(expected->fid->fsid, 0),
-				FSID_VAL_MEMBER(expected->fid->fsid, 1));
+				expected->fid->fsid.val[0],
+				expected->fid->fsid.val[1]);

FYI FSID_VAL_MEMBER is only for event_fid. I'm sorry, although there is a note
in fanotify.h, it's a bit confusing (see f37704d6c fanotify: Fix
FSID_VAL_MEMBER() usage).

There is also warning on array size on newer compilers:

  378 |  sprintf(fname1, "%s/%s", dname1, FILE_NAME1);
      |                      ^~
In file included from /usr/include/stdio.h:867,
                 from fanotify16.c:13:
/usr/include/bits/stdio2.h:36:10: note: ?__builtin___sprintf_chk? output between 12 and 267 bytes into a destination of size 256
   36 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   37 |       __bos (__s), __fmt, __va_arg_pack ());
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fanotify16.c:379:22: warning: ?%s? directive writing 10 bytes into a region of size between 0 and 255 [-Wformat-overflow=]
  379 |  sprintf(fname2, "%s/%s", dname1, FILE_NAME2);
      |                      ^~

It can be fixed by increasing the size of fname1 and fname2:
-static char fname1[BUF_SIZE], fname2[BUF_SIZE];
+static char fname1[BUF_SIZE + 11], fname2[BUF_SIZE + 11];

I don't like that code but on the other hand don't like introducing warnings
either.

Kind regards,
Petr
