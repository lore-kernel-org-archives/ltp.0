From: enh <enh@google.com>
Date: Tue, 12 Sep 2017 11:21:13 -0700
Subject: [LTP] [RFC PATCH 1/6] android: cve: Disable building
	cve-2017-5669
In-Reply-To: <20170911214149.4ongogs2asatw454@dell5510>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-2-petr.vorel@gmail.com>
 <20170905213027.GP84377@sspatil-desktop.mtv.corp.google.com>
 <20170911214149.4ongogs2asatw454@dell5510>
Message-ID: <CAJgzZoqb1WTRctUYy+eqXqafBX5F4jd-XchHFQ97M=44qV6F3A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 11, 2017 at 2:41 PM, Petr Vorel <petr.vorel@gmail.com> wrote:
>
> Hi,
>
> > Do you have pointers to how you are build + testing with this? There seem to
> > be some duplication of effort that I would like to avoid and make sure there
> > is only 1 way in which tests like this are disabled out of build.
>
> > I am currently working through a list[1] of disabled tests to make sure
> > nothing has changed and will love to have a unified way of maintaining that
> > list instead of doing it out-of-tree.
>
> > - ssp
>
> > 1. https://android.googlesource.com/platform/external/ltp/+/master/android/tools/disabled_tests.txt
>
> Great, it'd be nice to have working Android build (and not just everything disabled).
> Nice list, thanks for sharing.
>
> BTW do you build with standalone toolchain? Which API level are you going to support?
> https://android.googlesource.com/platform/ndk/+/master/build/tools/make-standalone-toolchain.sh

(since none of the folks actually working on this seem to be responding...)

no, they don't, but effectively, yes: the standalone toolchain is the
closest thing outside the platform build to what the platform build is
like. (and it's almost always the right choice any time you're trying
to build a non-Android linux project.)

as for the API level, because they're part of the platform build, in
NDK terms they're targeting "FUTURE", which isn't available in the
NDK. so you'll want 26 for now and then 27 when it's available and so
on.

if you *really* care, you can litter the code with stuff like

  #if defined(__BIONIC__) && __ANDROID_API_LEVEL__ > 21
  // code that requires something that only appeared in Lollipop
  #endif

but these VTS folks only care about the current platform release.
(because we can't suddenly go to OEMs and say "oh, that device you
shipped three or four years ago now has to pass this new test" for
obvious reasons :-) .)

one thing that's a little slippery is that there's stuff like SysV IPC
where the headers and functions are available and if you're on a
rooted device with a custom kernel, you can use it just fine, but
actual shipping Android devices MUST NOT ship with kernels that
support SysV IPC and MUST NOT relax the selinux neverallows that would
prevent you from using that stuff even if it was compiled in to your
kernel and so on... so there's a bit of a distinction between "i want
to be able to build this project" and "i want all these tests to
pass".

> Kind regards,
> Petr




-- 
Elliott Hughes - http://who/enh - http://jessies.org/~enh/
Android native code/tools questions? Mail me/drop by/add me as a reviewer.
