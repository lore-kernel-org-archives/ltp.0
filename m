From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  7 Feb 2018 16:36:50 +0100
Subject: [LTP] [RFC PATCH 1/1] numa: Fix TCONF message when numa disabled
	with --without-numa
Message-ID: <20180207153650.15095-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Default error message was misleading when using --without-numa configure
option.

Fixes: 39a85a1f1 ("configure: add knob to control numa support")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac                                                  | 11 ++++++++---
 include/mk/config.mk.in                                       |  1 +
 .../cpuset/cpuset_syscall_test/cpuset_syscall_test.c          |  2 +-
 testcases/kernel/hotplug/memory_hotplug/memtoy.c              |  2 +-
 testcases/kernel/mem/cpuset/cpuset01.c                        |  2 +-
 testcases/kernel/mem/ksm/ksm02.c                              |  2 +-
 testcases/kernel/mem/ksm/ksm04.c                              |  2 +-
 testcases/kernel/mem/ksm/ksm06.c                              |  2 +-
 testcases/kernel/mem/oom/oom02.c                              |  2 +-
 testcases/kernel/mem/oom/oom03.c                              |  2 +-
 testcases/kernel/mem/oom/oom04.c                              |  2 +-
 testcases/kernel/mem/oom/oom05.c                              |  2 +-
 testcases/kernel/mem/vma/vma02.c                              |  2 +-
 testcases/kernel/mem/vma/vma04.c                              |  2 +-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c     |  2 +-
 testcases/kernel/syscalls/mbind/mbind01.c                     |  2 +-
 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c     |  3 +--
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c     |  3 +--
 .../kernel/syscalls/migrate_pages/migrate_pages_common.h      |  2 ++
 testcases/kernel/syscalls/move_pages/move_pages01.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages02.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages03.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages04.c           |  3 +--
 testcases/kernel/syscalls/move_pages/move_pages05.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages06.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages07.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages08.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages09.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages10.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages11.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages12.c           |  2 +-
 testcases/kernel/syscalls/move_pages/move_pages_support.c     |  2 +-
 32 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/configure.ac b/configure.ac
index d66ea00e1..da3374913 100644
--- a/configure.ac
+++ b/configure.ac
@@ -165,9 +165,6 @@ LTP_CHECK_SELINUX
 LTP_CHECK_SIGNAL
 LTP_CHECK_SYSCALL_EVENTFD
 LTP_CHECK_SYSCALL_MODIFY_LDT
-if test "x$with_numa" = xyes; then
-LTP_CHECK_SYSCALL_NUMA
-fi
 LTP_CHECK_SYSCALL_QUOTACTL
 LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UNSHARE
@@ -215,4 +212,12 @@ LTP_CHECK_ATOMIC_MEMORY_MODEL
 LTP_CHECK_TPACKET_V3
 LTP_DETECT_HOST_CPU
 
+if test "x$with_numa" = xyes; then
+	LTP_CHECK_SYSCALL_NUMA
+	numa_error_msg="test requires libnuma >= 2 and it's development packages"
+else
+	numa_error_msg="NUMA support was disabled during build"
+fi
+AC_DEFINE_UNQUOTED(NUMA_ERROR_MSG, ["$numa_error_msg"], [Error message when no NUMA support])
+
 AC_OUTPUT
diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
index 01f178bff..b564c1cea 100644
--- a/include/mk/config.mk.in
+++ b/include/mk/config.mk.in
@@ -82,6 +82,7 @@ LINUX_VERSION_PATCH	:= @LINUX_VERSION_PATCH@
 WITH_MODULES		:= @WITH_MODULES@
 
 HOST_CPU		:= @HOST_CPU@
+NUMA_ERROR_MSG	:= @NUMA_ERROR_MSG@
 
 ifeq ($(strip $(prefix)),)
 $(error you are using $$(prefix) incorrectly -- set it to $(abs_top_srcdir) if you want to build in the source tree)
diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index f5049bfc0..16a01aa03 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -232,6 +232,6 @@ int main(int argc, char *argv[])
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "test requires libnuma >= 2 and it's development packages");
+	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
 }
 #endif
diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
index 8fec4ca51..0707a9c8c 100644
--- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
+++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
@@ -497,7 +497,7 @@ int main(int argc, char *argv[])
 #else
 int main(void)
 {
-	fprintf(stderr, "test requires libnuma >= 2 and it's development packages\n");
+	fprintf(stderr, NUMA_ERROR_MSG "\n");
 	return TCONF;
 }
 #endif
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 354b6fc32..853f7fe55 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -190,5 +190,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index f5511ed0c..03b44c059 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -119,5 +119,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index c3866392b..835222f17 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -123,5 +123,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index dfcb5d509..53d532cd1 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -103,5 +103,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 45e64d370..bdf4561a7 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -75,5 +75,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index c4b90c190..3e118c89b 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -89,5 +89,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 7dbf9ce70..760cb06af 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -97,5 +97,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index eb2453156..367b5119c 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -123,5 +123,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/mem/vma/vma02.c b/testcases/kernel/mem/vma/vma02.c
index 33d000d01..3d91863c3 100644
--- a/testcases/kernel/mem/vma/vma02.c
+++ b/testcases/kernel/mem/vma/vma02.c
@@ -166,6 +166,6 @@ void usage(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "test requires libnuma >= 2 and it's development packages");
+	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
 }
 #endif
