From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 18 Apr 2019 21:36:15 +0300
Subject: [LTP] [PATCH 4/4] syscalls/fanotify15: verify fid for dirent
	events
In-Reply-To: <20190416150015.GA22754@rei.lan>
References: <cover.1554197461.git.mbobrowski@mbobrowski.org>
 <2934be190caaaf4bb75caffd731d34711fbf1c61.1554197461.git.mbobrowski@mbobrowski.org>
 <20190416142959.GC20437@rei>
 <CAOQ4uxiuLd3C0ctx-+fUkAT8XZyY5SOw61-wB8BTdHh0FVPBXg@mail.gmail.com>
 <20190416150015.GA22754@rei.lan>
Message-ID: <CAOQ4uxh6VqHKH3Sf0URZPkDUcGAG0yzKrT6bqOiH0LG+43Qnnw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 16, 2019 at 6:00 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > Can put this code into an header in the fanotify/ directory along with
> > > the event_t structure definiton so that we do not carry two copies of
> > > nearly identical code.
> >
> > Correct, but I would rather leave the event_t structure private to the test
> > because it may have other fields in future tests of similar pattern...
> >
> > >
> > > If we passed a pointer to the event_t structure instead of the index we
> > > can call this function in a loop in the get_object_stats() in
> > > fanotify13, right?
> > >
> >
> > ...so I'd prefer to pass a pointer to fsid and file_handle to helper instead,
> > something like:
> > void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid, and
> > struct file_handle *handle)
>
> Sounds good to me as well.
>

BTW, I think fanotify14/fanotify15 could use
.all_filesystems = 1

The file handle/fsid issues are filesystem specific (e.g. ENODEV error).

Is anybody else seeing these errors with all_filesystems?

tst_test.c:1157: INFO: Testing on xfs
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
mkfs.xfs: Use the -f option to force overwrite.
tst_mkfs.c:101: BROK: mkfs.xfs:1: tst_test.c failed with 751

Thanks,
Amir.
