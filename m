From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Nov 2018 13:55:56 +0100
Subject: [LTP] [PATCH 1/1] syscalls/fanotify10: Require kernel v4.19
In-Reply-To: <20181106125015.GB4834@rei.lan>
References: <20181106124802.27170-1-pvorel@suse.cz>
 <20181106125015.GB4834@rei.lan>
Message-ID: <20181106125556.GA28469@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > FAN_MARK_INODE and FAN_MARK_MOUNT were added in v4.19-rc2:
> > d54f4fba889b fanotify: add API to attach/detach super block mark

> > Fixes: 16f127f4a syscalls/fanotify10: new test for mount ignore mask

> I would slightly prefer handling whatever error we get from fanotify so
> that the test would also work in a case that the functionality would get
> backported to older kernel. But if that's not easily done we may as well
> go for the kernel version detection.
Make sense. Amir, any idea, how to do that?

> > +	.min_kver = "4.19",

Kind regards,
Petr
