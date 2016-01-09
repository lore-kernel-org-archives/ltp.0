From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:13:49 +0000
Subject: [LTP] [PATCH V2 01/32] ltp: Don't link against libfl
Message-ID: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Chong Lu <Chong.Lu@windriver.com>

We have already defined yywrap function in scan.l file. After this, we no longer need to
link against libfl and so no longer get errors about undefined references to yylex.

Signed-off-by: Chong Lu <Chong.Lu@windriver.com>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 pan/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pan/Makefile b/pan/Makefile
index 4cc6466..a4b575b 100644
--- a/pan/Makefile
+++ b/pan/Makefile
@@ -31,7 +31,7 @@ CPPFLAGS		+= -Wno-error
 
 CPPFLAGS		+= -I$(abs_srcdir)
 
-LDLIBS			+= -lm $(LEXLIB)
+LDLIBS			+= -lm
 
 LFLAGS			+= -l
 
-- 
2.7.0

