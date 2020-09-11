From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Sep 2020 07:35:57 +0200
Subject: [LTP] [PATCH 1/1] syscalls/fanotify15: TCONF also on EOPNOTSUPP
In-Reply-To: <CAOQ4uxgVkz3Xatg43Py4md7LKEUoJKbb4H-Z5y1PyzPdZbx-Rw@mail.gmail.com>
References: <20200910110712.2181-1-pvorel@suse.cz>
 <CAOQ4uxgVkz3Xatg43Py4md7LKEUoJKbb4H-Z5y1PyzPdZbx-Rw@mail.gmail.com>
Message-ID: <20200911053557.GA3425@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> On Thu, Sep 10, 2020 at 2:07 PM Petr Vorel <pvorel@suse.cz> wrote:

> > instead of TBROK:
> > fanotify15.c:86: INFO: Test #0: FAN_REPORT_FID on filesystem including FAN_DELETE_SELF
> > fanotify15.c:96: BROK: fanotify_mark(3, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_MODIFY | FAN_ONDIR | 0x400, AT_FDCWD, mntpoint/test_dir) failed: EOPNOTSUPP (95)

> > is now reported:
> > fanotify15.c:86: INFO: Test #0: FAN_REPORT_FID on filesystem including FAN_DELETE_SELF
> > fanotify15.c:93: CONF: FAN_REPORT_FID not supported on exfat filesystem

> > fanotify15.c:86: INFO: Test #0: FAN_REPORT_FID on filesystem including FAN_DELETE_SELF
> > fanotify15.c:93: CONF: FAN_REPORT_FID not supported on ntfs filesystem

> > Found on 5.8.0 on openSUSE Tumbleweed.

> > Fixes: 403f11f3a ("syscalls/fanotify15: verify fid for dirent events")

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > I suppose that EXDEV (in fanotify_test_fid()) is really error which
> > should be caught as TBROK (unlike ENODEV and EOPNOTSUPP). Am I correct?

> No. EXDEV is also an indication of problematic filesystem.
> You will get it if you try to setup the mark on a btrfs subvolume, which is not
> the root volume, because in that case the "fsid" information from event is
> not reliable.

> Probably this is not going to happen in LTP, but still.

> Good spotting.

Merged commit where handling both EOPNOTSUPP and EXDEV.
Thanks!

> Thanks,
> Amir.

Kind regards,
Petr
