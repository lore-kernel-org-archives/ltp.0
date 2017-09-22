From: Sandeep Patil <sspatil@google.com>
Date: Fri, 22 Sep 2017 15:59:41 -0700
Subject: [LTP] [PATCH] mm: mmapstress04: Remove arguments passed to the test.
Message-ID: <20170922225941.100991-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test doesn't take any arguments, so don't pass it any.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 runtest/mm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/mm b/runtest/mm
index 55fc2cab0..76d233562 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -46,7 +46,7 @@ mallocstress01	mallocstress
 mmapstress01 mmapstress01 -p 20 -t 0.2
 mmapstress02 mmapstress02
 mmapstress03 mmapstress03
-mmapstress04 TMPFILE=`mktemp /tmp/example.XXXXXXXXXX`; ls -lR /usr/include/ > $TMPFILE; mmapstress04 $TMPFILE
+mmapstress04 mmapstress04
 mmapstress05 mmapstress05
 mmapstress06 mmapstress06 20
 mmapstress07 TMPFILE=`mktemp /tmp/example.XXXXXXXXXXXX`; mmapstress07 $TMPFILE
-- 
2.14.1.821.g8fa685d3b7-goog

