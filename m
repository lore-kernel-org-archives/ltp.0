From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 27 Apr 2020 11:19:33 +0200
Subject: [LTP] [PATCH] Add env variable as workaround for test issues in
 VMs
In-Reply-To: <96306598.10298812.1587978418983.JavaMail.zimbra@redhat.com>
References: <20200424150422.17467-1-mdoucha@suse.cz>
 <20200427053125.GA21164@dell5510>
 <951270734.10286613.1587972682386.JavaMail.zimbra@redhat.com>
 <CAEemH2daE69UT7mFGXOFQaj3bjqq8CRJr6bnhssyK3_7JPdHng@mail.gmail.com>
 <96306598.10298812.1587978418983.JavaMail.zimbra@redhat.com>
Message-ID: <20200427091933.GA23679@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > I take a rough look and doubt there is a bug in try_systemd_detect_virt().
> > Shouldn't strncmp() return zero the 'kvm'/'xen' is found?  I guess they
> > wanted:

> Yes, that looks like bug.
Good catch!

> > --- a/lib/tst_virt.c
> > +++ b/lib/tst_virt.c
> > @@ -93,10 +93,10 @@ static int try_systemd_detect_virt(void)
> >         if (ret)
> >                 return 0;

> > -       if (strncmp("kvm", virt_type, 3))
> > +       if (!strncmp("kvm", virt_type, 3))
> >                 return VIRT_KVM;

> > -       if (strncmp("xen", virt_type, 3))
> > +       if (!strncmp("xen", virt_type, 3))
> >                 return VIRT_XEN;

> >         return 0;

> > Apart from that two(kvm/xen) , we need to detect more virtualization tech
> > for ppc/s390 I think.

> We could return VIRT_OTHER by default. We don't really need to
> differentiate which one it is for purpose of this patch.
+1. And if we ever need to differentiate, we can always add them later, using
code from systemd-detect-virt
https://github.com/systemd/systemd/blob/master/src/basic/virt.c

Kind regards,
Petr
