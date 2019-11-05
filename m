From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 5 Nov 2019 13:28:01 +0530
Subject: [LTP] stable-rc-5.3.9-rc1: regressions detected -
 remove_proc_entry: removing non-empty directory 'net/dev_snmp6',
 leaking at least 'lo'
In-Reply-To: <20191105073459.GB2588562@kroah.com>
References: <CA+G9fYsWTFQZTHXUDPToaepnKGBoh61SsA_8SHcYgYZXN_L+mg@mail.gmail.com>
 <CA+G9fYu+6A3pYQGs2rydYtHNSCf1t9+OTRqrZeCbpc2ARLx2zA@mail.gmail.com>
 <20191105073459.GB2588562@kroah.com>
Message-ID: <CA+G9fYvau-CY8eeXM=atzQBjYbmUPg78MXu_GNjCyKDkW_CcVQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 5 Nov 2019 at 13:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> > > Linux stable rc 5.3 branch running LTP reported following test failures.
> > > While investigating these failures I have found this kernel warning
> > > from boot console.
> > > Please find detailed LTP output log in the bottom of this email.
> > >
> > > List of regression test cases:
> > >   ltp-containers-tests:
> > >     * netns_breakns_ip_ipv6_ioctl
<trim>
> > >     * netns_comm_ns_exec_ipv6_netlink
> >
> > These reported failures got fixed on latest stable-rc 5.3.y after
> > dropping a patch [1].
>
> What is the subject of the patch?

blackhole_netdev: fix syzkaller reported issue
upstream commit b0818f80c8c1bc215bba276bd61c216014fab23b

>
> > The kernel warning is also gone now.
> >
> > metadata:
> >   git branch: linux-5.3.y
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >   git commit: 75c9913bbf6e9e64cb669236571e6af45cddfd68
>
> The -rc tree is rebased all the time, can I get a "real" subject line to
> get a chance to figure out what you are trying to refer to here?

Linux 5.3.9-rc1 is good candidate on branch linux-5.3.y and
linux-stable-rc tree.

>
> > ref:
> > [PATCH AUTOSEL 5.3 12/33] blackhole_netdev: fix syzkaller reported issue
> > [1] https://lkml.org/lkml/2019/10/25/794
>
> lore.kernel.org is much more reliable :)

Thank you.

[ Sasha Levin <sashal@kernel.org>  wrote on Mon, 4 Nov 2019 12:13:45 -0500 ]
I've dropped this patch from 5.3 too, it was reverted upstream.
https://lore.kernel.org/netdev/20191104171345.GG4787@sasha-vm/

Ref:

Reverting below patch fixed this problem.
---
commit b0818f80c8c1bc215bba276bd61c216014fab23b
Author: Mahesh Bandewar <maheshb@google.com>
Date:   Fri Oct 11 18:14:55 2019 -0700

    blackhole_netdev: fix syzkaller reported issue

    While invalidating the dst, we assign backhole_netdev instead of
    loopback device. However, this device does not have idev pointer
    and hence no ip6_ptr even if IPv6 is enabled. Possibly this has
    triggered the syzbot reported crash.

    The syzbot report does not have reproducer, however, this is the
    only device that doesn't have matching idev created.

    Crash instruction is :

    static inline bool ip6_ignore_linkdown(const struct net_device *dev)
    {
            const struct inet6_dev *idev = __in6_dev_get(dev);

            return !!idev->cnf.ignore_routes_with_linkdown; <= crash
    }

    Also ipv6 always assumes presence of idev and never checks for it
    being NULL (as does the above referenced code). So adding a idev
    for the blackhole_netdev to avoid this class of crashes in the future.

    Signed-off-by: David S. Miller <davem@davemloft.net>
