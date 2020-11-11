From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Nov 2020 20:47:56 +0800
Subject: [LTP] [PATCH 1/1] m4: Remove workaround for old pkg-config
In-Reply-To: <20201111114843.GA14760@pevik>
References: <20201110120923.21759-1-pvorel@suse.cz>
 <20201111093934.GA5870@yuki.lan>
 <CAEemH2cyoSpQhTH5S=EWWoD7DaLz6WKFFadLFHMxkW8LHYM5CA@mail.gmail.com>
 <20201111095553.GA8524@pevik>
 <CAEemH2c4qTU1f99MBXTyVgvX-L=LNRneRJvmctkF9YiQ68u_-Q@mail.gmail.com>
 <20201111114843.GA14760@pevik>
Message-ID: <CAEemH2dbUQQr0s10tdTDYLZtx8TR=AYpXGxHjVD_jOYEWhSt8Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Wed, Nov 11, 2020 at 7:48 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > On Wed, Nov 11, 2020 at 5:56 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > > Hi,
>
> > > > On Wed, Nov 11, 2020 at 5:38 PM Cyril Hrubis <chrubis@suse.cz>
> wrote:
>
> > > > > Hi!
> > > > > Looks good to me, let's apply this unless anybody complains.
>
>
> > > > Hold on, please.
>
> > > > Seems we have to replace TIRPC_LIBS/TIRPC_CFLAGS with LIBTIRPC_* in
> all
> > > > respective Makefiles? Otherwise, it will fail like the Travis CI job
> I
> > > > guess.
>
> > > Correct, currently would fail without it.
> > > https://travis-ci.org/github/pevik/ltp/builds/742685737
>
> > > I'll send v2 where I implement this.
>
>
> > Thanks, I modified base on your patch, test result FYI
> >
> https://github.com/wangli5665/ltp/commit/dad10021771101e7fdd416af894be7484fcb7a52
> > https://travis-ci.org/github/wangli5665/ltp/builds/742909686
> You implemented it, thank you. Please push it after Travis finishes.


Pushed, and thanks for the explanation.

>
> Just an explanation, why I introduced TIRPC_{CFLAGS,LIBS}: there was
> Sun-RPC
> implementation in glibc, which I wanted to test. Thus variable name without
> "LIB" to say, that it could be also glibc.
>
> But Sun-RPC is broken, was deprecated and my patchset which removes it from
> glibc was accepted and released in glibc 2.32. Thus I'm going to send patch
> which reverts the commit 60b20c428060b20c428 ("rpc: Enable and fix build
> basic
> RPC tests with glibc SunRPC").
>
> My long term goal: fix and cleanup RPC tests (some are failing also with
> libtirpc), move these tests to libtirpc sources (they needs to be cleaned.
> And
> also I'd prefer to not put there whole LTP library, but just needed
> subset).
>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201111/6b807d74/attachment.htm>
