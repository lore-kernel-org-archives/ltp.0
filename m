From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Oct 2015 03:11:38 +0000
Subject: [LTP] [PATCH 2/11] capset/capset02: Testcase failed when no root
	user run it
In-Reply-To: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
Message-ID: <1446001907-43525-2-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add tst_require_root() to testcase for seteuid().

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/capset/capset02.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/capset/capset02.c b/testcases/kernel/syscalls/capset/capset02.c
index 146755c..d08878e 100644
--- a/testcases/kernel/syscalls/capset/capset02.c
+++ b/testcases/kernel/syscalls/capset/capset02.c
@@ -174,6 +174,7 @@ int main(int ac, char **av)
 
 void setup(void)
 {
+	tst_require_root();
 
 	TEST_PAUSE;
 
-- 
1.6.0.2

