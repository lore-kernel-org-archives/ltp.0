From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Dec 2017 16:46:36 +0100
Subject: [LTP] [RFC PATCH v2 0/5] Travis enhancements
Message-ID: <20171201154641.27407-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

TL;DR
See https://travis-ci.org/pevik-travis/ltp/builds/310089523

Now we have 11 jobs testing 7 compilers in 3 different ways (mostly normal
builds, 2x 32-bit cross-compile builds, 1x out-of-tree build, 1x build with
minimal dependencies).

It seems to be rule running only 5 containers at a time, so 11th build slowes
building about 4 min (18 min vs. 22 min). Which build would you remove?

I decided to specify dependencies in file (saves some duplicity).
These files can be used for builds on Debian/Ubuntu (as we re

Changes v1->v2:
* Dropped compilers:
  Dropped: gcc 4.6, 4.7, 4.8 and clang 3.5, 3.8
* Added different types of builds (32-bit cross-compile builds, out-of-tree build)
* Better handling of header and library dependencies (minimal build and build with full support).
* Minor changes.

Notes what I learned:
* Travis needs sudo for using apt, but it does not allow to use it in script
  (it must be in travis.yml)
* Don't use $INSTALL environment variable (I haven't figured how, but it
  reported build to be failed).


Petr Vorel (5):
  travis: Add build script and use it in travis
  travis: Drop old compilers, add new ones
  travis: Add 32-bit cross-compile builds
  travis: Add out-of-tree build
  travis: Install all dependencies + add build with minimal dependencies

 .travis.packages_i386   |   9 ++++
 .travis.packages_native |  18 ++++++++
 .travis.yml             |  87 ++++++++++++++++++++++++++-----------
 build.sh                | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+), 24 deletions(-)
 create mode 100644 .travis.packages_i386
 create mode 100644 .travis.packages_native
 create mode 100755 build.sh

-- 
2.15.0

