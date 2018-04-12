From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Apr 2018 11:01:26 +0800
Subject: [LTP] [PATCH v2] read_all: give more time to wait children
	finish read action
In-Reply-To: <87k1tevvld.fsf@rpws.prws.suse.cz>
References: <20180411094734.10962-1-liwang@redhat.com>
 <87k1tevvld.fsf@rpws.prws.suse.cz>
Message-ID: <CAEemH2ccG7grC2ObLOT-wDSp59v1b5W94cWnmY+VX1Mu+22KdQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Richard Palethorpe <rpalethorpe@suse.de> wrote:

>
> >  #define MAX_DISPLAY 40
> > +#define MICROSECOND 1
>
> Not necessary.
>
​
Ok.
​


> >
> >       for (i = 0; i < worker_count; i++) {
> > -             stop_attempts = 0xffff;
> >               if (workers[i].q) {
>
> Maybe change this to:
> if (!workers[i].q)
>    continue;
>
> To avoid a level of indentation.
>

​Sounds good.
​

> +                     tst_brk(TBROK,
> > +                             "Attempts %d times but still failed to
> push %s",
>                                  ^ Attempted
>

​Good catch.
​


>
> > +                             push_attempts, path);
> >               }
> >       }
> >  }
>
> Maybe you could put the "if (delaly < SECOND) ..." into a function?
>

​Firstly, I was thinking to take use of my new macros, but
consider that have not been reviewed. So I tend to keep
it as original, then replace them entirely after ltp gets
a generic loop functionality in library.



>
> Otherwise this looks good to me. There are some other things I want to
> change on this test, but we can leave those for another patch.
>

​Thanks, Patch v3 is coming...
​


-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180412/49b93e3a/attachment-0001.html>
