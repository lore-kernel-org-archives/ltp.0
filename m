From: Sandeep Patil <sspatil@google.com>
Date: Tue, 19 Sep 2017 16:46:00 -0700
Subject: [LTP] [RFC PATCH 1/6] android: cve: Disable building
 cve-2017-5669
In-Reply-To: <CAJgzZoptx4Dxj9fkq9bKqPxZEzqgJvG5fHGgx36tMQqwK0oGOA@mail.gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-2-petr.vorel@gmail.com>
 <20170905213027.GP84377@sspatil-desktop.mtv.corp.google.com>
 <20170911214149.4ongogs2asatw454@dell5510>
 <CAJgzZoqb1WTRctUYy+eqXqafBX5F4jd-XchHFQ97M=44qV6F3A@mail.gmail.com>
 <20170912212752.qw24kjkjxg5qqpaq@x230>
 <CAJgzZoptx4Dxj9fkq9bKqPxZEzqgJvG5fHGgx36tMQqwK0oGOA@mail.gmail.com>
Message-ID: <20170919234600.GA69781@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

(dropped the ball on this thread altogher...)

On Tue, Sep 12, 2017 at 04:58:54PM -0700, enh wrote:
> On Tue, Sep 12, 2017 at 2:27 PM, Petr Vorel <petr.vorel@gmail.com> wrote:
> >
> > Hi,
> >
> > > (since none of the folks actually working on this seem to be responding...)
> >
> > > no, they don't, but effectively, yes: the standalone toolchain is the
> > > closest thing outside the platform build to what the platform build is
> > > like. (and it's almost always the right choice any time you're trying
> > > to build a non-Android linux project.)
> > Right, I should have realized from the link and Android.mk that you're building
> > in AOSP tree :-).
> >
> > > as for the API level, because they're part of the platform build, in
> > > NDK terms they're targeting "FUTURE", which isn't available in the
> > > NDK. so you'll want 26 for now and then 27 when it's available and so
> > > on.
> >
> > > if you *really* care, you can litter the code with stuff like
> >
> > >   #if defined(__BIONIC__) && __ANDROID_API_LEVEL__ > 21
> > >   // code that requires something that only appeared in Lollipop
> > >   #endif
> > Well, even I posted code like this, I realized that flood the code with many
> > ifdefs isn't desired for LTP upstream especially AOSP itself doesn't care about
> > old releases.
> 
> yeah, i don't think anyone would thank you for it :-)


Indeed :)

> 
> > > but these VTS folks only care about the current platform release.
> > > (because we can't suddenly go to OEMs and say "oh, that device you
> > > shipped three or four years ago now has to pass this new test" for
> > > obvious reasons :-) .)
> > "Nice" embedded industry :-).
> >
> > > one thing that's a little slippery is that there's stuff like SysV IPC
> > > where the headers and functions are available and if you're on a
> > > rooted device with a custom kernel, you can use it just fine, but
> > > actual shipping Android devices MUST NOT ship with kernels that
> > > support SysV IPC and MUST NOT relax the selinux neverallows that would
> > > prevent you from using that stuff even if it was compiled in to your
> > > kernel and so on... so there's a bit of a distinction between "i want
> > > to be able to build this project" and "i want all these tests to
> > > pass".
> > Sure, successful build for android is the first step, IMHO the easier part.
> > And after fixing tests written in C there would be another challenging task:
> > make all this shell scripts working on Android (IMHO impossible with toolbox,
> > even with busybox would be hard).
> 
> toolbox is [mostly] long dead. current status:
> https://android.googlesource.com/platform/system/core/+/master/shell_and_utilities/
> 
> (looks like i should update that to say where "O" occurred...)
> 
> if you have specific requests for missing commands/options, file them
> at the toybox github or android bug tracker (or just mail me
> directly).
> 
> > OT: It'd be interesting to use LTP as a part of CTS to ensure that SysV IPC
> > doesn't work :-).
> 
> i think they are using LTP as part of VTS
> (https://source.android.com/devices/architecture/treble), which is why
> they're interested in building LTP with bionic for Android.

Yes, LTP runs as part of VTS and that's the reason to get as many tests as
possible working with bionic (atleast those that apply to Android.) Teh
scripts and commands tests as we are finding out increasingly depend or make
assumptions about the environment that are simply not true with Android. So,
in *most* cases, they land in that "disabled_tests" list, for those that do
work or are fixable with "available tools", we keep them around and they are
run as part of VTS.


Also, FYI, there are tests in VTS that make sure certain kernel
configurations are not set, thus making sure SYSV_IPC is never compiled in.

- ssp
