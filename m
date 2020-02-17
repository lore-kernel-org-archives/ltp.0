From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 10:43:48 +0100
Subject: [LTP] [PATCH v6 2/2] syscalls/fsmount01: Add test for new mount
 API v5.2
In-Reply-To: <1181359180.7790231.1581931018783.JavaMail.zimbra@redhat.com>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207144105.19947-2-pvorel@suse.cz>
 <CAEemH2f0db1i7Tpg-4jqa5h5j9KZpH+d4aRg-M3Xn3Mw9NU1eA@mail.gmail.com>
 <20200216131723.GA2725117@x230>
 <CAEemH2ewgh=OnRzEs+1X4rvsiChrLRRMxeK-ChZL3wDqco_iLg@mail.gmail.com>
 <1181359180.7790231.1581931018783.JavaMail.zimbra@redhat.com>
Message-ID: <20200217094348.GB13398@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

...
> > > BTW, I like the way Viresh Kumar gives in his fsmount.h, it looks more
> > > tidy
> > > > and clean.
> > > > http://lists.linux.it/pipermail/ltp/2020-February/015413.html
> > > Hm, competing implementations.
> > > Both tries to handle preventing redefinitions (e.g. FSOPEN_CLOEXEC) once
> > > the API hits libc headers (at least in musl it might be soon).
> > > Zorro tries to bind them to function check (e.g. #ifndef HAVE_FSMOUNT,
> > > #ifndef
> > > HAVE_MOVE_MOUNT), Viresh just use single check #ifndef OPEN_TREE_CLONE.
> > > I slightly prefer Viresh way (it's unlikely that libc headers would
> > > include just

> > +1 Viresh way.


> > > part of the new mount API definitions, although obviously the most safest
> > > way
> > > would be to either guard with #ifndef each definition or just give up on
> > > testing
> > > header and copy whole include/uapi/linux/mount.h (+ avoid using
> > > sys/mount.h;
> > > that's the way used for include/lapi/bpf.h).


> > @Cyril, @Jan, any else suggestion?

> I'd go with additions to lapi, and avoid copying entire linux/mount.h. And use
> #ifndef for each definition. v7 is currently not doing that, but it's easy
> to add if we run into problems later, when/if there are additions to mount API.
OK, I'm also for single guard with OPEN_TREE_CLONE until anything else is
needed. I'll add your ack for lapi commit.

Kind regards,
Petr
