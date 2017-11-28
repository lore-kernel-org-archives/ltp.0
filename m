From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Nov 2017 00:21:26 +0100
Subject: [LTP] [RFC PATCH 0/4] Travis enhancements
Message-ID: <20171128232130.4843-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I've added several travis enhancements, most notably added 32bit cross-compile
build and added more compilers (add gcc-7, clang-4.0, clang-5.0, remove clang-3.9).
Now there is 12 builds instead of 9, speed increased from ~13 min [1] to ~26 min [2],
which is maybe to much.  If we don't like it, we can decide which compilers to have.

BTW I have more plans: adding cross-compile arm build and out of tree build
(this one needs to be fixed).

[1] https://travis-ci.org/pevik-travis/ltp/builds/197584686
[2] https://travis-ci.org/pevik-travis/ltp/builds/308683533

Kind regards,
Petr

Petr Vorel (4):
  travis: Add build script
  travis: Add 32 cross-compile build + use build.sh
  travis: Add gcc-7, clang-4.0, clang-5.0, remove clang-3.9
  travis: Install all dependencies (headers and libraries)

 .travis.yml | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 build.sh    | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 4 deletions(-)
 create mode 100755 build.sh

-- 
2.15.0

