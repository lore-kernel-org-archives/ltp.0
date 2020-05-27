From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 27 May 2020 03:11:04 -0400 (EDT)
Subject: [LTP] [PATCH RFC 1/4] lib: add new cgroup test API
In-Reply-To: <CAEemH2cGa5tvgWAPbyoanBKh7MbM4kuo+Ws_i0Z2vmbCts1yYQ@mail.gmail.com>
References: <20200522012327.18991-1-liwang@redhat.com>
 <1156025603.13595880.1590481651127.JavaMail.zimbra@redhat.com>
 <CAEemH2cGa5tvgWAPbyoanBKh7MbM4kuo+Ws_i0Z2vmbCts1yYQ@mail.gmail.com>
Message-ID: <1731864663.13759097.1590563464850.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----

> > We should probably handle also EBUSY, for cases when controller is already
> > part
> > of existing hierarchy. E.g. cpu,cpuacct is mounted together, and someone
> > tries to mount just cpu:
> >   mount("none", "/mnt/cgroup", "cgroup", MS_MGC_VAL, "cpu") = -1 EBUSY
> > (Device or resource busy)
> >
> 
> That's true.
> 
> But in general, people are not permitted to use tst_cgroup*_mount()
> directly, it is only as the low-level/internal function to hide details we
> mount cgroup. My previous thought is that, in v1, cpu,cpuacct are bound
> together(as system way) in tst_croup_cpu().

They don't need to use tst_cgroup*_mount() directly, they could change their
system config and mount cpu,cpuacct,memcg together. Though chances of that
happening are low.

> > tst_cgroup_create(enum tst_cgroup_ctrl, const char *dir)
> >
> 
> Maybe we can drop the second parameter "dir", the mount
> functions are internal and we just use path macros in sub-function
> which like what I did.

I wanted to keep some flexibility in case test needs multiple cgroups.
I'll have a look at v1 you posted today.