diff --git a/testcases/kernel/mem/vma/vma04.c b/testcases/kernel/mem/vma/vma04.c
index a5918bcb7..8be025ae9 100644
--- a/testcases/kernel/mem/vma/vma04.c
+++ b/testcases/kernel/mem/vma/vma04.c
@@ -327,6 +327,6 @@ static void usage(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "test requires libnuma >= 2 and it's development packages");
+	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
 }
 #endif
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index a1b9e4327..fcb677986 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -315,6 +315,6 @@ static void setup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "test requires libnuma >= 2 and it's development packages");
+	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
 }
 #endif
diff --git a/testcases/kernel/syscalls/mbind/mbind01.c b/testcases/kernel/syscalls/mbind/mbind01.c
index 4eb7da698..4b63ed7d4 100644
--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -237,5 +237,5 @@ static struct tst_test test = {
 };
 
 #else
-TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 01409f300..b01401c5f 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -253,7 +253,6 @@ static void cleanup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't support __NR_migrate_pages or "
-		 "libnuma or libnuma development packages are not available");
+	tst_brkm(TCONF, NULL, NUMA_MIGRATE_PAGES_ERROR_MSG);
 }
 #endif
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index faf96b6b7..879a80f1a 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -402,7 +402,6 @@ static void cleanup(void)
 #else
 int main(void)
 {
-	tst_brkm(TCONF, NULL, "System doesn't support __NR_migrate_pages or "
-		 "libnuma or libnuma development packages are not available");
+	tst_brkm(TCONF, NULL, NUMA_MIGRATE_PAGES_ERROR_MSG);
 }
 #endif
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
index d821b07bd..77623bfac 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
@@ -27,6 +27,8 @@
 
 #define bitsperlong (8 * sizeof(unsigned long))
 
+#define NUMA_MIGRATE_PAGES_ERROR_MSG NUMA_ERROR_MSG " or system doesn't support __NR_migrate_pages"
+
 void set_bit(unsigned long *b, unsigned int n, unsigned int v);
 int check_ret(long expected_ret);
 int check_errno(long expected_errno);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages01.c b/testcases/kernel/syscalls/move_pages/move_pages01.c
index e86c5fc80..f541e9f22 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages01.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages01.c
@@ -101,7 +101,7 @@ int main(int argc, char **argv)
 
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index ee84b92a7..728f88f5a 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -117,7 +117,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index f3f4fd9c1..88a94d92d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -183,7 +183,7 @@ err_free_pages:
 		free_shared_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 3678df0e0..bf24a0895 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -150,12 +150,11 @@ err_free_pages:
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
 	tst_exit();
-
 }
 
 /*
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index da9642e7e..51ac058e0 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -198,7 +198,7 @@ err_free_shared:
 		free_shared_pages(pages + SHARED_PAGE, N_SHARED_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages06.c b/testcases/kernel/syscalls/move_pages/move_pages06.c
index 0edb58218..e65568123 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -113,7 +113,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index 0ed54b77a..ac3d11091 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -115,7 +115,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index bf237f35e..e1bf64b77 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -113,7 +113,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 2d9dc4680..273c750ff 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -125,7 +125,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages10.c b/testcases/kernel/syscalls/move_pages/move_pages10.c
index 7044135fa..5ff72a8b4 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages10.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages10.c
@@ -112,7 +112,7 @@ int main(int argc, char **argv)
 		free_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index a9d84c5d5..dec930b0e 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -186,7 +186,7 @@ err_free_pages:
 		free_shared_pages(pages, TEST_PAGES);
 	}
 #else
-	tst_resm(TCONF, "test requires libnuma >= 2 and it's development packages");
+	tst_resm(TCONF, NUMA_ERROR_MSG);
 #endif
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 1ac7bc1c4..4c37bfe4c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -267,5 +267,5 @@ static struct tst_test test = {
 };
 
 #else
-	TST_TEST_TCONF("test requires libnuma >= 2 and it's development packages");
+	TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/syscalls/move_pages/move_pages_support.c b/testcases/kernel/syscalls/move_pages/move_pages_support.c
index 31f74968f..610f570d0 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages_support.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages_support.c
@@ -409,6 +409,6 @@ void check_config(unsigned int min_nodes)
 		tst_brkm(TCONF, NULL, "2.6.18 or greater kernel required");
 	}
 #else
-	tst_brkm(TCONF, NULL, "NUMA support not provided");
+	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
 #endif
 }
-- 
2.16.1

