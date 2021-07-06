From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue,  6 Jul 2021 14:04:31 +0200
Subject: [LTP] [PATCH v2 1/4] fs_bind: Rename tests to have unique names
In-Reply-To: <20210706120434.867426-1-lkml@jv-coder.de>
References: <20210706120434.867426-1-lkml@jv-coder.de>
Message-ID: <20210706120434.867426-2-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

This is required in preparation of the next commit,
that will install the tests as individual ltp tests

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/kernel/fs/fs_bind/Makefile                          | 2 +-
 testcases/kernel/fs/fs_bind/bind/{test01 => fs_bind01.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test02 => fs_bind02.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test03 => fs_bind03.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test04 => fs_bind04.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test05 => fs_bind05.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test06 => fs_bind06.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test07-2 => fs_bind07-2.sh} | 0
 testcases/kernel/fs/fs_bind/bind/{test07 => fs_bind07.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test08 => fs_bind08.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test09 => fs_bind09.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test10 => fs_bind10.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test11 => fs_bind11.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test12 => fs_bind12.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test13 => fs_bind13.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test14 => fs_bind14.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test15 => fs_bind15.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test16 => fs_bind16.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test17 => fs_bind17.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test18 => fs_bind18.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test19 => fs_bind19.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test20 => fs_bind20.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test21 => fs_bind21.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test22 => fs_bind22.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test23 => fs_bind23.sh}     | 0
 testcases/kernel/fs/fs_bind/bind/{test24 => fs_bind24.sh}     | 0
 .../fs/fs_bind/cloneNS/{test01 => fs_bind_cloneNS01.sh}       | 0
 .../fs/fs_bind/cloneNS/{test02 => fs_bind_cloneNS02.sh}       | 0
 .../fs/fs_bind/cloneNS/{test03 => fs_bind_cloneNS03.sh}       | 0
 .../fs/fs_bind/cloneNS/{test04 => fs_bind_cloneNS04.sh}       | 0
 .../fs/fs_bind/cloneNS/{test05 => fs_bind_cloneNS05.sh}       | 0
 .../fs/fs_bind/cloneNS/{test06 => fs_bind_cloneNS06.sh}       | 0
 .../fs/fs_bind/cloneNS/{test07 => fs_bind_cloneNS07.sh}       | 0
 .../kernel/fs/fs_bind/move/{test01 => fs_bind_move01.sh}      | 0
 .../kernel/fs/fs_bind/move/{test02 => fs_bind_move02.sh}      | 0
 .../kernel/fs/fs_bind/move/{test03 => fs_bind_move03.sh}      | 0
 .../kernel/fs/fs_bind/move/{test04 => fs_bind_move04.sh}      | 0
 .../kernel/fs/fs_bind/move/{test05 => fs_bind_move05.sh}      | 0
 .../kernel/fs/fs_bind/move/{test06 => fs_bind_move06.sh}      | 0
 .../kernel/fs/fs_bind/move/{test07 => fs_bind_move07.sh}      | 0
 .../kernel/fs/fs_bind/move/{test08 => fs_bind_move08.sh}      | 0
 .../kernel/fs/fs_bind/move/{test09 => fs_bind_move09.sh}      | 0
 .../kernel/fs/fs_bind/move/{test10 => fs_bind_move10.sh}      | 0
 .../kernel/fs/fs_bind/move/{test11 => fs_bind_move11.sh}      | 0
 .../kernel/fs/fs_bind/move/{test12 => fs_bind_move12.sh}      | 0
 .../kernel/fs/fs_bind/move/{test13 => fs_bind_move13.sh}      | 0
 .../kernel/fs/fs_bind/move/{test14 => fs_bind_move14.sh}      | 0
 .../kernel/fs/fs_bind/move/{test15 => fs_bind_move15.sh}      | 0
 .../kernel/fs/fs_bind/move/{test16 => fs_bind_move16.sh}      | 0
 .../kernel/fs/fs_bind/move/{test17 => fs_bind_move17.sh}      | 0
 .../kernel/fs/fs_bind/move/{test18 => fs_bind_move18.sh}      | 0
 .../kernel/fs/fs_bind/move/{test19 => fs_bind_move19.sh}      | 0
 .../kernel/fs/fs_bind/move/{test20 => fs_bind_move20.sh}      | 0
 .../kernel/fs/fs_bind/move/{test21 => fs_bind_move21.sh}      | 0
 .../kernel/fs/fs_bind/move/{test22 => fs_bind_move22.sh}      | 0
 .../kernel/fs/fs_bind/rbind/{test01 => fs_bind_rbind01.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test02 => fs_bind_rbind02.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test03 => fs_bind_rbind03.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test04 => fs_bind_rbind04.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test05 => fs_bind_rbind05.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test06 => fs_bind_rbind06.sh}    | 0
 .../fs/fs_bind/rbind/{test07-2 => fs_bind_rbind07-2.sh}       | 0
 .../kernel/fs/fs_bind/rbind/{test07 => fs_bind_rbind07.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test08 => fs_bind_rbind08.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test09 => fs_bind_rbind09.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test10 => fs_bind_rbind10.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test11 => fs_bind_rbind11.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test12 => fs_bind_rbind12.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test13 => fs_bind_rbind13.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test14 => fs_bind_rbind14.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test15 => fs_bind_rbind15.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test16 => fs_bind_rbind16.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test17 => fs_bind_rbind17.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test18 => fs_bind_rbind18.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test19 => fs_bind_rbind19.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test20 => fs_bind_rbind20.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test21 => fs_bind_rbind21.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test22 => fs_bind_rbind22.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test23 => fs_bind_rbind23.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test24 => fs_bind_rbind24.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test25 => fs_bind_rbind25.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test26 => fs_bind_rbind26.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test27 => fs_bind_rbind27.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test28 => fs_bind_rbind28.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test29 => fs_bind_rbind29.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test30 => fs_bind_rbind30.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test31 => fs_bind_rbind31.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test32 => fs_bind_rbind32.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test33 => fs_bind_rbind33.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test34 => fs_bind_rbind34.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test35 => fs_bind_rbind35.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test36 => fs_bind_rbind36.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test37 => fs_bind_rbind37.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test38 => fs_bind_rbind38.sh}    | 0
 .../kernel/fs/fs_bind/rbind/{test39 => fs_bind_rbind39.sh}    | 0
 testscripts/test_fs_bind.sh                                   | 4 ++--
 96 files changed, 3 insertions(+), 3 deletions(-)
 rename testcases/kernel/fs/fs_bind/bind/{test01 => fs_bind01.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test02 => fs_bind02.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test03 => fs_bind03.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test04 => fs_bind04.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test05 => fs_bind05.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test06 => fs_bind06.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test07-2 => fs_bind07-2.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test07 => fs_bind07.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test08 => fs_bind08.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test09 => fs_bind09.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test10 => fs_bind10.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test11 => fs_bind11.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test12 => fs_bind12.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test13 => fs_bind13.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test14 => fs_bind14.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test15 => fs_bind15.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test16 => fs_bind16.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test17 => fs_bind17.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test18 => fs_bind18.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test19 => fs_bind19.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test20 => fs_bind20.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test21 => fs_bind21.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test22 => fs_bind22.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test23 => fs_bind23.sh} (100%)
 rename testcases/kernel/fs/fs_bind/bind/{test24 => fs_bind24.sh} (100%)
 rename testcases/kernel/fs/fs_bind/cloneNS/{test01 => fs_bind_cloneNS01.sh} (100%)
 rename testcases/kernel/fs/fs_bind/cloneNS/{test02 => fs_bind_cloneNS02.sh} (100%)
 rename testcases/kernel/fs/fs_bind/cloneNS/{test03 => fs_bind_cloneNS03.sh} (100%)
 rename testcases/kernel/fs/fs_bind/cloneNS/{test04 => fs_bind_cloneNS04.sh} (100%)
 rename testcases/kernel/fs/fs_bind/cloneNS/{test05 => fs_bind_cloneNS05.sh} (100%)
 rename testcases/kernel/fs/fs_bind/cloneNS/{test06 => fs_bind_cloneNS06.sh} (100%)
 rename testcases/kernel/fs/fs_bind/cloneNS/{test07 => fs_bind_cloneNS07.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test01 => fs_bind_move01.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test02 => fs_bind_move02.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test03 => fs_bind_move03.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test04 => fs_bind_move04.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test05 => fs_bind_move05.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test06 => fs_bind_move06.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test07 => fs_bind_move07.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test08 => fs_bind_move08.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test09 => fs_bind_move09.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test10 => fs_bind_move10.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test11 => fs_bind_move11.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test12 => fs_bind_move12.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test13 => fs_bind_move13.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test14 => fs_bind_move14.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test15 => fs_bind_move15.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test16 => fs_bind_move16.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test17 => fs_bind_move17.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test18 => fs_bind_move18.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test19 => fs_bind_move19.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test20 => fs_bind_move20.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test21 => fs_bind_move21.sh} (100%)
 rename testcases/kernel/fs/fs_bind/move/{test22 => fs_bind_move22.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test01 => fs_bind_rbind01.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test02 => fs_bind_rbind02.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test03 => fs_bind_rbind03.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test04 => fs_bind_rbind04.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test05 => fs_bind_rbind05.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test06 => fs_bind_rbind06.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test07-2 => fs_bind_rbind07-2.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test07 => fs_bind_rbind07.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test08 => fs_bind_rbind08.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test09 => fs_bind_rbind09.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test10 => fs_bind_rbind10.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test11 => fs_bind_rbind11.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test12 => fs_bind_rbind12.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test13 => fs_bind_rbind13.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test14 => fs_bind_rbind14.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test15 => fs_bind_rbind15.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test16 => fs_bind_rbind16.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test17 => fs_bind_rbind17.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test18 => fs_bind_rbind18.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test19 => fs_bind_rbind19.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test20 => fs_bind_rbind20.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test21 => fs_bind_rbind21.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test22 => fs_bind_rbind22.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test23 => fs_bind_rbind23.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test24 => fs_bind_rbind24.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test25 => fs_bind_rbind25.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test26 => fs_bind_rbind26.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test27 => fs_bind_rbind27.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test28 => fs_bind_rbind28.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test29 => fs_bind_rbind29.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test30 => fs_bind_rbind30.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test31 => fs_bind_rbind31.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test32 => fs_bind_rbind32.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test33 => fs_bind_rbind33.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test34 => fs_bind_rbind34.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test35 => fs_bind_rbind35.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test36 => fs_bind_rbind36.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test37 => fs_bind_rbind37.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test38 => fs_bind_rbind38.sh} (100%)
 rename testcases/kernel/fs/fs_bind/rbind/{test39 => fs_bind_rbind39.sh} (100%)

