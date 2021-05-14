From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 May 2021 15:26:39 +0200
Subject: [LTP] [RFC PATCH 1/1] doc: Add supported kernel, libc versions
Message-ID: <20210514132639.4181-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/supported-kernel-libc-versions.txt | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 doc/supported-kernel-libc-versions.txt

diff --git a/doc/supported-kernel-libc-versions.txt b/doc/supported-kernel-libc-versions.txt
new file mode 100644
index 000000000..b7ae01f11
--- /dev/null
+++ b/doc/supported-kernel-libc-versions.txt
@@ -0,0 +1,57 @@
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
+For older versions please use https://github.com/linux-test-project/ltp/releases[older LTP releases].
+
+1.2 Supported architectures
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+Targeted libc is https://www.gnu.org/software/libc/[GNU C Library (glibc)].
+
+https://uclibc-ng.org/[uClibc-ng] is not being tested should work as well as it
+attempt to maintain a glibc compatible interface
+(older https://www.uclibc.org/[uClibc] might have problems).
+
+https://musl.libc.org/[musl] is not yet supported
+(see https://github.com/linux-test-project/ltp/blob/master/travis/alpine.sh[travis script]
+for list of files which need to be deleted in order to compile under musl).
+
+For bionic libc please (Android) use https://android.googlesource.com/platform/external/ltp/[AOSP fork].
-- 
2.31.1

