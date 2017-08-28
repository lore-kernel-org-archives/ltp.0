From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Aug 2017 16:32:02 +0200
Subject: [LTP] [PATCH 4/4] [COMMITTED] nfsv4/locktest: Remove send-bugs line
	from help
In-Reply-To: <20170828143202.24021-1-chrubis@suse.cz>
References: <20170828143202.24021-1-chrubis@suse.cz>
Message-ID: <20170828143202.24021-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The ext.bull.net does not resolve to anything anyway and looking at
webarchive the bull.net went defunct in 1999.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/nfsv4/locks/locktests.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/network/nfsv4/locks/locktests.c b/testcases/network/nfsv4/locks/locktests.c
index 869dbe3c8..330c23b3b 100644
--- a/testcases/network/nfsv4/locks/locktests.c
+++ b/testcases/network/nfsv4/locks/locktests.c
@@ -943,8 +943,6 @@ int usage(void)
 {
 	printf("locktest -n <number of process> -f <test file> [-T]\n");
 	printf("Number of child process must be higher than 1\n");
-	printf("\n");
-	printf("Send bugs to vincent.roqueta@ext.bull.net\n");
 	exit(0);
 	return 0;
 }
-- 
2.13.0

