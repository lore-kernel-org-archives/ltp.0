From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  4 Dec 2017 13:25:48 +0100
Subject: [LTP] [RFC PATCH v3 0/5] Travis enhancements
Message-ID: <20171204122553.15338-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

see
https://travis-ci.org/pevik-travis/ltp/builds/311256334

Changes v2->v3:
* Changing prefix directory to 'ltp-install'. Previous ltp failed, if
  repository was clonned to the root of home directory.  Reported by Li Wang
  (thanks!).

Petr Vorel (5):
  travis: Add build script and use it in travis
  travis: Drop old compilers, add new ones
  travis: Add 32-bit cross-compile builds
  travis: Add out-of-tree build
  travis: Install all dependencies + add build with minimal dependencies

 .travis.packages_i386   |   9 ++++
 .travis.packages_native |  18 ++++++++
 .travis.yml             |  87 +++++++++++++++++++++++++++-----------
 build.sh                | 110 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+), 24 deletions(-)
 create mode 100644 .travis.packages_i386
 create mode 100644 .travis.packages_native
 create mode 100755 build.sh

-- 
2.15.0

