From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 17 May 2021 07:55:27 +0200
Subject: [LTP] [RFC PATCH 1/1] doc: Add supported kernel, libc versions
In-Reply-To: <YJ6A0gcR9L+P9IXm@yuki>
References: <20210514132639.4181-1-pvorel@suse.cz> <YJ6A0gcR9L+P9IXm@yuki>
Message-ID: <CAASaF6ytbCjwOSOywR4JUToJb_u9fOe2a2y4zE7_n99cgre5TQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 14, 2021 at 4:19 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > +Supported kernel, libc, toolchain versions
> > +==========================================
> > +
> > +1. Build testing with Travis CI
> > +-------------------------------
> > +
> > +We test master branch in https://travis-ci.org/github/linux-test-project/ltp/builds[travis CI]
> > +to ensure LTP builds on various distributions including old, current and bleeding edge.
> > +We test both gcc and clang toolchains, various arch with cross-compilation.
> > +
> > +For list of tested distros see
> > +https://github.com/linux-test-project/ltp/blob/master/.travis.yml[.travis.yml].
> > +
> > +
> > +NOTE: Travis does only build testing, passing the CI means only that the
> > +      test compiles fine on variety of different distributions and releases.
> > +
> > +1.1 Oldest tested distributions
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +[align="center",options="header"]
> > +|==============================================================
> > +| Distro                       | kernel | glibc | gcc   | clang
> > +| CentOS 7                     | 3.10   | 2.17  | 4.8.5 | -
> > +| Ubuntu 16.04 LTS xenial      | 4.4    | 2.23  | 5.3.1 | -
> > +| Debian 9 stretch (oldstable) | 4.9.30 | 2.24  | 6.3.0 | 3.8
> > +|==============================================================
> > +
> > +For older versions please use https://github.com/linux-test-project/ltp/releases[older LTP releases].
>
> I'm not sure that this is a good suggestion.
>
> I would write something as:
>
> Older distributions are not officially supported, which means that it
> may or may not work. It all depends on your luck. It should be possible
> to compile latest LTP even on slightly older distributions than we
> support with a few manual tweaks, e.g. disabling manually tests for
> newly added syscalls manually, etc.
>
> If latest LTP cannot be compiled even with some amount of workarounds,
> you may result to older LTP releases, however these are _not_ supported
> in any way. Also if you are trying to run LTP on more than 10 years old
> distribution you may as well reconsider you life choices.

Should we also give some hint about accepting patches/wokrarounds for
very old distros?
For example: "Trivial fixes/workarounds may be accepted, but users are
encouraged to move to newer distro."

>
> > +1.2 Supported architectures
>         ^
>         Tested?
>
> We do support more than we test, right?
>
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +[align="center",options="header"]
> > +|==================================
> > +| arch          | build
> > +| x86_64        | native
> > +| x86 emulation | native
> > +| aarch64       | cross compilation
> > +| ppc64le       | cross compilation
> > +| s390x         | cross compilation
> > +|==================================
> > +
> > +1.3 Supported libc
> > +~~~~~~~~~~~~~~~~~~
> > +
> > +Targeted libc is https://www.gnu.org/software/libc/[GNU C Library (glibc)].
> > +
> > +https://uclibc-ng.org/[uClibc-ng] is not being tested should work as well as it
> > +attempt to maintain a glibc compatible interface
> > +(older https://www.uclibc.org/[uClibc] might have problems).
> > +
> > +https://musl.libc.org/[musl] is not yet supported
>                                           ^
>                                           fully?
> > +(see https://github.com/linux-test-project/ltp/blob/master/travis/alpine.sh[travis script]
> > +for list of files which need to be deleted in order to compile under musl).
> > +
> > +For bionic libc please (Android) use https://android.googlesource.com/platform/external/ltp/[AOSP fork].
>
>
> Thanks a lot for starting this.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>

