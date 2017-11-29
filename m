From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 19:31:48 +0100
Subject: [LTP] [RFC PATCH 1/4] travis: Add build script
In-Reply-To: <20171129154227.GB15160@rei>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-2-pvorel@suse.cz>
 <CAEemH2evorTPAHpnYjydKcvwYha27zYSPZGKLZe+97Mni7N7vA@mail.gmail.com>
 <20171129082743.d5i5stufxmn25twr@dell5510>
 <CAEemH2fG=O7vVj=xyY58gwQLkq5JUw4fa4yaUEMAyoJfWE0V_A@mail.gmail.com>
 <20171129145249.6wfxny7sqnwchrjk@dell5510>
 <20171129154227.GB15160@rei>
Message-ID: <20171129183148.GA3573@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Cyril,

> > You're running configure without flags. For travis we run full build, e.g. with
> > --with-open-posix-testsuite --with-realtime-testsuite flags.

> Can we, pretty please, have out-of-tree build without the realtime and
> openposix testsuite for now. That way we will not break what is
> supposedly working for now...
Sure

If you don't mind Li, I'll propose in v2 mine version of out-of-tree function and not yours due things I've noted. But thanks a lot for your input!


Kind regards,
Petr
