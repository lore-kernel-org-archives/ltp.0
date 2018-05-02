From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 2 May 2018 10:32:57 +0200
Subject: [LTP] Source code for binaries like rsh,
 rlogin for embedded platforms like android
In-Reply-To: <72ca108fbea2765334b497fe49c7097b@codeaurora.org>
References: <0c961079e810a1175b3a07486ee0f27d@codeaurora.org>
 <20180430173937.ii2v22cqur6eozug@dell5510>
 <72ca108fbea2765334b497fe49c7097b@codeaurora.org>
Message-ID: <20180502083255.GA29088@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Avinash,

> Hi Petr,

> Thanks for providing the pointers to package sources.

> Will keep an eye for the release which will have an updated network tests.
Are you looking at any particular tests?
Quite a few tests are already able to run over netns (these using tst_net.sh or library
using it, e.g. tst_net_stress.sh, ipsec_lib.sh, virt_lib.sh, if-lib.sh).

And patches fixing this are always welcome.

> Thanks,
> Avinash

Kind regards,
Petr

> > Hi Avinash,

> > > Hi All,

> > > From where I can find source code for tools like rsh, rlogin which
> > > are used
> > > in testcases for various purposes.
> > Rdist: http://www.magnicomp.com/rdist/
> > > Other tools like host, tracepath etc were part of iputils package.
> > > But I am
> > > unable to find source for full netkit-rsh package source.
> > netkit-rsh:
> > http://http.debian.net/debian/pool/main/n/netkit-rsh/netkit-rsh_0.17.orig.tar.gz
> > (from https://packages.debian.org/buster/rsh-client)

> > BTW: We're planning to rewrite all network tests to support ssh/netns.

> > > If anybody in the community has any idea from where I can find then
> > > it would
> > > be of great help. Thanks in advance.

> > > Also, I saw some efforts to port LTP to Android(ANDROID flag for
> > > compilation
> > > in commit-id 34a7c82a7abd0a72746c2369ebdbc34e267b2c44).
> > > Are there any existing activities going on, any pointers to the
> > > progress
> > > made so far would be of great help ?
> > Best version for Android is on:
> > https://android.googlesource.com/platform/external/ltp/
> > Google folks time to time send patches to upstream.

> > > Thanks,
> > > Avinash


> > Kind regards,
> > Petr
