From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 5 Feb 2020 09:32:11 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/getrandom02: lower bufsize if low on
 entropy
In-Reply-To: <CAEemH2fnu9nZiGDfa5LTTMA0a_-PJ35fjjLdZ2vXYNGRJqHfVA@mail.gmail.com>
References: <7843cc36a04deb034e9479a139f535e5fa5f3135.1580894017.git.jstancek@redhat.com>
 <CAEemH2fnu9nZiGDfa5LTTMA0a_-PJ35fjjLdZ2vXYNGRJqHfVA@mail.gmail.com>
Message-ID: <1751041821.5968536.1580913131753.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> >
> > @@ -37,11 +39,17 @@ static int check_content(unsigned char *buf, int nb)
> >  static void verify_getrandom(unsigned int n)
> >  {
> >         unsigned char buf[256];
> > +       int bufsize = 64, entropy_avail;
> >
> 
> I'm not sure why here initialize bufsize as 64? can you explain more?

That would be the default, unless we know we have enough entropy.

I picked 64 as it matches 'random_read_wakeup_bits'. Assuming we can get
1bit/s entropy, then potentially worst case of waiting 4x for 64bit,
it should still fit within default 300 seconds.

But it's also rule of thumb, because it's smaller.

> 
> 
> >
> > -       memset(buf, 0, sizeof(buf));
> > +       if (access(PROC_ENTROPY_AVAIL, F_OK) == 0) {
> > +               SAFE_FILE_SCANF(PROC_ENTROPY_AVAIL, "%d", &entropy_avail);
> > +               if (entropy_avail > 256)
> > +                       bufsize = sizeof(buf);
> > +       }
> >
> > +       memset(buf, 0, sizeof(buf));
> >         do {
> > -               TEST(tst_syscall(__NR_getrandom, buf, sizeof(buf),
> > modes[n]));
> > +               TEST(tst_syscall(__NR_getrandom, buf, bufsize, modes[n]));
> >         } while ((modes[n] & GRND_NONBLOCK) && TST_RET == -1
> >                   && TST_ERR == EAGAIN);
> >
> > --
> > 2.18.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> >
> 
> --
> Regards,
> Li Wang
> 

