From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 12 Sep 2017 23:27:53 +0200
Subject: [LTP] [RFC PATCH 1/6] android: cve: Disable building
 cve-2017-5669
In-Reply-To: <CAJgzZoqb1WTRctUYy+eqXqafBX5F4jd-XchHFQ97M=44qV6F3A@mail.gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-2-petr.vorel@gmail.com>
 <20170905213027.GP84377@sspatil-desktop.mtv.corp.google.com>
 <20170911214149.4ongogs2asatw454@dell5510>
 <CAJgzZoqb1WTRctUYy+eqXqafBX5F4jd-XchHFQ97M=44qV6F3A@mail.gmail.com>
Message-ID: <20170912212752.qw24kjkjxg5qqpaq@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> (since none of the folks actually working on this seem to be responding...)

> no, they don't, but effectively, yes: the standalone toolchain is the
> closest thing outside the platform build to what the platform build is
> like. (and it's almost always the right choice any time you're trying
> to build a non-Android linux project.)
Right, I should have realized from the link and Android.mk that you're building
in AOSP tree :-).

> as for the API level, because they're part of the platform build, in
> NDK terms they're targeting "FUTURE", which isn't available in the
> NDK. so you'll want 26 for now and then 27 when it's available and so
> on.

> if you *really* care, you can litter the code with stuff like

>   #if defined(__BIONIC__) && __ANDROID_API_LEVEL__ > 21
>   // code that requires something that only appeared in Lollipop
>   #endif
Well, even I posted code like this, I realized that flood the code with many
ifdefs isn't desired for LTP upstream especially AOSP itself doesn't care about
old releases.

> but these VTS folks only care about the current platform release.
> (because we can't suddenly go to OEMs and say "oh, that device you
> shipped three or four years ago now has to pass this new test" for
> obvious reasons :-) .)
"Nice" embedded industry :-).

> one thing that's a little slippery is that there's stuff like SysV IPC
> where the headers and functions are available and if you're on a
> rooted device with a custom kernel, you can use it just fine, but
> actual shipping Android devices MUST NOT ship with kernels that
> support SysV IPC and MUST NOT relax the selinux neverallows that would
> prevent you from using that stuff even if it was compiled in to your
> kernel and so on... so there's a bit of a distinction between "i want
> to be able to build this project" and "i want all these tests to
> pass".
Sure, successful build for android is the first step, IMHO the easier part.
And after fixing tests written in C there would be another challenging task:
make all this shell scripts working on Android (IMHO impossible with toolbox,
even with busybox would be hard).
OT: It'd be interesting to use LTP as a part of CTS to ensure that SysV IPC
doesn't work :-).


Kind regards,
Petr
