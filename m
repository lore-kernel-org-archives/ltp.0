From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon,  5 Jul 2021 15:50:14 +0200
Subject: [LTP] [PATCH] fs_bind: Convert to ltp tests
In-Reply-To: <20210705135014.679200-1-lkml@jv-coder.de>
References: <20210705135014.679200-1-lkml@jv-coder.de>
Message-ID: <20210705135014.679200-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This patchset converts all fs_bind tests to individual ltp tests.
The test functionality is basically unchanged, just converted to
use a library instead of a testrunner script and several binaries
and shell scripts.

The tool smount is dropped. It should not be required anymore,
because it just emulates mount's --make-{shared,private,...},
which should be supported by most mount implementation nowadays.

Every test now also verifies, if the expected mounts exist, by
unmounting all expected mountpoints in the end and the library
code makes sure, no unexpected mountpoints remain.

The cloneNS tests are now also executed and working. The test code
is now fully contained in the fs_bind_cloneNS*.sh files, instead
of three files for test, parent and child and some wonky synchronization.
The three files contained code, that was executed before creating the
new mount namespace, in the parent process and in the child process.
The code in parent and child process had some synchronization points before.
Using ns_create and ns_exec no snychronization is required anymore,
because code can be executed arbitrarily in the parent or child namespace.

The test code uses only 3 actions:
 - mount (fs_bind_makedir is also a mount)
 - fs_bind_check to compare directory trees
 - umount
The cloneNS tests additionally create a mount namespace and run some
of the command inside this namespace.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 runtest/fs_bind                               | 106 +++-
 testcases/kernel/fs/fs_bind/.gitignore        |   2 -
 testcases/kernel/fs/fs_bind/BUGS              |   5 -
 testcases/kernel/fs/fs_bind/CHANGELOG         |  84 ---
 testcases/kernel/fs/fs_bind/Makefile          |  28 +-
 testcases/kernel/fs/fs_bind/README            | 165 ------
 testcases/kernel/fs/fs_bind/TODO              |  11 -
 testcases/kernel/fs/fs_bind/bin/Makefile      |  31 --
 testcases/kernel/fs/fs_bind/bin/check_prop    |  73 ---
 testcases/kernel/fs/fs_bind/bin/lockfile      |  84 ---
 testcases/kernel/fs/fs_bind/bin/makedir       | 101 ----
 testcases/kernel/fs/fs_bind/bin/nsclone.c     |  68 ---
 testcases/kernel/fs/fs_bind/bin/setup         | 104 ----
 testcases/kernel/fs/fs_bind/bin/setupnslock   |  64 ---
 testcases/kernel/fs/fs_bind/bin/smount.c      |  73 ---
 .../fs/fs_bind/bind/00_Descriptions.txt       | 176 ------
 testcases/kernel/fs/fs_bind/bind/Makefile     |  11 +
 testcases/kernel/fs/fs_bind/bind/fs_bind01.sh |  48 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind02.sh |  50 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind03.sh |  61 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind04.sh |  50 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind05.sh |  58 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind06.sh |  47 ++
 .../kernel/fs/fs_bind/bind/fs_bind07-2.sh     |  34 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind07.sh |  57 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind08.sh |  48 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind09.sh |  57 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind10.sh |  52 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind11.sh |  63 +++
 testcases/kernel/fs/fs_bind/bind/fs_bind12.sh |  52 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind13.sh |  38 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind14.sh |  34 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind15.sh |  43 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind16.sh |  35 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind17.sh |  48 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind18.sh |  48 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind19.sh |  52 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind20.sh |  48 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind21.sh |  57 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind22.sh |  40 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind23.sh |  40 ++
 testcases/kernel/fs/fs_bind/bind/fs_bind24.sh |  35 ++
 testcases/kernel/fs/fs_bind/bind/test01       |  99 ----
 testcases/kernel/fs/fs_bind/bind/test02       | 102 ----
 testcases/kernel/fs/fs_bind/bind/test03       | 118 ----
 testcases/kernel/fs/fs_bind/bind/test04       | 104 ----
 testcases/kernel/fs/fs_bind/bind/test05       | 113 ----
 testcases/kernel/fs/fs_bind/bind/test06       | 102 ----
 testcases/kernel/fs/fs_bind/bind/test07       | 113 ----
 testcases/kernel/fs/fs_bind/bind/test07-2     |  69 ---
 testcases/kernel/fs/fs_bind/bind/test08       | 102 ----
 testcases/kernel/fs/fs_bind/bind/test09       | 113 ----
 testcases/kernel/fs/fs_bind/bind/test10       | 108 ----
 testcases/kernel/fs/fs_bind/bind/test11       | 116 ----
 testcases/kernel/fs/fs_bind/bind/test12       | 108 ----
 testcases/kernel/fs/fs_bind/bind/test13       |  90 ---
 testcases/kernel/fs/fs_bind/bind/test14       |  86 ---
 testcases/kernel/fs/fs_bind/bind/test15       |  96 ----
 testcases/kernel/fs/fs_bind/bind/test16       |  87 ---
 testcases/kernel/fs/fs_bind/bind/test17       | 100 ----
 testcases/kernel/fs/fs_bind/bind/test18       |  98 ----
 testcases/kernel/fs/fs_bind/bind/test19       | 109 ----
 testcases/kernel/fs/fs_bind/bind/test20       |  98 ----
 testcases/kernel/fs/fs_bind/bind/test21       | 114 ----
 testcases/kernel/fs/fs_bind/bind/test22       |  95 ----
 testcases/kernel/fs/fs_bind/bind/test23       |  89 ---
 testcases/kernel/fs/fs_bind/bind/test24       |  87 ---
 .../fs/fs_bind/cloneNS/00_Descriptions.txt    |  70 ---
 testcases/kernel/fs/fs_bind/cloneNS/Makefile  |  11 +
 testcases/kernel/fs/fs_bind/cloneNS/child01   |  34 --
 testcases/kernel/fs/fs_bind/cloneNS/child02   |  42 --
 testcases/kernel/fs/fs_bind/cloneNS/child03   |  32 --
 testcases/kernel/fs/fs_bind/cloneNS/child04   |  33 --
 testcases/kernel/fs/fs_bind/cloneNS/child05   |  41 --
 testcases/kernel/fs/fs_bind/cloneNS/child06   |  49 --
 testcases/kernel/fs/fs_bind/cloneNS/child07   |  42 --
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh   |  38 ++
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh   |  53 ++
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh   |  27 +
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh   |  31 ++
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh   |  55 ++
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh   |  77 +++
 .../fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh   |  55 ++
 testcases/kernel/fs/fs_bind/cloneNS/parent01  |  44 --
 testcases/kernel/fs/fs_bind/cloneNS/parent02  |  45 --
 testcases/kernel/fs/fs_bind/cloneNS/parent03  |  34 --
 testcases/kernel/fs/fs_bind/cloneNS/parent04  |  37 --
 testcases/kernel/fs/fs_bind/cloneNS/parent05  |  45 --
 testcases/kernel/fs/fs_bind/cloneNS/parent06  |  51 --
 testcases/kernel/fs/fs_bind/cloneNS/parent07  |  48 --
 testcases/kernel/fs/fs_bind/cloneNS/test01    |  85 ---
 testcases/kernel/fs/fs_bind/cloneNS/test02    |  85 ---
 testcases/kernel/fs/fs_bind/cloneNS/test03    |  77 ---
 testcases/kernel/fs/fs_bind/cloneNS/test04    |  78 ---
 testcases/kernel/fs/fs_bind/cloneNS/test05    |  90 ---
 testcases/kernel/fs/fs_bind/cloneNS/test06    |  96 ----
 testcases/kernel/fs/fs_bind/cloneNS/test07    |  91 ---
 testcases/kernel/fs/fs_bind/fs_bind_lib.sh    | 246 ++++++++
 .../kernel/fs/fs_bind/fs_bind_regression.sh   |  56 ++
 .../fs/fs_bind/move/00_Descriptions.txt       | 158 ------
 testcases/kernel/fs/fs_bind/move/Makefile     |  11 +
 .../kernel/fs/fs_bind/move/fs_bind_move01.sh  |  44 ++
 .../kernel/fs/fs_bind/move/fs_bind_move02.sh  |  45 ++
 .../kernel/fs/fs_bind/move/fs_bind_move03.sh  |  47 ++
 .../kernel/fs/fs_bind/move/fs_bind_move04.sh  |  41 ++
 .../kernel/fs/fs_bind/move/fs_bind_move05.sh  |  44 ++
 .../kernel/fs/fs_bind/move/fs_bind_move06.sh  |  40 ++
 .../kernel/fs/fs_bind/move/fs_bind_move07.sh  |  41 ++
 .../kernel/fs/fs_bind/move/fs_bind_move08.sh  |  35 ++
 .../kernel/fs/fs_bind/move/fs_bind_move09.sh  |  50 ++
 .../kernel/fs/fs_bind/move/fs_bind_move10.sh  |  46 ++
 .../kernel/fs/fs_bind/move/fs_bind_move11.sh  |  47 ++
 .../kernel/fs/fs_bind/move/fs_bind_move12.sh  |  45 ++
 .../kernel/fs/fs_bind/move/fs_bind_move13.sh  |  30 +
 .../kernel/fs/fs_bind/move/fs_bind_move14.sh  |  32 ++
 .../kernel/fs/fs_bind/move/fs_bind_move15.sh  |  32 ++
 .../kernel/fs/fs_bind/move/fs_bind_move16.sh  |  29 +
 .../kernel/fs/fs_bind/move/fs_bind_move17.sh  |  27 +
 .../kernel/fs/fs_bind/move/fs_bind_move18.sh  |  47 ++
 .../kernel/fs/fs_bind/move/fs_bind_move19.sh  |  47 ++
 .../kernel/fs/fs_bind/move/fs_bind_move20.sh  |  31 ++
 .../kernel/fs/fs_bind/move/fs_bind_move21.sh  |  44 ++
 .../kernel/fs/fs_bind/move/fs_bind_move22.sh  |  37 ++
 testcases/kernel/fs/fs_bind/move/test01       |  93 ----
 testcases/kernel/fs/fs_bind/move/test02       |  94 ----
 testcases/kernel/fs/fs_bind/move/test03       |  97 ----
 testcases/kernel/fs/fs_bind/move/test04       |  89 ---
 testcases/kernel/fs/fs_bind/move/test05       |  94 ----
 testcases/kernel/fs/fs_bind/move/test06       |  88 ---
 testcases/kernel/fs/fs_bind/move/test07       |  91 ---
 testcases/kernel/fs/fs_bind/move/test08       |  85 ---
 testcases/kernel/fs/fs_bind/move/test09       |  99 ----
 testcases/kernel/fs/fs_bind/move/test10       | 100 ----
 testcases/kernel/fs/fs_bind/move/test11       |  98 ----
 testcases/kernel/fs/fs_bind/move/test12       |  98 ----
 testcases/kernel/fs/fs_bind/move/test13       |  80 ---
 testcases/kernel/fs/fs_bind/move/test14       |  82 ---
 testcases/kernel/fs/fs_bind/move/test15       |  82 ---
 testcases/kernel/fs/fs_bind/move/test16       |  80 ---
 testcases/kernel/fs/fs_bind/move/test17       |  77 ---
 testcases/kernel/fs/fs_bind/move/test18       | 101 ----
 testcases/kernel/fs/fs_bind/move/test19       |  95 ----
 testcases/kernel/fs/fs_bind/move/test20       |  79 ---
 testcases/kernel/fs/fs_bind/move/test21       |  93 ----
 testcases/kernel/fs/fs_bind/move/test22       |  87 ---
 .../fs/fs_bind/rbind/00_Descriptions.txt      | 266 ---------
 testcases/kernel/fs/fs_bind/rbind/Makefile    |  11 +
 .../fs/fs_bind/rbind/fs_bind_rbind01.sh       |  50 ++
 .../fs/fs_bind/rbind/fs_bind_rbind02.sh       |  50 ++
 .../fs/fs_bind/rbind/fs_bind_rbind03.sh       |  61 ++
 .../fs/fs_bind/rbind/fs_bind_rbind04.sh       |  52 ++
 .../fs/fs_bind/rbind/fs_bind_rbind05.sh       |  62 +++
 .../fs/fs_bind/rbind/fs_bind_rbind06.sh       |  52 ++
 .../fs/fs_bind/rbind/fs_bind_rbind07-2.sh     |  37 ++
 .../fs/fs_bind/rbind/fs_bind_rbind07.sh       |  62 +++
 .../fs/fs_bind/rbind/fs_bind_rbind08.sh       |  52 ++
 .../fs/fs_bind/rbind/fs_bind_rbind09.sh       |  63 +++
 .../fs/fs_bind/rbind/fs_bind_rbind10.sh       |  58 ++
 .../fs/fs_bind/rbind/fs_bind_rbind11.sh       |  68 +++
 .../fs/fs_bind/rbind/fs_bind_rbind12.sh       |  58 ++
 .../fs/fs_bind/rbind/fs_bind_rbind13.sh       |  39 ++
 .../fs/fs_bind/rbind/fs_bind_rbind14.sh       |  35 ++
 .../fs/fs_bind/rbind/fs_bind_rbind15.sh       |  45 ++
 .../fs/fs_bind/rbind/fs_bind_rbind16.sh       |  36 ++
 .../fs/fs_bind/rbind/fs_bind_rbind17.sh       |  50 ++
 .../fs/fs_bind/rbind/fs_bind_rbind18.sh       |  50 ++
 .../fs/fs_bind/rbind/fs_bind_rbind19.sh       |  53 ++
 .../fs/fs_bind/rbind/fs_bind_rbind20.sh       |  50 ++
 .../fs/fs_bind/rbind/fs_bind_rbind21.sh       |  56 ++
 .../fs/fs_bind/rbind/fs_bind_rbind22.sh       |  49 ++
 .../fs/fs_bind/rbind/fs_bind_rbind23.sh       |  49 ++
 .../fs/fs_bind/rbind/fs_bind_rbind24.sh       |  49 ++
 .../fs/fs_bind/rbind/fs_bind_rbind25.sh       |  56 ++
 .../fs/fs_bind/rbind/fs_bind_rbind26.sh       |  51 ++
 .../fs/fs_bind/rbind/fs_bind_rbind27.sh       |  56 ++
 .../fs/fs_bind/rbind/fs_bind_rbind28.sh       |  51 ++
 .../fs/fs_bind/rbind/fs_bind_rbind29.sh       |  43 ++
 .../fs/fs_bind/rbind/fs_bind_rbind30.sh       |  38 ++
 .../fs/fs_bind/rbind/fs_bind_rbind31.sh       |  45 ++
 .../fs/fs_bind/rbind/fs_bind_rbind32.sh       |  38 ++
 .../fs/fs_bind/rbind/fs_bind_rbind33.sh       |  59 ++
 .../fs/fs_bind/rbind/fs_bind_rbind34.sh       |  43 ++
 .../fs/fs_bind/rbind/fs_bind_rbind35.sh       |  46 ++
 .../fs/fs_bind/rbind/fs_bind_rbind36.sh       |  41 ++
 .../fs/fs_bind/rbind/fs_bind_rbind37.sh       |  55 ++
 .../fs/fs_bind/rbind/fs_bind_rbind38.sh       |  54 ++
 .../fs/fs_bind/rbind/fs_bind_rbind39.sh       |  31 ++
 testcases/kernel/fs/fs_bind/rbind/test01      |  98 ----
 testcases/kernel/fs/fs_bind/rbind/test02      |  97 ----
 testcases/kernel/fs/fs_bind/rbind/test03      | 118 ----
 testcases/kernel/fs/fs_bind/rbind/test04      | 104 ----
 testcases/kernel/fs/fs_bind/rbind/test05      | 113 ----
 testcases/kernel/fs/fs_bind/rbind/test06      | 102 ----
 testcases/kernel/fs/fs_bind/rbind/test07      | 113 ----
 testcases/kernel/fs/fs_bind/rbind/test07-2    |  69 ---
 testcases/kernel/fs/fs_bind/rbind/test08      | 103 ----
 testcases/kernel/fs/fs_bind/rbind/test09      | 113 ----
 testcases/kernel/fs/fs_bind/rbind/test10      | 108 ----
 testcases/kernel/fs/fs_bind/rbind/test11      | 117 ----
 testcases/kernel/fs/fs_bind/rbind/test12      | 108 ----
 testcases/kernel/fs/fs_bind/rbind/test13      |  94 ----
 testcases/kernel/fs/fs_bind/rbind/test14      |  86 ---
 testcases/kernel/fs/fs_bind/rbind/test15      |  97 ----
 testcases/kernel/fs/fs_bind/rbind/test16      |  87 ---
 testcases/kernel/fs/fs_bind/rbind/test17      |  98 ----
 testcases/kernel/fs/fs_bind/rbind/test18      |  98 ----
 testcases/kernel/fs/fs_bind/rbind/test19      | 108 ----
 testcases/kernel/fs/fs_bind/rbind/test20      |  98 ----
 testcases/kernel/fs/fs_bind/rbind/test21      | 106 ----
 testcases/kernel/fs/fs_bind/rbind/test22      |  99 ----
 testcases/kernel/fs/fs_bind/rbind/test23      | 101 ----
 testcases/kernel/fs/fs_bind/rbind/test24      | 101 ----
 testcases/kernel/fs/fs_bind/rbind/test25      | 106 ----
 testcases/kernel/fs/fs_bind/rbind/test26      |  98 ----
 testcases/kernel/fs/fs_bind/rbind/test27      | 104 ----
 testcases/kernel/fs/fs_bind/rbind/test28      |  99 ----
 testcases/kernel/fs/fs_bind/rbind/test29      |  91 ---
 testcases/kernel/fs/fs_bind/rbind/test30      |  86 ---
 testcases/kernel/fs/fs_bind/rbind/test31      |  93 ----
 testcases/kernel/fs/fs_bind/rbind/test32      |  86 ---
 testcases/kernel/fs/fs_bind/rbind/test33      | 114 ----
 testcases/kernel/fs/fs_bind/rbind/test34      |  93 ----
 testcases/kernel/fs/fs_bind/rbind/test35      |  95 ----
 testcases/kernel/fs/fs_bind/rbind/test36      |  91 ---
 testcases/kernel/fs/fs_bind/rbind/test37      | 102 ----
 testcases/kernel/fs/fs_bind/rbind/test38      | 101 ----
 testcases/kernel/fs/fs_bind/rbind/test39      |  78 ---
 .../fs/fs_bind/regression/00_Descriptions.txt |  44 --
 testcases/kernel/fs/fs_bind/regression/test01 |  71 ---
 testcases/kernel/fs/fs_bind/regression/test02 |  78 ---
 testcases/kernel/fs/fs_bind/regression/test03 |  77 ---
 testscripts/test_fs_bind.sh                   | 526 ------------------
 232 files changed, 4859 insertions(+), 12007 deletions(-)
 delete mode 100644 testcases/kernel/fs/fs_bind/.gitignore
 delete mode 100644 testcases/kernel/fs/fs_bind/BUGS
 delete mode 100644 testcases/kernel/fs/fs_bind/CHANGELOG
 delete mode 100644 testcases/kernel/fs/fs_bind/README
 delete mode 100644 testcases/kernel/fs/fs_bind/TODO
 delete mode 100644 testcases/kernel/fs/fs_bind/bin/Makefile
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/check_prop
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/lockfile
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/makedir
 delete mode 100644 testcases/kernel/fs/fs_bind/bin/nsclone.c
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/setup
 delete mode 100755 testcases/kernel/fs/fs_bind/bin/setupnslock
 delete mode 100644 testcases/kernel/fs/fs_bind/bin/smount.c
 delete mode 100644 testcases/kernel/fs/fs_bind/bind/00_Descriptions.txt
 create mode 100644 testcases/kernel/fs/fs_bind/bind/Makefile
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind01.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind02.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind03.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind04.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind05.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind06.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind07.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind08.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind09.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind10.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind11.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind12.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind13.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind14.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind15.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind16.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind17.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind18.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind19.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind20.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind21.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind22.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind23.sh
 create mode 100755 testcases/kernel/fs/fs_bind/bind/fs_bind24.sh
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test01
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test02
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test03
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test04
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test05
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test06
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test07
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test07-2
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test08
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test09
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test10
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test11
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test12
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test13
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test14
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test15
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test16
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test17
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test18
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test19
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test20
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test21
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test22
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test23
 delete mode 100755 testcases/kernel/fs/fs_bind/bind/test24
 delete mode 100644 testcases/kernel/fs/fs_bind/cloneNS/00_Descriptions.txt
 create mode 100644 testcases/kernel/fs/fs_bind/cloneNS/Makefile
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child01
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child02
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child03
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child04
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child05
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child06
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/child07
 create mode 100755 testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
 create mode 100755 testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
 create mode 100755 testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
 create mode 100755 testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
 create mode 100755 testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
 create mode 100755 testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
 create mode 100755 testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent01
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent02
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent03
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent04
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent05
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent06
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/parent07
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/test01
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/test02
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/test03
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/test04
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/test05
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/test06
 delete mode 100755 testcases/kernel/fs/fs_bind/cloneNS/test07
 create mode 100644 testcases/kernel/fs/fs_bind/fs_bind_lib.sh
 create mode 100755 testcases/kernel/fs/fs_bind/fs_bind_regression.sh
 delete mode 100644 testcases/kernel/fs/fs_bind/move/00_Descriptions.txt
 create mode 100644 testcases/kernel/fs/fs_bind/move/Makefile
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh
 create mode 100755 testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test01
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test02
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test03
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test04
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test05
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test06
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test07
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test08
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test09
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test10
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test11
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test12
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test13
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test14
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test15
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test16
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test17
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test18
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test19
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test20
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test21
 delete mode 100755 testcases/kernel/fs/fs_bind/move/test22
 delete mode 100644 testcases/kernel/fs/fs_bind/rbind/00_Descriptions.txt
 create mode 100644 testcases/kernel/fs/fs_bind/rbind/Makefile
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh
 create mode 100755 testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test01
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test02
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test03
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test04
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test05
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test06
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test07
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test07-2
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test08
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test09
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test10
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test11
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test12
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test13
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test14
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test15
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test16
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test17
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test18
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test19
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test20
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test21
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test22
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test23
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test24
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test25
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test26
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test27
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test28
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test29
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test30
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test31
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test32
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test33
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test34
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test35
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test36
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test37
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test38
 delete mode 100755 testcases/kernel/fs/fs_bind/rbind/test39
 delete mode 100644 testcases/kernel/fs/fs_bind/regression/00_Descriptions.txt
 delete mode 100755 testcases/kernel/fs/fs_bind/regression/test01
 delete mode 100755 testcases/kernel/fs/fs_bind/regression/test02
 delete mode 100755 testcases/kernel/fs/fs_bind/regression/test03
 delete mode 100755 testscripts/test_fs_bind.sh

diff --git a/runtest/fs_bind b/runtest/fs_bind
index 549d700de..c3e005234 100644
--- a/runtest/fs_bind
+++ b/runtest/fs_bind
@@ -1,2 +1,106 @@
 #DESCRIPTION:Bind mounts and shared subtrees
-BindMounts	$LTPROOT/testscripts/test_fs_bind.sh
+#BindMounts	$LTPROOT/testscripts/test_fs_bind.sh
+
+fs_bind01_sh   fs_bind01.sh
+fs_bind02_sh   fs_bind02.sh
+fs_bind03_sh   fs_bind03.sh
+fs_bind04_sh   fs_bind04.sh
+fs_bind05_sh   fs_bind05.sh
+fs_bind06_sh   fs_bind06.sh
+fs_bind07_sh   fs_bind07.sh
+fs_bind07-2_sh   fs_bind07-2.sh
+fs_bind08_sh   fs_bind08.sh
+fs_bind09_sh   fs_bind09.sh
+fs_bind10_sh   fs_bind10.sh
+fs_bind11_sh   fs_bind11.sh
+fs_bind12_sh   fs_bind12.sh
+fs_bind13_sh   fs_bind13.sh
+fs_bind14_sh   fs_bind14.sh
+fs_bind15_sh   fs_bind15.sh
+fs_bind16_sh   fs_bind16.sh
+fs_bind17_sh   fs_bind17.sh
+fs_bind18_sh   fs_bind18.sh
+fs_bind19_sh   fs_bind19.sh
+fs_bind20_sh   fs_bind20.sh
+fs_bind21_sh   fs_bind21.sh
+fs_bind22_sh   fs_bind22.sh
+fs_bind23_sh   fs_bind23.sh
+fs_bind24_sh   fs_bind24.sh
+
+
+fs_bind_move01_sh fs_bind_move01.sh
+fs_bind_move02_sh fs_bind_move02.sh
+fs_bind_move03_sh fs_bind_move03.sh
+fs_bind_move04_sh fs_bind_move04.sh
+fs_bind_move05_sh fs_bind_move05.sh
+fs_bind_move06_sh fs_bind_move06.sh
+fs_bind_move07_sh fs_bind_move07.sh
+fs_bind_move08_sh fs_bind_move08.sh
+fs_bind_move09_sh fs_bind_move09.sh
+fs_bind_move10_sh fs_bind_move10.sh
+fs_bind_move11_sh fs_bind_move11.sh
+fs_bind_move12_sh fs_bind_move12.sh
+fs_bind_move13_sh fs_bind_move13.sh
+fs_bind_move14_sh fs_bind_move14.sh
+fs_bind_move15_sh fs_bind_move15.sh
+fs_bind_move16_sh fs_bind_move16.sh
+fs_bind_move17_sh fs_bind_move17.sh
+fs_bind_move18_sh fs_bind_move18.sh
+fs_bind_move19_sh fs_bind_move19.sh
+fs_bind_move20_sh fs_bind_move20.sh
+fs_bind_move21_sh fs_bind_move21.sh
+fs_bind_move22_sh fs_bind_move22.sh
+
+
+fs_bind_rbind01_sh fs_bind_rbind01.sh
+fs_bind_rbind02_sh fs_bind_rbind02.sh
+fs_bind_rbind03_sh fs_bind_rbind03.sh
+fs_bind_rbind04_sh fs_bind_rbind04.sh
+fs_bind_rbind05_sh fs_bind_rbind05.sh
+fs_bind_rbind06_sh fs_bind_rbind06.sh
+fs_bind_rbind07-2_sh fs_bind_rbind07-2.sh
+fs_bind_rbind07_sh fs_bind_rbind07.sh
+fs_bind_rbind08_sh fs_bind_rbind08.sh
+fs_bind_rbind09_sh fs_bind_rbind09.sh
+fs_bind_rbind10_sh fs_bind_rbind10.sh
+fs_bind_rbind11_sh fs_bind_rbind11.sh
+fs_bind_rbind12_sh fs_bind_rbind12.sh
+fs_bind_rbind13_sh fs_bind_rbind13.sh
+fs_bind_rbind14_sh fs_bind_rbind14.sh
+fs_bind_rbind15_sh fs_bind_rbind15.sh
+fs_bind_rbind16_sh fs_bind_rbind16.sh
+fs_bind_rbind17_sh fs_bind_rbind17.sh
+fs_bind_rbind18_sh fs_bind_rbind18.sh
+fs_bind_rbind19_sh fs_bind_rbind19.sh
+fs_bind_rbind20_sh fs_bind_rbind20.sh
+fs_bind_rbind21_sh fs_bind_rbind21.sh
+fs_bind_rbind22_sh fs_bind_rbind22.sh
+fs_bind_rbind23_sh fs_bind_rbind23.sh
+fs_bind_rbind24_sh fs_bind_rbind24.sh
+fs_bind_rbind25_sh fs_bind_rbind25.sh
+fs_bind_rbind26_sh fs_bind_rbind26.sh
+fs_bind_rbind27_sh fs_bind_rbind27.sh
+fs_bind_rbind28_sh fs_bind_rbind28.sh
+fs_bind_rbind29_sh fs_bind_rbind29.sh
+fs_bind_rbind30_sh fs_bind_rbind30.sh
+fs_bind_rbind31_sh fs_bind_rbind31.sh
+fs_bind_rbind32_sh fs_bind_rbind32.sh
+fs_bind_rbind33_sh fs_bind_rbind33.sh
+fs_bind_rbind34_sh fs_bind_rbind34.sh
+fs_bind_rbind35_sh fs_bind_rbind35.sh
+fs_bind_rbind36_sh fs_bind_rbind36.sh
+fs_bind_rbind37_sh fs_bind_rbind37.sh
+fs_bind_rbind38_sh fs_bind_rbind38.sh
+fs_bind_rbind39_sh fs_bind_rbind39.sh
+
+
+fs_bind_regression_sh fs_bind_regression.sh
+
+
+fs_bind_cloneNS01_sh fs_bind_cloneNS01.sh
+fs_bind_cloneNS02_sh fs_bind_cloneNS02.sh
+fs_bind_cloneNS03_sh fs_bind_cloneNS03.sh
+fs_bind_cloneNS04_sh fs_bind_cloneNS04.sh
+fs_bind_cloneNS05_sh fs_bind_cloneNS05.sh
+fs_bind_cloneNS06_sh fs_bind_cloneNS06.sh
+fs_bind_cloneNS07_sh fs_bind_cloneNS07.sh
diff --git a/testcases/kernel/fs/fs_bind/.gitignore b/testcases/kernel/fs/fs_bind/.gitignore
deleted file mode 100644
index c4344da91..000000000
--- a/testcases/kernel/fs/fs_bind/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-/bin/nsclone
-/bin/smount
diff --git a/testcases/kernel/fs/fs_bind/BUGS b/testcases/kernel/fs/fs_bind/BUGS
deleted file mode 100644
index 51c1e30d9..000000000
--- a/testcases/kernel/fs/fs_bind/BUGS
+++ /dev/null
@@ -1,5 +0,0 @@
-Clone Namespace Tests:
-	Currently the cloneNS test do not accurately report a final success or
-	failure value. To check if a test has passed, view the test output and
-	look at each individual check_prop test, and see if there are any
-	failures.
diff --git a/testcases/kernel/fs/fs_bind/CHANGELOG b/testcases/kernel/fs/fs_bind/CHANGELOG
deleted file mode 100644
index d41598821..000000000
--- a/testcases/kernel/fs/fs_bind/CHANGELOG
+++ /dev/null
@@ -1,84 +0,0 @@
-Remove this file prior to submission??
-------------------------------------
-
-Changes by Matt Helsley <matthltc@us.ibm.com>, March 12th, 2008:
-
-Many (but not all) of these changes are scripted so that I can modify the tests
-quickly by editting the ltp-convert.sh script. It saves a copy of the test foo
-as foo.orig before making any modifications. Currently there's a patch.txt file
-which shows all the changes the script makes.
-
-Moved readme.README to README
-
-Made tests run in the sandbox directory rather than in testcases/working
-
-Moved scripts and executables from testcases/working to bin
-
-Based all non-local paths out of the "$FS_BIND_ROOT" directory rather than
-having a "$path" variable.
-
-Logged mount lists before and after each test, took a diff, and removed the list
-	if they look the same. Otherwise it keeps the two files, reports the
-	diff, cleans up the mounts with a big hammer, and goes onto the next
-	test.
-
-Logged the sandbox contents before and after, took a diff, and removed the
-	logged contents if they look the same. Otherwise it keeps the
-	lists of files and dirs, reports the problem, and cleans up the
-	sandbox. This happens after the mount cleanups otherwise it could fail.
-
-Factored out the "check" function from most tests (still need to work on "childXX" and "parentXX" scripts) and put it into the setup script.
-
-Factored out the "path" variable and pushd bits into the sharedSubtree script.
-
-Added some traps to the test scripts to detect unexpected errors and log them
-
-Switched to LTP infrastructure for the test scripts. The driver scripts however
-are not switched yet (easy to do). I did this by writing some LTP API shims
-rather than try to toss it into ltp-full-XXXXXX.tgz. Then, once everything
-uses LTP we can integrate it.
-
-Made mkdir logdir quiet (restore it??)
-
-Count total tests in a separate loop so we can detect accidentally skipped tests
-
-"test" is a program -- changed variables named "test" to "t" to avoid potential
-	confusion later
-
-Added quotes around paths, variables, and output that may someday contain
-spaces (hopefully never, but..)
-
-Added logdir/errors redirection of stderr
-
-Removed testcases/<Up> script
-
-Removed .c files in testcases/cloneNS which appeared to be unused
-
-Added Makefiles for .c files and for toplevel dir (for LTP integration)
-
-Converted "mmount" to "smount" to match the .c file.
-
-Fixed up nsclone.c and smount.c to compile and do so without warnings.
-	(at least on gcc 4.2.3-1 debian)
-
-Fixed some bugs in the testcases:
-	A couple copy-paste bugs
-	Bugs with uncloneable mounts being bound but the error wasn't expected.
-	A few path bugs.
-
-Added bits to handle commands that are expected to fail (return non-zero)
-	Fixup the return code so that these are trapped properly
-		expected_to_fail && /bin/false || /bin/true
-	Redirected output
-		mount_expected_to_fail 2> /dev/null || result=$?
-
-Added umounts and comments describing cleanup bits which cleanup in case of
-	unexpected mount --move failure for example
-
-Added a BUGS file
-
-Added a CHANGELOG
-
-Added TODO file(s)
-
-Moved the sharedSubtree test to LTPROOT/testscripts and rewrote it for LTP
diff --git a/testcases/kernel/fs/fs_bind/Makefile b/testcases/kernel/fs/fs_bind/Makefile
index 26d640831..770a5e6a2 100644
--- a/testcases/kernel/fs/fs_bind/Makefile
+++ b/testcases/kernel/fs/fs_bind/Makefile
@@ -1,33 +1,11 @@
-#
-#    kernel/fs/fs_bind testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
 # Ngie Cooper, July 2009
