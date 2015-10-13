From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 13 Oct 2015 06:54:46 -0400 (EDT)
Subject: [LTP] [PATCH v2] mem/hugetlb: shift an empty region to use in
 hugemmap02.c
In-Reply-To: <CAEemH2dGJE+zhHH83yeNzAW=A0H8o0T-D3nH=yc1Xt5sN0m2TQ@mail.gmail.com>
References: <1444647235-3041-1-git-send-email-liwang@redhat.com>
 <20151012182924.GB24472@rei.suse.cz>
 <CAEemH2eZKj6USX5nmVrRQ7QVykOrYZ9c=BhVPASW3=YTatZ0zA@mail.gmail.com>
 <CAEemH2dGJE+zhHH83yeNzAW=A0H8o0T-D3nH=yc1Xt5sN0m2TQ@mail.gmail.com>
Message-ID: <1102055073.29673944.1444733686476.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Cyril Hrubis" <chrubis@suse.cz>, "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 13 October, 2015 12:15:23 PM
> Subject: Re: [LTP] [PATCH v2] mem/hugetlb: shift an empty region to use in hugemmap02.c
> 
> Hi,
> 
> On Tue, Oct 13, 2015 at 1:39 PM, Li Wang <liwang@redhat.com> wrote:
> 
> > Hi,
> >
> > On Tue, Oct 13, 2015 at 2:29 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> >
> >> Hi!
> >> Generall idea looks good, a few comments below.
> >>
> >> > +/* MMAP */
> >> > +int range_is_mapped(unsigned long low, unsigned long high)
> >> >  #endif
> >> > diff --git a/testcases/kernel/mem/lib/mem.c
> >> b/testcases/kernel/mem/lib/mem.c
> >> > index 118b6c0..e0e1bdf 100644
> >> > --- a/testcases/kernel/mem/lib/mem.c
> >> > +++ b/testcases/kernel/mem/lib/mem.c
> >> > @@ -1113,3 +1113,46 @@ void update_shm_size(size_t * shm_size)
> >> >               *shm_size = shmmax;
> >> >       }
> >> >  }
> >> > +
> >> > +int range_is_mapped(unsigned long low, unsigned long high)
> >> > +{
> >> > +     FILE *f;
> >> > +     int MAPS_BUF_SZ = 4096;
> >> > +     char line[MAPS_BUF_SZ];
> >> > +     char *tmp;
> >> > +
> >> > +     f = fopen("/proc/self/maps", "r");
> >> > +     if (!f) {
> >> > +             printf("Failed to open /proc/self/maps.\n");
> >>                 ^
> >>                 should rather be tst_resm(TWARN, );
> >>
> >
> > ok. looks like using
> >     FILE * f = SAFE_FOPEN(NULL, "/proc/self/maps", "r");
> > is better than above.
> >
> >
> >> > +             return -1;
> >> > +     }
> >> > +
> >> > +     while (1) {
> >> > +             unsigned long start, end;
> >> > +             int ret;
> >> > +
> >> > +             tmp = fgets(line, MAPS_BUF_SZ, f);
> >> > +             if (!tmp)
> >> > +                     break;
> >> > +
> >> > +             ret = sscanf(line, "%lx-%lx", &start, &end);
> >> > +             if (ret != 2) {
> >> > +                     printf("Couldn't parse /proc/self/maps line:
> >> %s\n",
> >> > +                                     line);
> >>                         ^
> >>                         here as well
> >>
> >
> > ok.
> >
> >
> >> > +                     fclose(f);
> >> > +                     return -1;
> >> > +             }
> >>
> >> Why don't you just use fscanf()? It doesn't make sense to read the line
> >> into the buffer and then sscanf() the values.
> >>
> >
> okay, seems you are right. I tried and achieved another one,  following
> code test pass on my s390x system.
> -----------------------------------------
> int range_is_mapped(unsigned long low, unsigned long high)
> {
>     FILE *f = SAFE_FOPEN(NULL, "/proc/self/maps", "r");
> 
>     char buf[512];
> 
>     while (!feof(f)) {
>         unsigned long start, end;
>         int ret;
> 
>         ret = fscanf(f, "%lx-%lx %[^\n]%*c]", &start, &end, buf);
>         if (ret != 3) {
>             tst_resm(TWARN | TERRNO, "Couldn't parse /proc/self/maps
> line.");
>             SAFE_FCLOSE(NULL, f);
>         }
> 
>         if ((start >= low) && (start < high)) {
>             SAFE_FCLOSE(NULL, f);
>             return 1;
>         }
>         if ((end >= low) && (end < high)) {
>             SAFE_FCLOSE(NULL, f);
>             return 1;
>         }
>     }
> 
>     SAFE_FCLOSE(NULL, f);
>     return 0;
> }
> 
> so, which one is better?  I will format patch V3 when getting some
> proposals.
> 
> cc' jstancek@ if has some good idea.
> 

The approach above should work, but it also stores data to buf,
that we don't care about. You could do fscanf + "while (fgetc(f) != '\n');"
to forward to next line, if you want to avoid using buf.

Anyway, I'd go with fgets() + sscanf(), it wastes couple bytes on stack,
but it's the simplest.

Regards,
Jan
