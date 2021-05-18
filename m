From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 May 2021 19:49:29 +0200
Subject: [LTP] [PATCH v2 1/1] doc: Add supported distros (kernel, libc,
 toolchain)
In-Reply-To: <20210518173039.4657-1-pvorel@suse.cz>
References: <20210518173039.4657-1-pvorel@suse.cz>
Message-ID: <YKP+KakyxIuGc/fo@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> diff --git a/doc/supported-kernel-libc-versions.txt b/doc/supported-kernel-libc-versions.txt
> new file mode 100644
> index 000000000..a2dd66070
> --- /dev/null
> +++ b/doc/supported-kernel-libc-versions.txt
> @@ -0,0 +1,67 @@
> +Supported kernel, libc, toolchain versions
> +==========================================
> +
> +1. Build testing with Travis CI
> +-------------------------------
> +
> +We test master branch in https://travis-ci.org/github/linux-test-project/ltp/builds[travis CI]
> +to ensure LTP builds on various distributions including old, current and bleeding edge.
> +We test both gcc and clang toolchains, various arch with cross-compilation.
                                                  ^
						  This should be plural
						  so 'archs' I guess
> +For list of tested distros see
> +https://github.com/linux-test-project/ltp/blob/master/.travis.yml[.travis.yml].
> +
> +
> +NOTE: Travis does only build testing, passing the CI means only that the
> +      test compiles fine on variety of different distributions and releases.
> +      Also it uses the latest distribution image of a particular release.
           ^
	  Travis also uses...
> +1.1 Oldest tested distributions
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +[align="center",options="header"]
> +|==============================================================
> +| Distro                       | kernel | glibc | gcc   | clang
> +| CentOS 7                     | 3.10   | 2.17  | 4.8.5 | -
> +| Ubuntu 16.04 LTS xenial      | 4.4    | 2.23  | 5.3.1 | -
> +| Debian 9 stretch (oldstable) | 4.9.30 | 2.24  | 6.3.0 | 3.8
> +|==============================================================
> +
> +Older distributions are not officially supported, which means that it
> +may or may not work. It all depends on your luck. It should be possible
> +to compile latest LTP even on slightly older distributions than we
> +support with a few manual tweaks, e.g. disabling manually tests for
> +newly added syscalls manually, etc. Trivial fixes/workarounds may be accepted,
                          ^
			  This 'manually' is redundant and should be removed.

> +but users are encouraged to move to a newer distro.
> +
> +If latest LTP cannot be compiled even with some amount of workarounds,
> +you may result to older LTP releases, however these are _not_ supported
> +in any way. Also if you are trying to run LTP on more than 10 years old
> +distribution you may as well reconsider you life choices.

So in the end you haven't changed this for the nicer version I've
proposed?

> +1.2 Tested architectures
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +[align="center",options="header"]
> +|==================================
> +| arch          | build
> +| x86_64        | native
> +| x86 emulation | native
> +| aarch64       | cross compilation
> +| ppc64le       | cross compilation
> +| s390x         | cross compilation
> +|==================================
> +
> +1.3 Supported libc
> +~~~~~~~~~~~~~~~~~~
> +
> +[align="center",options="header"]
> +|==================================
> +| Libc      | Note
> +| https://www.gnu.org/software/libc/[GNU C Library (glibc)] | Targetted libc, tested both compilation and actual test results.
> +| https://uclibc-ng.org/[uClibc-ng] | Although not being tested it should work as well as it attempt to maintain a glibc compatible interface.
> +| https://www.uclibc.org/[uClibc]   | Older https://www.uclibc.org/[uClibc] might have problems.
> +| https://musl.libc.org/[musl] | Not yet fully supported (see
> +                                 https://github.com/linux-test-project/ltp/blob/master/travis/alpine.sh[travis script]
> +                                 for list of files which need to be deleted in order to compile under musl).
> +| binder (Android) | Please use https://android.googlesource.com/platform/external/ltp/[AOSP fork].
> -- 
> 2.31.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