diff --git a/testcases/kernel/fs/fs_bind/Makefile b/testcases/kernel/fs/fs_bind/Makefile
index 26d640831..d2b5b0f57 100644
--- a/testcases/kernel/fs/fs_bind/Makefile
+++ b/testcases/kernel/fs/fs_bind/Makefile
@@ -26,7 +26,7 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_DIR			:= $(prefix)/testcases/bin/fs_bind
 
-INSTALL_TARGETS			:= */test*
+INSTALL_TARGETS			:= */*.sh */test*
 
 RECURSIVE_TARGETS		:= all install uninstall
 
diff --git a/testcases/kernel/fs/fs_bind/bind/test01 b/testcases/kernel/fs/fs_bind/bind/fs_bind01.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test01
rename to testcases/kernel/fs/fs_bind/bind/fs_bind01.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test02 b/testcases/kernel/fs/fs_bind/bind/fs_bind02.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test02
rename to testcases/kernel/fs/fs_bind/bind/fs_bind02.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test03 b/testcases/kernel/fs/fs_bind/bind/fs_bind03.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test03
rename to testcases/kernel/fs/fs_bind/bind/fs_bind03.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test04 b/testcases/kernel/fs/fs_bind/bind/fs_bind04.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test04
rename to testcases/kernel/fs/fs_bind/bind/fs_bind04.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test05 b/testcases/kernel/fs/fs_bind/bind/fs_bind05.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test05
rename to testcases/kernel/fs/fs_bind/bind/fs_bind05.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test06 b/testcases/kernel/fs/fs_bind/bind/fs_bind06.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test06
rename to testcases/kernel/fs/fs_bind/bind/fs_bind06.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test07-2 b/testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test07-2
rename to testcases/kernel/fs/fs_bind/bind/fs_bind07-2.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test07 b/testcases/kernel/fs/fs_bind/bind/fs_bind07.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test07
rename to testcases/kernel/fs/fs_bind/bind/fs_bind07.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test08 b/testcases/kernel/fs/fs_bind/bind/fs_bind08.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test08
rename to testcases/kernel/fs/fs_bind/bind/fs_bind08.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test09 b/testcases/kernel/fs/fs_bind/bind/fs_bind09.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test09
rename to testcases/kernel/fs/fs_bind/bind/fs_bind09.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test10 b/testcases/kernel/fs/fs_bind/bind/fs_bind10.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test10
rename to testcases/kernel/fs/fs_bind/bind/fs_bind10.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test11 b/testcases/kernel/fs/fs_bind/bind/fs_bind11.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test11
rename to testcases/kernel/fs/fs_bind/bind/fs_bind11.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test12 b/testcases/kernel/fs/fs_bind/bind/fs_bind12.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test12
rename to testcases/kernel/fs/fs_bind/bind/fs_bind12.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test13 b/testcases/kernel/fs/fs_bind/bind/fs_bind13.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test13
rename to testcases/kernel/fs/fs_bind/bind/fs_bind13.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test14 b/testcases/kernel/fs/fs_bind/bind/fs_bind14.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test14
rename to testcases/kernel/fs/fs_bind/bind/fs_bind14.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test15 b/testcases/kernel/fs/fs_bind/bind/fs_bind15.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test15
rename to testcases/kernel/fs/fs_bind/bind/fs_bind15.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test16 b/testcases/kernel/fs/fs_bind/bind/fs_bind16.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test16
rename to testcases/kernel/fs/fs_bind/bind/fs_bind16.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test17 b/testcases/kernel/fs/fs_bind/bind/fs_bind17.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test17
rename to testcases/kernel/fs/fs_bind/bind/fs_bind17.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test18 b/testcases/kernel/fs/fs_bind/bind/fs_bind18.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test18
rename to testcases/kernel/fs/fs_bind/bind/fs_bind18.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test19 b/testcases/kernel/fs/fs_bind/bind/fs_bind19.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test19
rename to testcases/kernel/fs/fs_bind/bind/fs_bind19.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test20 b/testcases/kernel/fs/fs_bind/bind/fs_bind20.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test20
rename to testcases/kernel/fs/fs_bind/bind/fs_bind20.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test21 b/testcases/kernel/fs/fs_bind/bind/fs_bind21.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test21
rename to testcases/kernel/fs/fs_bind/bind/fs_bind21.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test22 b/testcases/kernel/fs/fs_bind/bind/fs_bind22.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test22
rename to testcases/kernel/fs/fs_bind/bind/fs_bind22.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test23 b/testcases/kernel/fs/fs_bind/bind/fs_bind23.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test23
rename to testcases/kernel/fs/fs_bind/bind/fs_bind23.sh
diff --git a/testcases/kernel/fs/fs_bind/bind/test24 b/testcases/kernel/fs/fs_bind/bind/fs_bind24.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/bind/test24
rename to testcases/kernel/fs/fs_bind/bind/fs_bind24.sh
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test01 b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/cloneNS/test01
rename to testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS01.sh
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test02 b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/cloneNS/test02
rename to testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS02.sh
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test03 b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/cloneNS/test03
rename to testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS03.sh
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test04 b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/cloneNS/test04
rename to testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS04.sh
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test05 b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/cloneNS/test05
rename to testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS05.sh
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test06 b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/cloneNS/test06
rename to testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS06.sh
diff --git a/testcases/kernel/fs/fs_bind/cloneNS/test07 b/testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/cloneNS/test07
rename to testcases/kernel/fs/fs_bind/cloneNS/fs_bind_cloneNS07.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test01 b/testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test01
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move01.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test02 b/testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test02
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move02.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test03 b/testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test03
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move03.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test04 b/testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test04
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move04.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test05 b/testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test05
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move05.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test06 b/testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test06
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move06.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test07 b/testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test07
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move07.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test08 b/testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test08
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move08.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test09 b/testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test09
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move09.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test10 b/testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test10
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move10.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test11 b/testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test11
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move11.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test12 b/testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test12
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move12.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test13 b/testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test13
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move13.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test14 b/testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test14
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move14.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test15 b/testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test15
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move15.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test16 b/testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test16
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move16.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test17 b/testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test17
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move17.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test18 b/testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test18
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move18.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test19 b/testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test19
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move19.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test20 b/testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test20
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move20.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test21 b/testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test21
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move21.sh
diff --git a/testcases/kernel/fs/fs_bind/move/test22 b/testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/move/test22
rename to testcases/kernel/fs/fs_bind/move/fs_bind_move22.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test01 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test01
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind01.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test02 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test02
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind02.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test03 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test03
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind03.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test04 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test04
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind04.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test05 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test05
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind05.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test06 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test06
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind06.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test07-2 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test07-2
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07-2.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test07 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test07
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind07.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test08 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test08
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind08.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test09 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test09
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind09.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test10 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test10
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind10.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test11 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test11
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind11.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test12 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test12
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind12.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test13 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test13
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind13.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test14 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test14
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind14.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test15 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test15
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind15.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test16 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test16
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind16.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test17 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test17
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind17.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test18 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test18
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind18.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test19 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test19
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind19.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test20 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test20
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind20.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test21 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test21
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind21.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test22 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test22
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind22.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test23 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test23
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind23.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test24 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test24
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind24.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test25 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test25
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind25.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test26 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test26
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind26.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test27 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test27
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind27.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test28 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test28
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind28.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test29 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test29
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind29.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test30 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test30
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind30.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test31 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test31
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind31.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test32 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test32
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind32.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test33 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test33
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind33.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test34 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test34
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind34.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test35 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test35
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind35.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test36 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test36
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind36.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test37 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test37
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind37.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test38 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test38
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind38.sh
diff --git a/testcases/kernel/fs/fs_bind/rbind/test39 b/testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh
similarity index 100%
rename from testcases/kernel/fs/fs_bind/rbind/test39
rename to testcases/kernel/fs/fs_bind/rbind/fs_bind_rbind39.sh
diff --git a/testscripts/test_fs_bind.sh b/testscripts/test_fs_bind.sh
index d06564d7b..f78c1c92b 100755
--- a/testscripts/test_fs_bind.sh
+++ b/testscripts/test_fs_bind.sh
@@ -63,7 +63,7 @@ test_setup()
 
 	total=0 # total number of tests
 	for dir in "${test_dirs[@]}" ; do
-		((total += `ls "${FS_BIND_ROOT}/${dir}/test"* | wc -l`))
+		((total += `ls "${FS_BIND_ROOT}/${dir}/"*.sh | wc -l`))
 	done
 	TST_TOTAL=${total}
 
@@ -480,7 +480,7 @@ main()
 {
 	TST_COUNT=1
 	for dir in "${test_dirs[@]}" ; do
-		tests=( $(find "${FS_BIND_ROOT}/${dir}" -type f -name 'test*') )
+		tests=( $(find "${FS_BIND_ROOT}/${dir}" -type f -name '*.sh') )
 		clean_sandbox "$0" || break
 		for t in "${tests[@]}" ; do
 			run_test "$t"
-- 
2.25.1

