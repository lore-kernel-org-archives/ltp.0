From: Daniel =?unknown-8bit?q?D=C3=ADaz?= <daniel.diaz@linaro.org>
Date: Wed, 20 Feb 2019 10:48:55 -0600
Subject: [LTP] [PATCH 3/3] syscalls/ptrace05: Include lapi/signal.h for
 __SIGRT{MIN, MAX}
In-Reply-To: <20190220163329.GA7554@x230>
References: <20190220153412.18090-1-daniel.diaz@linaro.org>
 <20190220153412.18090-3-daniel.diaz@linaro.org> <20190220163329.GA7554@x230>
Message-ID: <CAEUSe7-sw7c8UdXy62HzjdXtp3ziD=ZCWYUMjw0tousN1fFHsg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hello!

On Wed, 20 Feb 2019 at 10:33, Petr Vorel <pvorel@suse.cz> wrote:
> Hi Daniel,
>
> > MUSL does not include __SIGRTMIN nor __SIGRTMAX. The
> > compatibility header can help here.
> lib/tst_sig.c and testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01=
.c also
> use __SIGRTMIN. Don't you have a problem to build it?

Using latest LTP and latest OE-Core (MACHINE =3D "qemuarm64"; TCLIB =3D
"musl"), no, it built fine. Same for 20190115 -- it built fine. (I'm
about to submit the upgrade to that version to OE-core.)

Would you like me to add the #include in those two as well?


> + I'd squash adding of these includes into single commit.

Great! I did that for OE, so let me send that patch instead.

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
