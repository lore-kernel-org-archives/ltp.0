From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Dec 2017 18:45:42 +0100
Subject: [LTP] [RFC PATCH 0/2] travis: Cross-compile ARM builds
Message-ID: <20171212174544.12310-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

last patch-set for travis, adding cross-compile ARM builds (32-bit and 64-bit).
Both builds are in-tree, as out-of-tree build is tested by 2 native builds.

NOTE: It might be possible to add foreign architecture to ubuntu and install
other libraries and headers to do build with full dependencies, but I haven't
tested it.

See the result:
https://travis-ci.org/pevik-travis/ltp/builds/315469420

Kind regards,
Petr

Petr Vorel (2):
  build.sh: Add cross-compile build option
  travis: Add 2x cross-compile ARM build

 .travis.yml | 33 ++++++++++++++++-----------------
 build.sh    | 15 ++++++++++++++-
 2 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.15.0

