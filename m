From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:11 +0200
Subject: [LTP] [COMMITTED] [PATCH 38/40] syscalls/open03: Make use of
	SAFE_CLOSE()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-38-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Coccinelle haven't caught this one because of the else branch.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/open/open03.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open03.c b/testcases/kernel/syscalls/open/open03.c
index 80e43c6e9..aa15ee9e9 100644
--- a/testcases/kernel/syscalls/open/open03.c
+++ b/testcases/kernel/syscalls/open/open03.c
@@ -64,10 +64,8 @@ int main(int ac, char **av)
 				 "open(%s, O_RDWR|O_CREAT,0700) returned %ld",
 				 fname, TEST_RETURN);
 
-			if (close(fd) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "close(%s) failed", fname);
-			else SAFE_UNLINK(cleanup, fname);
+			SAFE_CLOSE(cleanup, fd);
+			SAFE_UNLINK(cleanup, fname);
 		}
 	}
 
-- 
2.13.5

