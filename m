From: Zhengwang Ruan <ruanzw@xiaopeng.com>
Date: Tue,  9 Apr 2019 12:05:10 +0800
Subject: [LTP] [PATCH v1] include/mk/env_post.mk: enable __ANDROID__
	definition for Android build
Message-ID: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Enable the __ANDROID__ definition by default for Android build, otherwise we
should manually enable it by configure command.

Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
---
 include/mk/env_post.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 913bdf5..7953e0a 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -44,7 +44,7 @@ endif
 ifeq ($(ANDROID),1)
 # There are many undeclared functions, it's best not to accidentally overlook
 # them.
-CFLAGS				+= -Werror-implicit-function-declaration
+CFLAGS				+= -Werror-implicit-function-declaration -D__ANDROID__
 
 LDFLAGS				+= -L$(top_builddir)/lib/android_libpthread
 LDFLAGS				+= -L$(top_builddir)/lib/android_librt
-- 
2.7.4

