From: Murphy Zhou <xzhou@redhat.com>
Date: Tue, 14 May 2019 20:38:20 +0800
Subject: [LTP] [PATCH] safe_setuid: skip if testing on CIFS
In-Reply-To: <CAH2r5mvSS4crgid-srKr+hycN=uW-vPLGhF81RvA6UBP2T7K4A@mail.gmail.com>
References: <20190510043845.4977-1-xzhou@redhat.com>
 <20190513143413.GA4568@dell5510>
 <CAH2r5mvSS4crgid-srKr+hycN=uW-vPLGhF81RvA6UBP2T7K4A@mail.gmail.com>
Message-ID: <20190514123820.sh5l3rhyxaohmppn@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr and Steve,

Thanks for reviewing! Steve you are right that this is more about
mode bits and ownership. Great to know the development work progress.
Most of the tests fail after setuid because chmod/chown operations
before that does not take effect, which is expected now I guess.
Now I am testing option "dynperm".

Self nack for this patch. Don't skip them.

Thanks!
M

On Mon, May 13, 2019 at 03:13:39PM -0500, Steve French wrote:
> Also note that we are working on patches to improve saving of mode
> bits and ownership information even in cases where the server does not
> support POSIX Extensions.
> 
> Currently mount options cifsacl and idsfromsid can be used for some
> use cases but they are being extended.
> 
> On Mon, May 13, 2019 at 11:04 AM Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Hi Murphy,
> >
> > > As CIFS is not supporting setuid operations.
> > Any reference to this?
> > fs/cifs/cifsfs.c and other parts of kernel cifs works with CIFS_MOUNT_SET_UID.
> > Also samba_setreuid() from lib/util/setid.c from samba git (I guess used in
> > samba libraries works with SYS_setreuid syscall or setreuid() libc wrapper.
> > What am I missing?
> >
> > > diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> > > index 0e59a3f98..36941ec0b 100644
> > > --- a/lib/tst_safe_macros.c
> > > +++ b/lib/tst_safe_macros.c
> > > @@ -111,6 +111,7 @@ int safe_setreuid(const char *file, const int lineno,
> > >                 uid_t ruid, uid_t euid)
> > >  {
> > >       int rval;
> > > +     long fs_type;
> >
> > >       rval = setreuid(ruid, euid);
> > >       if (rval == -1) {
> > > @@ -119,6 +120,13 @@ int safe_setreuid(const char *file, const int lineno,
> > >                        (long)ruid, (long)euid);
> > >       }
> >
> > > +     fs_type = tst_fs_type(".");
> > > +     if (fs_type == TST_CIFS_MAGIC) {
> > > +             tst_brk_(file, lineno, TCONF,
> > > +                      "setreuid is not supported on %s filesystem",
> > > +                      tst_fs_type_name(fs_type));
> > > +     }
> > I guess this check should be before setreuid() As it's in safe_seteuid() and
> > safe_setuid()
> > > +
> > >       return rval;
> > >  }
> >
> > Kind regards,
> > Petr
> 
> 
> 
> -- 
> Thanks,
> 
> Steve
