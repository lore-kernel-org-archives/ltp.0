From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Wed, 19 Aug 2020 00:20:08 +0800
Subject: [LTP] [PATCHv2 1/2] lib/tst_kvercmp: Add support to get
 distname for different OS in tst_kvcmp_distname
In-Reply-To: <20200818152941.GG27964@yuki.lan>
References: <20200818100422.27775-1-po-hsu.lin@canonical.com>
 <20200818100422.27775-2-po-hsu.lin@canonical.com>
 <20200818152941.GG27964@yuki.lan>
Message-ID: <CAMy_GT9kZbvC9=t9e2J4nrfW+vMHzK-DH2bU3=ZbkJepk4TrEQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 18, 2020 at 11:29 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> >  static char *parse_digit(const char *str, int *d)
> >  {
> >       unsigned long v;
> > @@ -127,6 +130,8 @@ int tst_kvexcmp(const char *tst_exv, const char *cur_ver)
> >
> >  const char *tst_kvcmp_distname(const char *kver)
> >  {
> > +     static char distname[64];
> > +     char *tok;
> >       if (strstr(kver, ".el5uek"))
> >               return "OL5UEK";
> >
> > @@ -139,6 +144,17 @@ const char *tst_kvcmp_distname(const char *kver)
> >       if (strstr(kver, ".el6"))
> >               return "RHEL6";
> >
> > +     // Special case for other releases with the presencse of /etc/os-release
> > +     if (access(OSRELEASE_PATH, F_OK) != -1) {
> > +             SAFE_FILE_LINES_SCANF(NULL, OSRELEASE_PATH, "ID=%s", distname);
> > +             tok = strtok(distname,"\0");
>
> Isn't this strtok() useless?
Hello,
oh indeed, the delimiter in strtok will become null character anyway.
I think just tok = distname can do the trick here.
I will send v3 tomorrow.

Thank you


>
>
> Other than that the patchset looks fine.
>
> > +             while (*tok) {
> > +                     *tok = toupper((unsigned char) *tok);
> > +                     tok++;
> > +             }
> > +             return distname;
> > +     }
> > +
> >       return NULL;
> >  }
> >
> > --
> > 2.25.1
> >
>
> --
> Cyril Hrubis
> chrubis@suse.cz
