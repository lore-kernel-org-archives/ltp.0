From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Dec 2018 16:00:16 +0100
Subject: [LTP] Should people be concerned if they run the tests on their
 work boxes and getting ltp in distributions.
In-Reply-To: <CADdDZRnSugmfoyv1Mpt-HBrMVP5mD7Y4g3wA1cB3yaTPoeoGAg@mail.gmail.com>
References: <CADdDZRnSugmfoyv1Mpt-HBrMVP5mD7Y4g3wA1cB3yaTPoeoGAg@mail.gmail.com>
Message-ID: <20181221150016.GC27446@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi shirish,

> Although one of the questions which probably should be part of the FAQ
> is should there be any concerns in running the tests on your everyday
> work machines ? I know that ideally it should be  run in  a lab but
> what if you do not have acces to that sort of infrastructure ? Are
> these any sort of good practises that people recommend to read through
> before starting the tests ?
https://github.com/linux-test-project/ltp/blob/master/README.md#warning

> I was able to compile and install ltp to /opt/ltp successfully and
> even run the version command, although found it a bit curious as to
> why autotools is used instead of something like cmake which has more
> readable human error output.
IMHO while autotools have lots of disadvantages, they're better for use then
CMake (better for broken toolchain checks + we're not using C++, building only
on windows).

> I also was wondering if there have been distributions which are either
> using ltp as part of their test infrastructure or/and also building
> binaries for their users .
IMHO only embedded ones: buildroot [1], and Yocto/OpenEmbedded [2], android [3]
Gentoo had it [4], but removed it 2 years ago [5], also other distros had it
[6].  And QA teams in enterprise distros use it for testing (SLES, RHEL, Oracle
Linux, ...).  We don't expect it to be packaged in in normal distros, that's why
we have static libraries (easier to reinstall for embedded, although I wanted to
optionally build shred libraries instead) and use default PREFIX /opt.

Kind regards,
Petr

[1] https://git.busybox.net/buildroot/tree/package/ltp-testsuite
[2] http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/meta/recipes-extended/ltp/
[3] https://android.googlesource.com/platform/external/ltp/
[4] https://gitweb.gentoo.org/repo/gentoo.git/tree/app-benchmarks/ltp?id=469b5b5fe0ed34052bafe67b3fc065468faeec3d
[5] https://gitweb.gentoo.org/repo/gentoo.git/commit/?id=755e2e74b59343ea17fa6b7582ced53cd83dfd0f
[6] https://pkgs.org/download/ltp