-#
 
 top_srcdir			?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_DIR			:= $(prefix)/testcases/bin/fs_bind
-
-INSTALL_TARGETS			:= */test*
-
-RECURSIVE_TARGETS		:= all install uninstall
+INSTALL_TARGETS			:= fs_bind_lib.sh fs_bind_regression.sh
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/fs/fs_bind/README b/testcases/kernel/fs/fs_bind/README
deleted file mode 100644
index 74b2ee1e7..000000000
--- a/testcases/kernel/fs/fs_bind/README
+++ /dev/null
@@ -1,165 +0,0 @@
-=================================================================
-Test Suite for Bind Mount and Shared Subtree Features in the VFS:
-=================================================================
-Author: Avantika Mathur
-Date: September 16, 2005
-Last update: March 18th, 2008 (by Matt Helsley)
-
-About:
-------
-These tests exercise the Linux Kernel's bind mount and shared subtree
-capabilities. With it administrators may use clear semantics to manage
-complex mount trees on a system.
-
-Bind mount simply allows administrators to make a directory appear in
-two places at once -- somewhat like hard links for files:
-
-# mkdir mnt mnt2
-# mount --bind mnt mnt2
-# touch mnt/a
-# ls mnt2
-a
-
-Note that bind mounts are not recursive. To get a recursive bind mount
-use --rbind.
-
-Another limitation of simple bind mounts is they cannot propagate future binds:
-
-# mkdir mnt mnt2
-# mount --bind mnt mnt2
-# touch mnt/a
-# mkdir mnt/foo
-# ls mnt2
-a foo
-# mkdir sub
-# touch sub/b
-# mount --bind sub /mnt/foo
-# ls mnt/foo
-b
-# ls mnt2/foo
-
-mnt2/foo appears to be empty because the second bind mount did not propagate
-to mnt2. Shared subtrees allow propagation whereas bind mounts do not.
-To enable full administrator control of propagation there are several kinds of
-subtrees:
-	private		[default -- this is a "normal" mount]
-	shared		[propagation goes both ways]
-	slave		[propagation goes one way]
-	unbindable	[cannot --bind and hence cannot share]
-
-For further details on these types of subtrees please see your kernel source's
-Documentation/filesystems/sharedsubtree.txt file.
-
-Building:
----------
-Uses GNU Make. In the root directory type:
-make
-
-Installing:
------------
-Type:
-make install
-
-Cleaning:
----------
-Type:
-make clean
-
-Running:
---------
-run LTPROOT/testscripts/test_fs_bind.sh
-
-
-Testcases:
-----------
-There are multiple testcases testing in each of the following categories,
-testing functionality of different types of mounts, different combinations,
-etc:
--- bind
--- rbind
--- move
--- regression tests
--- clone namespace (currently not run)
-
-
-Directory Structure:
---------------------
-In the root directory of the suite there are scripts to execute the whole test suite. Logged results are stored in LTPROOT/results/fs_bind. PASS/FAIL
-indications are passed to the LTP API and logged in the results directory too.
-
-Basic tests of bind and move mounts are part of the test_fs_bind.sh test
-script itself. These are prerequisites for the more the complicated tests.
-The bind, rbind, and move directories contain tests for bind, rbind, move in
-combination with the various kinds of subtrees. The regression and cloneNS
-directories perform basic regression tests and combine some of the tests with
-mount namespaces respectively.
-
-The bin directory contains scripts used by each of the testcases for
-common setup, creating, and comparing mounts.
-
-Running the Test Suite:
------------------------
-To run the entire testsuite run:
-test_fs_bind.sh
-
-Log directories where the results are stored in LTPROOT/results/fs_bind
-
-Reading the Test Suite Results:
--------------------------------
-Test suite results are logged, by default, in the LTPROOT/results/fs_bind
-directory. Its structure is:
-fs_bind-\
-	|-> errors		 (stderr of main test suite script itself)
-	|-> summary		 (stdout of main test suite script itself)
-	|-move--\
-	|	|->test01-\	(logs of test01)
-	|	|	  |-> log		(stdout)
-	|	|	  |-> err		(stderr)
-	|	|	  |-> mtab.before
-	|	|	  |-> mtab.after
-	|	|	  |-> proc_mounts.before
-	|	|	  |-> proc_mounts.after
-	|	|	  |-> files.before	(files  before running)
-	|	|	  |-> dirs.before	(dirs   before running)
-	|	|	  |-> files.after	(files  after  running)
-	|	|	  \-> dirs.after	(dirs   after  running)
-	|	|->test02-\
-	|	|	  |
-	|	...	  ...
-	|-rbind--\
-	|        |-->
-	...       ...
-
-An testXX/err file will only be left for those tests that had errors and
-stderr was non-empty. mounts.*, files.*, and dirs.* files will be left for
-tests that appear to have broken cleanup sections. The test_fs_bind.sh
-script robustly handles cleanup so, unless the tests are run individually, this
-is not an issue that prevents testing from completing successfully nor does it
-interfere with test results.
-
-These files make it easy to determine what happened during a given test.
-It's easy to see which tests need to be debugged and which do not. It also
-makes it easy to aggregate output or trace sandbox dirtying from test to test.
-
-Running individual Tests:
--------------------------
-Currently tests cannot be run individually because there are several important
-LTP environment dependencies. Some of them are documented below:
-	LTP test script environment variables:
-		LTPROOT
-		TCID
-		TST_TOTAL
-		TST_COUNT
-	LTP commands/functions:
-		tst_resm
-		tst_brkm
-		tst_exit
-	LTP contents:
-		LTPROOT/testcases/bin
-
-It's important to note that the individual test scripts use the current working
-directory extensively but never exit it. This may allow the tests to be run
-individually once the above LTP environment dependencies are resolved.
-Lastly none of the logging or debugging information will appear in the
-LTPROOT/results/fs_bind directory when tests are invoked individually since
-those are collected by the test_fs_bind.sh script.
diff --git a/testcases/kernel/fs/fs_bind/TODO b/testcases/kernel/fs/fs_bind/TODO
deleted file mode 100644
index 1730148ef..000000000
--- a/testcases/kernel/fs/fs_bind/TODO
+++ /dev/null
@@ -1,11 +0,0 @@
-Consider replacing long invocations
-	(replace "$FS_BIND_ROOT/bin/makedir") with something shorter).
-
-Factor out common bits of setup, setupnslock, and lockfile
-
-Rename smount to something more meaningful? (bind_mount ?)
-
-Check for leaks of vfsmount structs by diffing vfs slab cache obj numbers
-	(after -before)
-
-The cloneNS testcases need to be checked and tested -- consider them expiremental. (at least as of March 2008)
diff --git a/testcases/kernel/fs/fs_bind/bin/Makefile b/testcases/kernel/fs/fs_bind/bin/Makefile
deleted file mode 100644
index 2c09a286d..000000000
--- a/testcases/kernel/fs/fs_bind/bin/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    testcases/kernel/fs/fs_bind/bin Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, September 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-
-INSTALL_DIR		:= $(prefix)/testcases/bin/fs_bind/bin
-
-INSTALL_TARGETS		:= check_prop lockfile makedir setup setupnslock
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs_bind/bin/check_prop b/testcases/kernel/fs/fs_bind/bin/check_prop
deleted file mode 100755
index 07da8ea28..000000000
--- a/testcases/kernel/fs/fs_bind/bin/check_prop
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-reverse=0
-while getopts "n" args $OPTIONS
-do
-	case "$args" in
-        n)      reverse=1
-		shift
-                ;;
- 	esac
-done
-
-if [ $reverse -eq 1 ]
-then
-	echo Check No Propagation $*
-else
-	echo Check Propagation $*
-fi
-
-dir1="$1"
-shift
-
-for dir2 in "$@"
-do
-	# compare adjacent pairs of directory trees
-
-	echo "Checking \"$dir1\" \"$dir2\""
-	diff -r "$dir1" "$dir2" 2> /dev/null
-
-	if [ $? -ne 0 ]
-	then
-		if [ $reverse -eq 1 ]
-		then
-			echo Successful
-			echo "---------"
-			exit 0
-		else
-			echo "FAILED"
-			echo "---------"
-                	exit 1
-		fi
-        fi
-        dir1="$dir2"
-done
-
-if [ $reverse -eq 1 ]
-then
-	echo FAILED
-	echo "---------"
-	exit -1
-else
-	echo Successful
-	echo "---------"
-	exit 0
-fi
diff --git a/testcases/kernel/fs/fs_bind/bin/lockfile b/testcases/kernel/fs/fs_bind/bin/lockfile
deleted file mode 100755
index 93d4d81a9..000000000
--- a/testcases/kernel/fs/fs_bind/bin/lockfile
+++ /dev/null
@@ -1,84 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Ram Pai (linuxram@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-lockfile="/.nslock"
-SUCCESS=0
-FAIL=1
-otherpid=
-startparent()
-{
-	rm -f $lockfile
-	echo $$ >| ${lockfile}parent
-	while [ 1 ]
-	do
-		otherpid="$(cat ${lockfile}child 2> /dev/null)"
-		if [ -n "$otherpid" -a -d /proc/$otherpid ]
-		then
-			return
-		fi
-	done
-}
-
-startchild()
-{
-	rm -f $lockfile
-	echo $$ >| ${lockfile}child
-	while [ 1 ]
-	do
-		otherpid="$(cat ${lockfile}parent 2> /dev/null)"
-		if [ -n "$otherpid" -a -d /proc/$otherpid ]
-		then
-			return
-		fi
-	done
-}
-
-iamgoingahead()
-{
-	while [ 1 ]
-	do
-		if [ ! -d /proc/$otherpid ]
-		then
-			return $FAIL
-		fi
-		str=`cat $lockfile 2> /dev/null`
-		pid=$(echo $str | awk '{print $1}')
-		error=$(echo $str | awk '{print $2}')
-		if [ "$pid" == "$$" ]
-		then
-			return $error
-		fi
-		sleep 1
-	done
-}
-
-
-goahead()
-{
-	set -x
-	ret=$SUCCESS
-	if [ -n "$1" ]
-	then
-		ret=$1
-	fi
-	echo "$otherpid $ret" >| $lockfile
-	set +x
-}
diff --git a/testcases/kernel/fs/fs_bind/bin/makedir b/testcases/kernel/fs/fs_bind/bin/makedir
deleted file mode 100755
index 7c0766a1b..000000000
--- a/testcases/kernel/fs/fs_bind/bin/makedir
+++ /dev/null
@@ -1,101 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-mflags=""
-#mflags="-n" # Don't futz with mtab
-
-flag=y
-while getopts "n" arg "$@"
-do
-        case "$arg" in
-        n)      flag=n
-                shift
-                ;;
-        esac
-done
-
-bind_type="$1"
-dir="$2"
-
-
-if [ ! -d "$dir" ]
-then
-	if [ -e "$dir" ]; then
-		echo "ERROR: a file by the name \"$dir\" exists"
-		exit 1
-	fi
-	mkdir -p "$dir"
-	echo "mkdir -p \"$dir\""
-fi
-
-
-if [ "$flag" = "y" ] && [ "$bind_type" != slave ]
-then
-	mount $mflags --bind "$dir" "$dir" || exit $?
-	echo "mount $mflags --bind \"$dir\" \"$dir\""
-fi
-
-# Try to use native mount, else fallback to included smount binary
-case "$bind_type" in
-   share)
-   	echo "mount $mflags --make-rshared \"$dir\""
-	mount $mflags --make-rshared "$dir" 2> /dev/null || \
-	smount "$dir" rshared || exit $?
-      	;;
-   priv)
-   	echo "mount $mflags --make-rprivate \"$dir\""
-	mount $mflags --make-rprivate "$dir" 2> /dev/null || \
-	smount "$dir" rprivate || exit $?
-      	;;
-   slave)
-   	echo "mount $mflags --make-rslave \"$dir\""
-	mount $mflags --make-rslave "$dir" 2> /dev/null || \
-	smount "$dir" rslave || exit $?
-      	;;
-   unclone)
-   	echo "mount $mflags --make-runbindable \"$dir\""
-	mount $mflags --make-runbindable "$dir" 2> /dev/null || \
-	smount "$dir" runclone || exit $?
-      	;;
-   nshare)
-   	echo "mount $mflags --make-shared \"$dir\""
-	mount $mflags --make-shared "$dir" 2> /dev/null || \
-	smount "$dir" shared || exit $?
-      	;;
-   npriv)
-   	echo "mount $mflags --make-private \"$dir\""
-	mount $mflags --make-private "$dir" 2> /dev/null || \
-	smount "$dir" private || exit $?
-      	;;
-   nslave)
-   	echo "mount $mflags --make-slave \"$dir\""
-	mount $mflags --make-slave "$dir" 2> /dev/null || \
-	smount "$dir" slave || exit $?
-      	;;
-   nunclone)
-   	echo "mount $mflags --make-unbindable \"$dir\""
-	mount $mflags --make-unbindable "$dir" 2> /dev/null || \
-	smount "$dir" unclone || exit $?
-      	;;
-   *)
-   	echo "$0: unrecognized bind type (1st arg): $bind_type" 1>&2
-	exit 1
-	;;
-esac
diff --git a/testcases/kernel/fs/fs_bind/bin/nsclone.c b/testcases/kernel/fs/fs_bind/bin/nsclone.c
deleted file mode 100644
index 36ae874db..000000000
--- a/testcases/kernel/fs/fs_bind/bin/nsclone.c
+++ /dev/null
@@ -1,68 +0,0 @@
-/*
- * Copyright (c) International Business Machines  Corp., 2005
- * Author: Ram Pai (linuxram@us.ibm.com)
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#define _GNU_SOURCE
-
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <sched.h>
-#include <signal.h>
-#include <unistd.h>
-#include "test.h"
-#include <sys/types.h>
-#include <sys/wait.h>
-
-int myfunc(void *arg)
-{
-	return system(arg);
-}
-
-static void usage(char *cmd)
-{
-	printf("%s  child_script parent_script\n", cmd);
-}
-
-int main(int argc, char *argv[])
-{
-	char *child_cmd;
-	char *parent_cmd;
-	int ret = 0, childret = 0;
-
-	if (argc < 3) {
-		usage(argv[0]);
-		exit(1);
-	}
-
-	child_cmd = (char *)strdup(argv[2]);
-	parent_cmd = (char *)strdup(argv[1]);
-
-	printf("1\n");
-	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, myfunc, (void *)child_cmd);
-	if (ret != -1) {
-		system(parent_cmd);
-		wait(&childret);
-	} else {
-		fprintf(stderr, "clone failed\n");
-	}
-	if (ret || !WIFEXITED(childret)) {
-		exit(1);
-	}
-	exit(0);
-}
diff --git a/testcases/kernel/fs/fs_bind/bin/setup b/testcases/kernel/fs/fs_bind/bin/setup
deleted file mode 100755
index 4e30ef42b..000000000
--- a/testcases/kernel/fs/fs_bind/bin/setup
+++ /dev/null
@@ -1,104 +0,0 @@
-#!/bin/bash -v
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-disk1=disk1
-disk2=disk2
-disk3=disk3
-disk4=disk4
-fs=ext3
-
-mkdir -p $disk1 $disk2 $disk3 $disk4
-
-
-
-rm -rf $disk1/* $disk2/* $disk3/* $disk4/*
-
-mkdir $disk1/a $disk1/b $disk1/c
-mkdir $disk2/d $disk2/e $disk2/f
-mkdir $disk3/g $disk3/h $disk3/i
-mkdir $disk4/j $disk4/k $disk4/l
-
-lockfile="/.nslock"
-otherpid=
-startparent()
-{
-        rm -f $lockfile
-        echo $$ >| ${lockfile}parent
-        while [ 1 ]
-        do
-                otherpid="$(cat ${lockfile}child 2> /dev/null)"
-                if [ -n "$otherpid" -a -d /proc/$otherpid ]
-                then
-                        return
-                fi
-        done
-}
-
-
-startchild()
-{
-        rm -f $lockfile
-        echo $$ >| ${lockfile}child
-        while [ 1 ]
-        do
-                otherpid="$(cat ${lockfile}parent 2> /dev/null)"
-                if [ -n "$otherpid" -a -d /proc/$otherpid ]
-                then
-                        return
-                fi
-        done
-}
-
-iamgoingahead()
-{
-        while [ 1 ]
-        do
-                pid=`cat $lockfile 2> /dev/null`
-                if [ "$pid" == "$$" ]
-                then
-                        return
-                fi
-                sleep 1
-        done
-}
-
-
-goahead()
-{
-        set -x
-        echo $otherpid > $lockfile
-        set +x
-}
-
-
-check(){
-	"${FS_BIND_ROOT}/bin/check_prop" $*
-	ret=$?
-	if [ $ret -ne 0 ]; then
-		result=$ret
-	fi
-}
-export result=0
-
-cleanup(){
-	rm -rf "disk"*
-}
diff --git a/testcases/kernel/fs/fs_bind/bin/setupnslock b/testcases/kernel/fs/fs_bind/bin/setupnslock
deleted file mode 100755
index e35927b69..000000000
--- a/testcases/kernel/fs/fs_bind/bin/setupnslock
+++ /dev/null
@@ -1,64 +0,0 @@
-#!/bin/bash
-
-lockfile="/.nslock"
-SUCCESS=0
-FAIL=1
-otherpid=
-startparent()
-{
-        rm -f $lockfile
-        echo $$ >| ${lockfile}parent
-        while [ 1 ]
-        do
-                otherpid="$(cat ${lockfile}child 2> /dev/null)"
-                if [ -n "$otherpid" -a -d /proc/$otherpid ]
-                then
-                        return
-                fi
-        done
-}
-
-startchild()
-{
-        rm -f $lockfile
-        echo $$ >| ${lockfile}child
-        while [ 1 ]
-        do
-                otherpid="$(cat ${lockfile}parent 2> /dev/null)"
-                if [ -n "$otherpid" -a -d /proc/$otherpid ]
-                then
-                        return
-                fi
-        done
-}
-
-iamgoingahead()
-{
-        while [ 1 ]
-        do
-                if [ ! -d /proc/$otherpid ]
-                then
-                        return $FAIL
-                fi
-                str=`cat $lockfile 2> /dev/null`
-                pid=$(echo $str | awk '{print $1}')
-                error=$(echo $str | awk '{print $2}')
-                if [ "$pid" == "$$" ]
-                then
-                        return $error
-                fi
-                sleep 1
-        done
-}
-
-goahead()
-{
-        set -x
-        ret=$SUCCESS
-        if [ -n "$1" ]
-        then
-                ret=$1
-        fi
-        echo "$otherpid $ret" >| $lockfile
-        set +x
-}
diff --git a/testcases/kernel/fs/fs_bind/bin/smount.c b/testcases/kernel/fs/fs_bind/bin/smount.c
deleted file mode 100644
index 9484687ee..000000000
--- a/testcases/kernel/fs/fs_bind/bin/smount.c
+++ /dev/null
@@ -1,73 +0,0 @@
-//
-//this code was developed my Miklos Szeredi <miklos@szeredi.hu>
-//and modified by Ram Pai <linuxram@us.ibm.com>
-// sample usage:
-//              newmount /tmp shared
-//
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-
-#include <unistd.h>
-#include <sys/mount.h>
-#include <sys/fsuid.h>
-
-#ifndef MS_REC
-#define MS_REC		0x4000	/* 16384: Recursive loopback */
-#endif
-
-#ifndef MS_SHARED
-#define MS_SHARED		1<<20	/* Shared */
-#endif
-
-#ifndef MS_PRIVATE
-#define MS_PRIVATE		1<<18	/* Private */
-#endif
-
-#ifndef MS_SLAVE
-#define MS_SLAVE		1<<19	/* Slave */
-#endif
-
-#ifndef MS_UNCLONE
-#define MS_UNCLONE		1<<17	/* UNCLONE */
-#endif
-
-int main(int argc, char *argv[])
-{
-	int type;
-	if (argc != 3) {
-		fprintf(stderr, "usage: %s DIR "
-			"[rshared|rslave|rprivate|runclone|shared|slave|private|unclone]\n",
-			argv[0]);
-		return 1;
-	}
-
-	fprintf(stdout, "%s %s %s\n", argv[0], argv[1], argv[2]);
-
-	if (strcmp(argv[2], "rshared") == 0)
-		type = (MS_SHARED | MS_REC);
-	else if (strcmp(argv[2], "rslave") == 0)
-		type = (MS_SLAVE | MS_REC);
-	else if (strcmp(argv[2], "rprivate") == 0)
-		type = (MS_PRIVATE | MS_REC);
-	else if (strcmp(argv[2], "runclone") == 0)
-		type = (MS_UNCLONE | MS_REC);
-	else if (strcmp(argv[2], "shared") == 0)
-		type = MS_SHARED;
-	else if (strcmp(argv[2], "slave") == 0)
-		type = MS_SLAVE;
-	else if (strcmp(argv[2], "private") == 0)
-		type = MS_PRIVATE;
-	else if (strcmp(argv[2], "unclone") == 0)
-		type = MS_UNCLONE;
-	else {
-		fprintf(stderr, "invalid operation: %s\n", argv[2]);
-		return 1;
-	}
-	setfsuid(getuid());
-	if (mount("", argv[1], "ext2", type, "") == -1) {
-		perror("mount");
-		return 1;
-	}
-	return 0;
-}
diff --git a/testcases/kernel/fs/fs_bind/bind/00_Descriptions.txt b/testcases/kernel/fs/fs_bind/bind/00_Descriptions.txt
deleted file mode 100644
index 1a3979f0d..000000000
--- a/testcases/kernel/fs/fs_bind/bind/00_Descriptions.txt
+++ /dev/null
@@ -1,176 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-OO_DESCRIPTION.txt
-==================
-
-The contents of the bind directory:
-test01 - shared child to shared parent.
-test02 - shared child to private parent.
-test03 - shared child to slave parent.
-test04 - shared child to unclonable parent.
-test05 - private child to shared parent.
-test06 - private child to private parent.
-test07 - private child to slave parent.
-test07-2 - create slave then mount master - slave still propagates.
-test08 - private child to uncloneable parent.
-test09 - slave child to shared parent.
-test10 - slave child to private parent.
-test11 - slave child to slave parent.
-test12 - slave child to uncloneable parent.
-test13 - uncloneable child to shared parent.
-test14 - uncloneable child to private parent.
-test15 - uncloneable child to slave parent.
-test16 - uncloneable child to uncloneable parent.
-test17 - shared subtree with shared child to shared subtree.
-test18 - shared subtree with shared child to private subtree.
-test19 - shared subtree with shared child to slave subtree.
-test20 - shared subtree with shared child to uncloneable subtree.
-test21 - multi-level slave p-nodes.
-test22 - bind within same tree - root to child
-test23 - shared child to shared parent.
-test24 - shared child to shared parent.
-
-
-test07-2:
-=========
-create slave then mount master - slave still propagates.
-
-
-test01:
-=======
-shared child to shared parent.
-
-
-test02:
-=======
-shared child to private parent.
-
-
-test03:
-=======
-shared child to slave parent.
-
-
-test04:
-=======
-shared child to unclonable parent.
-
-
-test05:
-=======
-private child to shared parent.
-
-
-test06:
-=======
-private child to private parent.
-
-
-test07:
-=======
-private child to slave parent.
-
-
-test08:
-=======
-private child to uncloneable parent.
-
-
-test09:
-=======
-slave child to shared parent.
-
-
-test10:
-=======
-slave child to private parent.
-
-
-test11:
-=======
-slave child to slave parent.
-
-
-test12:
-=======
-slave child to uncloneable parent.
-
-
-test13:
-=======
-uncloneable child to shared parent.
-
-
-test14:
-=======
-uncloneable child to private parent.
-
-
-test15:
-=======
-uncloneable child to slave parent.
-
-
-test16:
-=======
-uncloneable child to uncloneable parent.
-
-
-test17:
-=======
-shared subtree with shared child to shared subtree.
-
-
-test18:
-=======
-shared subtree with shared child to private subtree.
-
-
-test19:
-=======
-shared subtree with shared child to slave subtree.
-
-
-test20:
-=======
-shared subtree with shared child to uncloneable subtree.
-
-
-test21:
-=======
-multi-level slave p-nodes.
-
-
-test22:
-=======
-bind within same tree - root to child
-
-
-test23:
-=======
-shared child to shared parent.
-
-
-test24:
-=======
-shared child to shared parent.
-
-
diff --git a/testcases/kernel/fs/fs_bind/bind/Makefile b/testcases/kernel/fs/fs_bind/bind/Makefile
new file mode 100644
index 000000000..48233262e
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir			?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS			:= fs_bind*
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind01.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind01.sh
new file mode 100755
index 000000000..70d7fe11b
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind01.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared child to shared parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --bind parent2 share2
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+
+	fs_bind_check parent2 share2
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+	fs_bind_check parent1/child1/a parent2/child2/a share2/child2/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+	fs_bind_check parent1/child1/b parent2/child2/b share2/child2/b
+	fs_bind_check parent2 share2
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind02.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind02.sh
new file mode 100755
index 000000000..dd7efeb4b
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind02.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared child to private parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --bind parent1/child1 share1
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 share1
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check parent1/child1/a parent2/child2/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check parent1/child1/b parent2/child2/b share1/b
+	
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind03.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind03.sh
new file mode 100755
index 000000000..019f135d6
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind03.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared child to slave parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+	mkdir parent2
+
+	EXPECT_PASS mount --bind parent1/child1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share2
+	EXPECT_PASS mount --bind share2 parent2
+	EXPECT_PASS mount --make-rslave parent2
+
+	fs_bind_check share2 parent2
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --bind parent1/child1 share1
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 share1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent1/child1/a
+
+	fs_bind_check parent1/child1/a parent2/child2/a share1/a
+	fs_bind_check -n parent2/child2/a share2/child2/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent2/child2/b share2/child2/b
+	fs_bind_check parent1/child1/b parent2/child2/b share1/b
+	
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount parent2
+
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind04.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind04.sh
new file mode 100755
index 000000000..d525dc649
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind04.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared child to unclonable parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --bind parent1/child1 share1
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 share1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+	fs_bind_check parent1/child1/a parent2/child2/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+	fs_bind_check parent1/child1/b parent2/child2/b share1/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/c
+	fs_bind_check parent1/child1/c parent2/child2/c share1/c
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount parent1/child1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind05.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind05.sh
new file mode 100755
index 000000000..234b911c9
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind05.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: private child to shared parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --bind parent1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --bind parent2 share2
+
+	fs_bind_check -n parent1/child1 share1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 parent2/child2 share2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+	fs_bind_check -n parent1/child1/a parent2/child2/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check parent2/child2/b share2/child2/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share2/child2/c
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check parent2/child2/c share2/child2/c
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount share2/child2/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind06.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind06.sh
new file mode 100755
index 000000000..13bf8abd8
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind06.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: private child to private parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --bind parent1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+	fs_bind_check -n  parent1/child1 share1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check -n  parent1/child1 share1/child1
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh
new file mode 100755
index 000000000..92e71c976
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: create slave then mount master - slave still propagates"
+
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --bind share2 parent2
+	EXPECT_PASS mount --make-slave parent2
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share2
+	fs_bind_check parent2 share2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/a
+	fs_bind_check -n parent2/a share2/a
+
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind07.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind07.sh
new file mode 100755
index 000000000..bae87a5cd
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind07.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: private child to slave parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --bind parent1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+	fs_bind_check -n  parent1/child1 share1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share2
+	EXPECT_PASS mount --bind share2 parent2
+	EXPECT_PASS mount --make-rslave parent2
+	mkdir parent2/child2
+	fs_bind_check parent2 share2
+
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 parent2/child2
+	fs_bind_check -n parent2/child2 share2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check -n  parent1/child1 share1/child1
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind08.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind08.sh
new file mode 100755
index 000000000..4bb292b42
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind08.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: private child to uncloneable parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --bind parent1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+
+	fs_bind_check -n parent1/child1 share1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+	fs_bind_check -n parent1/child1/a parent2/child2/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check -n parent1/child1 share1/child1
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind09.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind09.sh
new file mode 100755
index 000000000..a10511c77
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind09.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: slave child to shared parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind parent2 share2
+	EXPECT_PASS mount --bind share1 parent1/child1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --make-rslave parent1/child1
+	fs_bind_check parent1/child1 share1
+
+	mkdir parent2/child2
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check parent2/child2 share2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/c
+	fs_bind_check share1/c parent1/child1/c
+	fs_bind_check parent1/child1/c parent2/child2/c
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind10.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind10.sh
new file mode 100755
index 000000000..4e60d8615
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind10.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: slave child to private parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind share1 parent1/child1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --make-rslave parent1/child1
+	fs_bind_check parent1/child1 share1
+
+	mkdir parent2/child2
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/c
+	fs_bind_check share1/c parent1/child1/c
+	fs_bind_check parent1/child1/c parent2/child2/c
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind11.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind11.sh
new file mode 100755
index 000000000..07f87a612
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind11.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: slave child to slave parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind parent2 share2
+	EXPECT_PASS mount --bind share1 parent1/child1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share2
+	EXPECT_PASS mount --make-rslave parent1/child1
+	EXPECT_PASS mount --make-rslave parent2
+
+	mkdir parent2/child2
+	fs_bind_check parent1/child1 share1
+	fs_bind_check parent2 share2
+
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent1/child1/a
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" parent2/child2/b
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check -n parent2/child2 share2/child2
+
+	EXPECT_PASS umount parent2/child2/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/c
+	fs_bind_check share1/c parent1/child1/c
+	fs_bind_check parent1/child1/c parent2/child2/c
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind12.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind12.sh
new file mode 100755
index 000000000..38942fc6f
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind12.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: slave child to uncloneable parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind share1 parent1/child1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --make-rslave parent1/child1
+	fs_bind_check parent1/child1 share1
+
+	mkdir parent2/child2
+	EXPECT_PASS mount --bind parent1/child1 parent2/child2
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1/a
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/child2/b
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/c
+	fs_bind_check share1/c parent1/child1/c
+	fs_bind_check parent1/child1/c parent2/child2/c
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind13.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind13.sh
new file mode 100755
index 000000000..7090a2b6f
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind13.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: uncloneable child to shared parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir runbindable parent1/child1
+
+	EXPECT_PASS mount --bind parent1 share1
+	EXPECT_PASS mount --bind parent2 share2
+	mkdir parent1/child1/x
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1/x
+	mkdir parent2/child2
+	EXPECT_FAIL mount --bind parent1/child1 parent2/child2
+
+	EXPECT_PASS umount parent1/child1/x
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind14.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind14.sh
new file mode 100755
index 000000000..dd0c1345b
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind14.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: uncloneable child to private parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir runbindable parent1/child1
+	mkdir parent1/child1/x
+
+	EXPECT_PASS mount --bind parent1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1/x
+	mkdir parent2/child2
+	EXPECT_FAIL mount --bind parent1/child1 parent2/child2
+
+	EXPECT_PASS umount parent1/child1/x
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind15.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind15.sh
new file mode 100755
index 000000000..9a7c7f388
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind15.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: uncloneable child to slave parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir runbindable parent1/child1
+	mkdir parent1/child1/x
+
+	EXPECT_PASS mount --bind parent1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1/x
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share2
+	EXPECT_PASS mount --bind --make-rslave share2 parent2
+
+	fs_bind_check parent2 share2
+
+	mkdir parent2/child2
+	EXPECT_FAIL mount --bind parent1/child1 parent2/child2
+
+	EXPECT_PASS umount parent1/child1/x
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind16.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind16.sh
new file mode 100755
index 000000000..85bbd9f90
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind16.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: uncloneable child to uncloneable parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir runbindable parent1/child1
+	mkdir parent1/child1/x
+
+	EXPECT_PASS mount --bind parent1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1/x
+
+	mkdir parent2/child2
+	EXPECT_FAIL mount --bind parent1/child1 parent2/child2
+
+	EXPECT_PASS umount parent1/child1/x
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind17.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind17.sh
new file mode 100755
index 000000000..e0e844120
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind17.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared subtree with shared child to shared subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --bind share1 parent1
+
+	EXPECT_PASS mount --bind parent1 parent2
+	fs_bind_makedir rshared parent1/child1
+	fs_bind_check parent1 share1 parent2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1
+	fs_bind_check parent1/child1 parent2/child1
+	fs_bind_check parent1/child1 share1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/a
+	fs_bind_check parent1/a parent2/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/b
+	fs_bind_check parent1/b parent2/b share1/b
+
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind18.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind18.sh
new file mode 100755
index 000000000..262d1cbe0
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind18.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared subtree with shared child to private subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --bind share1 parent1
+
+	EXPECT_PASS mount --bind parent1 parent2
+	fs_bind_makedir rshared parent1/child1
+	fs_bind_check parent1 share1 parent2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1
+	fs_bind_check parent1/child1 parent2/child1
+	fs_bind_check parent1/child1 share1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/a
+	fs_bind_check parent1/a parent2/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/b
+	fs_bind_check parent1/b parent2/b share1/b
+
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind19.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind19.sh
new file mode 100755
index 000000000..0d18a4259
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind19.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared subtree with shared child to slave subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --bind share1 parent1
+	EXPECT_PASS mount --bind --make-rslave share2 parent2
+
+	EXPECT_PASS mount --bind parent1 parent2
+	fs_bind_makedir rshared parent1/child1
+	fs_bind_check parent1 share1 parent2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1
+	fs_bind_check parent1/child1 parent2/child1
+	fs_bind_check parent1/child1 share1/child1
+	
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/a
+	fs_bind_check parent1/a parent2/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/b
+	fs_bind_check parent1/b parent2/b share1/b
+
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind20.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind20.sh
new file mode 100755
index 000000000..e19de1950
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind20.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared subtree with shared child to uncloneable subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --bind share1 parent1
+
+	EXPECT_PASS mount --bind parent1 parent2
+	fs_bind_makedir rshared parent1/child1
+	fs_bind_check parent1 share1 parent2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent1/child1
+	fs_bind_check parent1/child1 parent2/child1
+	fs_bind_check parent1/child1 share1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/a
+	fs_bind_check parent1/a parent2/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/b
+	fs_bind_check parent1/b parent2/b share1/b
+
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind21.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind21.sh
new file mode 100755
index 000000000..d8abe99de
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind21.sh
@@ -0,0 +1,57 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: multi-level slave p-nodes"
+
+	fs_bind_makedir rshared dir1
+
+	mkdir dir1/x dir2 dir3 dir4
+
+	EXPECT_PASS mount --bind dir1 dir2
+	EXPECT_PASS mount --make-rslave dir2
+	EXPECT_PASS mount --make-rshared dir2
+
+	EXPECT_PASS mount --bind dir2 dir3
+	EXPECT_PASS mount --make-rslave dir3
+	EXPECT_PASS mount --make-rshared dir3
+
+	EXPECT_PASS mount --bind dir3 dir4
+	EXPECT_PASS mount --make-rslave dir4
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1/x
+	fs_bind_check dir1/x dir2/x dir3/x dir4/x
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir2/x/a
+	fs_bind_check -n dir1/x/a dir2/x/a
+	fs_bind_check dir2/x/a dir3/x/a dir4/x/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" dir3/x/b
+	fs_bind_check -n dir1/x/b dir3/x/b
+	fs_bind_check -n dir2/x/b dir3/x/b
+	fs_bind_check dir3/x/b dir4/x/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" dir4/x/c
+	fs_bind_check -n dir1/x/c dir4/x/c
+	fs_bind_check -n dir2/x/c dir4/x/c
+	fs_bind_check -n dir3/x/c dir4/x/c
+
+	EXPECT_PASS umount dir2/x/a
+	EXPECT_PASS umount dir3/x/b
+	EXPECT_PASS umount dir4/x/c
+	EXPECT_PASS umount dir1/x
+	EXPECT_PASS umount dir1
+	EXPECT_PASS umount dir2
+	EXPECT_PASS umount dir3
+	EXPECT_PASS umount dir4
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind22.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind22.sh
new file mode 100755
index 000000000..d013f8c7d
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind22.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: bind within same tree - root to child"
+
+	fs_bind_makedir rshared parent
+	fs_bind_makedir rshared parent/child1
+	fs_bind_makedir rshared parent/child2
+
+	EXPECT_PASS mount --bind parent parent/child2/
+	fs_bind_check parent parent/child2/
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent/child2/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child2/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" parent/child2/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child1
+	EXPECT_PASS umount parent/child2
+	EXPECT_PASS umount parent/child2
+	EXPECT_PASS umount parent
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind23.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind23.sh
new file mode 100755
index 000000000..af7aaa095
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind23.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared child to shared parent"
+
+	fs_bind_makedir private mnt
+	fs_bind_makedir rshared mnt/1
+
+	mkdir mnt/2 mnt/1/abc
+	EXPECT_PASS mount --bind mnt/1 mnt/2
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" mnt/1/abc
+
+	fs_bind_check mnt/1/abc mnt/2/abc "$FS_BIND_DISK1"
+
+	mkdir tmp2
+	fs_bind_makedir rshared tmp1
+	EXPECT_PASS mount --bind tmp1 tmp2
+
+	mkdir tmp1/3
+	EXPECT_PASS mount --move mnt tmp1/3
+	fs_bind_check tmp1/3/1/abc tmp2/3/1/abc tmp2/3/2/abc "$FS_BIND_DISK1"
+
+	EXPECT_PASS umount tmp1/3/1/abc
+	EXPECT_PASS umount tmp1/3/1
+	EXPECT_PASS umount tmp1/3/2
+	EXPECT_PASS umount tmp1/3
+	EXPECT_PASS umount tmp1
+	EXPECT_PASS umount tmp2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/fs_bind24.sh b/testcases/kernel/fs/fs_bind/bind/fs_bind24.sh
new file mode 100755
index 000000000..fe9a816e7
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/bind/fs_bind24.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "bind: shared child to shared parent"
+
+	fs_bind_makedir rshared dir1
+	mkdir dir1/1 dir1/1/2 dir1/1/2/3 dir1/1/2/fs_bind_check dir2 dir3 dir4
+	touch dir4/ls
+
+	EXPECT_PASS mount --bind dir1/1/2 dir2
+	EXPECT_PASS mount --make-rslave dir1
+	EXPECT_PASS mount --make-rshared dir1
+
+	EXPECT_PASS mount --bind dir1/1/2/3 dir3
+	EXPECT_PASS mount --make-rslave dir1
+
+	EXPECT_PASS mount --bind dir4 dir2/fs_bind_check
+	fs_bind_check dir1/1/2/fs_bind_check/ dir4
+
+	EXPECT_PASS umount dir2/fs_bind_check
+	EXPECT_PASS umount dir3
+	EXPECT_PASS umount dir2
+	EXPECT_PASS umount dir1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/bind/test01 b/testcases/kernel/fs/fs_bind/bind/test01
deleted file mode 100755
index 52005dc1d..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test01
+++ /dev/null
@@ -1,99 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test01} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST01***************"
-tst_resm TINFO "bind: shared child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test01 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind "$disk1" parent1/child1
-
-	mkdir parent2/child2
-
-	mount --bind parent2 share2
-	mount --bind parent1/child1 parent2/child2
-
-	check parent2 share2
-	check parent1/child1 parent2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check parent1/child1/a parent2/child2/a share2/child2/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check parent1/child1/b parent2/child2/b share2/child2/b
-	check parent2 share2
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test01: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test01: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent1/child1/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "bind/test01: FAILED: bind: shared child to shared parent."
-	exit 1
-else
-	tst_resm TPASS "bind/test01: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test02 b/testcases/kernel/fs/fs_bind/bind/test02
deleted file mode 100755
index a4d743c88..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test02
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test02} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST02***************"
-tst_resm TINFO "bind: shared child to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test02 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind "$disk1" parent1/child1
-
-	mkdir parent2/child2
-
-	mount --bind parent1/child1 share1
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 share1
-	check parent1/child1 parent2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check parent1/child1/a parent2/child2/a share1/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check parent1/child1/b parent2/child2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test02: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test02: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent1/child1/b
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount parent2/child2
-	umount parent2
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test02: FAILED: bind: shared child to private parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test02: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test03 b/testcases/kernel/fs/fs_bind/bind/test03
deleted file mode 100755
index ac1f426f0..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test03
+++ /dev/null
@@ -1,118 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test03} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST03***************"
-tst_resm TINFO "bind: shared child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test03 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	mkdir parent2
-
-	mount --bind parent1/child1 share1
-	mount --bind "$disk1" parent1/child1
-	mount --bind "$disk2" share2
-	mount --bind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	"${FS_BIND_ROOT}/bin/check_prop" share2 parent2
-
-
-	mkdir parent2/child2
-	ls share2
-
-	mount --bind parent1/child1 share1
-	mount --bind parent1/child1 parent2/child2
-
-	"${FS_BIND_ROOT}/bin/check_prop" parent1/child1 share1 parent2/child2
-
-	mount --bind "$disk3" parent1/child1/a
-
-	"${FS_BIND_ROOT}/bin/check_prop" parent1/child1/a parent2/child2/a share1/a
-	"${FS_BIND_ROOT}/bin/check_prop" -n parent2/child2/a share2/child2/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	"${FS_BIND_ROOT}/bin/check_prop" -n parent2/child2/b share2/child2/b
-	"${FS_BIND_ROOT}/bin/check_prop" parent1/child1/b parent2/child2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test03: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test03: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent1/child1/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share2
-	umount share2
-	umount share2
-	umount parent1
-	umount parent2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test03: FAILED: bind: shared child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test03: PASSED"
-        exit 0
-fi
-
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test04 b/testcases/kernel/fs/fs_bind/bind/test04
deleted file mode 100755
index ac17f8be0..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test04
+++ /dev/null
@@ -1,104 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test04} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-
-tst_resm TINFO "***************TEST04***************"
-tst_resm TINFO "bind: shared child to unclonable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test04 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind "$disk1" parent1/child1
-
-	mkdir parent2/child2
-
-	mount --bind parent1/child1 share1
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 share1 parent2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check parent1/child1/a parent2/child2/a share1/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check parent1/child1/b parent2/child2/b share1/b
-
-	mount --bind "$disk4" share1/c
-
-	check parent1/child1/c parent2/child2/c share1/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test04: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test04: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent1/child1/b
-	umount parent1/child1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test04: FAILED: bind: shared child to unclonable parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test04: PASSED"
-        exit 0
-fi
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test05 b/testcases/kernel/fs/fs_bind/bind/test05
deleted file mode 100755
index 911286409..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test05
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test05} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST05***************"
-tst_resm TINFO "bind: private child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test05 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --bind parent1 share1
-	mount --bind "$disk1" parent1/child1
-	mount --bind parent2 share2
-
-	check -n  parent1/child1 share1/child1
-
-	mkdir parent2/child2
-
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2 share2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check parent2/child2/b share2/child2/b
-
-	mount --bind "$disk4" share2/child2/c
-
-	check -n parent1/child1/b parent2/child2/b
-	check parent2/child2/c share2/child2/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test05: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test05: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount share2/child2/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test05: FAILED: bind: private child to shared parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test05: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test06 b/testcases/kernel/fs/fs_bind/bind/test06
deleted file mode 100755
index 1da8fd559..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test06
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test06} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST06***************"
-tst_resm TINFO "bind: private child to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test06 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --bind parent1 share1
-	mount --bind "$disk1" parent1/child1
-
-	check -n  parent1/child1 share1/child1
-
-	mkdir parent2/child2
-
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check -n  parent1/child1 share1/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test06: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test06: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test06: FAILED: bind: private child to private parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test06: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test07 b/testcases/kernel/fs/fs_bind/bind/test07
deleted file mode 100755
index 301ab3007..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test07
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test07} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST07***************"
-tst_resm TINFO "bind: private child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test07 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --bind parent1 share1
-	mount --bind "$disk1" parent1/child1
-
-	check -n  parent1/child1 share1/child1
-
-	mount --bind "$disk2" share2
-	mount --bind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-	#mount --bind "$disk2" share2
-
-	mkdir parent2/child2
-	check parent2 share2
-
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-	check -n parent2/child2 share2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check -n  parent1/child1 share1/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test07: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test07: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test07: FAILED: bind: private child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test07: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test07-2 b/testcases/kernel/fs/fs_bind/bind/test07-2
deleted file mode 100755
index faf1e2fa4..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test07-2
+++ /dev/null
@@ -1,69 +0,0 @@
-#!/bin/bash
-
-SETS_DEFAULTS="${TCID=test07-2} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST07-2***************"
-tst_resm TINFO "bind: create slave then mount master - slave still propagates."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test07-2 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --bind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-	mount --bind "$disk1" share2
-
-	check parent2 share2
-
-	mount --bind "$disk2" parent2/a
-
-	check -n parent2/a share2/a
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test07-2: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test07-2: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/a
-	umount parent2
-	umount parent2
-	umount parent2
-
-	umount share2
-	umount share2
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test07-2: FAILED: bind: create slave then mount master - slave still propagates."
-        exit 1
-else
-        tst_resm TPASS "bind/test07-2: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test08 b/testcases/kernel/fs/fs_bind/bind/test08
deleted file mode 100755
index 2d8e80829..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test08
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test08} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST08***************"
-tst_resm TINFO "bind: private child to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test08 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --bind parent1 share1
-	mount --bind "$disk1" parent1/child1
-
-	check -n  parent1/child1 share1/child1
-
-	mkdir parent2/child2
-
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check -n  parent1/child1 share1/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test08: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test08: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test08: FAILED: bind: private child to uncloneable parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test08: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test09 b/testcases/kernel/fs/fs_bind/bind/test09
deleted file mode 100755
index 46ff0dc41..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test09
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test09} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST09***************"
-tst_resm TINFO "bind: slave child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test09 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind parent2 share2
-	mount --bind share1 parent1/child1
-	mount --bind "$disk1" share1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	check parent1/child1 share1
-
-	mkdir parent2/child2
-
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-	check -n parent1/child1/a share1/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check parent2/child2 share2/child2
-
-	mount --bind "$disk4" share1/c
-	check share1/c parent1/child1/c
-	check parent1/child1/c parent2/child2/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test09: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test09: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount share1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test09: FAILED: bind: slave child to shared parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test09: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test10 b/testcases/kernel/fs/fs_bind/bind/test10
deleted file mode 100755
index ebfcf5adc..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test10
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test10} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST10***************"
-tst_resm TINFO "bind: slave child to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test10 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind share1 parent1/child1
-	mount --bind "$disk1" share1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	check parent1/child1 share1
-
-	mkdir parent2/child2
-
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-	check -n parent1/child1/a share1/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-
-	mount --bind "$disk4" share1/c
-	check share1/c parent1/child1/c
-	check parent1/child1/c parent2/child2/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test10: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test10: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount share1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test10: FAILED: bind: slave child to private parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test10: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test11 b/testcases/kernel/fs/fs_bind/bind/test11
deleted file mode 100755
index e1b70e1d9..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test11
+++ /dev/null
@@ -1,116 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test11} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST11***************"
-tst_resm TINFO "bind: slave child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test11 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind parent2 share2
-	mount --bind share1 parent1/child1
-	mount --bind "$disk1" share1
-	mount --bind "$disk2" share2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	mkdir parent2/child2
-
-	check parent1/child1 share1
-	check parent2 share2
-
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --bind "$disk3" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-	check -n parent1/child1/a share1/a
-
-	mount --bind "$disk4" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check -n parent2/child2 share2/child2
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test11: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test11: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/b
-
-	mount --bind "$disk4" share1/c
-	check share1/c parent1/child1/c
-	check parent1/child1/c parent2/child2/c
-
-	umount parent1/child1/a
-	umount share1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount parent2
-	umount parent2
-	umount parent2
-	umount parent2
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test11: FAILED: bind: slave child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test11: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test12 b/testcases/kernel/fs/fs_bind/bind/test12
deleted file mode 100755
index 307e6da54..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test12
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test12} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST12***************"
-tst_resm TINFO "bind: slave child to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test12 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind share1 parent1/child1
-	mount --bind "$disk1" share1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	check parent1/child1 share1
-
-	mkdir parent2/child2
-
-	mount --bind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --bind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-	check -n parent1/child1/a share1/a
-
-	mount --bind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-
-	mount --bind "$disk4" share1/c
-	check share1/c parent1/child1/c
-	check parent1/child1/c parent2/child2/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test12: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test12: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount share1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount share1
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test12: FAILED: bind: slave child to uncloneable parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test12: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test13 b/testcases/kernel/fs/fs_bind/bind/test13
deleted file mode 100755
index ed559ece6..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test13
+++ /dev/null
@@ -1,90 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test13} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST13***************"
-tst_resm TINFO "bind: uncloneable child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test13 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-
-	mount --bind parent1 share1
-	mount --bind parent2 share2
-	mkdir parent1/child1/x
-	mount --bind "$disk1" parent1/child1/x
-	mkdir parent2/child2
-	mount --bind parent1/child1 parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test13: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test13: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/x
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-        tst_resm TFAIL "bind/test13: FAILED: bind: uncloneable child to shared parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test13: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test14 b/testcases/kernel/fs/fs_bind/bind/test14
deleted file mode 100755
index 6015b9a54..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test14
+++ /dev/null
@@ -1,86 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test14} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST14***************"
-tst_resm TINFO "bind: uncloneable child to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test14 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mkdir parent1/child1/x
-
-	mount --bind parent1 share1
-	mount --bind "$disk1" parent1/child1/x
-	mkdir parent2/child2
-	mount --bind parent1/child1 parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test14: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test14: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/x
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-        tst_resm TFAIL "bind/test14: FAILED: bind: uncloneable child to private parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test14: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test15 b/testcases/kernel/fs/fs_bind/bind/test15
deleted file mode 100755
index 8e36c559c..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test15
+++ /dev/null
@@ -1,96 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test15} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST15***************"
-tst_resm TINFO "bind: uncloneable child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test15 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mkdir parent1/child1/x
-
-	mount --bind parent1 share1
-	mount --bind "$disk1" parent1/child1/x
-	mount --bind "$disk2" share2
-	mount --bind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	check parent2 share2
-
-	mkdir parent2/child2
-	mount --bind parent1/child1 parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test15: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test15: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/x
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-        tst_resm TFAIL "bind/test15: FAILED: bind: uncloneable child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test15: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test16 b/testcases/kernel/fs/fs_bind/bind/test16
deleted file mode 100755
index ec2ef686b..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test16
+++ /dev/null
@@ -1,87 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test16} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST16***************"
-tst_resm TINFO "bind: uncloneable child to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test16 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mkdir parent1/child1/x
-
-	mount --bind parent1 share1
-	mount --bind "$disk1" parent1/child1/x
-
-	mkdir parent2/child2
-	mount --bind parent1/child1 parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test16: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test16: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/x
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-        tst_resm TFAIL "bind/test16: FAILED: bind: uncloneable child to uncloneable parent."
-        exit 1
-else
-        tst_resm TPASS "bind/test16: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test17 b/testcases/kernel/fs/fs_bind/bind/test17
deleted file mode 100755
index 828625aea..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test17
+++ /dev/null
@@ -1,100 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test17} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-result=0
-
-tst_resm TINFO "***************TEST17***************"
-tst_resm TINFO "bind: shared subtree with shared child to shared subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test17 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --bind "$disk1" share1
-	mount --bind share1 parent1
-
-	mount --bind parent1 parent2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	check parent1 share1 parent2
-	mount --bind "$disk2" parent1/child1
-	check parent1/child1 parent2/child1
-	check parent1/child1 share1/child1
-	mount --bind "$disk3" parent2/a
-
-	check parent1/a parent2/a share1/a
-
-	mount --bind "$disk4" share1/b
-
-	check parent1/b parent2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test17: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test17: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/b
-	umount parent2/a
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent2
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "bind/test17: FAILED: bind: shared subtree with shared child to shared subtree."
-	exit 1
-else
-	tst_resm TPASS "bind/test17: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test18 b/testcases/kernel/fs/fs_bind/bind/test18
deleted file mode 100755
index 1cb06c4c7..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test18
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test18} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST18***************"
-tst_resm TINFO "bind: shared subtree with shared child to private subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test18 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --bind "$disk1" share1
-	mount --bind share1 parent1
-
-	mount --bind parent1 parent2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	check parent1 share1 parent2
-	mount --bind "$disk2" parent1/child1
-	check parent1/child1 parent2/child1
-	check parent1/child1 share1/child1
-	mount --bind "$disk3" parent2/a
-
-	check parent1/a parent2/a share1/a
-
-	mount --bind "$disk4" share1/b
-
-	check parent1/b parent2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test18: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test18: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/b
-	umount parent2/a
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent2
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "bind/test18: FAILED: bind: shared subtree with shared child to private subtree."
-	exit 1
-else
-	tst_resm TPASS "bind/test18: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test19 b/testcases/kernel/fs/fs_bind/bind/test19
deleted file mode 100755
index fdec5c316..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test19
+++ /dev/null
@@ -1,109 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test19} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST19***************"
-tst_resm TINFO "bind: shared subtree with shared child to slave subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test19 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	####### SETUP ######
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --bind "$disk1" share1
-	mount --bind share1 parent1
-	mount --bind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	###### BODY ######
-	mount --bind parent1 parent2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	##### VERIFICATION ######
-	check parent1 share1 parent2
-	mount --bind "$disk2" parent1/child1
-	check parent1/child1 parent2/child1
-	check parent1/child1 share1/child1
-	mount --bind "$disk3" parent2/a
-
-	check parent1/a parent2/a share1/a
-
-	mount --bind "$disk4" share1/b
-
-	check parent1/b parent2/b share1/b
-
-	##### CLEANUP ######
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test19: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test19: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/b
-	umount parent2/a
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent2
-	umount parent1
-	umount share1
-	umount share2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "bind/test19: FAILED: bind: shared subtree with shared child to slave subtree."
-	exit 1
-else
-	tst_resm TPASS "bind/test19: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test20 b/testcases/kernel/fs/fs_bind/bind/test20
deleted file mode 100755
index 57f091bf3..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test20
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test20} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST20***************"
-tst_resm TINFO "bind: shared subtree with shared child to uncloneable subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test20 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --bind "$disk1" share1
-	mount --bind share1 parent1
-
-	mount --bind parent1 parent2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	check parent1 share1 parent2
-	mount --bind "$disk2" parent1/child1
-	check parent1/child1 parent2/child1
-	check parent1/child1 share1/child1
-	mount --bind "$disk3" parent2/a
-
-	check parent1/a parent2/a share1/a
-
-	mount --bind "$disk4" share1/b
-
-	check parent1/b parent2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test20: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test20: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/b
-	umount parent2/a
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent2
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "bind/test20: FAILED: bind: shared subtree with shared child to uncloneable subtree."
-	exit 1
-else
-	tst_resm TPASS "bind/test20: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test21 b/testcases/kernel/fs/fs_bind/bind/test21
deleted file mode 100755
index dfba4e766..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test21
+++ /dev/null
@@ -1,114 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test21} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST21***************"
-tst_resm TINFO "bind: multi-level slave p-nodes."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test21 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
-
-	mkdir dir1/x dir2 dir3 dir4
-
-	mount --bind dir1 dir2
-	"${FS_BIND_ROOT}/bin/makedir" slave dir2
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir2
-
-	mount --bind dir2 dir3
-	"${FS_BIND_ROOT}/bin/makedir" slave dir3
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir3
-
-	mount --bind dir3 dir4
-	"${FS_BIND_ROOT}/bin/makedir" slave dir4
-
-	mount --bind "$disk1" dir1/x
-
-	check dir1/x dir2/x dir3/x dir4/x
-
-	mount --bind "$disk2" dir2/x/a
-	check -n dir1/x/a dir2/x/a
-	check dir2/x/a dir3/x/a dir4/x/a
-
-	mount --bind "$disk3" dir3/x/b
-	check -n dir1/x/b dir3/x/b
-	check -n dir2/x/b dir3/x/b
-	check dir3/x/b dir4/x/b
-
-	mount --bind "$disk4" dir4/x/c
-	check -n dir1/x/c dir4/x/c
-	check -n dir2/x/c dir4/x/c
-	check -n dir3/x/c dir4/x/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test21: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test21: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir2/x/a
-	umount dir3/x/b
-	umount dir4/x/c
-	umount dir1/x
-	umount dir1
-	umount dir1
-	umount dir2
-	umount dir3
-	umount dir4
-
-	rm -rf dir*
-
-	cleanup
-} >& /dev/null
-
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "bind/test21: FAILED: bind: multi-level slave p-nodes."
-        exit 1
-else
-        tst_resm TPASS "bind/test21: PASSED"
-        exit 0
-fi
-
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test22 b/testcases/kernel/fs/fs_bind/bind/test22
deleted file mode 100755
index 027dcebdf..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test22
+++ /dev/null
@@ -1,95 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test22} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST22***************"
-tst_resm TINFO "bind: bind within same tree - root to child "
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test22 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child1
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child2
-
-	mount --bind parent parent/child2/
-
-	check parent parent/child2/
-
-	mount --bind "$disk3" parent/child2/child1
-
-	check parent/child1 parent/child2/child1
-
-	 umount parent/child2/child1
-
-	check parent/child1 parent/child2/child1
-
-	mount --bind "$disk4" parent/child2/child1
-
-	check parent/child1 parent/child2/child1
-
-	 umount parent/child1
-
-	check parent/child1 parent/child2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test22: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test22: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent/child1
-	umount parent/child2
-	umount parent/child2
-	umount parent
-
-	rm -rf parent
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "bind/test22: FAILED: bind: bind within same tree - root to child "
-	exit 1
-else
-	tst_resm TPASS "bind/test22: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test23 b/testcases/kernel/fs/fs_bind/bind/test23
deleted file mode 100755
index b6a8679e3..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test23
+++ /dev/null
@@ -1,89 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test23} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST24***************"
-tst_resm TINFO "bind: shared child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test23 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	mkdir mnt mnt/1 mnt/2 mnt/1/abc tmp1 tmp1/3 tmp2
-
-	mount --bind mnt mnt
-	"${FS_BIND_ROOT}/bin/makedir" share mnt/1 mnt/1
-	mount --bind mnt/1 mnt/2
-	mount --bind "$disk1" mnt/1/abc
-
-	check mnt/1/abc mnt/2/abc "$disk1"
-
-	"${FS_BIND_ROOT}/bin/makedir" share tmp1
-	mount --bind tmp1 tmp2
-
-	mount --move mnt tmp1/3
-	check tmp1/3/1/abc tmp2/3/1/abc tmp2/3/2/abc "$disk1"
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test23: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test23: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount tmp1/3/1/abc
-	umount tmp1/3/1
-	umount tmp1/3/2
-	umount tmp1/3
-	umount tmp1
-	umount tmp1
-	umount tmp2
-
-	rm -rf mnt tmp1 tmp2
-
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "bind/test23: FAILED: bind: shared child to shared parent."
-	exit 1
-else
-	tst_resm TPASS "bind/test23: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/bind/test24 b/testcases/kernel/fs/fs_bind/bind/test24
deleted file mode 100755
index 59f70c6ea..000000000
--- a/testcases/kernel/fs/fs_bind/bind/test24
+++ /dev/null
@@ -1,87 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test24} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST24***************"
-tst_resm TINFO "bind: shared child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of bind/test24 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
-	mkdir dir1/1 dir1/1/2 dir1/1/2/3 dir1/1/2/check dir2 dir3 dir4
-	touch dir4/ls
-
-	mount --bind dir1/1/2 dir2
-	"${FS_BIND_ROOT}/bin/makedir" slave dir1
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir1
-
-	mount --bind dir1/1/2/3 dir3
-	"${FS_BIND_ROOT}/bin/makedir" slave dir1
-
-	mount --bind dir4 dir2/check
-
-	check dir1/1/2/check/ dir4
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "bind/test24: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "bind/test24: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir2/check
-	umount dir3
-	umount dir2
-	umount dir1
-
-
-	rm -rf dir*
-
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "bind/test24: FAILED: bind: shared child to shared parent."
-	exit 1
-else
-	tst_resm TPASS "bind/test24: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/00_Descriptions.txt b/testcases/kernel/fs/fs_bind/cloneNS/00_Descriptions.txt
deleted file mode 100644
index 8c616cca6..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/00_Descriptions.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-OO_DESCRIPTION.txt
-==================
-
-The contents of the cloneNS directory:
-test01 - namespace with shared dirs
-test02 - namespaces with parent-slave
-test03 - namespace with unclonable mount
-test04 - namespace with private mount.
-test05 - namespace with multi-level
-test06 - namespace with shared point bind mounted
-test07 - slave child to slave parent.
-
-
-test01:
-=======
-namespace with shared dirs
-
-
-test02:
-=======
-namespaces with parent-slave
-
-
-test03:
-=======
-namespace with unclonable mount
-
-
-test04:
-=======
-namespace with private mount.
-
-
-test05:
-=======
-namespace with multi-level
-chain of slaves
-
-
-test06:
-=======
-namespace with shared point bind mounted
-within the same directory
-
-
-test07:
-=======
-slave child to slave parent.
-
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/Makefile b/testcases/kernel/fs/fs_bind/cloneNS/Makefile
new file mode 100644
index 000000000..48233262e
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/cloneNS/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir			?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS			:= fs_bind*
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child01 b/testcases/kernel/fs/fs_bind/cloneNS/child01
deleted file mode 100755
index 4e667941f..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child01
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-check "$disk2" dir1/a dir2/a
-mount --bind "$disk3" dir1/b
-check dir1/b dir2/b
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child02 b/testcases/kernel/fs/fs_bind/cloneNS/child02
deleted file mode 100755
index b46e8d1d2..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child02
+++ /dev/null
@@ -1,42 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-
-check "$disk2" dir1/a dir2/a
-check -n "$disk3" d2/b
-check -n "$disk3" d1/b
-
-mount --bind "$disk4" dir1/c
-check dir1/c dir2/c
-
-umount dir2/a
-check -n dir1/a dir2/a
-
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child03 b/testcases/kernel/fs/fs_bind/cloneNS/child03
deleted file mode 100755
index 2b78bc3bc..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child03
+++ /dev/null
@@ -1,32 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-check "$disk1" dir1
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child04 b/testcases/kernel/fs/fs_bind/cloneNS/child04
deleted file mode 100755
index b6ba67c62..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child04
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-check -n "$disk2" dir1/a
-mount --bind "$disk3" dir1/b
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child05 b/testcases/kernel/fs/fs_bind/cloneNS/child05
deleted file mode 100755
index a82cbb2b5..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child05
+++ /dev/null
@@ -1,41 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-
-check "$disk2" parent/child1/a parent/child2/child1/a
-check "$disk3" parent/child1/b parent/child2/child1/b
-
-mount --bind "$disk4" parent/child2/child1/c
-check parent/child2/child1/c parent/child1/c
-
-umount parent/child1/b
-check parent/child2/child1/b parent/child1/b
-
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child06 b/testcases/kernel/fs/fs_bind/cloneNS/child06
deleted file mode 100755
index 5abbf97ec..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child06
+++ /dev/null
@@ -1,49 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-
-check dir1/x dir2/x dir3/x dir4/x
-
-echo ls dir1/x/a
-ls dir1/x/a
-check -n dir1/x/a dir2/x/a
-check "$disk2" dir2/x/a dir3/x/a dir4/x/a
-
-mount --rbind "$disk3" dir3/x/b
-check -n dir1/x/b dir3/x/b
-check -n dir2/x/b dir3/x/b
-check dir3/x/b dir4/x/b
-
-mount --rbind "$disk4" dir4/x/c
-check -n dir1/x/c dir4/x/c
-check -n dir2/x/c dir4/x/c
-check -n dir3/x/c dir4/x/c
-
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/child07 b/testcases/kernel/fs/fs_bind/cloneNS/child07
deleted file mode 100755
index 50c4965c0..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/child07
+++ /dev/null
@@ -1,42 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startchild
-goahead
-iamgoingahead
-
-
-result=0
-
-check parent2 parent2/a parent2/a/a
-check parent2/b parent2/a/b parent2/a/a/b
-
-mount --bind "$disk3" parent1/a/c
-check parent2/c parent2/a/c parent2/a/a/c
-
-goahead
-iamgoingahead
-check parent2/c parent2/a/c parent2/a/a/c
-
-
-exit $result
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
new file mode 100755
index 000000000..e4d0bb42d
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+    tst_res TINFO "cloneNS: namespace with shared dirs"
+
+	fs_bind_makedir rshared dir1
+	fs_bind_makedir rshared dir2
+
+    EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+    EXPECT_PASS mount --bind dir1 dir2
+
+    fs_bind_create_ns
+
+    EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir2/a
+    fs_bind_check dir1/a dir2/a
+
+    fs_bind_check -s "$FS_BIND_DISK2" dir1/a dir2/a
+    fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK3" $PWD/dir1/b
+    fs_bind_check -s dir1/b dir2/b
+
+    EXPECT_PASS umount dir1/b
+    EXPECT_PASS umount dir2/a
+    EXPECT_PASS umount dir2
+    EXPECT_PASS umount dir1
+    EXPECT_PASS umount dir2
+    EXPECT_PASS umount dir1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
new file mode 100755
index 000000000..9e0f5fe05
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+    tst_res TINFO "cloneNS: namespaces with parent-slave"
+
+	fs_bind_makedir rshared dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+
+	mkdir dir2
+	EXPECT_PASS mount --bind dir1 dir2
+    EXPECT_PASS mount --make-slave dir2
+
+    fs_bind_create_ns
+
+    EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir1/a
+    fs_bind_check dir1/a dir2/a
+    EXPECT_PASS mount --bind "$FS_BIND_DISK3" dir2/b
+    fs_bind_check -n dir1/b dir2/b
+
+
+    fs_bind_check -s "$FS_BIND_DISK2" dir1/a dir2/a
+    fs_bind_check -s -n "$FS_BIND_DISK3" dir2/b
+    fs_bind_check -s -n "$FS_BIND_DISK3" dir1/b
+    fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK4" $PWD/dir1/c
+    fs_bind_check -s dir1/c dir2/c
+
+    fs_bind_exec_ns umount $PWD/dir2/a
+    fs_bind_check -s -n dir1/a dir2/a
+
+
+    fs_bind_check "$FS_BIND_DISK2" dir1/a dir2/a
+    fs_bind_check "$FS_BIND_DISK4" dir1/c dir2/c
+
+    fs_bind_destroy_ns
+
+    EXPECT_PASS umount dir1/c
+    EXPECT_PASS umount dir1/a
+    EXPECT_PASS umount dir2/b
+    EXPECT_PASS umount dir2
+    EXPECT_PASS umount dir1
+    EXPECT_PASS umount dir1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
new file mode 100755
index 000000000..a7bb819b1
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+    tst_res TINFO "cloneNS: namespace with unclonable mount"
+
+    fs_bind_makedir runbindable dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+    fs_bind_check "$FS_BIND_DISK1" dir1
+
+    fs_bind_create_ns
+
+    fs_bind_check -s "$FS_BIND_DISK1" dir1
+    
+    EXPECT_PASS umount dir1
+    EXPECT_PASS umount dir1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
new file mode 100755
index 000000000..4236a1fb9
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+    tst_res TINFO "cloneNS: namespace with private mount"
+
+    fs_bind_makedir private dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+    fs_bind_create_ns
+
+    EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir1/a
+
+    fs_bind_check -s -n "$FS_BIND_DISK2" dir1/a
+    fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK3" "$PWD/dir1/b"
+
+    fs_bind_check -n "$FS_BIND_DISK3" dir1/b   
+
+    EXPECT_PASS umount dir1/a
+    EXPECT_PASS umount dir1
+    EXPECT_PASS umount dir1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
new file mode 100755
index 000000000..88d673b2e
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+    tst_res TINFO "cloneNS: namespace with multi-level chain of slaves"
+
+	fs_bind_makedir rshared parent
+	fs_bind_makedir rshared parent/child1
+	fs_bind_makedir rshared parent/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent/child1
+	EXPECT_PASS mount --rbind parent parent/child2
+
+    fs_bind_create_ns
+
+    EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent/child1/a
+    fs_bind_check parent/child1/a parent/child2/child1/a
+
+    EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent/child2/child1/b
+    fs_bind_check parent/child1/b parent/child2/child1/b
+
+
+    fs_bind_check -s "$FS_BIND_DISK2" parent/child1/a parent/child2/child1/a
+    fs_bind_check -s "$FS_BIND_DISK3" parent/child1/b parent/child2/child1/b
+
+    fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK4" "$PWD/parent/child2/child1/c"
+    fs_bind_check -scheck parent/child2/child1/c parent/child1/c
+
+    fs_bind_exec_ns umount "$PWD/parent/child1/b"
+    fs_bind_check -s parent/child2/child1/b parent/child1/b
+
+
+    fs_bind_check "$FS_BIND_DISK4" parent/child2/child1/c parent/child1/c
+    fs_bind_check -n "$FS_BIND_DISK3" parent/child1/b
+    fs_bind_check parent/child1/b parent/child2/child1/b
+
+
+    EXPECT_PASS umount parent/child2/child1/c
+    EXPECT_PASS umount parent/child2/child1/a
+    EXPECT_PASS umount parent/child2/child1
+    EXPECT_PASS umount parent/child2/child1
+    EXPECT_PASS umount parent/child2/child2
+    EXPECT_PASS umount parent/child2
+    EXPECT_PASS umount parent
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
new file mode 100755
index 000000000..9a156c947
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
@@ -0,0 +1,77 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+    tst_res TINFO "cloneNS: namespace with shared point bind mounted within the same directory"
+
+    fs_bind_makedir rshared dir1
+
+	mkdir dir1/x dir2 dir3 dir4
+
+	EXPECT_PASS mount --rbind dir1 dir2
+    EXPECT_PASS mount --make-rslave dir2
+	EXPECT_PASS mount --make-rshared dir2
+
+	EXPECT_PASS mount --rbind dir2 dir3
+    EXPECT_PASS mount --make-rslave dir3
+    EXPECT_PASS mount --make-rshared dir3
+
+	EXPECT_PASS mount --rbind dir3 dir4
+    EXPECT_PASS mount --make-rslave dir4
+
+    fs_bind_create_ns
+
+    EXPECT_PASS mount --rbind "$FS_BIND_DISK1" dir1/x
+
+    fs_bind_check dir1/x dir2/x dir3/x dir4/x
+
+    EXPECT_PASS mount --rbind "$FS_BIND_DISK2" dir2/x/a
+    fs_bind_check -n dir1/x/a dir2/x/a
+    fs_bind_check dir2/x/a dir3/x/a dir4/x/a
+
+
+    fs_bind_check -s dir1/x dir2/x dir3/x dir4/x
+
+    fs_bind_check -s -n dir1/x/a dir2/x/a
+    fs_bind_check -s "$FS_BIND_DISK2" dir2/x/a dir3/x/a dir4/x/a
+
+    fs_bind_exec_ns mount --rbind "$PWD/$FS_BIND_DISK3" "$PWD/dir3/x/b"
+    fs_bind_check -s -n dir1/x/b dir3/x/b
+    fs_bind_check -s -n dir2/x/b dir3/x/b
+    fs_bind_check -s dir3/x/b dir4/x/b
+
+    fs_bind_exec_ns mount --rbind "$PWD/$FS_BIND_DISK4" "$PWD/dir4/x/c"
+    fs_bind_check -s -n dir1/x/c dir4/x/c
+    fs_bind_check -s -n dir2/x/c dir4/x/c
+    fs_bind_check -s -n dir3/x/c dir4/x/c
+
+
+    fs_bind_check -n dir1/x/b dir3/x/b
+    fs_bind_check -n dir2/x/b dir3/x/b
+    fs_bind_check dir3/x/b dir4/x/b
+    fs_bind_check "$FS_BIND_DISK3" dir3/x/b
+
+    fs_bind_check -n "$FS_BIND_DISK4" dir4/x/c
+    fs_bind_check dir1/x/c dir2/x/c dir3/x/c dir4/x/c
+
+
+    EXPECT_PASS umount dir3/x/b
+    EXPECT_PASS umount dir3/x/a
+    EXPECT_PASS umount dir2/x/a
+    EXPECT_PASS umount dir2/x
+    EXPECT_PASS umount dir1/x
+    EXPECT_PASS umount dir4
+    EXPECT_PASS umount dir3
+    EXPECT_PASS umount dir2
+    EXPECT_PASS umount dir1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
new file mode 100755
index 000000000..04c524485
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+    tst_res TINFO "cloneNS: slave child to slave parent"
+
+	mkdir parent1 parent2
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1
+	EXPECT_PASS mount --make-rshared parent1
+	EXPECT_PASS mount --bind parent1 parent2
+
+	fs_bind_check parent1 parent2
+
+	EXPECT_PASS mount --move parent1 parent2/a
+
+	fs_bind_check parent2 parent2/a parent2/a/a
+
+    fs_bind_create_ns
+
+    fs_bind_check parent2 parent2/a parent2/a/a
+
+    EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/b
+    fs_bind_check parent2/b parent2/a/b parent2/a/a/b
+
+
+    fs_bind_check -s parent2 parent2/a parent2/a/a
+    fs_bind_check -s parent2/b parent2/a/b parent2/a/a/b
+
+    fs_bind_exec_ns mount --bind "$PWD/$FS_BIND_DISK3" "$PWD/parent2/a/c"
+    fs_bind_check -s parent2/c parent2/a/c parent2/a/a/c
+
+
+    fs_bind_check parent2 parent2/a parent2/a/a
+    fs_bind_check parent2/c parent2/a/c parent2/a/a/c
+
+    EXPECT_PASS umount parent2/a/a/c
+    fs_bind_check parent2/c parent2/a/c parent2/a/a/c
+    
+    
+    fs_bind_check -s parent2/c parent2/a/c parent2/a/a/c
+
+    EXPECT_PASS umount parent2/a/b
+    EXPECT_PASS umount parent2/a/a
+    EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent01 b/testcases/kernel/fs/fs_bind/cloneNS/parent01
deleted file mode 100755
index afeb5bf1b..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent01
+++ /dev/null
@@ -1,44 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-ls
-ls dir*
-mount --bind "$disk2" dir2/a
-check dir1/a dir2/a
-echo dir1/a
-ls dir1/a
-
-goahead
-iamgoingahead
-check "$disk3" dir1/b dir2/b
-echo dir2/b
-ls dir2/b
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent02 b/testcases/kernel/fs/fs_bind/cloneNS/parent02
deleted file mode 100755
index 56b3c9072..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent02
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-ls
-ls dir*
-mount --bind "$disk2" dir1/a
-check dir1/a dir2/a
-
-mount --bind "$disk3" dir2/b
-check -n dir1/b dir2/b
-
-goahead
-iamgoingahead
-
-check "$disk2" dir1/a dir2/a
-check "$disk4" dir1/c dir2/c
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent03 b/testcases/kernel/fs/fs_bind/cloneNS/parent03
deleted file mode 100755
index e9c3b77c5..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent03
+++ /dev/null
@@ -1,34 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-check "$disk1" dir1
-goahead
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent04 b/testcases/kernel/fs/fs_bind/cloneNS/parent04
deleted file mode 100755
index 58ac7306d..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent04
+++ /dev/null
@@ -1,37 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-mount --bind "$disk2" dir1/a
-goahead
-iamgoingahead
-check -n "$disk3" dir1/b
-
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent05 b/testcases/kernel/fs/fs_bind/cloneNS/parent05
deleted file mode 100755
index 3aa69dfe4..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent05
+++ /dev/null
@@ -1,45 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-mount --bind "$disk2" parent/child1/a
-check parent/child1/a parent/child2/child1/a
-
-mount --bind "$disk3" parent/child2/child1/b
-check parent/child1/b parent/child2/child1/b
-
-goahead
-iamgoingahead
-
-check "$disk4" parent/child2/child1/c parent/child1/c
-check -n "$disk3" parent/child1/b
-check parent/child1/b parent/child2/child1/b
-
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent06 b/testcases/kernel/fs/fs_bind/cloneNS/parent06
deleted file mode 100755
index 0f3e87f89..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent06
+++ /dev/null
@@ -1,51 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-mount --rbind "$disk1" dir1/x
-
-check dir1/x dir2/x dir3/x dir4/x
-
-mount --rbind "$disk2" dir2/x/a
-check -n dir1/x/a dir2/x/a
-check dir2/x/a dir3/x/a dir4/x/a
-
-
-goahead
-iamgoingahead
-
-check -n dir1/x/b dir3/x/b
-check -n dir2/x/b dir3/x/b
-check dir3/x/b dir4/x/b
-check "$disk3" dir3/x/b
-
-check -n "$disk4" dir4/x/c
-check dir1/x/c dir2/x/c dir3/x/c dir4/x/c
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/parent07 b/testcases/kernel/fs/fs_bind/cloneNS/parent07
deleted file mode 100755
index 6a5109f7c..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/parent07
+++ /dev/null
@@ -1,48 +0,0 @@
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-. "${FS_BIND_ROOT}/bin/setup"
-. "${FS_BIND_ROOT}/bin/setupnslock"
-
-startparent
-iamgoingahead
-
-
-result=0
-
-check parent2 parent2/a parent2/a/a
-
-mount --bind "$disk2" parent2/b
-check parent2/b parent2/a/b parent2/a/a/b
-
-
-goahead
-iamgoingahead
-
-
-check parent2 parent2/a parent2/a/a
-check parent2/c parent2/a/c parent2/a/a/c
-
-umount parent2/a/a/c
-check parent2/c parent2/a/c parent2/a/a/c
-goahead
-
-exit $result
-
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test01 b/testcases/kernel/fs/fs_bind/cloneNS/test01
deleted file mode 100755
index a4fda7dc4..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/test01
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test01} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST01***************"
-tst_resm TINFO "cloneNS: namespace with shared dirs"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test01 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent01" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child01" .
-
-	chmod 755 parent01 child01
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
-	"${FS_BIND_ROOT}/bin/makedir" share dir2
-
-
-	mount --bind "$disk1" dir1
-
-	mount --bind dir1 dir2
-
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent01 ./child01 || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test01: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test01: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1/a
-	umount dir2/b
-	umount dir1
-	umount dir1
-	umount dir1
-	umount dir2
-
-	rm -rf dir* parent* child*
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test01: FAILED: cloneNS: namespace with shared dirs"
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test01: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test02 b/testcases/kernel/fs/fs_bind/cloneNS/test02
deleted file mode 100755
index 62045130f..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/test02
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-SETS_DEFAULTS="${TCID=test02} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST02***************"
-tst_resm TINFO "cloneNS: namespaces with parent-slave"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test02 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent02" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child02" .
-
-	chmod 755 parent02 child02
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
-	mount --bind "$disk1" dir1
-
-	mkdir dir2
-	mount --bind dir1 dir2
-	"${FS_BIND_ROOT}/bin/makedir" slave dir2
-
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent02 ./child02 || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test02: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test02: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1/a
-	umount dir2/b
-	umount dir1/c
-	umount dir2
-	umount dir1
-	umount dir1
-
-	rm -rf dir* parent* child*
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test02: FAILED: cloneNS: namespaces with parent-slave"
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test02: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test03 b/testcases/kernel/fs/fs_bind/cloneNS/test03
deleted file mode 100755
index 8db2c78fc..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/test03
+++ /dev/null
@@ -1,77 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test03} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST03***************"
-tst_resm TINFO "cloneNS: namespace with unclonable mount "
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test03 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent03" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child03" .
-
-	chmod 755 parent03 child03
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone dir1
-	mount --bind "$disk1" dir1
-
-
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent03 ./child03 || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test03: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test03: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1
-	umount dir1
-
-	rm -rf dir* parent* child*
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test03: FAILED: cloneNS: namespace with unclonable mount "
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test03: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test04 b/testcases/kernel/fs/fs_bind/cloneNS/test04
deleted file mode 100755
index 2605fbedf..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/test04
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test04} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST04***************"
-tst_resm TINFO "cloneNS: namespace with private mount."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test04 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent04" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child04" .
-
-	chmod 755 parent04 child04
-
-	"${FS_BIND_ROOT}/bin/makedir" priv dir1
-	mount --bind "$disk1" dir1
-
-
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent04 ./child04 || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test04: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test04: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1/a
-	umount dir1
-	umount dir1
-
-	rm -rf dir* parent* child*
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test04: FAILED: cloneNS: namespace with private mount."
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test04: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test05 b/testcases/kernel/fs/fs_bind/cloneNS/test05
deleted file mode 100755
index d03ac2937..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/test05
+++ /dev/null
@@ -1,90 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test05} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST05***************"
-tst_resm TINFO "cloneNS: namespace with multi-level "
-tst_resm TINFO "chain of slaves"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test05 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent05" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child05" .
-
-	chmod 755 parent05 child05
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child1
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child2
-
-	mount --rbind "$disk1" parent/child1
-
-	mount --rbind parent parent/child2/
-
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent05 ./child05 || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test05: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test05: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent/child2/child2
-	umount parent/child2/child1/a
-	umount parent/child2/child1/c
-	umount parent/child2/child1
-	umount parent/child2/child1
-	umount parent/child2
-	umount parent/child2
-	umount parent
-
-	rm -rf parent* child*
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test05: FAILED: cloneNS: namespace with multi-level
-chain of slaves"
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test05: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test06 b/testcases/kernel/fs/fs_bind/cloneNS/test06
deleted file mode 100755
index b7af489a2..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/test06
+++ /dev/null
@@ -1,96 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test06} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST06***************"
-tst_resm TINFO "cloneNS: namespace with shared point bind mounted "
-tst_resm TINFO "within the same directory"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test06 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent06" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child06" .
-
-	chmod 755 parent06 child06
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
-
-	mkdir dir1/x dir2 dir3 dir4
-
-	mount --rbind dir1 dir2
-	"${FS_BIND_ROOT}/bin/makedir" slave dir2
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir2
-
-	mount --rbind dir2 dir3
-	"${FS_BIND_ROOT}/bin/makedir" slave dir3
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir3
-
-	mount --rbind dir3 dir4
-	"${FS_BIND_ROOT}/bin/makedir" slave dir4
-
-
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent06 ./child06 || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test06: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test06: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir3/x/b
-	umount dir2/x/a
-	umount dir1/x
-	umount dir4
-	umount dir3
-	umount dir2
-	umount dir1
-
-	rm -rf parent* child* dir*
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "cloneNS/test06: FAILED: cloneNS: namespace with shared point bind mounted
-within the same directory"
-	exit 1
-else
-	tst_resm TPASS "cloneNS/test06: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test07 b/testcases/kernel/fs/fs_bind/cloneNS/test07
deleted file mode 100755
index bf94912c6..000000000
--- a/testcases/kernel/fs/fs_bind/cloneNS/test07
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test07} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST 07***************"
-tst_resm TINFO "cloneNS: slave child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of cloneNS/test07 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	cp "${FS_BIND_ROOT}/cloneNS/parent07" ./
-	cp "${FS_BIND_ROOT}/cloneNS/child07" .
-	chmod 755 parent07 child07
-
-	mkdir parent1 parent2
-	mount --bind "$disk1" parent1
-	mount --make-rshared parent1 > /dev/null 2>&1 || "${FS_BIND_ROOT}/bin/smount" parent1 rshared
-	mount --bind parent1 parent2
-
-	check parent1 parent2
-
-	mount --move parent1 parent2/a
-
-	check parent2 parent2/a parent2/a/a
-
-	"${FS_BIND_ROOT}/bin/nsclone" ./parent07 ./child07 || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "cloneNS/test07: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "cloneNS/test07: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/b
-	umount parent2/a/a
-	umount parent2/a
-	umount parent2
-	umount parent1
-
-
-
-	rm -rf parent* child*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "cloneNS/test07: FAILED: cloneNS: slave child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "cloneNS/test07: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/fs_bind_lib.sh b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
new file mode 100644
index 000000000..d5ea276a9
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/fs_bind_lib.sh
@@ -0,0 +1,246 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Based on work by: Avantika Mathur (mathurav@us.ibm.com)
+
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_ROOT=1
+TST_MIN_KVER=2.6.15
+TST_SETUP=fs_bind_setup
+TST_CLEANUP=fs_bind_cleanup
+TST_TESTFUNC=fs_bind_test
+TST_NEEDS_CMDS="mount umount awk sed"
+
+. tst_test.sh
+
+[ -z "$FS_BIND_TESTFUNC" ] && tst_brk TBROK "Please set FS_BIND_TESTFUNC before sourcing fs_bind_lib.sh"
+
+# Test interface:
+#
+# FS_BIND_TESTFUNC is the real testfunction. Please do not use
+# TST_TESTFUNC in the test. FS_BIND_TESTFUNC is used to wrap some additional logic.
+# TST_CNT can be used as usual
+
+FS_BIND_SANDBOX="sandbox"
+FS_BIND_DISK1="disk1"
+FS_BIND_DISK2="disk2"
+FS_BIND_DISK3="disk3"
+FS_BIND_DISK4="disk4"
+
+FS_BIND_MNTNS_PID=
+
+# Creates a directory and bind-mounts it to itself.
+# usage: fs_bind_makedir share_mode directory
+# where
+#  share_mode is one of the --make-{shared,priv,...}
+#  supported by mount
+#  directory is directory where to be created/configured.
+#  If it does not exist, it will be created
+fs_bind_makedir()
+{
+	local bind_type dir
+
+	bind_type="$1"
+	dir="$2"
+
+	case "$bind_type" in
+	shared|private|rshared|slave|rslave|rprivate|runbindable) ;;
+	*) tst_brk TBROK "Unknown share type \"$bind_type\""
+	esac
+
+	if [ -e "$dir" ]; then
+		tst_brk TBROK "An entry by the name \"$dir\" exists already"
+	fi
+
+	ROD mkdir -p "$dir"
+
+	# Most mount implementations can use --make-* in the same command as bind,
+	# but busybox mount, fails at least to set --make-private
+	EXPECT_PASS mount --bind "$dir" "$dir"
+	EXPECT_PASS mount --make-$bind_type "$dir"
+}
+
+# Verifies that subtrees contain the same content
+# usage: fs_bind_check [-n] dir1 dirn...
+# where
+#  -n  If set, expectes the subtrees to not be equal
+#  -s  Run check in mount namespace
+# dir1 dirn... An arbitraty number of directories, that are compared.
+#              If -n is given, only two directories are allowed.
+fs_bind_check()
+{
+	local expect_diff use_ns args msg dir1 dir2 fail output
+	expect_diff=0
+	use_ns=0
+	while getopts "ns" args; do
+		case "$args" in
+		n) expect_diff=1; shift; ;;
+		s) use_ns=1; shift; ;;
+		esac
+	done
+	msg="Check"
+	[ $expect_diff -eq 1 ] && msg="$msg no"
+	msg="$msg propagation"
+    if [ $use_ns -eq 1 ]; then
+		[ -z "$FS_BIND_MNTNS_PID" ] && tst_brk TBROK "Namespace does not exist"
+		msg="$msg in mnt namespace"
+	fi
+	msg="$msg $*"
+
+	if [ $# -lt 2 ] || ( [ $expect_diff -eq 1 ] && [ $# -ne 2 ] ); then
+		tst_brk TBROK "Insufficient arguments"
+	fi
+
+	dir1=$1
+	shift
+
+	for dir2 in "$@"; do
+		# compare adjacent pairs of directory trees
+
+        if [ ! -d "$dir1" ]; then
+            tst_res TFAIL "$msg: \"$dir1\" does not exist"
+            return 1
+        elif [ ! -d "$dir2" ]; then
+            if [ $expect_diff -eq 1 ]; then
+                tst_res TPASS "$msg"
+                return 0
+            else
+                tst_res TFAIL "$msg: \"$dir2\" does not exist"
+                return 1
+            fi
+        fi
+
+		if [ $use_ns -eq 1 ]; then
+			output="$(ns_exec ${FS_BIND_MNTNS_PID} mnt diff -r "$PWD/$dir1" "$PWD/$dir2" 2> /dev/null)"
+		else
+			output="$(diff -r "$dir1" "$dir2" 2> /dev/null)"
+		fi
+
+		if [ $? -ne 0 ]; then
+			if [ $expect_diff -eq 1 ]; then
+                # Since expect_diff=1 allows only two directories
+                # to be compared, we are done after finding the first diff
+				tst_res TPASS "$msg"
+				return 0
+			else
+				tst_res TFAIL "$msg:"
+                tst_res TFAIL "\"$dir1\" \"$dir2\" differ:\n$output"
+				return 1
+			fi
+		fi
+		dir1="$dir2"
+	done
+
+	if [ $expect_diff -eq 1 ]; then
+		tst_res TFAIL "$msg"
+		return 1
+	else
+		tst_res TPASS "$msg"
+		return 0
+	fi
+}
+
+fs_bind_setup()
+{
+	fs_bind_makedir private "$FS_BIND_SANDBOX"
+
+    cd $FS_BIND_SANDBOX
+	mkdir -p "$FS_BIND_DISK1" "$FS_BIND_DISK2" "$FS_BIND_DISK3" "$FS_BIND_DISK4"
+    mkdir "$FS_BIND_DISK1/a" "$FS_BIND_DISK1/b" "$FS_BIND_DISK1/c"
+    mkdir "$FS_BIND_DISK2/d" "$FS_BIND_DISK2/e" "$FS_BIND_DISK2/f"
+    mkdir "$FS_BIND_DISK3/g" "$FS_BIND_DISK3/h" "$FS_BIND_DISK3/i"
+    mkdir "$FS_BIND_DISK4/j" "$FS_BIND_DISK4/k" "$FS_BIND_DISK4/l"
+}
+
+_fs_bind_unmount_all()
+{
+	local mounts
+
+	cd "$TST_TMPDIR"
+
+	# Cleanup leftover mounts from the test
+	# sed '1!G;h;$!d' is used to reverse /proc/mounts.
+	# unmounting in reverse order requires significantly less iterations
+	# There is a slight chance, this loop does not terminate, if a mount
+	# cannot be unmounted for some reason. In that case the timeout
+	# will kill the test, but we cannot restore the system anyway
+	while true; do
+		mounts=$( sed '1!G;h;$!d' /proc/mounts \
+			| awk -vtmp="$TST_TMPDIR/$FS_BIND_SANDBOX/" \
+			'index($2, tmp) {print $2}' )
+		[ -z "$mounts" ] && break
+		echo $mounts | xargs umount 2>/dev/null
+	done
+}
+
+fs_bind_cleanup()
+{
+ 	_fs_bind_unmount_all
+    umount "$FS_BIND_SANDBOX"
+}
+
+_fs_bind_setup_test()
+{
+	local e
+
+	cd "$TST_TMPDIR/$FS_BIND_SANDBOX" || tst_brk "Unable to cd into sandbox"
+	
+	for e in ls *; do
+		if   [ "$e" = "$FS_BIND_DISK1" ] \
+		  || [ "$e" = "$FS_BIND_DISK2" ] \
+		  || [ "$e" = "$FS_BIND_DISK3" ] \
+		  || [ "$e" = "$FS_BIND_DISK4" ]; then
+		  continue
+		fi
+		rm -rf "$e"
+	done
+}
+
+fs_bind_create_ns()
+{
+	[ -n "$FS_BIND_MNTNS_PID" ] && tst_brk TBROK "Namespace exist already"
+	FS_BIND_MNTNS_PID=$(ns_create mnt)
+}
+
+fs_bind_exec_ns()
+{
+	[ -z "$FS_BIND_MNTNS_PID" ] && tst_brk TBROK "Namespace does not exist"
+	EXPECT_PASS ns_exec $FS_BIND_MNTNS_PID mnt "$@"
+}
+
+fs_bind_destroy_ns()
+{
+	[ -n "$FS_BIND_MNTNS_PID" ] && kill $FS_BIND_MNTNS_PID 2>/dev/null
+	FS_BIND_MNTNS_PID=
+}
+
+_fs_bind_cleanup_test()
+{
+	local mounts
+
+	fs_bind_destroy_ns
+
+	mounts=$( awk -v tmp="$TST_TMPDIR/$FS_BIND_SANDBOX/" '
+		index($2, tmp) {
+			print substr($2, length(tmp) + 1)
+		}
+	' /proc/mounts )
+	if [ -n "$mounts" ]; then
+		tst_res TFAIL "There are still mounts in the sandbox:\n$mounts"
+	fi
+	_fs_bind_unmount_all
+}
+
+fs_bind_test()
+{
+	_fs_bind_setup_test
+
+	if type ${FS_BIND_TESTFUNC}1 > /dev/null 2>&1; then
+		"$FS_BIND_TESTFUNC$_tst_i" $1
+	else
+		"$FS_BIND_TESTFUNC" $1
+	fi
+
+	_fs_bind_cleanup_test
+}
diff --git a/testcases/kernel/fs/fs_bind/fs_bind_regression.sh b/testcases/kernel/fs/fs_bind/fs_bind_regression.sh
new file mode 100755
index 000000000..ce3e64ce4
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/fs_bind_regression.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+TST_CNT=3
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test1()
+{
+	tst_res TINFO "regression: bind unshared directory to unshare mountpoint"
+
+	mkdir dir
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir
+	fs_bind_check "$FS_BIND_DISK1" dir
+	EXPECT_PASS umount dir
+}
+
+test2()
+{
+	tst_res TINFO "regression: rbind unshared directory to unshare mountpoint"
+
+	mkdir dir1
+	mkdir dir2
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir1/a
+	EXPECT_PASS mount --rbind dir1 dir2
+
+	fs_bind_check dir1/a dir2/a
+
+	EXPECT_PASS umount dir1/a
+	EXPECT_PASS umount dir2/a
+	EXPECT_PASS umount dir2
+	EXPECT_PASS umount dir1
+}
+
+test3()
+{
+	tst_res TINFO "regression: move unshared directory to unshare mountpoint"
+
+	mkdir dir1
+	mkdir dir2
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" dir1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" dir1/a
+	EXPECT_PASS mount --move dir1 dir2
+
+	fs_bind_check dir2/a "$FS_BIND_DISK2"
+
+	EXPECT_PASS umount dir2/a
+	EXPECT_PASS umount dir2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/00_Descriptions.txt b/testcases/kernel/fs/fs_bind/move/00_Descriptions.txt
deleted file mode 100644
index 9355d82d6..000000000
--- a/testcases/kernel/fs/fs_bind/move/00_Descriptions.txt
+++ /dev/null
@@ -1,158 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-OO_DESCRIPTION.txt
-==================
-
-The contents of the move directory:
-test01 - shared child to shared parent.
-test02 - shared subtree to private parent.
-test03 - shared subtree to slave parent.
-test04 - shared subtree to uncloneable parent.
-test05 - private subtree to shared parent.
-test06 - private subtree to private parent.
-test07 - private subtree to slave parent.
-test08 - private subtree to uncloneable parent.
-test09 - slave subtree to shared parent.
-test10 - slave subtree to private parent.
-test11 - slave subtree to slave parent.
-test12 - slave subtree to uncloneable parent.
-test13 - uncloneable subtree to shared parent.
-test14 - uncloneable subtree to private parent.
-test15 - uncloneable subtree to slave parent.
-test16 - uncloneable subtree to uncloneable parent.
-test17 - tree with shared parent - check ERROR.
-test18 - private to private - with shared children
-test19 - private to private - with slave children
-test20 - private to private - with unclonable children
-test21 - shared tree within a tree it is bound to.
-test22 - shared tree within a tree it is bound to - and then move t
-
-
-test01:
-=======
-shared child to shared parent.
-
-
-test02:
-=======
-shared subtree to private parent.
-
-
-test03:
-=======
-shared subtree to slave parent.
-
-
-test04:
-=======
-shared subtree to uncloneable parent.
-
-
-test05:
-=======
-private subtree to shared parent.
-
-
-test06:
-=======
-private subtree to private parent.
-
-
-test07:
-=======
-private subtree to slave parent.
-
-
-test08:
-=======
-private subtree to uncloneable parent.
-
-
-test09:
-=======
-slave subtree to shared parent.
-
-
-test10:
-=======
-slave subtree to private parent.
-
-
-test11:
-=======
-slave subtree to slave parent.
-
-
-test12:
-=======
-slave subtree to uncloneable parent.
-
-
-test13:
-=======
-uncloneable subtree to shared parent.
-
-
-test14:
-=======
-uncloneable subtree to private parent.
-
-
-test15:
-=======
-uncloneable subtree to slave parent.
-
-
-test16:
-=======
-uncloneable subtree to uncloneable parent.
-
-
-test17:
-=======
-tree with shared parent - check ERROR.
-
-
-test18:
-=======
-private to private - with shared children
-
-
-test19:
-=======
-private to private - with slave children
-
-
-test20:
-=======
-private to private - with unclonable children
-
-
-test21:
-=======
-shared tree within a tree it is bound to.
-
-
-test22:
-=======
-shared tree within a tree it is bound to - and then move to another share subtree
-
-
diff --git a/testcases/kernel/fs/fs_bind/move/Makefile b/testcases/kernel/fs/fs_bind/move/Makefile
new file mode 100644
index 000000000..48233262e
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir			?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS			:= fs_bind*
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
new file mode 100755
index 000000000..761cd2c7b
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: shared child to shared parent"
+
+	fs_bind_makedir rshared dir
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --bind dir share1
+	EXPECT_PASS mount --bind parent2 share2
+	mkdir dir/grandchild
+	mkdir parent2/child2
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_fs_bind_check parent2/child2/grandchild share1/grandchild share2/child2/grandchild
+	fs_bind_fs_bind_check -n dir/grandchild parent2/child2/grandchild
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share1/grandchild/a
+
+	fs_bind_fs_bind_check parent2/child2/grandchild/a share1/grandchild/a share2/child2/grandchild/a
+
+	EXPECT_PASS umount share1/grandchild/a
+	EXPECT_PASS umount share1/grandchild/
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh
new file mode 100755
index 000000000..141a8da14
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: shared subtree to private parent"
+
+	fs_bind_makedir rshared dir
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --bind dir share1
+	mkdir dir/grandchild
+	mkdir parent2/child2
+	EXPECT_PASS mount --move dir parent2/child2
+	EXPECT_PASS mount --bind parent2 share2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_check parent2/child2/grandchild share1/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
+	fs_bind_check -n share2/child2 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share1/grandchild/a
+
+	fs_bind_check parent2/child2/grandchild/a share1/grandchild/a
+
+	EXPECT_PASS umount share1/grandchild/a
+	EXPECT_PASS umount share1/grandchild/
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh
new file mode 100755
index 000000000..1e33b8301
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: shared subtree to slave parent"
+
+	fs_bind_makedir rshared dir
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --bind dir share1
+	EXPECT_PASS mount --bind share2 parent2
+	mkdir dir/grandchild
+	mkdir parent2/child2
+	EXPECT_PASS mount --make-rslave parent2
+
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_check parent2/child2/grandchild share1/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
+	fs_bind_check -n share2/child2 parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share1/grandchild/a
+
+	fs_bind_check parent2/child2/grandchild/a share1/grandchild/a
+
+	EXPECT_PASS umount share1/grandchild/a
+	EXPECT_PASS umount parent2/child2/grandchild
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh
new file mode 100755
index 000000000..711ce5bd4
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: shared subtree to uncloneable parent"
+
+	fs_bind_makedir rshared dir
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+
+
+	EXPECT_PASS mount --bind dir share1
+	mkdir dir/grandchild
+	mkdir parent2/child2
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_check parent2/child2/grandchild share1/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share1/grandchild/a
+
+	fs_bind_check parent2/child2/grandchild/a share1/grandchild/a
+
+	EXPECT_PASS umount share1/grandchild/a
+	EXPECT_PASS umount share1/grandchild/
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh
new file mode 100755
index 000000000..57ca42366
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: private subtree to shared parent"
+	fs_bind_makedir private dir
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --bind parent2 share2
+	mkdir dir/grandchild
+	EXPECT_PASS mount --bind dir share1
+	mkdir parent2/child2
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_check parent2/child2/grandchild share2/child2/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
+	fs_bind_check -n share1/grandchild parent2/child2/grandchild
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share2/child2/grandchild/a
+
+	fs_bind_check parent2/child2/grandchild/a share2/child2/grandchild/a
+
+	EXPECT_PASS umount parent2/child2/grandchild/a
+	EXPECT_PASS umount parent2/child2/grandchild
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh
new file mode 100755
index 000000000..e0d027fc5
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: private subtree to private parent"
+
+	fs_bind_makedir private dir
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared share1
+
+	mkdir dir/grandchild
+	EXPECT_PASS mount --bind dir share1
+	mkdir parent2/child2
+	EXPECT_PASS mount --bind parent2 share2
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_check -n parent2/child2/grandchild share2/child2/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
+	fs_bind_check -n share1/grandchild parent2/child2/grandchild
+
+	EXPECT_PASS umount parent2/child2/grandchild
+	EXPECT_PASS umount parent2/child2/
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh
new file mode 100755
index 000000000..c451406d1
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: private subtree to slave parent"
+
+	fs_bind_makedir private dir
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared share1
+
+	mkdir dir/grandchild
+	EXPECT_PASS mount --bind dir share1
+	mkdir parent2/child2
+	EXPECT_PASS mount --bind parent2 share2
+	EXPECT_PASS mount --make-rslave parent2
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_check -n parent2/child2/grandchild share2/child2/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
+	fs_bind_check -n share1/grandchild parent2/child2/grandchild
+
+	EXPECT_PASS umount parent2/child2/grandchild
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh
new file mode 100755
index 000000000..a3d7082c5
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: private subtree to uncloneable parent"
+
+	fs_bind_makedir private dir
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+
+	mkdir dir/grandchild
+	EXPECT_PASS mount --bind dir share1
+	mkdir parent2/child2
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
+	fs_bind_check -n share1/grandchild parent2/child2/grandchild
+
+	EXPECT_PASS umount parent2/child2/grandchild
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh
new file mode 100755
index 000000000..b4b9339ee
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: slave subtree to shared parent"
+
+	fs_bind_makedir rshared dir
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --bind parent2 share2
+	mkdir dir/grandchild
+	EXPECT_PASS mount --bind dir share1
+	EXPECT_PASS mount --make-rslave dir
+	mkdir parent2/child2
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent2/child2/grandchild
+	fs_bind_check parent2/child2/grandchild share2/child2/grandchild
+	fs_bind_check -n dir/grandchild parent2/child2/grandchild
+	fs_bind_check -n share1/grandchild parent2/child2/grandchild
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share2/child2/grandchild/a
+
+	fs_bind_check parent2/child2/grandchild/a share2/child2/grandchild/a
+
+	mkdir share1/test
+
+	fs_bind_check parent2/child2 share1
+
+	EXPECT_PASS umount parent2/child2/grandchild/a
+	EXPECT_PASS umount parent2/child2/grandchild
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh
new file mode 100755
index 000000000..bd743f33d
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: slave subtree to private parent"
+
+	fs_bind_makedir rshared dir
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared share1
+
+	mkdir dir/grandchild
+	EXPECT_PASS mount --bind dir share1
+	EXPECT_PASS mount --make-rslave dir
+	mkdir parent2/child2
+	EXPECT_PASS mount --bind parent2 share2
+
+	EXPECT_PASS mount --move dir parent2/child2
+	fs_bind_check -n parent2/child2 share2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1/grandchild
+	fs_bind_check parent2/child2/grandchild share1/grandchild
+	fs_bind_check -n dir/grandchild/ parent2/child2/grandchild
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/child2/grandchild/a
+	fs_bind_check -n share1/grandchild/a parent2/child2/grandchild/a
+
+	EXPECT_PASS umount parent2/child2/grandchild/a
+	EXPECT_PASS umount share1/grandchild
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh
new file mode 100755
index 000000000..40a0484d4
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: slave subtree to slave parent"
+
+	fs_bind_makedir rshared dir
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared share1
+
+	mkdir dir/grandchild
+	EXPECT_PASS mount --bind dir share1
+	EXPECT_PASS mount --make-rslave dir
+	mkdir parent2/child2
+	EXPECT_PASS mount --bind parent2 share2
+	EXPECT_PASS mount --make-rslave parent2
+
+	EXPECT_PASS mount --move dir parent2/child2
+	fs_bind_check -n parent2/child2 share2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1/grandchild
+	fs_bind_check parent2/child2/grandchild share1/grandchild
+	fs_bind_check -n dir/grandchild/ parent2/child2/grandchild
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/child2/grandchild/a
+	fs_bind_check -n share1/grandchild/a parent2/child2/grandchild/a
+
+	EXPECT_PASS umount parent2/child2/grandchild/a
+	EXPECT_PASS umount share1/grandchild
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh
new file mode 100755
index 000000000..f89ce424c
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: slave subtree to uncloneable parent"
+
+	fs_bind_makedir rshared dir
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared share1
+
+	mkdir dir/grandchild
+	EXPECT_PASS mount --bind dir share1
+	EXPECT_PASS mount --make-rslave dir
+	mkdir parent2/child2
+	EXPECT_FAIL mount --bind parent2 share2 2> /dev/null
+
+	EXPECT_PASS mount --move dir parent2/child2
+	fs_bind_check -n parent2/child2 share2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1/grandchild
+	fs_bind_check parent2/child2/grandchild share1/grandchild
+	fs_bind_check -n dir/grandchild/ parent2/child2/grandchild
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/child2/grandchild/a
+	fs_bind_check -n share1/grandchild/a parent2/child2/grandchild/a
+
+	EXPECT_PASS umount parent2/child2/grandchild/a
+	EXPECT_PASS umount share1/grandchild
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh
new file mode 100755
index 000000000..d46058a47
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: uncloneable subtree to shared parent"
+
+	fs_bind_makedir runbindable dir
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --bind parent2 share2
+	mkdir dir/grandchild
+	mkdir parent2/child2
+	EXPECT_FAIL mount --move dir parent2/child2
+
+	EXPECT_PASS umount dir
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh
new file mode 100755
index 000000000..78cb455cf
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: uncloneable subtree to private parent"
+
+	fs_bind_makedir runbindable dir
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share2
+
+	mkdir dir/grandchild
+	mkdir parent2/child2
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS mount --bind parent2 share2
+	fs_bind_check  -n parent2/child2/ share2/child2/
+
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh
new file mode 100755
index 000000000..e74fb713f
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: uncloneable subtree to slave parent"
+
+	fs_bind_makedir runbindable dir
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --bind parent2 share2
+	mkdir dir/grandchild
+	mkdir parent2/child2
+	EXPECT_PASS mount --make-rslave parent2
+	EXPECT_PASS mount --move dir parent2/child2
+	fs_bind_check  -n parent2/child2/ share2/child2/
+
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh
new file mode 100755
index 000000000..7ab16afaa
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: uncloneable subtree to uncloneable parent"
+
+	fs_bind_makedir runbindable dir
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+
+	mkdir dir/grandchild
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --move dir parent2/child2
+
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh
new file mode 100755
index 000000000..dbd2fa80a
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: tree with shared parent"
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent1/child1
+	fs_bind_makedir rshared parent2
+
+	mkdir parent2/child2
+
+	EXPECT_FAIL mount --move parent1/child1 parent2/child2
+
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh
new file mode 100755
index 000000000..1a3c2be37
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: private to private - with shared children"
+
+	fs_bind_makedir private parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared parent1/child1
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --bind parent1/child1 share1
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+
+	EXPECT_PASS mount --move parent1 parent2
+
+	fs_bind_check parent2/child1 share1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/child1/a
+	fs_bind_check parent2/child1/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" share1/b
+	fs_bind_check parent2/child1/b share1/b
+
+	EXPECT_PASS umount parent2/child1/a
+	fs_bind_check parent2/child1/a share1/a
+
+	EXPECT_PASS umount parent2/child1/b
+	fs_bind_check parent2/child1/b share1/b
+
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh
new file mode 100755
index 000000000..c19dc01ab
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: private to private - with slave children"
+
+	fs_bind_makedir private parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	mkdir parent1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --bind share1 parent1/child1
+
+	EXPECT_PASS mount --make-rslave parent1/child1
+
+	EXPECT_PASS mount --move parent1 parent2
+
+	fs_bind_check parent2/child1 share1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/child1/a
+	fs_bind_check -n parent2/child1/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" share1/b
+	fs_bind_check parent2/child1/b share1/b
+
+	EXPECT_PASS umount parent2/child1/b
+	fs_bind_check -n parent2/child1/b share1/b
+
+	EXPECT_PASS umount parent2/child1/a
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh
new file mode 100755
index 000000000..a9012a5f1
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: private to private - with unclonable children"
+
+	fs_bind_makedir private parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir runbindable parent1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+
+	EXPECT_PASS mount --move parent1 parent2
+
+	fs_bind_check "$FS_BIND_DISK1" parent2/child1
+
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh
new file mode 100755
index 000000000..c1a6d9d64
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: shared tree within a tree it is bound to"
+
+	mkdir parent1 parent2
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1
+	EXPECT_PASS mount --make-rshared parent1
+	
+	EXPECT_PASS mount --bind parent1 parent2
+
+	fs_bind_check parent1 parent2
+
+	EXPECT_PASS mount --move parent1 parent2/a
+
+	fs_bind_check parent2 parent2/a parent2/a/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/b
+
+	fs_bind_check parent2/b parent2/a/b parent2/a/a/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent2/a/c
+
+	fs_bind_check parent2/c parent2/a/c parent2/a/a/c
+
+	EXPECT_PASS umount parent2/a/a/c
+
+	fs_bind_check parent2/c parent2/a/c parent2/a/a/c
+
+	EXPECT_PASS umount parent2/b
+	EXPECT_PASS umount parent2/a/a
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh b/testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh
new file mode 100755
index 000000000..61dbc712b
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "move: shared tree within a tree it is bound to - and then move to another share subtree"
+
+	fs_bind_makedir rshared parent1
+	mkdir parent1/a parent2
+	EXPECT_PASS mount --bind parent1 parent2
+
+	fs_bind_check parent1 parent2
+
+	EXPECT_PASS mount --move parent1 parent2/a
+
+	fs_bind_check parent2 parent2/a parent2/a/a
+
+	fs_bind_makedir rshared tmp1
+	mkdir tmp2 tmp1/1
+
+	EXPECT_PASS mount --bind tmp1 tmp2
+	EXPECT_PASS mount --move parent2  tmp1/1
+
+	EXPECT_PASS umount tmp1/1/a/a
+	EXPECT_PASS umount tmp1/1
+	EXPECT_PASS umount tmp1
+	EXPECT_PASS umount tmp2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/move/test01 b/testcases/kernel/fs/fs_bind/move/test01
deleted file mode 100755
index 8b799e6ac..000000000
--- a/testcases/kernel/fs/fs_bind/move/test01
+++ /dev/null
@@ -1,93 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test01} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST01***************"
-tst_resm TINFO "move: shared child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test01 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --bind dir share1
-	mount --bind parent2 share2
-	mkdir dir/grandchild
-	mkdir parent2/child2
-	mount --move dir parent2/child2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check parent2/child2/grandchild share1/grandchild share2/child2/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-
-	mount --bind "$disk2" share1/grandchild/a
-
-	check parent2/child2/grandchild/a share1/grandchild/a share2/child2/grandchild/a
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test01: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test01: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir 2> /dev/null
-	umount share1/grandchild/a
-	umount share1/grandchild/
-	umount parent2/child2
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test01: FAILED: move: shared child to shared parent."
-	exit 1
-else
-	tst_resm TPASS "move/test01: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test02 b/testcases/kernel/fs/fs_bind/move/test02
deleted file mode 100755
index 18de6d4db..000000000
--- a/testcases/kernel/fs/fs_bind/move/test02
+++ /dev/null
@@ -1,94 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-SETS_DEFAULTS="${TCID=test02} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST02***************"
-tst_resm TINFO "move: shared subtree to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test02 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-
-	mount --bind dir share1
-	mkdir dir/grandchild
-	mkdir parent2/child2
-	mount --move dir parent2/child2
-	mount --bind parent2 share2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check parent2/child2/grandchild share1/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-	check -n share2/child2/grandchild parent2/child2/grandchild
-
-	mount --bind "$disk2" share1/grandchild/a
-
-	check parent2/child2/grandchild/a share1/grandchild/a
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test02: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test02: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/grandchild/a
-	umount share1/grandchild/
-	umount parent2/child2
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test02: FAILED: move: shared subtree to private parent."
-	exit 1
-else
-	tst_resm TPASS "move/test02: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test03 b/testcases/kernel/fs/fs_bind/move/test03
deleted file mode 100755
index e2960e372..000000000
--- a/testcases/kernel/fs/fs_bind/move/test03
+++ /dev/null
@@ -1,97 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test03} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST02***************"
-tst_resm TINFO "move: shared subtree to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test03 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --bind dir share1
-	mount --bind share2 parent2
-	mkdir dir/grandchild
-	mkdir parent2/child2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	mount --move dir parent2/child2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check parent2/child2/grandchild share1/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-	check -n share2/child2/grandchild parent2/child2/grandchild
-
-	mount --bind "$disk2" share1/grandchild/a
-
-	check parent2/child2/grandchild/a share1/grandchild/a
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test03: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test03: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/grandchild/a
-	umount parent2/child2/grandchild
-	umount parent2/child2 # if move succeeded
-	umount dir # if move failed
-	umount parent2
-	umount share1
-	umount share2
-	umount share1
-	umount parent2
-	umount dir
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test03: FAILED: move: shared subtree to slave parent."
-	exit 1
-else
-	tst_resm TPASS "move/test03: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test04 b/testcases/kernel/fs/fs_bind/move/test04
deleted file mode 100755
index 0715d68f5..000000000
--- a/testcases/kernel/fs/fs_bind/move/test04
+++ /dev/null
@@ -1,89 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test04} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST04***************"
-tst_resm TINFO "move: shared subtree to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test04 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-
-	mount --bind dir share1
-	mkdir dir/grandchild
-	mkdir parent2/child2
-	mount --move dir parent2/child2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check parent2/child2/grandchild share1/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-
-	mount --bind "$disk2" share1/grandchild/a
-
-	check parent2/child2/grandchild/a share1/grandchild/a
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test04: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test04: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/grandchild/a
-	umount share1/grandchild/
-	umount parent2/child2
-	umount share1
-	umount share1
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test04: FAILED: move: shared subtree to uncloneable parent."
-	exit 1
-else
-	tst_resm TPASS "move/test04: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test05 b/testcases/kernel/fs/fs_bind/move/test05
deleted file mode 100755
index 21901d0cd..000000000
--- a/testcases/kernel/fs/fs_bind/move/test05
+++ /dev/null
@@ -1,94 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test05} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST05***************"
-tst_resm TINFO "move: private subtree to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test05 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" priv dir
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --bind parent2 share2
-	mkdir dir/grandchild
-	mount --bind dir share1
-	mkdir parent2/child2
-	mount --move dir parent2/child2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check parent2/child2/grandchild share2/child2/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-	check -n share1/grandchild parent2/child2/grandchild
-
-	mount --bind "$disk2" share2/child2/grandchild/a
-
-	check parent2/child2/grandchild/a share2/child2/grandchild/a
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test05: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test05: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/grandchild/a
-	umount parent2/child2/grandchild
-	umount parent2/child2 # if move succeeded
-	umount dir # if move failed
-	umount share1
-	umount share2
-	umount share1
-	umount share2
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test05: FAILED: move: private subtree to shared parent."
-	exit 1
-else
-	tst_resm TPASS "move/test05: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test06 b/testcases/kernel/fs/fs_bind/move/test06
deleted file mode 100755
index a7aed3cf6..000000000
--- a/testcases/kernel/fs/fs_bind/move/test06
+++ /dev/null
@@ -1,88 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test06} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST06***************"
-tst_resm TINFO "move: private subtree to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test06 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" priv dir
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mkdir dir/grandchild
-	mount --bind dir share1
-	mkdir parent2/child2
-	mount --bind parent2 share2
-	mount --move dir parent2/child2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check -n parent2/child2/grandchild share2/child2/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-	check -n share1/grandchild parent2/child2/grandchild
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test06: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test06: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/grandchild
-	umount parent2/child2/
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test06: FAILED: move: private subtree to private parent."
-	exit 1
-else
-	tst_resm TPASS "move/test06: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test07 b/testcases/kernel/fs/fs_bind/move/test07
deleted file mode 100755
index afe81b6eb..000000000
--- a/testcases/kernel/fs/fs_bind/move/test07
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test07} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST07***************"
-tst_resm TINFO "move: private subtree to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test07 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" priv dir
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mkdir dir/grandchild
-	mount --bind dir share1
-	mkdir parent2/child2
-	mount --bind parent2 share2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-	mount --move dir parent2/child2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check -n parent2/child2/grandchild share2/child2/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-	check -n share1/grandchild parent2/child2/grandchild
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test07: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test07: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/grandchild
-	umount parent2/child2 # if move succeeded
-	umount dir # if move did not succeed
-	umount share2
-	umount share1
-	umount share1
-	umount share2
-	umount parent2
-	umount dir
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test07: FAILED: move: private subtree to slave parent."
-	exit 1
-else
-	tst_resm TPASS "move/test07: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test08 b/testcases/kernel/fs/fs_bind/move/test08
deleted file mode 100755
index 21f419b96..000000000
--- a/testcases/kernel/fs/fs_bind/move/test08
+++ /dev/null
@@ -1,85 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test08} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST08***************"
-tst_resm TINFO "move: private subtree to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test08 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" priv dir
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mkdir dir/grandchild
-	mount --bind dir share1
-	mkdir parent2/child2
-	mount --move dir parent2/child2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-	check -n share1/grandchild parent2/child2/grandchild
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test08: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test08: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/grandchild
-	umount parent2/child2 # if move succeeded
-	umount dir # if move failed
-	umount share1
-	umount share1
-	umount parent2
-	umount dir
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test08: FAILED: move: private subtree to uncloneable parent."
-	exit 1
-else
-	tst_resm TPASS "move/test08: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test09 b/testcases/kernel/fs/fs_bind/move/test09
deleted file mode 100755
index 8f7c25456..000000000
--- a/testcases/kernel/fs/fs_bind/move/test09
+++ /dev/null
@@ -1,99 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test09} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST09***************"
-tst_resm TINFO "move: slave subtree to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test09 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --bind parent2 share2
-	mkdir dir/grandchild
-	mount --bind dir share1
-	"${FS_BIND_ROOT}/bin/makedir" slave dir
-	mkdir parent2/child2
-	mount --move dir parent2/child2
-
-	mount --bind "$disk1" parent2/child2/grandchild
-	check parent2/child2/grandchild share2/child2/grandchild
-	check -n dir/grandchild parent2/child2/grandchild
-	check -n share1/grandchild parent2/child2/grandchild
-
-	mount --bind "$disk2" share2/child2/grandchild/a
-
-	check parent2/child2/grandchild/a share2/child2/grandchild/a
-
-	mkdir share1/test
-
-	check parent2/child2 share1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test09: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test09: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/grandchild/a
-	umount parent2/child2/grandchild
-	umount parent2/child2
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount dir
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test09: FAILED: move: slave subtree to shared parent."
-	exit 1
-else
-	tst_resm TPASS "move/test09: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test10 b/testcases/kernel/fs/fs_bind/move/test10
deleted file mode 100755
index 93e203618..000000000
--- a/testcases/kernel/fs/fs_bind/move/test10
+++ /dev/null
@@ -1,100 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test10} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST10***************"
-tst_resm TINFO "move: slave subtree to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test10 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mkdir dir/grandchild
-	mount --bind dir share1
-	"${FS_BIND_ROOT}/bin/makedir" slave dir
-	mkdir parent2/child2
-	mount --bind parent2 share2
-
-	mount --move dir parent2/child2
-	check -n parent2/child2 share2/child2
-
-	mount --bind "$disk1" share1/grandchild
-	check parent2/child2/grandchild share1/grandchild
-	check -n dir/grandchild/ parent2/child2/grandchild
-
-	mount --bind "$disk2" parent2/child2/grandchild/a
-	check -n share1/grandchild/a parent2/child2/grandchild/a
-
-
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test10: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test10: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/grandchild/a
-	umount share1/grandchild # also does umount parent2/child2/grandchild
-	umount parent2/child2
-	umount dir # if move fails
-	umount share2
-	umount share1
-	umount share1
-	umount share2
-	umount parent2
-	umount dir
-
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test10: FAILED: move: slave subtree to private parent."
-	exit 1
-else
-	tst_resm TPASS "move/test10: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test11 b/testcases/kernel/fs/fs_bind/move/test11
deleted file mode 100755
index 9392f9b9d..000000000
--- a/testcases/kernel/fs/fs_bind/move/test11
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test11} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST11***************"
-tst_resm TINFO "move: slave subtree to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test11 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mkdir dir/grandchild
-	mount --bind dir share1
-	"${FS_BIND_ROOT}/bin/makedir" slave dir
-	mkdir parent2/child2
-	mount --bind parent2 share2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	mount --move dir parent2/child2
-	check -n parent2/child2 share2/child2
-
-	mount --bind "$disk1" share1/grandchild
-	check parent2/child2/grandchild share1/grandchild
-	check -n dir/grandchild/ parent2/child2/grandchild
-
-	mount --bind "$disk2" parent2/child2/grandchild/a
-	check -n share1/grandchild/a parent2/child2/grandchild/a
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test11: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test11: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/grandchild/a
-	umount share1/grandchild
-	umount parent2/child2
-	umount dir # if move fails
-	umount share2
-	umount share1
-	umount share1
-	umount share2
-	umount parent2
-	umount dir
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test11: FAILED: move: slave subtree to slave parent."
-	exit 1
-else
-	tst_resm TPASS "move/test11: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test12 b/testcases/kernel/fs/fs_bind/move/test12
deleted file mode 100755
index 0803fb86b..000000000
--- a/testcases/kernel/fs/fs_bind/move/test12
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test12} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST12***************"
-tst_resm TINFO "move: slave subtree to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test12 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mkdir dir/grandchild
-	mount --bind dir share1
-	"${FS_BIND_ROOT}/bin/makedir" slave dir
-	mkdir parent2/child2
-	mount --bind parent2 share2 2> /dev/null && /bin/false || /bin/true #mount should fail
-
-	mount --move dir parent2/child2
-	check -n parent2/child2 share2/child2
-
-	mount --bind "$disk1" share1/grandchild
-	check parent2/child2/grandchild share1/grandchild
-	check -n dir/grandchild/ parent2/child2/grandchild
-
-	mount --bind "$disk2" parent2/child2/grandchild/a
-	check -n share1/grandchild/a parent2/child2/grandchild/a
-
-
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test12: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test12: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/grandchild/a
-	umount share1/grandchild
-	umount parent2/child2
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount dir
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test12: FAILED: move: slave subtree to uncloneable parent."
-	exit 1
-else
-	tst_resm TPASS "move/test12: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test13 b/testcases/kernel/fs/fs_bind/move/test13
deleted file mode 100755
index 7d92c0661..000000000
--- a/testcases/kernel/fs/fs_bind/move/test13
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test13} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST13***************"
-tst_resm TINFO "move: uncloneable subtree to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test13 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone dir
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --bind parent2 share2
-	mkdir dir/grandchild
-	mkdir parent2/child2
-	mount --move dir parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test13: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test13: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir
-	umount parent2/child2
-	umount share2
-	umount share2
-	umount parent2
-	umount dir
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 1 ]
-then
-	tst_resm TFAIL "move/test13: FAILED: move: uncloneable subtree to shared parent."
-	exit 1
-else
-	tst_resm TPASS "move/test13: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test14 b/testcases/kernel/fs/fs_bind/move/test14
deleted file mode 100755
index cc6d114c6..000000000
--- a/testcases/kernel/fs/fs_bind/move/test14
+++ /dev/null
@@ -1,82 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test14} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST14***************"
-tst_resm TINFO "move: uncloneable subtree to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test14 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone dir
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mkdir dir/grandchild
-	mkdir parent2/child2
-	mount --move dir parent2/child2
-
-	mount --bind parent2 share2
-	check  -n parent2/child2/ share2/child2/
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test14: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test14: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share2
-	umount parent2/child2
-	umount dir # if the move fails
-	umount share2
-	umount parent2
-	umount dir
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test14: FAILED: move: uncloneable subtree to private parent."
-	exit 1
-else
-	tst_resm TPASS "move/test14: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test15 b/testcases/kernel/fs/fs_bind/move/test15
deleted file mode 100755
index cf98720a1..000000000
--- a/testcases/kernel/fs/fs_bind/move/test15
+++ /dev/null
@@ -1,82 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test15} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST15***************"
-tst_resm TINFO "move: uncloneable subtree to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test15 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone dir
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --bind parent2 share2
-	mkdir dir/grandchild
-	mkdir parent2/child2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-	mount --move dir parent2/child2
-	check  -n parent2/child2/ share2/child2/
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test15: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test15: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2
-	umount dir # if the move fails
-	umount share2
-	umount share2
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test15: FAILED: move: uncloneable subtree to slave parent."
-	exit 1
-else
-	tst_resm TPASS "move/test15: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test16 b/testcases/kernel/fs/fs_bind/move/test16
deleted file mode 100755
index 4457cb984..000000000
--- a/testcases/kernel/fs/fs_bind/move/test16
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test16} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST16***************"
-tst_resm TINFO "move: uncloneable subtree to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test16 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone dir
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mkdir dir/grandchild
-	mkdir parent2/child2
-
-	mount --move dir parent2/child2
-	result=$?
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test16: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test16: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2
-	umount dir # if the move fails
-	umount share1
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test16: FAILED: move: uncloneable subtree to uncloneable parent."
-	exit 1
-else
-	tst_resm TPASS "move/test16: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test17 b/testcases/kernel/fs/fs_bind/move/test17
deleted file mode 100755
index 093d0a80b..000000000
--- a/testcases/kernel/fs/fs_bind/move/test17
+++ /dev/null
@@ -1,77 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test17} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST17***************"
-tst_resm TINFO "move: tree with shared parent"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test17 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-
-	mkdir parent2/child2
-
-	mount --move parent1/child1 parent2/child2 2> /dev/null || result=$?
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test17: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test17: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1 # if the move failed
-	umount parent2/child2 # if the move succeeded
-	umount parent2
-	umount parent1
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-	tst_resm TFAIL "move/test17: FAILED: move: tree with shared parent - check ERROR."
-	exit 1
-else
-	tst_resm TPASS "move/test17: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test18 b/testcases/kernel/fs/fs_bind/move/test18
deleted file mode 100755
index 91eab3eb0..000000000
--- a/testcases/kernel/fs/fs_bind/move/test18
+++ /dev/null
@@ -1,101 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test18} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST18***************"
-tst_resm TINFO "move: private to private - with shared children "
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test18 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --bind parent1/child1 share1
-	mount --bind "$disk1" parent1/child1
-
-	mount --move parent1 parent2
-
-	check parent2/child1 share1
-
-	#
-	mount --bind "$disk2" parent2/child1/a
-	check parent2/child1/a share1/a
-
-	mount --bind "$disk3" share1/b
-	check parent2/child1/b share1/b
-
-	 umount parent2/child1/a #share1/a
-	check parent2/child1/a share1/a
-
-	 umount parent2/child1/b #share1/b
-	check parent2/child1/b share1/b
-	#
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test18: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test18: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child1
-	umount parent2/child1
-
-	umount parent1/child1
-	umount share1
-
-	umount share1
-	umount parent1/child1
-	umount parent2
-	umount parent1
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test18: FAILED: move: private to private - with shared children "
-	exit 1
-else
-	tst_resm TPASS "move/test18: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test19 b/testcases/kernel/fs/fs_bind/move/test19
deleted file mode 100755
index 44da81929..000000000
--- a/testcases/kernel/fs/fs_bind/move/test19
+++ /dev/null
@@ -1,95 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test19} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST19***************"
-tst_resm TINFO "move: private to private - with slave children "
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test19 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	mkdir parent1/child1
-
-	mount --bind "$disk1" share1
-	mount --bind share1 parent1/child1
-
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	mount --move parent1 parent2
-
-	check parent2/child1 share1
-
-	mount --bind "$disk2" parent2/child1/a
-	check -n parent2/child1/a share1/a
-
-	mount --bind "$disk3" share1/b
-	check parent2/child1/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test19: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test19: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child1/b
-	check -n parent2/child1/b share1/b
-
-	umount parent2/child1/a
-	umount parent2/child1
-	umount share1/b
-	umount share1
-	umount share1
-	umount parent1
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test19: FAILED: move: private to private - with slave children "
-	exit 1
-else
-	tst_resm TPASS "move/test19: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test20 b/testcases/kernel/fs/fs_bind/move/test20
deleted file mode 100755
index 7af2ab054..000000000
--- a/testcases/kernel/fs/fs_bind/move/test20
+++ /dev/null
@@ -1,79 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test20} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST20***************"
-tst_resm TINFO "move: private to private - with unclonable children "
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test20 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-
-	mount --bind "$disk1" parent1/child1
-
-	mount --move parent1 parent2
-
-	check "$disk1" parent2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test20: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test20: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1
-	umount parent2
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test20: FAILED: move: private to private - with unclonable children "
-	exit 1
-else
-	tst_resm TPASS "move/test20: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test21 b/testcases/kernel/fs/fs_bind/move/test21
deleted file mode 100755
index 954e0fb7b..000000000
--- a/testcases/kernel/fs/fs_bind/move/test21
+++ /dev/null
@@ -1,93 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test21} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST21***************"
-tst_resm TINFO "move: shared tree within a tree it is bound to."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test21 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	mkdir parent1 parent2
-	mount --bind "$disk1" parent1
-	mount --make-rshared parent1 > /dev/null 2>&1 || "${FS_BIND_ROOT}/bin/smount" parent1 rshared
-	mount --bind parent1 parent2
-
-	check parent1 parent2
-
-	mount --move parent1 parent2/a
-
-	check parent2 parent2/a parent2/a/a
-
-	mount --bind "$disk2" parent2/b
-
-	check parent2/b parent2/a/b parent2/a/a/b
-
-	mount --bind "$disk3" parent2/a/c
-
-	check parent2/c parent2/a/c parent2/a/a/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test21: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test21: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/a/a/c
-
-	check parent2/c parent2/a/c parent2/a/a/c
-
-	umount parent2/b
-	umount parent2/a/a
-	umount parent2/a
-	umount parent2
-	umount parent1
-
-	rm -rf dir parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test21: FAILED: move: shared tree within a tree it is bound to."
-	exit 1
-else
-	tst_resm TPASS "move/test21: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/move/test22 b/testcases/kernel/fs/fs_bind/move/test22
deleted file mode 100755
index ebdd50a4d..000000000
--- a/testcases/kernel/fs/fs_bind/move/test22
+++ /dev/null
@@ -1,87 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test22} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST22***************"
-tst_resm TINFO "move: shared tree within a tree it is bound to - and then move to another share subtree"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of move/test22 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	mkdir parent1/a parent2
-	mount --bind parent1 parent2
-
-	check parent1 parent2
-
-	mount --move parent1 parent2/a
-
-	check parent2 parent2/a parent2/a/a
-
-	"${FS_BIND_ROOT}/bin/makedir" share tmp1
-	mkdir tmp2 tmp1/1
-
-	mount --bind tmp1 tmp2
-	mount --move parent2  tmp1/1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "move/test22: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "move/test22: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount tmp1/1/a/a
-	umount tmp1/1/a
-	umount tmp1/1
-	umount tmp1
-	umount tmp1
-	umount tmp2
-
-	rm -rf dir parent* tmp1 tmp2
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "move/test22: FAILED: move: shared tree within a tree it is bound to - and then move to another share subtree"
-	exit 1
-else
-	tst_resm TPASS "move/test22: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/00_Descriptions.txt b/testcases/kernel/fs/fs_bind/rbind/00_Descriptions.txt
deleted file mode 100644
index b2d0604f8..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/00_Descriptions.txt
+++ /dev/null
@@ -1,266 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-OO_DESCRIPTION.txt
-==================
-
-The contents of the rbind directory:
-test07-2 - create slave then mount master - slave still propagates
-test01 - shared child to shared parent.
-test02 - shared child to private parent.
-test03 - shared child to slave parent.
-test04 - shared child to unclonable parent.
-test05 - private child to shared parent.
-test06 - private child to private parent.
-test07 - private child to slave parent.
-test08 - private child to uncloneable parent.
-test09 - slave child to shared parent.
-test10 - slave child to private parent.
-test11 - slave child to slave parent.
-test12 - slave child to uncloneable parent.
-test13 - uncloneable child to shared parent.
-test14 - uncloneable child to private parent.
-test15 - uncloneable child to slave parent.
-test16 - uncloneable child to uncloneable parent.
-test17 - shared subtree with shared child to shared subtree.
-test18 - shared subtree with shared child to private subtree.
-test19 - shared subtree with shared child to slave subtree.
-test20 - shared subtree with shared child to uncloneable subtree.
-test21 - shared subtree with  private child to shared subtree.
-test22 - shared subtree with  private child to slave subtree.
-test23 - shared subtree with  private child to private subtree.
-test24 - shared subtree with unclonable child to private subtree.
-test25 - shared subtree with slave child to shared subtree.
-test26 - shared subtree with slave child to private subtree.
-test27 - shared subtree with slave child to slave subtree.
-test28 - shared subtree with slave child to unclone subtree.
-test29 - shared subtree with uncloneable child to shared subtree.
-test30 - shared subtree with uncloneable child to private subtree.
-test31 - shared subtree with uncloneable child to slave subtree.
-test32 - shared subtree with uncloneable child to uncloneable subt
-test33 - multi-level slave p-nodes.
-test34 - rbind within same tree - root to child, child is shared
-test35 - rbind within same tree - root to child, child is private
-test36 - rbind within same tree - root to child, child is unclonea
-test37 - private to private - with shared children.
-test38 - private to private - with slave children.
-test39 - private to private - with unclonable children.
-
-
-test07-2:
-=========
-create slave then mount master - slave still propagates.
-
-
-test01:
-=======
-shared child to shared parent.
-
-
-test02:
-=======
-shared child to private parent.
-
-
-test03:
-=======
-shared child to slave parent.
-
-
-test04:
-=======
-shared child to unclonable parent.
-
-
-test05:
-=======
-private child to shared parent.
-
-
-test06:
-=======
-private child to private parent.
-
-
-test07:
-=======
-private child to slave parent.
-
-
-test08:
-=======
-private child to uncloneable parent.
-
-
-test09:
-=======
-slave child to shared parent.
-
-
-test10:
-=======
-slave child to private parent.
-
-
-test11:
-=======
-slave child to slave parent.
-
-
-test12:
-=======
-slave child to uncloneable parent.
-
-
-test13:
-=======
-uncloneable child to shared parent.
-
-
-test14:
-=======
-uncloneable child to private parent.
-
-
-test15:
-=======
-uncloneable child to slave parent.
-
-
-test16:
-=======
-uncloneable child to uncloneable parent.
-
-
-test17:
-=======
-shared subtree with shared child to shared subtree.
-
-
-test18:
-=======
-shared subtree with shared child to private subtree.
-
-
-test19:
-=======
-shared subtree with shared child to slave subtree.
-
-
-test20:
-=======
-shared subtree with shared child to uncloneable subtree.
-
-
-test21:
-=======
-shared subtree with  private child to shared subtree.
-
-
-test22:
-=======
-shared subtree with  private child to slave subtree.
-
-
-test23:
-=======
-shared subtree with  private child to private subtree.
-
-
-test24:
-=======
-shared subtree with unclonable child to private subtree.
-
-
-test25:
-=======
-shared subtree with slave child to shared subtree.
-
-
-test26:
-=======
-shared subtree with slave child to private subtree.
-
-
-test27:
-=======
-shared subtree with slave child to slave subtree.
-
-
-test28:
-=======
-shared subtree with slave child to unclone subtree.
-
-
-test29:
-=======
-shared subtree with uncloneable child to shared subtree.
-
-
-test30:
-=======
-shared subtree with uncloneable child to private subtree.
-
-
-test31:
-=======
-shared subtree with uncloneable child to slave subtree.
-
-
-test32:
-=======
-shared subtree with uncloneable child to uncloneable subtree.
-
-
-test33:
-=======
-multi-level slave p-nodes.
-
-
-test34:
-=======
-rbind within same tree - root to child, child is shared
-
-
-test35:
-=======
-rbind within same tree - root to child, child is private
-
-
-test36:
-=======
-rbind within same tree - root to child, child is uncloneable
-
-
-test37:
-=======
-private to private - with shared children.
-
-
-test38:
-=======
-private to private - with slave children.
-
-
-test39:
-=======
-private to private - with unclonable children.
-
-
diff --git a/testcases/kernel/fs/fs_bind/rbind/Makefile b/testcases/kernel/fs/fs_bind/rbind/Makefile
new file mode 100644
index 000000000..48233262e
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2009, Cisco Systems Inc.
+# Ngie Cooper, July 2009
+
+top_srcdir			?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS			:= fs_bind*
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh
new file mode 100755
index 000000000..aee6f2bf5
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared child to shared parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent2 share2
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent2 share2
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check parent1/child1/a parent2/child2/a share2/child2/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check parent1/child1/b parent2/child2/b share2/child2/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh
new file mode 100755
index 000000000..0a2ce7949
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared child to private parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 share1
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 share1
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check parent1/child1/a parent2/child2/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check parent1/child1/b parent2/child2/b share1/b
+
+
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh
new file mode 100755
index 000000000..86a930735
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared child to slave parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+	mkdir parent2
+
+	EXPECT_PASS mount --rbind parent1/child1 share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" share2
+	EXPECT_PASS mount --rbind share2 parent2
+	EXPECT_PASS mount --make-rslave parent2
+
+	fs_bind_check share2 parent2
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 share1
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 share1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent1/child1/a
+
+	fs_bind_check parent1/child1/a parent2/child2/a share1/a
+	fs_bind_check -n parent2/child2 share2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent2/child2 share2/child2
+	fs_bind_check parent1/child1/b parent2/child2/b share1/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh
new file mode 100755
index 000000000..27c2d2148
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared child to unclonable parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 share1
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 share1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check parent1/child1/a parent2/child2/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check parent1/child1/b parent2/child2/b share1/b
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/c
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount parent1/child1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh
new file mode 100755
index 000000000..7c6bc3e00
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: private child to shared parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --rbind parent1 share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent2 share2
+
+	fs_bind_check -n  parent1/child1 share1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 parent2/child2 share2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check parent2/child2/c share2/child2/c
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share2/child2/c
+
+	fs_bind_check -n parent1/child1/c parent2/child2/c
+	fs_bind_check parent2/child2/c share2/child2/c
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount share2/child2/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh
new file mode 100755
index 000000000..32905196a
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: private child to private parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --rbind parent1 share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+
+	fs_bind_check -n  parent1/child1 share1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check -n  parent1/child1 share1/child1
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh
new file mode 100755
index 000000000..11db71998
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: create slave then mount master - slave still propagates"
+
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --rbind share2 parent2
+	EXPECT_PASS mount --make-rslave parent2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share2
+
+	fs_bind_check parent2 share2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent2/a
+
+	fs_bind_check -n parent2/a share2/a
+
+
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh
new file mode 100755
index 000000000..79e16dec5
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: private child to slave parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --rbind parent1 share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+
+	fs_bind_check -n  parent1/child1 share1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" share2
+	EXPECT_PASS mount --rbind share2 parent2
+	EXPECT_PASS mount --make-rslave parent2
+
+	mkdir parent2/child2
+	fs_bind_check parent2 share2
+
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 parent2/child2
+	fs_bind_check -n parent2/child2 share2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check -n  parent1/child1 share1/child1
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh
new file mode 100755
index 000000000..f7e403608
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: private child to uncloneable parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --rbind parent1 share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+
+	fs_bind_check -n  parent1/child1 share1/child1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check -n  parent1/child1 share1/child1
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh
new file mode 100755
index 000000000..cc06aad8c
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: slave child to shared parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --rbind parent2 share2
+	EXPECT_PASS mount --rbind share1 parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --make-rslave parent1/child1
+
+	fs_bind_check parent1/child1 share1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check parent2/child2/b share2/child2/b
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/c
+	fs_bind_check share1/c parent1/child1/c
+	fs_bind_check parent1/child1/c parent2/child2/c
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh
new file mode 100755
index 000000000..e74670e6a
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: slave child to private parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --rbind share1 parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --make-rslave parent1/child1
+
+	fs_bind_check parent1/child1 share1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/c
+	fs_bind_check share1/c parent1/child1/c
+	fs_bind_check parent1/child1/c parent2/child2/c
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh
new file mode 100755
index 000000000..b5e2213a1
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: slave child to slave parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --rbind parent2 share2
+	EXPECT_PASS mount --rbind share1 parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" share2
+	EXPECT_PASS mount --make-rslave parent1/child1
+	EXPECT_PASS mount --make-rslave parent2
+
+	mkdir parent2/child2
+
+	fs_bind_check parent1/child1 share1
+	fs_bind_check parent2 share2
+
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+	fs_bind_check -n parent2/child2 share2/child2
+
+	EXPECT_PASS umount parent2/child2/b
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/c
+	fs_bind_check share1/c parent1/child1/c
+	fs_bind_check parent1/child1/c parent2/child2/c
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh
new file mode 100755
index 000000000..5e908e666
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: slave child to uncloneable parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --rbind share1 parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --make-rslave parent1/child1
+
+	fs_bind_check parent1/child1 share1
+
+	mkdir parent2/child2
+
+	EXPECT_PASS mount --rbind parent1/child1 parent2/child2
+
+	fs_bind_check parent1/child1 parent2/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n  parent1/child1/a parent2/child2/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child2/b
+
+	fs_bind_check -n parent1/child1/b parent2/child2/b
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/c
+	fs_bind_check share1/c parent1/child1/c
+	fs_bind_check parent1/child1/c parent2/child2/c
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child2/b
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child2
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh
new file mode 100755
index 000000000..5a6775e4f
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: uncloneable child to shared parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir runbindable parent1/child1
+	mkdir parent1/child1/x
+
+	EXPECT_PASS mount --rbind parent1 share1
+	EXPECT_PASS mount --rbind parent2 share2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1/x
+	mkdir parent2/child2
+	EXPECT_FAIL mount --rbind parent1/child1 parent2/child2
+
+
+	EXPECT_PASS umount parent1/child1/x
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh
new file mode 100755
index 000000000..164ded501
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: uncloneable child to private parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir runbindable parent1/child1
+	mkdir parent1/child1/x
+
+	EXPECT_PASS mount --rbind parent1 share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1/x
+	mkdir parent2/child2
+	EXPECT_FAIL mount --rbind parent1/child1 parent2/child2
+
+
+	EXPECT_PASS umount parent1/child1/x
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh
new file mode 100755
index 000000000..086767f9c
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: uncloneable child to slave parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir runbindable parent1/child1
+	mkdir parent1/child1/x
+
+	EXPECT_PASS mount --rbind parent1 share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1/x
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" share2
+	EXPECT_PASS mount --rbind share2 parent2
+	EXPECT_PASS mount --make-rslave parent2
+
+	fs_bind_check parent2 share2
+
+	mkdir parent2/child2
+	EXPECT_FAIL mount --rbind parent1/child1 parent2/child2
+
+
+	EXPECT_PASS umount parent1/child1/x
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh
new file mode 100755
index 000000000..8cb193e21
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: uncloneable child to uncloneable parent"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir runbindable parent1/child1
+	mkdir parent1/child1/x
+
+	EXPECT_PASS mount --rbind parent1 share1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1/x
+
+	mkdir parent2/child2
+	EXPECT_FAIL mount --rbind parent1/child1 parent2/child2
+
+
+	EXPECT_PASS umount parent1/child1/x
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh
new file mode 100755
index 000000000..f5bff11a2
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with shared child to shared subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --rbind share1 parent1
+
+	fs_bind_makedir rshared parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 share1 parent2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1
+	fs_bind_check parent1/child1 parent2/child1
+	fs_bind_check parent1/child1 share1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/a
+
+	fs_bind_check parent1/a parent2/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/b
+
+	fs_bind_check parent1/b parent2/b share1/b
+
+
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh
new file mode 100755
index 000000000..94ffe947c
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with shared child to private subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --rbind share1 parent1
+
+	fs_bind_makedir rshared parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 share1 parent2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1
+	fs_bind_check parent1/child1 parent2/child1
+	fs_bind_check parent1/child1 share1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/a
+
+	fs_bind_check parent1/a parent2/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/b
+
+	fs_bind_check parent1/b parent2/b share1/b
+
+
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh
new file mode 100755
index 000000000..527f69ae8
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with shared child to slave subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --rbind share1 parent1
+	EXPECT_PASS mount --rbind share2 parent2
+	EXPECT_PASS mount --make-rslave parent2
+
+	fs_bind_makedir rshared parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+	fs_bind_check parent1 share1 parent2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1
+	fs_bind_check parent1/child1 parent2/child1
+	fs_bind_check parent1/child1 share1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/a
+
+	fs_bind_check parent1/a parent2/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/b
+
+	fs_bind_check parent1/b parent2/b share1/b
+
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh
new file mode 100755
index 000000000..4e35487f4
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with shared child to uncloneable subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" share1
+	EXPECT_PASS mount --rbind share1 parent1
+
+	fs_bind_makedir rshared parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 share1 parent2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1
+	fs_bind_check parent1/child1 parent2/child1
+	fs_bind_check parent1/child1 share1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/a
+
+	fs_bind_check parent1/a parent2/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/b
+
+	fs_bind_check parent1/b parent2/b share1/b
+
+
+	EXPECT_PASS umount share1/b
+	EXPECT_PASS umount parent2/a
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh
new file mode 100755
index 000000000..a1cb90b46
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with  private child to shared subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --rbind share1 parent1
+	EXPECT_PASS mount --rbind share2 parent2
+
+	fs_bind_makedir private parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 share1 parent2 share2
+	fs_bind_check parent1/child1/ parent2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n parent1/child1/a parent2/child1/a
+	fs_bind_check -n parent1/child1/a share1/child1/a
+	fs_bind_check parent2/child1/a share2/child1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child1/b
+
+	fs_bind_check -n parent1/child1/b parent2/child1/b
+	fs_bind_check parent2/child1/b share2/child1/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child1/b
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh
new file mode 100755
index 000000000..7ed13787a
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with  private child to slave subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --rbind share2 parent2
+	EXPECT_PASS mount --make-rslave parent2
+	fs_bind_makedir private parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1/ parent2/child1
+	fs_bind_check -n parent2 share2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n parent1/child1/a parent2/child1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child1/b
+
+	fs_bind_check -n parent1/child1/b parent2/child1/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child1/b
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh
new file mode 100755
index 000000000..a36e47938
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with  private child to private subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+	EXPECT_PASS mount --rbind parent1 share1
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1/ parent2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n parent1/child1/a share1/child1/a
+	fs_bind_check -n parent1/child1/a parent2/child1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child1/b
+
+	fs_bind_check -n parent1/child1/b parent2/child1/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child1/b
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh
new file mode 100755
index 000000000..73cc9bada
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with unclonable child to private subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir private parent1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+	EXPECT_PASS mount --rbind parent1 share1
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1/ parent2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n parent1/child1/a share1/child1/a
+	fs_bind_check -n parent1/child1/a parent2/child1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child1/b
+
+	fs_bind_check -n parent1/child1/b parent2/child1/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child1/b
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh
new file mode 100755
index 000000000..717a9381e
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with slave child to shared subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	mkdir parent1/child1
+
+	EXPECT_PASS mount --bind share1 parent1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --make-rslave parent1/child1
+
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1/ parent2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n parent1/child1/a parent2/child1/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child1/b
+
+	fs_bind_check -n parent1/child1/b parent2/child1/b
+	fs_bind_check -n parent2/child1/b share1/b
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" share1/c
+	fs_bind_check parent2/child1/c share1/c
+	fs_bind_check parent1/child1/c share1/c
+
+
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child1/b
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh
new file mode 100755
index 000000000..9472f6926
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with slave child to private subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind share1 parent1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --make-rslave parent1/child1
+
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1/ parent2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n parent1/child1/a parent2/child1/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child1/b
+
+	fs_bind_check -n parent1/child1/b parent2/child1/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child1/b
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh
new file mode 100755
index 000000000..687230a26
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with slave child to slave subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind share1 parent1/child1
+	EXPECT_PASS mount --bind share2 parent2
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --make-rslave parent1/child1
+	EXPECT_PASS mount --make-rslave parent2
+
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1/ parent2/child1
+	fs_bind_check -n parent2 share2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n parent1/child1/a parent2/child1/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child1/b
+
+	fs_bind_check -n parent1/child1/b parent2/child1/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child1/b
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh
new file mode 100755
index 000000000..828c5b94c
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with slave child to unclone subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared parent1/child1
+
+	EXPECT_PASS mount --bind share1 parent1/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --make-rslave parent1/child1
+
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1/ parent2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" parent1/child1/a
+
+	fs_bind_check -n parent1/child1/a parent2/child1/a
+	fs_bind_check -n parent1/child1/a share1/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent2/child1/b
+
+	fs_bind_check -n parent1/child1/b parent2/child1/b
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent2/child1/b
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh
new file mode 100755
index 000000000..105ad353e
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with uncloneable child to shared subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir rshared parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --rbind share1 parent1
+	EXPECT_PASS mount --rbind share2 parent2
+
+	fs_bind_makedir runbindable parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check -n parent1/child1 share1/child1
+	fs_bind_check -n parent1/child1 parent2/child1
+	fs_bind_check parent2/child1 share2/child1
+
+
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh
new file mode 100755
index 000000000..09df7002c
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with uncloneable child to private subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --rbind share1 parent1
+
+	fs_bind_makedir runbindable parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check -n parent1/child1 share1/child1
+	fs_bind_check -n parent1/child1 parent2/child1
+
+
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh
new file mode 100755
index 000000000..e34952886
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with uncloneable child to slave subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir private parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+
+	EXPECT_PASS mount --rbind share1 parent1
+	EXPECT_PASS mount --rbind share2 parent2
+
+	EXPECT_PASS mount --make-rslave parent2
+
+	fs_bind_makedir runbindable parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check -n parent1/child1 share1/child1
+	fs_bind_check -n parent1/child1 parent2/child1
+	fs_bind_check -n parent2 share2
+
+
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh
new file mode 100755
index 000000000..3d68283c0
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: shared subtree with uncloneable child to uncloneable subtree"
+
+	fs_bind_makedir rshared parent1
+	fs_bind_makedir runbindable parent2
+	fs_bind_makedir rshared share1
+
+	EXPECT_PASS mount --rbind share1 parent1
+
+	fs_bind_makedir runbindable parent1/child1
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check -n parent1/child1 share1/child1
+	fs_bind_check -n parent1/child1 parent2/child1
+
+
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount parent1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent1
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
new file mode 100755
index 000000000..964acce18
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: multi-level slave p-nodes"
+
+	fs_bind_makedir rshared dir1
+
+	mkdir dir1/x dir2 dir3 dir4
+
+	EXPECT_PASS mount --rbind dir1 dir2
+	EXPECT_PASS mount --make-rslave dir2
+	EXPECT_PASS mount --make-share dir2
+
+	EXPECT_PASS mount --rbind dir2 dir3
+	EXPECT_PASS mount --make-rslave dir3
+	EXPECT_PASS mount --make-share dir3
+
+	EXPECT_PASS mount --rbind dir3 dir4
+	EXPECT_PASS mount --make-rslave dir4
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK1" dir1/x
+
+	fs_bind_check dir1/x dir2/x dir3/x dir4/x
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK2" dir2/x/a
+	fs_bind_check -n dir1/x/a dir2/x/a
+	fs_bind_check dir2/x/a dir3/x/a dir4/x/a
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" dir3/x/b
+	fs_bind_check -n dir1/x/b dir3/x/b
+	fs_bind_check -n dir2/x/b dir3/x/b
+	fs_bind_check dir3/x/b dir4/x/b
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" dir4/x/c
+	fs_bind_check -n dir1/x/c dir4/x/c
+	fs_bind_check -n dir2/x/c dir4/x/c
+	fs_bind_check -n dir3/x/c dir4/x/c
+
+
+	EXPECT_PASS umount dir2/x/a
+	EXPECT_PASS umount dir3/x/b
+	EXPECT_PASS umount dir4/x/c
+	EXPECT_PASS umount dir1/x
+	EXPECT_PASS umount dir1
+	EXPECT_PASS umount dir2
+	EXPECT_PASS umount dir3
+	EXPECT_PASS umount dir4
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh
new file mode 100755
index 000000000..c421432b9
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: rbind within same tree - root to child, child is shared "
+
+	fs_bind_makedir rshared parent
+	fs_bind_makedir rshared parent/child1
+	fs_bind_makedir rshared parent/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent/child1
+
+	EXPECT_PASS mount --rbind parent parent/child2/
+	fs_bind_check parent parent/child2/
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child2/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" parent/child2/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+
+	EXPECT_PASS umount parent/child2/child2
+	EXPECT_PASS umount parent/child2
+	EXPECT_PASS umount parent
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh
new file mode 100755
index 000000000..f14168d34
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: rbind within same tree - root to child, child is private "
+
+	fs_bind_makedir rshared parent
+	fs_bind_makedir private parent/child1
+	fs_bind_makedir rshared parent/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent/child1
+
+	EXPECT_PASS mount --rbind parent parent/child2/
+	fs_bind_check parent parent/child2/
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child2/child1
+	#added -n
+	fs_bind_check -n parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" parent/child2/child1
+	fs_bind_check -n parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child2/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+
+	EXPECT_PASS umount parent/child2/child2
+	EXPECT_PASS umount parent/child2/child1
+	EXPECT_PASS umount parent/child2
+	EXPECT_PASS umount parent/child2
+	EXPECT_PASS umount parent
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh
new file mode 100755
index 000000000..8e90974b9
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: rbind within same tree - root to child, child is uncloneable"
+
+	fs_bind_makedir rshared parent
+	fs_bind_makedir runbindable parent/child1
+	fs_bind_makedir rshared parent/child2
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK3" parent/child1
+
+	EXPECT_PASS mount --rbind parent parent/child2/
+	fs_bind_check parent parent/child2/
+	fs_bind_check -n  parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+	EXPECT_PASS mount --rbind "$FS_BIND_DISK4" parent/child2/child1
+	fs_bind_check -n  parent/child1 parent/child2/child1
+
+	EXPECT_PASS umount parent/child2/child1
+	fs_bind_check parent/child1 parent/child2/child1
+
+
+	EXPECT_PASS umount parent/child2/child2
+	EXPECT_PASS umount parent/child1
+	EXPECT_PASS umount parent/child2
+	EXPECT_PASS umount parent
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh
new file mode 100755
index 000000000..726fbf0eb
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: private to private - with shared children"
+
+	mkdir parent1 parent2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	fs_bind_makedir rshared parent1/child1
+	fs_bind_makedir rshared parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+	EXPECT_PASS mount --rbind parent1/child1 share1
+
+	EXPECT_PASS mount --rbind parent2/child2 share2
+
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1 parent2/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" parent2/child1/a
+	fs_bind_check parent1/child1/a parent2/child1/a share1//a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent1/child1/b
+	fs_bind_check parent1/child1/b parent2/child1/b share1/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" share1/c
+	fs_bind_check parent1/child1/c parent2/child1/c share1/c
+
+
+	EXPECT_PASS umount parent1/child1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount share1/c
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount parent2/child2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh
new file mode 100755
index 000000000..8861230b7
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: private to private - with slave children"
+
+	mkdir parent1 parent2 parent1/child1 parent2/child2
+	fs_bind_makedir rshared share1
+	fs_bind_makedir rshared share2
+	EXPECT_PASS mount --rbind share1 parent1/child1
+	EXPECT_PASS mount --rbind share2 parent2/child2
+	EXPECT_PASS mount --make-rslave parent1/child1
+	EXPECT_PASS mount --make-rslave parent2/child2
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" share1
+
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 parent2
+	fs_bind_check parent1/child1 parent2/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK2" share1/a
+	fs_bind_check parent1/child1/a parent2/child1/a share1/a
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK3" parent1/child1/b
+	fs_bind_check -n parent1/child1/b share1/b
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK4" parent2/child1/c
+	fs_bind_check -n parent2/child1/c share1/c
+
+
+	EXPECT_PASS umount share1/a
+	EXPECT_PASS umount parent1/child1/b
+	EXPECT_PASS umount parent2/child1/c
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2/child1
+	EXPECT_PASS umount parent2
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share1
+	EXPECT_PASS umount share2
+	EXPECT_PASS umount parent2/child2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh
new file mode 100755
index 000000000..697c7dd00
--- /dev/null
+++ b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2005
+# Copyright (c) 2021 Joerg Vehlow <joerg.vehlow@aox-tech.de>
+# Author: Avantika Mathur (mathurav@us.ibm.com)
+
+FS_BIND_TESTFUNC=test
+
+. fs_bind_lib.sh
+
+test()
+{
+	tst_res TINFO "rbind: private to private - with unclonable children"
+
+	mkdir parent1 parent2
+	fs_bind_makedir runbindable parent1/child1
+
+	EXPECT_PASS mount --bind "$FS_BIND_DISK1" parent1/child1
+
+	EXPECT_PASS mount --rbind parent1 parent2
+
+	fs_bind_check parent1 parent2
+	fs_bind_check -n parent1/child1 parent2/child1
+
+
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent1/child1
+	EXPECT_PASS umount parent2
+}
+
+tst_run
diff --git a/testcases/kernel/fs/fs_bind/rbind/test01 b/testcases/kernel/fs/fs_bind/rbind/test01
deleted file mode 100755
index cb574adb6..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test01
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test01} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST01***************"
-tst_resm TINFO "rbind: shared child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test01 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --rbind "$disk1" parent1/child1
-
-	mkdir parent2/child2
-
-	mount --rbind parent2 share2
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent2 share2
-	check parent1/child1 parent2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check parent1/child1/a parent2/child2/a share2/child2/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check parent1/child1/b parent2/child2/b share2/child2/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test01: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test01: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent1/child1/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test01: FAILED: rbind: shared child to shared parent."
-	exit 1
-else
-	tst_resm TPASS "rbind/test01: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test02 b/testcases/kernel/fs/fs_bind/rbind/test02
deleted file mode 100755
index f68f69104..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test02
+++ /dev/null
@@ -1,97 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test02} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST02***************"
-tst_resm TINFO "rbind: shared child to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test02 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --rbind "$disk1" parent1/child1
-
-	mkdir parent2/child2
-
-	mount --rbind parent1/child1 share1
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 share1
-	check parent1/child1 parent2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check parent1/child1/a parent2/child2/a share1/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check parent1/child1/b parent2/child2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test02: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test02: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/b
-	umount parent1/child1/a
-	umount parent2/child2
-	umount share1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount parent2
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test02: FAILED: rbind: shared child to private parent."
-	exit 1
-else
-	tst_resm TPASS "rbind/test02: PASSED"
-	exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test03 b/testcases/kernel/fs/fs_bind/rbind/test03
deleted file mode 100755
index 6838ffc2a..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test03
+++ /dev/null
@@ -1,118 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test03} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST03***************"
-tst_resm TINFO "rbind: shared child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test03 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	mkdir parent2
-
-	mount --rbind parent1/child1 share1
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind "$disk2" share2
-	mount --rbind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	"${FS_BIND_ROOT}/bin/check_prop" share2 parent2
-
-
-	mkdir parent2/child2
-	ls share2
-
-	mount --rbind parent1/child1 share1
-	mount --rbind parent1/child1 parent2/child2
-
-	"${FS_BIND_ROOT}/bin/check_prop" parent1/child1 share1 parent2/child2
-
-	mount --rbind "$disk3" parent1/child1/a
-
-	"${FS_BIND_ROOT}/bin/check_prop" parent1/child1/a parent2/child2/a share1/a
-	"${FS_BIND_ROOT}/bin/check_prop" -n parent2/child2 share2/child2
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	"${FS_BIND_ROOT}/bin/check_prop" -n parent2/child2 share2/child2
-	"${FS_BIND_ROOT}/bin/check_prop" parent1/child1/b parent2/child2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test03: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test03: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent1/child1/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share2
-	umount share2
-	umount share2
-	umount parent1
-	umount parent2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test03: FAILED: rbind: shared child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test03: PASSED"
-        exit 0
-fi
-
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test04 b/testcases/kernel/fs/fs_bind/rbind/test04
deleted file mode 100755
index 5cdd920c8..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test04
+++ /dev/null
@@ -1,104 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test04} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-
-tst_resm TINFO "***************TEST04***************"
-tst_resm TINFO "rbind: shared child to unclonable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test04 failed" && tst_exit)
-export result=0
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --rbind "$disk1" parent1/child1
-
-	mkdir parent2/child2
-
-	mount --rbind parent1/child1 share1
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 share1 parent2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check parent1/child1/a parent2/child2/a share1/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check parent1/child1/b parent2/child2/b share1/b
-
-	mount --rbind "$disk4" share1/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test04: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test04: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent1/child1/b
-	umount parent1/child1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test04: FAILED: rbind: shared child to unclonable parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test04: PASSED"
-        exit 0
-fi
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test05 b/testcases/kernel/fs/fs_bind/rbind/test05
deleted file mode 100755
index a23cbc198..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test05
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test05} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST05***************"
-tst_resm TINFO "rbind: private child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test05 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --rbind parent1 share1
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent2 share2
-
-	check -n  parent1/child1 share1/child1
-
-	mkdir parent2/child2
-
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2 share2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check parent2/child2/c share2/child2/c
-
-	mount --rbind "$disk4" share2/child2/c
-
-	check -n parent1/child1/c parent2/child2/c
-	check parent2/child2/c share2/child2/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test05: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test05: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount share2/child2/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test05: FAILED: rbind: private child to shared parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test05: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test06 b/testcases/kernel/fs/fs_bind/rbind/test06
deleted file mode 100755
index 71efc5477..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test06
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test06} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST06***************"
-tst_resm TINFO "rbind: private child to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test06 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --rbind parent1 share1
-	mount --rbind "$disk1" parent1/child1
-
-	check -n  parent1/child1 share1/child1
-
-	mkdir parent2/child2
-
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check -n  parent1/child1 share1/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test06: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test06: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test06: FAILED: rbind: private child to private parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test06: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test07 b/testcases/kernel/fs/fs_bind/rbind/test07
deleted file mode 100755
index c35b1e093..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test07
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test07} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST07***************"
-tst_resm TINFO "rbind: private child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test07 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --rbind parent1 share1
-	mount --rbind "$disk1" parent1/child1
-
-	check -n  parent1/child1 share1/child1
-
-	mount --rbind "$disk2" share2
-	mount --rbind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-	#mount --rbind "$disk2" share2
-
-	mkdir parent2/child2
-	check parent2 share2
-
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-	check -n parent2/child2 share2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check -n  parent1/child1 share1/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test07: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test07: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test07: FAILED: rbind: private child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test07: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test07-2 b/testcases/kernel/fs/fs_bind/rbind/test07-2
deleted file mode 100755
index 580bb0e9c..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test07-2
+++ /dev/null
@@ -1,69 +0,0 @@
-#!/bin/bash
-
-SETS_DEFAULTS="${TCID=test07-2} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST07***************"
-tst_resm TINFO "rbind: create slave then mount master - slave still propagates."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test07-2 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --rbind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-	mount --rbind "$disk1" share2
-
-	check parent2 share2
-
-	mount --rbind "$disk2" parent2/a
-
-	check -n parent2/a share2/a
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test07-2: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test07-2: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/a
-	umount parent2
-	umount parent2
-	umount parent2
-
-	umount share2
-	umount share2
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test07-2: FAILED: rbind: create slave then mount master - slave still propagates."
-        exit 1
-else
-        tst_resm TPASS "rbind/test07-2: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test08 b/testcases/kernel/fs/fs_bind/rbind/test08
deleted file mode 100755
index 3aa1851b2..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test08
+++ /dev/null
@@ -1,103 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-SETS_DEFAULTS="${TCID=test08} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST08***************"
-tst_resm TINFO "rbind: private child to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test08 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --rbind parent1 share1
-	mount --rbind "$disk1" parent1/child1
-
-	check -n  parent1/child1 share1/child1
-
-	mkdir parent2/child2
-
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check -n  parent1/child1 share1/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test08: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test08: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test08: FAILED: rbind: private child to uncloneable parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test08: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test09 b/testcases/kernel/fs/fs_bind/rbind/test09
deleted file mode 100755
index 9b9555ad4..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test09
+++ /dev/null
@@ -1,113 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test09} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST09***************"
-tst_resm TINFO "rbind: slave child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test09 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --rbind parent2 share2
-	mount --rbind share1 parent1/child1
-	mount --rbind "$disk1" share1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	check parent1/child1 share1
-
-	mkdir parent2/child2
-
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-	check -n parent1/child1/a share1/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check parent2/child2/b share2/child2/b
-
-	mount --rbind "$disk4" share1/c
-	check share1/c parent1/child1/c
-	check parent1/child1/c parent2/child2/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test09: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test09: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount share1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test09: FAILED: rbind: slave child to shared parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test09: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test10 b/testcases/kernel/fs/fs_bind/rbind/test10
deleted file mode 100755
index 5e2450978..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test10
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test10} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST10***************"
-tst_resm TINFO "rbind: slave child to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test10 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --rbind share1 parent1/child1
-	mount --rbind "$disk1" share1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	check parent1/child1 share1
-
-	mkdir parent2/child2
-
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-	check -n parent1/child1/a share1/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-
-	mount --rbind "$disk4" share1/c
-	check share1/c parent1/child1/c
-	check parent1/child1/c parent2/child2/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test10: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test10: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount share1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test10: FAILED: rbind: slave child to private parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test10: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test11 b/testcases/kernel/fs/fs_bind/rbind/test11
deleted file mode 100755
index d79c0971f..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test11
+++ /dev/null
@@ -1,117 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test11} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST11***************"
-tst_resm TINFO "rbind: slave child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test11 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --rbind parent2 share2
-	mount --rbind share1 parent1/child1
-	mount --rbind "$disk1" share1
-	mount --rbind "$disk2" share2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	mkdir parent2/child2
-
-	check parent1/child1 share1
-	check parent2 share2
-
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --rbind "$disk3" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-	check -n parent1/child1/a share1/a
-
-	mount --rbind "$disk4" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-	check -n parent2/child2 share2/child2
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test11: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test11: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent2/child2/b
-
-	mount --rbind "$disk4" share1/c
-	check share1/c parent1/child1/c
-	check parent1/child1/c parent2/child2/c
-
-	umount parent1/child1/a
-	umount share1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1
-	umount parent2
-	umount parent2
-	umount parent2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test11: FAILED: rbind: slave child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test11: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test12 b/testcases/kernel/fs/fs_bind/rbind/test12
deleted file mode 100755
index dfe5a2ae7..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test12
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test12} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST12***************"
-tst_resm TINFO "rbind: slave child to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test12 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --rbind share1 parent1/child1
-	mount --rbind "$disk1" share1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	check parent1/child1 share1
-
-	mkdir parent2/child2
-
-	mount --rbind parent1/child1 parent2/child2
-
-	check parent1/child1 parent2/child2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n  parent1/child1/a parent2/child2/a
-	check -n parent1/child1/a share1/a
-
-	mount --rbind "$disk3" parent2/child2/b
-
-	check -n parent1/child1/b parent2/child2/b
-
-	mount --rbind "$disk4" share1/c
-	check share1/c parent1/child1/c
-	check parent1/child1/c parent2/child2/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test12: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test12: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child2/b
-	umount share1/c
-	umount parent2/child2
-	umount parent1/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount share1
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test12: FAILED: rbind: slave child to uncloneable parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test12: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test13 b/testcases/kernel/fs/fs_bind/rbind/test13
deleted file mode 100755
index 4069741e4..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test13
+++ /dev/null
@@ -1,94 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test13} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST13***************"
-tst_resm TINFO "rbind: uncloneable child to shared parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test13 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mkdir parent1/child1/x
-
-	mount --rbind parent1 share1
-	mount --rbind parent2 share2
-	mount --rbind "$disk1" parent1/child1/x
-	mkdir parent2/child2
-	mount --rbind parent1/child1 parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test13: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test13: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/x
-	umount parent1/child1
-
-	rm -rf parent1/child1
-	rm -rf parent2/child2
-
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-        tst_resm TFAIL "rbind/test13: FAILED: rbind: uncloneable child to shared parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test13: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test14 b/testcases/kernel/fs/fs_bind/rbind/test14
deleted file mode 100755
index 0b6033450..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test14
+++ /dev/null
@@ -1,86 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test14} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST14***************"
-tst_resm TINFO "rbind: uncloneable child to private parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test14 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mkdir parent1/child1/x
-
-	mount --rbind parent1 share1
-	mount --rbind "$disk1" parent1/child1/x
-	mkdir parent2/child2
-	mount --rbind parent1/child1 parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test14: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test14: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/x
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-        tst_resm TFAIL "rbind/test14: FAILED: rbind: uncloneable child to private parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test14: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test15 b/testcases/kernel/fs/fs_bind/rbind/test15
deleted file mode 100755
index 79ba31195..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test15
+++ /dev/null
@@ -1,97 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test15} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST15***************"
-tst_resm TINFO "rbind: uncloneable child to slave parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test15 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mkdir parent1/child1/x
-
-	mount --rbind parent1 share1
-	mount --rbind "$disk1" parent1/child1/x
-	mount --rbind "$disk2" share2
-	mount --rbind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	check parent2 share2
-
-	mkdir parent2/child2
-	mount --rbind parent1/child1 parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test15: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test15: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/x
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount share2
-	umount share2
-	umount share2
-	umount parent2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-        tst_resm TFAIL "rbind/test15: FAILED: rbind: uncloneable child to slave parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test15: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test16 b/testcases/kernel/fs/fs_bind/rbind/test16
deleted file mode 100755
index b916ec68d..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test16
+++ /dev/null
@@ -1,87 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test16} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST16***************"
-tst_resm TINFO "rbind: uncloneable child to uncloneable parent."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test16 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mkdir parent1/child1/x
-
-	mount --rbind parent1 share1
-	mount --rbind "$disk1" parent1/child1/x
-
-	mkdir parent2/child2
-	mount --rbind parent1/child1 parent2/child2 2> /dev/null || result=$? # mount should fail
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test16: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test16: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/x
-	umount parent1/child1
-	umount share1
-	umount share1
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -eq 0 ]
-then
-        tst_resm TFAIL "rbind/test16: FAILED: rbind: uncloneable child to uncloneable parent."
-        exit 1
-else
-        tst_resm TPASS "rbind/test16: PASSED"
-        exit 0
-fi
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test17 b/testcases/kernel/fs/fs_bind/rbind/test17
deleted file mode 100755
index fbf83f599..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test17
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test17} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST17***************"
-tst_resm TINFO "rbind: shared subtree with shared child to shared subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test17 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --rbind "$disk1" share1
-	mount --rbind share1 parent1
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	mount --rbind parent1 parent2
-
-	check parent1 share1 parent2
-	mount --rbind "$disk2" parent1/child1
-	check parent1/child1 parent2/child1
-	check parent1/child1 share1/child1
-	mount --rbind "$disk3" parent2/a
-
-	check parent1/a parent2/a share1/a
-
-	mount --rbind "$disk4" share1/b
-
-	check parent1/b parent2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test17: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test17: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/b
-	umount parent2/a
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent2
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test17: FAILED: rbind: shared subtree with shared child to shared subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test17: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test18 b/testcases/kernel/fs/fs_bind/rbind/test18
deleted file mode 100755
index 4eba0ed23..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test18
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test18} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST18***************"
-tst_resm TINFO "rbind: shared subtree with shared child to private subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test18 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --rbind "$disk1" share1
-	mount --rbind share1 parent1
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	mount --rbind parent1 parent2
-
-	check parent1 share1 parent2
-	mount --rbind "$disk2" parent1/child1
-	check parent1/child1 parent2/child1
-	check parent1/child1 share1/child1
-	mount --rbind "$disk3" parent2/a
-
-	check parent1/a parent2/a share1/a
-
-	mount --rbind "$disk4" share1/b
-
-	check parent1/b parent2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test18: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test18: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/b
-	umount parent2/a
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent2
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test18: FAILED: rbind: shared subtree with shared child to private subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test18: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test19 b/testcases/kernel/fs/fs_bind/rbind/test19
deleted file mode 100755
index 078ee28b0..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test19
+++ /dev/null
@@ -1,108 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test19} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST19***************"
-tst_resm TINFO "rbind: shared subtree with shared child to slave subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test19 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	####### SETUP ######
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --rbind "$disk1" share1
-	mount --rbind share1 parent1
-	mount --rbind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	###### BODY ######
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	mount --rbind parent1 parent2
-	##### VERIFICATION ######
-	check parent1 share1 parent2
-	mount --rbind "$disk2" parent1/child1
-	check parent1/child1 parent2/child1
-	check parent1/child1 share1/child1
-	mount --rbind "$disk3" parent2/a
-
-	check parent1/a parent2/a share1/a
-
-	mount --rbind "$disk4" share1/b
-
-	check parent1/b parent2/b share1/b
-
-	##### CLEANUP ######
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test19: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test19: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/b
-	umount parent2/a
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent2
-	umount parent1
-	umount share1
-	umount share2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test19: FAILED: rbind: shared subtree with shared child to slave subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test19: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test20 b/testcases/kernel/fs/fs_bind/rbind/test20
deleted file mode 100755
index 3e2bdeb41..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test20
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test20} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST20***************"
-tst_resm TINFO "rbind: shared subtree with shared child to uncloneable subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test20 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --rbind "$disk1" share1
-	mount --rbind share1 parent1
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	mount --rbind parent1 parent2
-
-	check parent1 share1 parent2
-	mount --rbind "$disk2" parent1/child1
-	check parent1/child1 parent2/child1
-	check parent1/child1 share1/child1
-	mount --rbind "$disk3" parent2/a
-
-	check parent1/a parent2/a share1/a
-
-	mount --rbind "$disk4" share1/b
-
-	check parent1/b parent2/b share1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test20: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test20: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/b
-	umount parent2/a
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent2
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test20: FAILED: rbind: shared subtree with shared child to uncloneable subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test20: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test21 b/testcases/kernel/fs/fs_bind/rbind/test21
deleted file mode 100755
index 2c1424a9c..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test21
+++ /dev/null
@@ -1,106 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test21} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST21***************"
-tst_resm TINFO "rbind: shared subtree with  private child to shared subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test21 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --rbind share1 parent1
-	mount --rbind share2 parent2
-
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent1 parent2
-
-	check parent1 share1 parent2 share2
-	check parent1/child1/ parent2/child1
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n parent1/child1/a parent2/child1/a
-	check -n parent1/child1/a share1/child1/a
-	check parent2/child1/a share2/child1/a
-
-	mount --rbind "$disk3" parent2/child1/b
-
-	check -n parent1/child1/b parent2/child1/b
-	check parent2/child1/b share2/child1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test21: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test21: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child1/b
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share2
-	umount share2
-	umount share2
-	umount share2
-	umount parent1
-	umount parent2
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test21: FAILED: rbind: shared subtree with  private child to shared subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test21: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test22 b/testcases/kernel/fs/fs_bind/rbind/test22
deleted file mode 100755
index 6eda42557..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test22
+++ /dev/null
@@ -1,99 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test22} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST22***************"
-tst_resm TINFO "rbind: shared subtree with  private child to slave subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test22 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --rbind share2 parent2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent1 parent2
-
-	check parent1 parent2
-	check parent1/child1/ parent2/child1
-	check -n parent2 share2
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n parent1/child1/a parent2/child1/a
-
-	mount --rbind "$disk3" parent2/child1/b
-
-	check -n parent1/child1/b parent2/child1/b
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test22: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test22: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child1/b
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	umount share2
-	umount parent2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test22: FAILED: rbind: shared subtree with  private child to slave subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test22: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test23 b/testcases/kernel/fs/fs_bind/rbind/test23
deleted file mode 100755
index d8fcce274..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test23
+++ /dev/null
@@ -1,101 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test23} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST23***************"
-tst_resm TINFO "rbind: shared subtree with  private child to private subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test23 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent1 parent2
-	mount --rbind parent1 share1
-
-	check parent1 parent2
-	check parent1/child1/ parent2/child1
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n parent1/child1/a share1/child1/a
-	check -n parent1/child1/a parent2/child1/a
-
-	mount --rbind "$disk3" parent2/child1/b
-
-	check -n parent1/child1/b parent2/child1/b
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test23: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test23: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child1/b
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1/child1
-	umount share1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test23: FAILED: rbind: shared subtree with  private child to private subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test23: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test24 b/testcases/kernel/fs/fs_bind/rbind/test24
deleted file mode 100755
index 7899f5082..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test24
+++ /dev/null
@@ -1,101 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test24} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST24***************"
-tst_resm TINFO "rbind: shared subtree with unclonable child to private subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test24 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent1/child1
-
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent1 parent2
-	mount --rbind parent1 share1
-
-	check parent1 parent2
-	check parent1/child1/ parent2/child1
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n parent1/child1/a share1/child1/a
-	check -n parent1/child1/a parent2/child1/a
-
-	mount --rbind "$disk3" parent2/child1/b
-
-	check -n parent1/child1/b parent2/child1/b
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test24: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test24: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child1/b
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount share1/child1
-	umount share1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test24: FAILED: rbind: shared subtree with unclonable child to private subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test24: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test25 b/testcases/kernel/fs/fs_bind/rbind/test25
deleted file mode 100755
index bd6817254..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test25
+++ /dev/null
@@ -1,106 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-
-SETS_DEFAULTS="${TCID=test25} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST25***************"
-tst_resm TINFO "rbind: shared subtree with slave child to shared subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test25 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	mkdir parent1/child1
-
-	mount --bind share1 parent1/child1
-
-	mount --rbind "$disk1" parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	mount --rbind parent1 parent2
-
-	check parent1 parent2
-	check parent1/child1/ parent2/child1
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n parent1/child1/a parent2/child1/a
-	check -n parent1/child1/a share1/a
-
-	mount --rbind "$disk3" parent2/child1/b
-
-	check -n parent1/child1/b parent2/child1/b
-	check -n parent2/child1/b share1/b
-
-	mount --rbind "$disk4" share1/c
-	check parent2/child1/c share1/c
-	check parent1/child1/c share1/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test25: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test25: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/c
-	umount parent1/child1/a
-	umount parent2/child1/b
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test25: FAILED: rbind: shared subtree with slave child to shared subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test25: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test26 b/testcases/kernel/fs/fs_bind/rbind/test26
deleted file mode 100755
index dd0e39a9e..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test26
+++ /dev/null
@@ -1,98 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test26} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST26***************"
-tst_resm TINFO "rbind: shared subtree with slave child to private subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test26 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind share1 parent1/child1
-
-	mount --rbind "$disk1" parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	mount --rbind parent1 parent2
-
-	check parent1 parent2
-	check parent1/child1/ parent2/child1
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n parent1/child1/a parent2/child1/a
-	check -n parent1/child1/a share1/a
-
-	mount --rbind "$disk3" parent2/child1/b
-
-	check -n parent1/child1/b parent2/child1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test26: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test26: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child1/b
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test26: FAILED: rbind: shared subtree with slave child to private subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test26: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test27 b/testcases/kernel/fs/fs_bind/rbind/test27
deleted file mode 100755
index af2b64b49..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test27
+++ /dev/null
@@ -1,104 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test27} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST27***************"
-tst_resm TINFO "rbind: shared subtree with slave child to slave subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test27 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind share1 parent1/child1
-	mount --bind share2 parent2
-	mount --rbind "$disk1" parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	mount --rbind parent1 parent2
-
-	check parent1 parent2
-	check parent1/child1/ parent2/child1
-	check -n parent2 share2
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n parent1/child1/a parent2/child1/a
-	check -n parent1/child1/a share1/a
-
-	mount --rbind "$disk3" parent2/child1/b
-
-	check -n parent1/child1/b parent2/child1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test27: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test27: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child1/b
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent2
-	umount share2
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test27: FAILED: rbind: shared subtree with slave child to slave subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test27: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test28 b/testcases/kernel/fs/fs_bind/rbind/test28
deleted file mode 100755
index aba105a6b..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test28
+++ /dev/null
@@ -1,99 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test28} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST28***************"
-tst_resm TINFO "rbind: shared subtree with slave child to unclone subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test28 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-
-	mount --bind share1 parent1/child1
-
-	mount --rbind "$disk1" parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-
-	mount --rbind parent1 parent2
-
-	check parent1 parent2
-	check parent1/child1/ parent2/child1
-
-	mount --rbind "$disk2" parent1/child1/a
-
-	check -n parent1/child1/a parent2/child1/a
-	check -n parent1/child1/a share1/a
-
-	mount --rbind "$disk3" parent2/child1/b
-
-	check -n parent1/child1/b parent2/child1/b
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test28: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test28: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent2/child1/b
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	umount share1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test28: FAILED: rbind: shared subtree with slave child to unclone subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test28: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test29 b/testcases/kernel/fs/fs_bind/rbind/test29
deleted file mode 100755
index 9b3cd683f..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test29
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test29} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST29***************"
-tst_resm TINFO "rbind: shared subtree with uncloneable child to shared subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test29 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --rbind share1 parent1
-	mount --rbind share2 parent2
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent1 parent2
-
-	check -n parent1/child1 share1/child1
-	check -n parent1/child1 parent2/child1
-	check parent2/child1 share2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test29: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test29: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1
-	umount parent1/child1
-	umount share2
-	umount share2
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent1
-	umount share2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test29: FAILED: rbind: shared subtree with uncloneable child to shared subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test29: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test30 b/testcases/kernel/fs/fs_bind/rbind/test30
deleted file mode 100755
index 93fd1e917..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test30
+++ /dev/null
@@ -1,86 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test30} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST30***************"
-tst_resm TINFO "rbind: shared subtree with uncloneable child to private subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test30 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --rbind share1 parent1
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent1 parent2
-
-	check -n parent1/child1 share1/child1
-	check -n parent1/child1 parent2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test30: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test30: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test30: FAILED: rbind: shared subtree with uncloneable child to private subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test30: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test31 b/testcases/kernel/fs/fs_bind/rbind/test31
deleted file mode 100755
index 32e462389..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test31
+++ /dev/null
@@ -1,93 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test31} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST31***************"
-tst_resm TINFO "rbind: shared subtree with uncloneable child to slave subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test31 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" priv parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-
-	mount --rbind share1 parent1
-	mount --rbind share2 parent2
-
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent1 parent2
-
-	check -n parent1/child1 share1/child1
-	check -n parent1/child1 parent2/child1
-	check -n parent2 share2
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test31: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test31: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent2
-	umount parent1
-	umount share1
-	umount share2
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test31: FAILED: rbind: shared subtree with uncloneable child to slave subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test31: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test32 b/testcases/kernel/fs/fs_bind/rbind/test32
deleted file mode 100755
index bf14aa21b..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test32
+++ /dev/null
@@ -1,86 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test32} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST32***************"
-tst_resm TINFO "rbind: shared subtree with uncloneable child to uncloneable subtree."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test32 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent1
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-
-	mount --rbind share1 parent1
-
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-	mount --rbind "$disk1" parent1/child1
-	mount --rbind parent1 parent2
-
-	check -n parent1/child1 share1/child1
-	check -n parent1/child1 parent2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test32: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test32: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-	umount parent2
-	umount parent1
-	umount share1
-	umount parent1
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test32: FAILED: rbind: shared subtree with uncloneable child to uncloneable subtree."
-	exit 1
-else
-	tst_resm TPASS "rbind/test32: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test33 b/testcases/kernel/fs/fs_bind/rbind/test33
deleted file mode 100755
index 1ba506a7d..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test33
+++ /dev/null
@@ -1,114 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test33} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST33***************"
-tst_resm TINFO "rbind: multi-level slave p-nodes."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test33 failed" && tst_exit)
-export result=0
-
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share dir1
-
-	mkdir dir1/x dir2 dir3 dir4
-
-	mount --rbind dir1 dir2
-	"${FS_BIND_ROOT}/bin/makedir" slave dir2
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir2
-
-	mount --rbind dir2 dir3
-	"${FS_BIND_ROOT}/bin/makedir" slave dir3
-	"${FS_BIND_ROOT}/bin/makedir" -n share dir3
-
-	mount --rbind dir3 dir4
-	"${FS_BIND_ROOT}/bin/makedir" slave dir4
-
-	mount --rbind "$disk1" dir1/x
-
-	check dir1/x dir2/x dir3/x dir4/x
-
-	mount --rbind "$disk2" dir2/x/a
-	check -n dir1/x/a dir2/x/a
-	check dir2/x/a dir3/x/a dir4/x/a
-
-	mount --rbind "$disk3" dir3/x/b
-	check -n dir1/x/b dir3/x/b
-	check -n dir2/x/b dir3/x/b
-	check dir3/x/b dir4/x/b
-
-	mount --rbind "$disk4" dir4/x/c
-	check -n dir1/x/c dir4/x/c
-	check -n dir2/x/c dir4/x/c
-	check -n dir3/x/c dir4/x/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test33: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test33: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir2/x/a
-	umount dir3/x/b
-	umount dir4/x/c
-	umount dir1/x
-	umount dir1
-	umount dir1
-	umount dir2
-	umount dir3
-	umount dir4
-
-	rm -rf dir*
-
-	cleanup
-} >& /dev/null
-
-if [ $result -ne 0 ]
-then
-        tst_resm TFAIL "rbind/test33: FAILED: rbind: multi-level slave p-nodes."
-        exit 1
-else
-        tst_resm TPASS "rbind/test33: PASSED"
-        exit 0
-fi
-
-
-
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test34 b/testcases/kernel/fs/fs_bind/rbind/test34
deleted file mode 100755
index 3e7d49cf8..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test34
+++ /dev/null
@@ -1,93 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test34} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST34***************"
-tst_resm TINFO "rbind: rbind within same tree - root to child, child is shared "
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test34 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child1
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child2
-
-	mount --rbind "$disk3" parent/child1
-
-	mount --rbind parent parent/child2/
-	check parent parent/child2/
-	check parent/child1 parent/child2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test34: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test34: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent/child2/child1
-	check parent/child1 parent/child2/child1
-
-	umount parent/child1
-	check parent/child1 parent/child2/child1
-
-	mount --rbind "$disk4" parent/child2/child1
-	check parent/child1 parent/child2/child1
-
-	umount parent/child1
-	check parent/child1 parent/child2/child1
-
-	umount parent/child2/child2
-	umount parent/child2
-	umount parent/child2
-	umount parent
-
-	rm -rf parent
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test34: FAILED: rbind: rbind within same tree - root to child, child is shared "
-	exit 1
-else
-	tst_resm TPASS "rbind/test34: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test35 b/testcases/kernel/fs/fs_bind/rbind/test35
deleted file mode 100755
index fb79cf84f..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test35
+++ /dev/null
@@ -1,95 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test35} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST35***************"
-tst_resm TINFO "rbind: rbind within same tree - root to child, child is private "
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test35 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent
-	"${FS_BIND_ROOT}/bin/makedir" priv parent/child1
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child2
-
-	mount --rbind "$disk3" parent/child1
-
-	mount --rbind parent parent/child2/
-	check parent parent/child2/
-	check parent/child1 parent/child2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test35: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test35: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent/child2/child1
-	#added -n
-	check -n parent/child1 parent/child2/child1
-
-	umount parent/child1
-	check parent/child1 parent/child2/child1
-
-	mount --rbind "$disk4" parent/child2/child1
-	check -n parent/child1 parent/child2/child1
-
-	umount parent/child2/child1
-	check parent/child1 parent/child2/child1
-
-	umount parent/child2/child2
-	umount parent/child2/child1
-	umount parent/child2
-	umount parent/child2
-	umount parent
-
-	rm -rf parent
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test35: FAILED: rbind: rbind within same tree - root to child, child is private "
-	exit 1
-else
-	tst_resm TPASS "rbind/test35: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test36 b/testcases/kernel/fs/fs_bind/rbind/test36
deleted file mode 100755
index 68701513b..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test36
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test36} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST36***************"
-tst_resm TINFO "rbind: rbind within same tree - root to child, child is uncloneable"
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test36 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	"${FS_BIND_ROOT}/bin/makedir" share parent
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent/child1
-	"${FS_BIND_ROOT}/bin/makedir" share parent/child2
-
-	mount --rbind "$disk3" parent/child1
-
-	mount --rbind parent parent/child2/
-	check parent parent/child2/
-	check -n  parent/child1 parent/child2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test36: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test36: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent/child1
-	check parent/child1 parent/child2/child1
-
-	mount --rbind "$disk4" parent/child2/child1
-	check -n  parent/child1 parent/child2/child1
-
-	umount parent/child2/child1
-	check parent/child1 parent/child2/child1
-
-	umount parent/child2/child2
-	umount parent/child1
-	umount parent/child2
-	umount parent/child2
-	umount parent
-
-	rm -rf parent
-
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test36: FAILED: rbind: rbind within same tree - root to child, child is uncloneable"
-	exit 1
-else
-	tst_resm TPASS "rbind/test36: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test37 b/testcases/kernel/fs/fs_bind/rbind/test37
deleted file mode 100755
index 14a6b4a54..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test37
+++ /dev/null
@@ -1,102 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test37} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST37***************"
-tst_resm TINFO "rbind: private to private - with shared children."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test37 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	mkdir parent1 parent2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	"${FS_BIND_ROOT}/bin/makedir" share parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" share parent2/child2
-
-	mount --bind "$disk1" parent1/child1
-	mount --rbind parent1/child1 share1
-
-	mount --rbind parent2/child2 share2
-
-	mount --rbind parent1 parent2
-
-	check parent1 parent2
-	check parent1/child1 parent2/child1
-
-	mount --bind "$disk2" parent2/child1/a
-	check parent1/child1/a parent2/child1/a share1//a
-
-	mount --bind "$disk3" parent1/child1/b
-	check parent1/child1/b parent2/child1/b share1/b
-
-	mount --bind "$disk4" share1/c
-	check parent1/child1/c parent2/child1/c share1/c
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test37: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test37: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1/a
-	umount parent1/child1/b
-	umount share1/c
-	umount parent2/child1
-	umount parent2/child1
-	umount parent1/child1
-	umount parent2
-	umount share2
-	umount share2
-	umount share1
-	umount share1
-	umount parent2/child2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test37: FAILED: rbind: private to private - with shared children."
-	exit 1
-else
-	tst_resm TPASS "rbind/test37: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test38 b/testcases/kernel/fs/fs_bind/rbind/test38
deleted file mode 100755
index ae7477e5f..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test38
+++ /dev/null
@@ -1,101 +0,0 @@
-#!/bin/bash
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test38} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST38***************"
-tst_resm TINFO "rbind: private to private - with slave children."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test38 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	mkdir parent1 parent2 parent1/child1 parent2/child2
-	"${FS_BIND_ROOT}/bin/makedir" share share1
-	"${FS_BIND_ROOT}/bin/makedir" share share2
-	mount --rbind share1 parent1/child1
-	mount --rbind share2 parent2/child2
-	"${FS_BIND_ROOT}/bin/makedir" slave parent1/child1
-	"${FS_BIND_ROOT}/bin/makedir" slave parent2/child2
-
-	mount --bind "$disk1" share1
-
-	mount --rbind parent1 parent2
-
-	check parent1 parent2
-	check parent1/child1 parent2/child1
-
-	mount --bind "$disk2" share1/a
-	check parent1/child1/a parent2/child1/a share1/a
-
-	mount --bind "$disk3" parent1/child1/b
-	check -n parent1/child1/b share1/b
-
-	mount --bind "$disk4" parent2/child1/c
-	check -n parent2/child1/c share1/c
-
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test38: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test38: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount share1/a
-	umount parent1/child1/b
-	umount parent2/child1/c
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2/child1
-	umount parent2/child1
-	umount parent2
-	umount share1
-	umount share1
-	umount share2
-	umount parent2/child2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test38: FAILED: rbind: private to private - with slave children."
-	exit 1
-else
-	tst_resm TPASS "rbind/test38: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/rbind/test39 b/testcases/kernel/fs/fs_bind/rbind/test39
deleted file mode 100755
index 006b06b3c..000000000
--- a/testcases/kernel/fs/fs_bind/rbind/test39
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test39} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST39***************"
-tst_resm TINFO "rbind: private to private - with unclonable children."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of rbind/test39 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-	mkdir parent1 parent2
-	"${FS_BIND_ROOT}/bin/makedir" unclone parent1/child1
-
-	mount --bind "$disk1" parent1/child1
-
-	mount --rbind parent1 parent2
-
-	check parent1 parent2
-	check -n parent1/child1 parent2/child1
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "rbind/test39: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "rbind/test39: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount parent1/child1
-	umount parent1/child1
-	umount parent2
-
-	rm -rf parent* share*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "rbind/test39: FAILED: rbind: private to private - with unclonable children."
-	exit 1
-else
-	tst_resm TPASS "rbind/test39: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/regression/00_Descriptions.txt b/testcases/kernel/fs/fs_bind/regression/00_Descriptions.txt
deleted file mode 100644
index 273e08ae7..000000000
--- a/testcases/kernel/fs/fs_bind/regression/00_Descriptions.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*                                                                            */
-/******************************************************************************/
-
-OO_DESCRIPTION.txt
-==================
-
-The contents of the regression directory:
-test01 - bind unshared directory to unshare mountpoint.
-test02 - rbind unshared directory to unshare mountpoint.
-test03 - move unshared directory to unshare mountpoint.
-
-
-test01:
-=======
-bind unshared directory to unshare mountpoint.
-
-
-test02:
-=======
-rbind unshared directory to unshare mountpoint.
-
-
-test03:
-=======
-move unshared directory to unshare mountpoint.
-
-
diff --git a/testcases/kernel/fs/fs_bind/regression/test01 b/testcases/kernel/fs/fs_bind/regression/test01
deleted file mode 100755
index 8cfbfb4fc..000000000
--- a/testcases/kernel/fs/fs_bind/regression/test01
+++ /dev/null
@@ -1,71 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test01} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST01***************"
-tst_resm TINFO "regression: bind unshared directory to unshare mountpoint."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of regression/test01 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	mkdir dir
-	mount --bind "$disk1" dir
-	check "$disk1" dir
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "regression/test01: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "regression/test01: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir
-
-	rm -rf dir
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "regression/test01: FAILED: regression: bind unshared directory to unshare mountpoint."
-	exit 1
-else
-	tst_resm TPASS "regression/test01: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/regression/test02 b/testcases/kernel/fs/fs_bind/regression/test02
deleted file mode 100755
index c07c3ed98..000000000
--- a/testcases/kernel/fs/fs_bind/regression/test02
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test02} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST02***************"
-tst_resm TINFO "regression: rbind unshared directory to unshare mountpoint."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of regression/test02 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	mkdir dir1
-	mkdir dir2
-	mount --bind "$disk1" dir1
-	mount --bind "$disk2" dir1/a
-	mount --rbind dir1 dir2
-
-	check dir1/a dir2/a
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "regression/test02: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "regression/test02: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir1/a
-	umount dir2/a
-	umount dir2
-	umount dir1
-
-	rm -rf dir*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "regression/test02: FAILED: regression: rbind unshared directory to unshare mountpoint."
-	exit 1
-else
-	tst_resm TPASS "regression/test02: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testcases/kernel/fs/fs_bind/regression/test03 b/testcases/kernel/fs/fs_bind/regression/test03
deleted file mode 100755
index 7b3cc3e97..000000000
--- a/testcases/kernel/fs/fs_bind/regression/test03
+++ /dev/null
@@ -1,77 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Author: Avantika Mathur (mathurav@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-SETS_DEFAULTS="${TCID=test03} ${TST_COUNT=1} ${TST_TOTAL=1}"
-declare -r TCID
-declare -r TST_COUNT
-declare -r TST_TOTAL
-export TCID TST_COUNT TST_TOTAL
-
-tst_resm TINFO "***************TEST03***************"
-tst_resm TINFO "regression: move unshared directory to unshare mountpoint."
-tst_resm TINFO "************************************"
-
-. "${FS_BIND_ROOT}/bin/setup" || (tst_resm TWARN "Setup of regression/test03 failed" && tst_exit)
-export result=0
-
-
-
-trap 'ERR=$? ; ERR_MSG="caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"; break' ERR
-
-while /bin/true ; do
-	# This loop is for error recovery purposes only
-
-
-
-	mkdir dir1
-	mkdir dir2
-	mount --bind "$disk1" dir1
-	mount --bind "$disk2" dir1/a
-	mount --move dir1 dir2
-
-	check dir2/a "$disk2"
-
-	break
-done
-trap 'ERR=$? ; tst_resm TWARN "regression/test03: caught error near: ${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}:$_ (returned ${ERR})"' ERR
-if [ -n "${ERR_MSG}" ]; then
-	tst_resm TWARN "regression/test03: ${ERR_MSG}"
-	ERR_MSG=""
-	result=$ERR
-fi
-trap '' ERR
-{
-	umount dir2/a
-	umount dir2
-	umount dir1
-
-	rm -rf dir*
-	cleanup
-} >& /dev/null
-if [ $result -ne 0 ]
-then
-	tst_resm TFAIL "regression/test03: FAILED: regression: move unshared directory to unshare mountpoint."
-	exit 1
-else
-	tst_resm TPASS "regression/test03: PASSED"
-	exit 0
-fi
-tst_exit
diff --git a/testscripts/test_fs_bind.sh b/testscripts/test_fs_bind.sh
deleted file mode 100755
index d06564d7b..000000000
--- a/testscripts/test_fs_bind.sh
+++ /dev/null
@@ -1,526 +0,0 @@
-#!/bin/bash
-
-#
-# Copyright (c) International Business Machines  Corp., 2005
-# Authors: Avantika Mathur (mathurav@us.ibm.com)
-#          Matt Helsley (matthltc@us.ibm.com)
-#
-# This library is free software; you can redistribute it and/or
-# modify it under the terms of the GNU Lesser General Public
-# License as published by the Free Software Foundation; either
-# version 2.1 of the License, or (at your option) any later version.
-#
-# This library is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# Lesser General Public License for more details.
-#
-# You should have received a copy of the GNU Lesser General Public
-# License along with this library; if not, write to the Free Software
-# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-
-if tst_kvcmp -lt "2.6.15"; then
-       tst_resm TCONF "System kernel version is less than 2.6.15"
-       tst_resm TCONF "Cannot execute test"
-       exit 0
-fi
-
-test_setup()
-{
-	#######################################################################
-	## Configure
-	#######################################################################
-	dopts='-dEBb'
-
-	## Remove logged test state depending on results. 0 means do not remove,
-	## 1 means OK to remove.
-	# rm saved state from tests that appear to have cleaned up properly?
-	rm_ok=1
-	# rm saved state from tests that don't appear to have fully cleaned up?
-	rm_err=0
-
-	#######################################################################
-	## Initialize some variables
-	#######################################################################
-	TCID="$0"
-	TST_COUNT=0
-
-	test_dirs=( move bind rbind regression )  #cloneNS
-	nfailed=0
-	nsucceeded=0
-
-	# set the LTPROOT directory
-	cd `dirname $0`
-	LTPROOT="${PWD}"
-	echo "${LTPROOT}" | grep testscripts > /dev/null 2>&1
-	if [ $? -eq 0 ]; then
-		cd ..
-		LTPROOT="${PWD}"
-	fi
-
-	FS_BIND_ROOT="${LTPROOT}/testcases/bin/fs_bind"
-
-	total=0 # total number of tests
-	for dir in "${test_dirs[@]}" ; do
-		((total += `ls "${FS_BIND_ROOT}/${dir}/test"* | wc -l`))
-	done
-	TST_TOTAL=${total}
-
-	# set the PATH to include testcases/bin
-	LTPBIN="${LTPROOT}/testcases/bin"
-	PATH="${PATH}:/usr/sbin:${LTPBIN}:${FS_BIND_ROOT}/bin"
-
-	# Results directory
-	resdir="${LTPROOT}/results/fs_bind"
-	if [ ! -d "${resdir}" ]; then
-		mkdir -p "${resdir}" 2> /dev/null
-	fi
-
-	TMPDIR="${TMPDIR:-/tmp}"
-	# A temporary directory where we can do stuff and that is
-	# safe to remove
-	sandbox="${TMPDIR}/sandbox"
-
-	ERR_MSG=""
-
-	export LTPBIN PATH FS_BIND_ROOT ERR_MSG TCID TST_COUNT TST_TOTAL
-
-	if [ ! -d "${resdir}" ]; then
-		tst_brkm TBROK true "$0: failed to make results directory"
-		exit 1
-	fi
-}
-
-test_prereqs()
-{
-	# Must be root to run the containers testsuite
-	if [ $UID != 0 ]; then
-		tst_brkm TBROK true "FAILED: Must be root to execute this script"
-		exit 1
-	fi
-
-	mkdir "${sandbox}" >& /dev/null
-	if [ ! -d "${sandbox}" -o ! -x "${sandbox}" ]; then
-		tst_brkm TBROK true "$0: failed to make directory \"${sandbox}\""
-		exit -1
-	fi
-
-	mount --bind "${sandbox}" "${sandbox}" >& /dev/null
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK true "$0: failed to perform bind mount on directory \"${sandbox}\""
-		exit 1
-	fi
-
-	mount --make-private "${sandbox}" >& /dev/null
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK true "$0: failed to make private mountpoint on directory \"${sandbox}\""
-		exit 1
-	fi
-
-	local mnt_bind=1
-	local mnt_move=1
-
-	pushd "${sandbox}" > /dev/null && {
-		mkdir bind_test move_test && {
-			mount --bind bind_test bind_test && {
-				mnt_bind=0
-				mount --move bind_test move_test && {
-					mnt_move=0
-					umount move_test
-				} || {
-					# bind mount succeeded but move mount
-					# failed
-					umount bind_test
-				}
-			} || {
-				# mount failed -- check if it's because we
-				# don't have privileges we need
-				if [ $? -eq 32 ]; then
-					tst_brkm TBROK true "$0 requires the privilege to use the mount command"
-					exit 32
-				fi
-			}
-			rmdir bind_test move_test
-		}
-		popd > /dev/null
-	}
-
-	if [ ${mnt_bind} -eq 1 -o ${mnt_move} -eq 1 ]; then
-		tst_brkm TBROK true "$0: requires that mount support the --bind and --move options"
-		exit 1
-	fi
-
-	if tst_kvcmp -lt "2.6.15"; then
-		tst_resm TWARN "$0: the remaining tests require 2.6.15 or later"
-		tst_exit 0
-		exit
-	else
-		tst_resm TINFO "$0: kernel >= 2.6.15 detected -- continuing"
-	fi
-
-	mount --make-shared "${sandbox}" > /dev/null 2>&1 || "${FS_BIND_ROOT}/bin/smount" "${sandbox}" shared
-	umount "${sandbox}" || {
-		tst_resm TFAIL "$0: failed to umount simplest shared subtree"
-		exit 1
-	}
-	tst_resm TPASS "$0: umounted simplest shared subtree"
-
-}
-
-# mounts we are concerned with in a well-defined order (helps diff)
-# returns grep return codes
-grep_proc_mounts()
-{
-	local rc=0
-
-	# Save the pipefail shell option
-	shopt -o -q pipefail
-	local save=$?
-	set -o pipefail
-
-	# Grep /proc/mounts which is often more up-to-date than mounts
-	# We use pipefail because if the grep fails we want to pass that along
-	grep -F "${sandbox}" /proc/mounts | sort -b
-	rc=$?
-
-	# Restore the pipefail shell options
-	[ $save -eq 0 ] && shopt -o -s pipefail || shopt -o -u pipefail
-
-	return $rc
-}
-
-# Record the mount state
-save_proc_mounts()
-{
-	touch "$2/proc_mounts.before" >& /dev/null
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK true "$1: failed to record proc mounts"
-		return 1
-	fi
-
-	grep_proc_mounts 2> /dev/null > "$2/proc_mounts.before"
-	return 0
-}
-
-# Compare mount list after the test with the list from before.
-# If there are no differences then remove the before list and silently
-# return 0. Else print the differences to stderr and return 1.
-check_proc_mounts()
-{
-	local tname="$1"
-
-	if [ ! -r "$2/proc_mounts.before" ]; then
-		tst_brkm TBROK true "${tname}: Could not find pre-test proc mount list"
-		return 1
-	fi
-
-	grep_proc_mounts 2> /dev/null > "$2/proc_mounts.after"
-	# If the mounts are the same then just return
-	diff ${dopts} -q "$2/proc_mounts.before" "$2/proc_mounts.after" >& /dev/null
-	if [ $? -eq 0 ]; then
-		[ $rm_ok -eq 1 ] && rm -f "$2/proc_mounts."{before,after}
-		return 0
-	fi
-
-	tst_resm TWARN "${tname}: did not properly clean up its proc mounts"
-	diff ${dopts} -U 0 "$2/proc_mounts.before" "$2/proc_mounts.after" | grep -vE '^\@\@' 1>&2
-	[ $rm_err -eq 1 ] && rm -f "$2/proc_mounts."{before,after}
-	return 1
-}
-
-# Undo leftover mounts
-restore_proc_mounts()
-{
-	#local tname="$1"
-
-	# do lazy umounts -- we're assuming that tests will only leave
-	# new mounts around and will never remove mounts outside the test
-	# directory
-	( while grep_proc_mounts ; do
-		grep_proc_mounts | awk '{print $2}' | xargs -r -n 1 umount -l
-	done ) >& /dev/null
-
-	# mount list and exit with 0
-	[ $rm_err -eq 1 ] && rm -f "$2/proc_mounts."{before,after} 1>&2 # >& /dev/null
-	return 0
-	# if returning error do this:
-	# tst_brkm TBROK true "${tname}: failed to restore mounts"
-}
-
-# mounts we are concerned with in a well-defined order (helps diff)
-# returns grep return codes
-grep_mounts()
-{
-	local rc=0
-
-	# Save the pipefail shell option
-	shopt -o -q pipefail
-	local save=$?
-	set -o pipefail
-
-	# Grep mount command output (which tends to come from /etc/mtab)
-	# We use pipefail because if the grep fails we want to pass that along
-	mount | grep -F "${sandbox}" | sort -b
-	rc=$?
-
-	# Restore the pipefail shell options
-	[ $save -eq 0 ] && shopt -o -s pipefail || shopt -o -u pipefail
-
-	return $rc
-}
-
-# Record the mount state
-save_mounts()
-{
-	touch "$2/mtab.before" >& /dev/null
-	if [ $? -ne 0 ]; then
-		tst_brkm TBROK true "$1: failed to record mtab mounts"
-		return 1
-	fi
-
-	grep_mounts 2> /dev/null > "$2/mtab.before"
-	return 0
-}
-
-# Compare mount list after the test with the list from before.
-# If there are no differences then remove the before list and silently
-# return 0. Else print the differences to stderr and return 1.
-check_mounts()
-{
-	local tname="$1"
-
-	if [ ! -r "$2/mtab.before" ]; then
-		tst_brkm TBROK true "${tname}: Could not find pre-test mtab mount list"
-		return 1
-	fi
-
-	grep_mounts 2> /dev/null > "$2/mtab.after"
-	# If the mounts are the same then just return
-	diff ${dopts} -q "$2/mtab.before" "$2/mtab.after" >& /dev/null
-	if [ $? -eq 0 ]; then
-		[ $rm_ok -eq 1 ] && rm -f "$2/mtab."{before,after}
-		return 0
-	fi
-
-	tst_resm TWARN "${tname}: did not properly clean up its mtab mounts"
-	diff ${dopts} -U 0 "$2/mtab.before" "$2/mtab.after" | grep -vE '^\@\@' 1>&2
-	[ $rm_err -eq 1 ] && rm -f "$2/mtab."{before,after}
-	return 1
-}
-
-# Undo leftover mounts
-restore_mounts()
-{
-	#local tname="$1"
-
-	# do lazy umounts -- we're assuming that tests will only leave
-	# new mounts around and will never remove mounts outside the test
-	# directory
-	( while grep_mounts ; do
-		grep_mounts | awk '{print $3}' | xargs -r -n 1 umount -l
-	done ) >& /dev/null
-
-	# mount list and exit with 0
-	[ $rm_err -eq 1 ] && rm -f "$2/mtab."{before,after} 1>&2 # >& /dev/null
-	return 0
-	# if returning error do this:
-	# tst_brkm TBROK true "${tname}: failed to restore mounts"
-}
-
-# Record the sandbox state
-# We don't save full sandbox state -- just the names of files and dirs present
-save_sandbox()
-{
-	local when="before"
-	local tname="$1"
-
-	if [ -e "$2/files.before" ]; then
-		if [ -e "$2/files.after" ]; then
-			tst_brkm TBROK true "${tname}: stale catalog of \"${sandbox}\""
-			return 1
-		fi
-		when="after"
-	fi
-
-	( find "${sandbox}" -type d -print | sort > "$2/dirs.$when"
-	  find "${sandbox}" -type f -print | sort | \
-		grep -vE '^'"$2"'/(dirs|files)\.(before|after)$' > "$2/files.$when" ) >& /dev/null
-	return 0
-}
-
-# Save sandbox after test and then compare. If the sandbox state is not
-# clean then print the differences to stderr and return 1. Else remove all
-# saved sandbox state and silently return 0
-check_sandbox()
-{
-	local tname="$1"
-
-	if [ ! -r "$2/files.before" -o ! -r "$2/dirs.before" ]; then
-		tst_brkm TBROK true "${tname} missing saved catalog of \"${sandbox}\""
-		return 1
-	fi
-
-	save_sandbox "${tname} (check)" "$2"
-
-	( diff ${dopts} -q "$2/dirs.before" "$2/dirs.after" && \
-	  diff ${dopts} -q "$2/files.before" "$2/files.after" )  >& /dev/null \
-	  && {
-		[ $rm_ok -eq 1 ] && rm -f "$2/"{files,dirs}.{before,after}
-		return 0
-	}
-
-	tst_resm TWARN "${tname} did not properly clean up \"${sandbox}\""
-	diff ${dopts} -U 0 "$2/dirs.before" "$2/dirs.after" 1>&2
-	diff ${dopts} -U 0 "$2/files.before" "$2/files.after" 1>&2
-	[ $rm_err -eq 1 ] && rm -f "$2/"{files,dirs}.{before,after} 1>&2
-	return 1
-}
-
-# Robust sandbox cleanup
-clean_sandbox()
-{
-	local tname="$1"
-
-	{ rm -rf "${sandbox}" ; mkdir "${sandbox}" ; } >& /dev/null
-	if [ ! -d "${sandbox}" -o ! -x "${sandbox}" ]; then
-		tst_brkm TBROK true "$tname: failed to make directory \"${sandbox}\""
-		return 1
-	fi
-	return 0
-}
-
-# Check file for non-whitespace chars
-is_file_empty()
-{
-	awk '/^[[:space:]]*$/  { next }
-	      { exit 1; }' < "$1"
-}
-
-#
-# Run the specified test script.
-#
-# Return 1 if the test was broken but should not stop the remaining test
-#	categories from being run.
-# Return 2 if the test was broken and no further tests should be run.
-# Return 0 otherwise (if the test was broken but it shouldn't affect other
-#	test runs)
-# Note that this means the return status is not the success or failure of the
-#	test itself.
-#
-run_test()
-{
-	local t="$1"
-	local tname="$(basename "$(dirname "$t")")/$(basename "$t")"
-	local log="$resdir/$tname/log"
-	local errlog="$resdir/$tname/err"
-	local do_break=0
-
-	ERR_MSG=""
-
-	# Pre-test
-	mkdir -p "$resdir/$tname"
-	if [ ! -d "$resdir/$tname" -o ! -x "$resdir/$tname" ]; then
-		tst_brkm TBROK true "$0: can't make or use \"$resdir/$tname\" as a log directory"
-		return 1
-	fi
-
-	save_sandbox "$tname" "$resdir/$tname" || do_break=1
-	save_mounts "$tname" "$resdir/$tname" || do_break=1
-	save_proc_mounts "$tname" "$resdir/$tname" || do_break=1
-	mount --bind "${sandbox}" "${sandbox}" >& /dev/null || do_break=1
-	mount --make-private "${sandbox}" >& /dev/null || do_break=1
-
-	if [ $do_break -eq 1 ]; then
-		umount -l "${sandbox}" >& /dev/null
-		tst_brkm TBROK true "$tname: failed to save pre-test state of \"${sandbox}\""
-		return 2
-	fi
-	pushd "${sandbox}" > /dev/null
-
-	# Run the test
-	(
-		TCID="$tname"
-		declare -r TST_COUNT
-		export LTPBIN PATH FS_BIND_ROOT ERR_MSG TCID TST_COUNT TST_TOTAL
-		"$t" #> "$log" 2> "$errlog"
-	)
-	local rc=$?
-	TCID="$0"
-
-	# Post-test
-	popd > /dev/null
-	if [ $rc -ne 0 ]; then
-		#echo "FAILED"
-		((nfailed++))
-	else
-		#echo "SUCCEEDED"
-		((nsucceeded++))
-	fi
-	umount -l "${sandbox}" >& /dev/null
-	check_proc_mounts "$tname" "$resdir/$tname" || \
-	restore_proc_mounts "$tname" "$resdir/$tname" || do_break=1
-	check_mounts "$tname" "$resdir/$tname" || \
-	restore_mounts "$tname" "$resdir/$tname" || do_break=1
-	check_sandbox "$tname" "$resdir/$tname"
-	clean_sandbox "$tname" || do_break=1
-	if [ $do_break -eq 1 ]; then
-		tst_brkm TBROK true "$tname: failed to restore pre-test state of \"${sandbox}\""
-		return 2
-	fi
-
-	# If we succeeded and the error log is empty remove it
-	if [ $rc -eq 0 -a -w "$errlog" ] && is_file_empty "$errlog" ; then
-		rm -f "$errlog"
-	fi
-	return 0
-}
-
-main()
-{
-	TST_COUNT=1
-	for dir in "${test_dirs[@]}" ; do
-		tests=( $(find "${FS_BIND_ROOT}/${dir}" -type f -name 'test*') )
-		clean_sandbox "$0" || break
-		for t in "${tests[@]}" ; do
-			run_test "$t"
-			local rc=$?
-
-			if [ $rc -ne 0 ]; then
-				break $rc
-			fi
-
-			((TST_COUNT++))
-		done
-	done
-	rm -rf "${sandbox}"
-	return 0
-
-	skipped=$((total - nsucceeded - nfailed))
-	if [ $nfailed -eq 0 -a $skipped -eq 0 ]; then
-		# Use PASSED for the summary rather than SUCCEEDED to make it
-		# easy to determine 100% success from a calling script
-		summary="PASSED"
-	else
-		# Use FAILED to make it easy to find > 0% failure from a
-		# calling script
-		summary="FAILED"
-	fi
-	cat - <<-EOF
-		*********************************
-		RESULTS SUMMARY:
-
-			passed:  $nsucceeded/$total
-			failed:  $nfailed/$total
-			skipped: $skipped/$total
-			summary: $summary
-
-		*********************************
-	EOF
-}
-
-test_setup || exit 1
-test_prereqs || exit 1
-declare -r FS_BIND_ROOT
-declare -r TST_TOTAL
-main  #2> "$resdir/errors" 1> "$resdir/summary"
-- 
2.25.1

