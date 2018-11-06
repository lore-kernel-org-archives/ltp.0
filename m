From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Nov 2018 14:59:46 +0200
Subject: [LTP] [PATCH 1/1] syscalls/fanotify10: Require kernel v4.19
In-Reply-To: <20181106125556.GA28469@dell5510>
References: <20181106124802.27170-1-pvorel@suse.cz>
 <20181106125015.GB4834@rei.lan> <20181106125556.GA28469@dell5510>
Message-ID: <CAOQ4uxhd9XZj=zvkm1j8mZBkBRw0qhvfwcaRQKzs24bVjsfUZw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 6, 2018 at 2:55 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> > > FAN_MARK_INODE and FAN_MARK_MOUNT were added in v4.19-rc2:
> > > d54f4fba889b fanotify: add API to attach/detach super block mark
>
> > > Fixes: 16f127f4a syscalls/fanotify10: new test for mount ignore mask
>
> > I would slightly prefer handling whatever error we get from fanotify so
> > that the test would also work in a case that the functionality would get
> > backported to older kernel. But if that's not easily done we may as well
> > go for the kernel version detection.
> Make sense. Amir, any idea, how to do that?
>

There must be some confusion.
FAN_MARK_MOUNT was NOT added in v4.19-rc2.
It has been there from the start.
FAN_MARK_INODE was NOT added either
the define FAN_MARK_INODE  0 is just a convenience readability define
it does not change the API.

You may be confusing with FAN_MARK_FILESYSTEM
just was just added in kernel v4.20-rc1.
The extension of tests to cover FAN_MARK_FILESYSTEM
is waiting in my queue:
https://github.com/amir73il/ltp/commits/fanotify_sb

And it already includes runtime checks for FAN_MARK_FILESYSTEM
support.

Did I miss anything?

Thanks,
Amir.
