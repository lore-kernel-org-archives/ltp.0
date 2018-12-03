From: Greg Hackmann <ghackmann@google.com>
Date: Mon,  3 Dec 2018 11:01:48 -0800
Subject: [LTP] [PATCH 2/2] getrlimit/getrlimit03: add test to
	runtest/syscalls
In-Reply-To: <20181203190148.93108-1-ghackmann@google.com>
References: <20181203190148.93108-1-ghackmann@google.com>
Message-ID: <20181203190148.93108-2-ghackmann@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When I added this test, I forgot to add it to runtest/syscalls.  Let's
fix that.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 runtest/syscalls | 1 +
 1 file changed, 1 insertion(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index ac1d2d2cd..34b47f36b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -439,6 +439,7 @@ getresuid03 getresuid03
 
 getrlimit01 getrlimit01
 getrlimit02 getrlimit02
+getrlimit03 getrlimit03
 
 get_mempolicy01 get_mempolicy01
 get_robust_list01 get_robust_list01
-- 
2.20.0.rc1.387.gf8505762e3-goog

