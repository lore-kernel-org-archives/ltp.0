From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Sep 2020 11:29:32 +0200
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2cxf2RQz5psmsaUsBHRrtayLJUVTfCo+NvevSyu7bLmvA@mail.gmail.com>
References: <20200908073138.GB2475@yuki.lan> <20200922182102.GB12980@yuki.lan>
 <CAEemH2dFqYRNNSyhQ1bJ_L+wHFUQkOVBgdnm-_6Nqr4rP7UbBg@mail.gmail.com>
 <CAEemH2cxf2RQz5psmsaUsBHRrtayLJUVTfCo+NvevSyu7bLmvA@mail.gmail.com>
Message-ID: <20200923092932.GB12109@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> CC' people who touched the patches maybe give a hand.
+1

> On Wed, Sep 23, 2020 at 2:50 PM Li Wang <liwang@redhat.com> wrote:

> > On Wed, Sep 23, 2020 at 2:20 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> >> Hi!
> >> As far as I can tell I've pushed the last patch that should have been in
> >> the release just now. With that we should have a week worth of
> >> pre-release testing since we are aiming for a release at the end of the
> >> September. If you haven't tried LTP git HEAD yet, please do so now and
> >> report any problems you find.


> > We still got this persistent fail on some kernels(RHEL8, kernel-v5.9-rc4):

> > ---
> > send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> > send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> > send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> > send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
This is working on openSUSE kernel 5.9.0-rc3. I haven't checked whether there
are some special patches or whether there is a regression in rc4.

> > ---
> > fanotify10.c:404: TFAIL: group 0 (4) got event: mask 1020 (expected 1000)
> > pid=95067 fd=12
> > fanotify10.c:404: TFAIL: group 1 (4) got event: mask 1020 (expected 1000)
> > pid=95067 fd=12
> > fanotify10.c:404: TFAIL: group 2 (4) got event: mask 1020 (expected 1000)
> > pid=95067 fd=12
> > fanotify10.c:404: TFAIL: group 0 (0) got event: mask 1020 (expected 1000)
> > pid=95067 fd=12
> > fanotify10.c:404: TFAIL: group 1 (0) got event: mask 1020 (expected 1000)
> > pid=95067 fd=12
> > fanotify10.c:404: TFAIL: group 2 (0) got event: mask 1020 (expected 1000)
> > pid=95067 fd=12
Again, working on openSUSE kernel 5.9.0-rc3.

> > ---
> > recvmmsg01.c:86:9: error: request for member ?type? in something not a
> > structure or union
> >   timeout.type = tv->ts_type;
Yes, 135af8ededd4d74d32f3322801fbab1f732a259a added in recvmmsg01 broke build:
https://travis-ci.org/github/linux-test-project/ltp/builds/729394877
(this build is for sendto03 - next commit, but that's ok)

Having a look into it.

> > Otherwise, the latest LTP test good from my side(RHEL8, mainline-kernel).

Kind regards,
Petr
