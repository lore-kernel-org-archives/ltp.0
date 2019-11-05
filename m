From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Nov 2019 14:09:05 +0530
Subject: [LTP] stable-rc-5.3.9-rc1: regressions detected -
 remove_proc_entry: removing non-empty directory 'net/dev_snmp6',
 leaking at least 'lo'
In-Reply-To: <20191105080614.GB2611856@kroah.com>
References: <CA+G9fYsWTFQZTHXUDPToaepnKGBoh61SsA_8SHcYgYZXN_L+mg@mail.gmail.com>
 <CA+G9fYu+6A3pYQGs2rydYtHNSCf1t9+OTRqrZeCbpc2ARLx2zA@mail.gmail.com>
 <20191105073459.GB2588562@kroah.com>
 <CA+G9fYvau-CY8eeXM=atzQBjYbmUPg78MXu_GNjCyKDkW_CcVQ@mail.gmail.com>
 <20191105080614.GB2611856@kroah.com>
Message-ID: <CA+G9fYtWc+6XzWZtG76T7+TdF+tAyUqJPQT8-ykZRTy1sCgEPQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 5 Nov 2019 at 13:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> > > > These reported failures got fixed on latest stable-rc 5.3.y after
> > > > dropping a patch [1].
> > >
> > > What is the subject of the patch?
> >
> > blackhole_netdev: fix syzkaller reported issue
> > upstream commit b0818f80c8c1bc215bba276bd61c216014fab23b
>
> That commit is not in any stable queue or tree at the moment, are you
> sure this is still an issue?

Since it has been dropped, the issue is gone now.

>
> > > > The kernel warning is also gone now.
> > > >
> > > > metadata:
> > > >   git branch: linux-5.3.y
> > > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > >   git commit: 75c9913bbf6e9e64cb669236571e6af45cddfd68
> > >
> > > The -rc tree is rebased all the time, can I get a "real" subject line to
> > > get a chance to figure out what you are trying to refer to here?
> >
> > Linux 5.3.9-rc1 is good candidate on branch linux-5.3.y and
> > linux-stable-rc tree.
>
> I can not parse this, what do you mean?

linux-stable-rc linux-5.3.y branch and make kernel version 5.3.9-rc1
is been tested and
no regresion found.

- Naresh
