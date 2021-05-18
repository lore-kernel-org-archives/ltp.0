From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 May 2021 19:30:39 +0200
Subject: [LTP] [PATCH v2 1/1] doc: Add supported distros (kernel, libc,
 toolchain)
Message-ID: <20210518173039.4657-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Acked-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Acked-by: Jan Stancek <jstancek@redhat.com>
Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
See it:
https://github.com/pevik/ltp/wiki/Supported-kernel-libc-versions

changes v1->v2:
* all requested changes
  - 2 paragraphs from Cyril
  - changed title supported architectures => tested architectures (Cyril)
  - mention Travis uses the lastest distribution image (Xu)
* Put Supported libc into table
 doc/supported-kernel-libc-versions.txt | 67 ++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 doc/supported-kernel-libc-versions.txt

diff --git a/doc/supported-kernel-libc-versions.txt b/doc/supported-kernel-libc-versions.txt
new file mode 100644
index 000000000..a2dd66070
--- /dev/null
+++ b/doc/supported-kernel-libc-versions.txt
@@ -0,0 +1,67 @@
+Supported kernel, libc, toolchain versions
+==========================================
+
+1. Build testing with Travis CI
+-------------------------------
+
+We test master branch in https://travis-ci.org/github/linux-test-project/ltp/builds[travis CI]
+to ensure LTP builds on various distributions including old, current and bleeding edge.
+We test both gcc and clang toolchains, various arch with cross-compilation.
+
+For list of tested distros see
+https://github.com/linux-test-project/ltp/blob/master/.travis.yml[.travis.yml].
+
+
+NOTE: Travis does only build testing, passing the CI means only that the
+      test compiles fine on variety of different distributions and releases.
+      Also it uses the latest distribution image of a particular release.
+
+1.1 Oldest tested distributions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+[align="center",options="header"]
+|==============================================================
+| Distro                       | kernel | glibc | gcc   | clang
+| CentOS 7                     | 3.10   | 2.17  | 4.8.5 | -
+| Ubuntu 16.04 LTS xenial      | 4.4    | 2.23  | 5.3.1 | -
+| Debian 9 stretch (oldstable) | 4.9.30 | 2.24  | 6.3.0 | 3.8
+|==============================================================
+
+Older distributions are not officially supported, which means that it
+may or may not work. It all depends on your luck. It should be possible
+to compile latest LTP even on slightly older distributions than we
+support with a few manual tweaks, e.g. disabling manually tests for
+newly added syscalls manually, etc. Trivial fixes/workarounds may be accepted,
+but users are encouraged to move to a newer distro.
+
+If latest LTP cannot be compiled even with some amount of workarounds,
+you may result to older LTP releases, however these are _not_ supported
+in any way. Also if you are trying to run LTP on more than 10 years old
+distribution you may as well reconsider you life choices.
+
+1.2 Tested architectures
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+[align="center",options="header"]
+|==================================
+| arch          | build
+| x86_64        | native
+| x86 emulation | native
+| aarch64       | cross compilation
+| ppc64le       | cross compilation
+| s390x         | cross compilation
+|==================================
+
+1.3 Supported libc
+~~~~~~~~~~~~~~~~~~
+
+[align="center",options="header"]
+|==================================
+| Libc      | Note
+| https://www.gnu.org/software/libc/[GNU C Library (glibc)] | Targetted libc, tested both compilation and actual test results.
+| https://uclibc-ng.org/[uClibc-ng] | Although not being tested it should work as well as it attempt to maintain a glibc compatible interface.
+| https://www.uclibc.org/[uClibc]   | Older https://www.uclibc.org/[uClibc] might have problems.
+| https://musl.libc.org/[musl] | Not yet fully supported (see
+                                 https://github.com/linux-test-project/ltp/blob/master/travis/alpine.sh[travis script]
+                                 for list of files which need to be deleted in order to compile under musl).
+| binder (Android) | Please use https://android.googlesource.com/platform/external/ltp/[AOSP fork].
-- 
2.31.1

