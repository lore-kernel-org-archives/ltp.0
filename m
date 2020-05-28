From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 28 May 2020 13:45:56 -0700
Subject: [LTP] [PATCH] sigwaitinfo: Do not run invalid/undefined test cases
Message-ID: <20200528204556.2444156-1-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These testcases run for eternity on musl

test_bad_address* cases are passing invalid pointers to a function; that's always UB
empty_set and timeout rely on the implementation-defined "may fail" for EINTR in sigtimedwait [1]

normally "may fail" is an "unspecified" but here the impl
is supposed to document it so it's "impl-defined"

[1] https://pubs.opengroup.org/onlinepubs/9699919799/functions/sigtimedwait.html

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Rich Felker <dalias@aerifal.cx>
---
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c      | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 6a30c27f6f..3a4cfe1b43 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -452,25 +452,17 @@ struct test_desc {
 #endif
 #if defined TEST_SIGWAITINFO
 	{
-	test_empty_set, my_sigwaitinfo, SIGUSR1}, {
 	test_unmasked_matching, my_sigwaitinfo, SIGUSR1}, {
 	test_masked_matching, my_sigwaitinfo, SIGUSR1}, {
 	test_unmasked_matching_noinfo, my_sigwaitinfo, SIGUSR1}, {
-	test_masked_matching_noinfo, my_sigwaitinfo, SIGUSR1}, {
-	test_bad_address, my_sigwaitinfo, SIGUSR1}, {
-	test_bad_address2, my_sigwaitinfo, SIGUSR1},
+	test_masked_matching_noinfo, my_sigwaitinfo, SIGUSR1},
 #endif
 #if defined TEST_SIGTIMEDWAIT
 	{
-	test_empty_set, my_sigtimedwait, SIGUSR1}, {
 	test_unmasked_matching, my_sigtimedwait, SIGUSR1}, {
 	test_masked_matching, my_sigtimedwait, SIGUSR1}, {
 	test_unmasked_matching_noinfo, my_sigtimedwait, SIGUSR1}, {
-	test_masked_matching_noinfo, my_sigtimedwait, SIGUSR1}, {
-	test_bad_address, my_sigtimedwait, SIGUSR1}, {
-	test_bad_address2, my_sigtimedwait, SIGUSR1}, {
-	test_bad_address3, my_sigtimedwait, SIGUSR1}, {
-	test_timeout, my_sigtimedwait, 0},
+	test_masked_matching_noinfo, my_sigtimedwait, SIGUSR1},
 #endif
 };
 
-- 
2.26.2

