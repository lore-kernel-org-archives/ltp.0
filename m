From: Piotr Gawel <piotr.krzysztof.gawel@gmail.com>
Date: Wed, 24 Jul 2019 20:23:43 +0200
Subject: [LTP] [PATCH] tst_timer: fix qsort comparison function
In-Reply-To: <1563992624-4968-1-git-send-email-piotr.krzysztof.gawel@gmail.com>
References: <1563992624-4968-1-git-send-email-piotr.krzysztof.gawel@gmail.com>
Message-ID: <1563992624-4968-2-git-send-email-piotr.krzysztof.gawel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From qsort() manual:
    The  comparison  function must return an integer
    less than, equal to, or greater than zero if the
    first argument is considered to be respectively
    less than, equal to, or greater than the second.
    If two members compare as equal, their order in
    the sorted array is undefined.
We need it in descending order so the logic is
reverted.

Signed-off-by: Piotr Gawel <piotr.krzysztof.gawel@gmail.com>
---
 lib/tst_timer_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 4c16b59..f6459e5 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -159,7 +159,7 @@ static int cmp(const void *a, const void *b)
 {
 	const long long *aa = a, *bb = b;
 
-	return *aa < *bb;
+	return (*bb - *aa);
 }
 
 /*
-- 
2.7.4

