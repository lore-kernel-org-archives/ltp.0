From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  5 Oct 2020 15:30:43 +0200
Subject: [LTP] [PATCH 00/11] Test metadata extraction
Message-ID: <20201005133054.23587-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patchset adds a test metadata extraction into LTP and also
documentation generator that produces browseable HTML documentation from
the exported metadata. For detailed description of the idea and
implementation see the patch that adds README.md.

While the idea is quite new the code is mature enough to be included in
the upstream repository and I'm also worried that we will not get any
feedback or users of the metadata unless it's included in the upstream
git.

The next step is to use the extracted metadata in runltp-ng in the proof
of concept parallel executor that has been written by Ritchie and posted
to this mailing list as well.

Cyril Hrubis (4):
  docparse: Add test documentation parser
  docparse: Add README
  syscalls: Add a few documentation comments
  syscalls: Move needs_drivers inside of the tst_test struct

Petr Vorel (7):
  make: Support compiling native build tools
  travis: Add git
  make: Allow {INSTALL,MAKE}_TARGETS be a directory
  make: Allow CLEAN_TARGETS to remove directories
  travis: Install docparse dependencies
  docparse: Add configure options
  docparse: Generate html and pdf using asciidoc{,tor}

 Makefile                                      |   4 +
 configure.ac                                  |  32 +-
 docparse/.gitignore                           |   7 +
 docparse/Makefile                             |  77 ++++
 docparse/README.md                            | 248 ++++++++++
 docparse/data_storage.h                       | 299 ++++++++++++
 docparse/docparse.c                           | 415 +++++++++++++++++
 docparse/parse.sh                             |  41 ++
 docparse/testinfo.pl                          | 424 ++++++++++++++++++
 include/mk/config.mk.in                       |  21 +
 include/mk/env_post.mk                        |   3 +-
 include/mk/features.mk.in                     |   5 +
 include/mk/functions.mk                       |   3 +-
 include/mk/generic_leaf_target.inc            |  16 +-
 include/mk/rules.mk                           |   8 +
 m4/ax_compare_version.m4                      | 177 ++++++++
 m4/ax_prog_perl_modules.m4                    |  77 ++++
 m4/ltp-docparse.m4                            | 112 +++++
 testcases/kernel/syscalls/abort/abort01.c     |  16 +-
 testcases/kernel/syscalls/accept/accept01.c   |   8 +-
 testcases/kernel/syscalls/accept/accept02.c   |   7 +-
 testcases/kernel/syscalls/acct/acct01.c       |   5 +
 testcases/kernel/syscalls/acct/acct02.c       |   6 +-
 .../kernel/syscalls/fsetxattr/fsetxattr02.c   |  10 +-
 testcases/kernel/syscalls/ioctl/ioctl08.c     |   9 +-
 travis/alpine.sh                              |   4 +
 travis/debian.minimal.sh                      |   8 +-
 travis/debian.sh                              |  10 +-
 travis/fedora.sh                              |  12 +-
 travis/tumbleweed.sh                          |   9 +-
 30 files changed, 2034 insertions(+), 39 deletions(-)
 create mode 100644 docparse/.gitignore
 create mode 100644 docparse/Makefile
 create mode 100644 docparse/README.md
 create mode 100644 docparse/data_storage.h
 create mode 100644 docparse/docparse.c
 create mode 100755 docparse/parse.sh
 create mode 100755 docparse/testinfo.pl
 create mode 100644 m4/ax_compare_version.m4
 create mode 100644 m4/ax_prog_perl_modules.m4
 create mode 100644 m4/ltp-docparse.m4

-- 
2.26.2

