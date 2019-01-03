From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  3 Jan 2019 14:26:04 +0100
Subject: [LTP] [PATCH v2 0/3] Docker based travis CI
Message-ID: <20190103132607.24930-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v1->v2 (mostly Cyril's suggestions for 3rd commit):
* generate docker files on the fly
* remove unused script travis/travis.sh (I wasn't able to put this file
  into docker, that's why it's its content in .travis.yml)
* simplify file names (@Cyril: using siple debian.sh instead of setup.debian.sh)

It looked to me easier to use symlinks in travis/ directory then add
another variable. Now we see for each build compiler and distro +
optional variant or tree:

https://travis-ci.org/pevik/ltp/builds/474844878

Kind regards,
Petr

Petr Vorel (3):
  ver_linux: Print clang version
  ver_linux: Add lsb_release -a
  travis: Use docker based builds

 .travis.packages_i386                  |   9 --
 .travis.packages_native                |  18 ---
 .travis.yml                            | 149 +++++++++----------------
 build.sh                               |  12 +-
 travis/centos.sh                       |   1 +
 travis/debian.cross-compile.aarch64.sh |   7 ++
 travis/debian.cross-compile.ppc64le.sh |   7 ++
 travis/debian.i386.sh                  |  19 ++++
 travis/debian.minimal.sh               |  19 ++++
 travis/debian.sh                       |  35 ++++++
 travis/fedora.sh                       |  12 ++
 travis/opensuse.sh                     |   1 +
 travis/tumbleweed.sh                   |  21 ++++
 travis/ubuntu.sh                       |   1 +
 ver_linux                              |   5 +
 15 files changed, 189 insertions(+), 127 deletions(-)
 delete mode 100644 .travis.packages_i386
 delete mode 100644 .travis.packages_native
 create mode 120000 travis/centos.sh
 create mode 100755 travis/debian.cross-compile.aarch64.sh
 create mode 100755 travis/debian.cross-compile.ppc64le.sh
 create mode 100755 travis/debian.i386.sh
 create mode 100755 travis/debian.minimal.sh
 create mode 100755 travis/debian.sh
 create mode 100755 travis/fedora.sh
 create mode 120000 travis/opensuse.sh
 create mode 100755 travis/tumbleweed.sh
 create mode 120000 travis/ubuntu.sh

-- 
2.19.2

