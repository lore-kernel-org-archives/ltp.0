From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 30 Sep 2020 15:50:09 +0100
Subject: [LTP] [PATCH 3/3] eventfd01: Handle no AIO support
In-Reply-To: <20200930145009.16260-1-rpalethorpe@suse.com>
References: <20200930145009.16260-1-rpalethorpe@suse.com>
Message-ID: <20200930145009.16260-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/eventfd/eventfd01.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/eventfd/eventfd01.c b/testcases/kernel/syscalls/eventfd/eventfd01.c
index e4f9c804a..4d888910b 100644
--- a/testcases/kernel/syscalls/eventfd/eventfd01.c
+++ b/testcases/kernel/syscalls/eventfd/eventfd01.c
@@ -510,6 +510,11 @@ static int trigger_eventfd_overflow(int evfd, int *fd, io_context_t * ctx)
 	ret = io_setup(16, ctx);
 	if (ret < 0) {
 		errno = -ret;
+		if (errno == ENOSYS) {
+			tst_brkm(TCONF | TERRNO, cleanup,
+				 "io_setup(): AIO not supported by kernel");
+		}
+
 		tst_resm(TINFO | TERRNO, "io_setup error");
 		return -1;
 	}
-- 
2.28.0

