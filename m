From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 22 Apr 2020 12:20:07 +0200
Subject: [LTP] [PATCH] Add tags to setsockopt04 and add it to the CVE runfile
Message-ID: <20200422102007.14244-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #491

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

This test scenario has some potential to cause false positives if the send
buffer size changes to unsigned type in kernel.

 runtest/cve                                         | 1 +
 testcases/kernel/syscalls/setsockopt/setsockopt04.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 629cf7035..942e5a5d7 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -13,6 +13,7 @@ cve-2016-5195 dirtyc0w
 cve-2016-7042 cve-2016-7042
 cve-2016-7117 cve-2016-7117
 cve-2016-9604 keyctl08
+cve-2016-9793 setsockopt04
 cve-2016-10044 cve-2016-10044
 cve-2017-2618 cve-2017-2618
 cve-2017-2671 cve-2017-2671
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt04.c b/testcases/kernel/syscalls/setsockopt/setsockopt04.c
index fda5c6b02..50d82346c 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt04.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt04.c
@@ -61,4 +61,9 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "b98b0bc8c431"},
+		{"CVE", "2016-9793"},
+		{}
+	}
 };
-- 
2.26.0

