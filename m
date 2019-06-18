From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 18 Jun 2019 19:00:46 +0300
Subject: [LTP] [PATCH v3 3/3] syscalls/ioctl_ns0[156]: align stack and
 wait for child
In-Reply-To: <894722811.28675645.1560782288619.JavaMail.zimbra@redhat.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
 <CAEemH2frt_zGSdSRL3d_J+km74p8ruQTNF6bVhEpaiTdMLCC6A@mail.gmail.com>
 <1320546599.27920597.1560420988025.JavaMail.zimbra@redhat.com>
 <20190613141714.GC29926@rei.lan>
 <1211798607.28016198.1560437855198.JavaMail.zimbra@redhat.com>
 <20190613151419.GE29926@rei.lan>
 <151498464.28356667.1560670442630.JavaMail.zimbra@redhat.com>
 <20190617085039.GA1629@rei.lan>
 <894722811.28675645.1560782288619.JavaMail.zimbra@redhat.com>
Message-ID: <CAOQ4uxgPPoxWp5fJ-7GdgEg89683_1mL3mCHqevGX=-FrRYwmA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 17, 2019 at 5:38 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
> > Hi!
> > > > > I recall I started with that position (free all), and I thought you
> > > > > turned me around after this many years :-).
> > > >
> > > > Well I didn't care that much, but I guess that I lean slightly to free
> > > > the memory :-).
> > >
> > > OK, so should I repost or is this good to go with free added to cleanup?
> >
> > Let's do that.
>
> Pushed.
> (Li, I added your Acked-by to it, since your comment has been addressed).
>

FYI, not related to these fixes, but tests ioctl_ns0[46] have failures on kernel
without CONFIG_USER_NS:
tst_test.c:1112: INFO: Timeout per run is 0h 05m 00s
ioctl_ns04.c:24: CONF: namespace not available
safe_macros.c:225: BROK: ioctl_ns04.c:31:
open(/proc/self/ns/user,0,01606327050) failed: ENOENT

And so does test getxattr05:
getxattr05.c:85: PASS: Got same data when acquiring the value of
system.posix_acl_access twice
getxattr05.c:95: FAIL: unshare(CLONE_NEWUSER) failed: EINVAL
tst_test.c:362: BROK: Invalid child (29014) exit value 1

Thanks,
Amir.
