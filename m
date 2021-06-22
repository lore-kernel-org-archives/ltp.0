From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 22 Jun 2021 12:35:14 +0100
Subject: [LTP] [PATCH 8/8] locktests: Fix uninitialized var error
In-Reply-To: <20210622113514.22284-1-rpalethorpe@suse.com>
References: <20210622113514.22284-1-rpalethorpe@suse.com>
Message-ID: <20210622113514.22284-9-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The compiler does not appear to understand that the initial
state (SELECT) will always initialize tLock in the first
iteration. Initializing tLock to zero suppresses the error.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/network/nfsv4/locks/locktests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/nfsv4/locks/locktests.c b/testcases/network/nfsv4/locks/locktests.c
index d2c766bc1..54faca3ec 100644
--- a/testcases/network/nfsv4/locks/locktests.c
+++ b/testcases/network/nfsv4/locks/locktests.c
@@ -580,7 +580,7 @@ int master(void)
 	char dbg[16];
 #endif
 	struct flock request;
-	struct s_test tLock;
+	struct s_test tLock = { 0 };
 	enum state_t state;
 	int offset;
 	/* A test sentence written in the file */
-- 
2.31.1

