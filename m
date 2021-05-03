From: Ankit Jain <ankitja@vmware.com>
Date: Mon, 3 May 2021 13:37:19 +0530
Subject: [LTP] [PATCH] realtime/func/pi-tests: testpi-2 parser indentation
 fix
Message-ID: <1620029239-31643-1-git-send-email-ankitja@vmware.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is an indentation issue in parser for testpi-2
which causes incorect parsing of the logs.

Signed-off-by: Ankit Jain <ankitja@vmware.com>
---
 testcases/realtime/func/pi-tests/parse-testpi2.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/parse-testpi2.py b/testcases/realtime/func/pi-tests/parse-testpi2.py
index 69b2748..a455843 100644
--- a/testcases/realtime/func/pi-tests/parse-testpi2.py
+++ b/testcases/realtime/func/pi-tests/parse-testpi2.py
@@ -49,10 +49,8 @@ class TestPi2(Log):
					flag=True
				elif count == 0:
					return False
+			prev_line=line

-
-
-		prev_line=line
		if count>=2:
			return True
		else:
--
2.7.4
