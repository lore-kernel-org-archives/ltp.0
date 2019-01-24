From: Steve Muckle <smuckle@google.com>
Date: Thu, 24 Jan 2019 11:28:49 -0800
Subject: [LTP] [PATCH] syscalls: add getresgid*_16,
	getresuid*_16 to runtest/syscalls
Message-ID: <20190124192849.47482-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These tests were recently created. Add them to the syscalls suite
of tests.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 runtest/syscalls | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 34b47f36b..45fcebdd9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -430,12 +430,18 @@ getrandom03 getrandom03
 getrandom04 getrandom04
 
 getresgid01 getresgid01
+getresgid01_16 getresgid01_16
 getresgid02 getresgid02
+getresgid02_16 getresgid02_16
 getresgid03 getresgid03
+getresgid03_16 getresgid03_16
 
 getresuid01 getresuid01
+getresuid01_16 getresuid01_16
 getresuid02 getresuid02
+getresuid02_16 getresuid02_16
 getresuid03 getresuid03
+getresuid03_16 getresuid03_16
 
 getrlimit01 getrlimit01
 getrlimit02 getrlimit02
-- 
2.20.1.321.g9e740568ce-goog

