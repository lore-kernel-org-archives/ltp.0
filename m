From: Zhengwang Ruan <ruanzw@xiaopeng.com>
Date: Thu, 25 Apr 2019 00:55:39 +0800
Subject: [LTP] [PATCH v2] include/mk/env_post.mk: enable __ANDROID__
	definition for Android build
Message-ID: <1556124939-7699-1-git-send-email-ruanzw@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The definition of __ANDROID__ has been widely used to compile android-specific
things (i.e. busybox [1] [2], dnsmasq [3]), so we expected NDK to automatically
pass it to help build LTP for android, but unfortunately it didn't (it is tested
with android-ndk-r19c). Currently, we have to manually specify -D__ANDROID__ in
configure step before launch 'make ANDROID=1' command, and this is suffering for
those who don't have good knowledge of LTP, so it is necessary to enable it if
built for android.

In the past, there had been a lot of discussion about which one of __ANDROID__
and ANDROID was the best choice to define the android-only code, but __ANDROID__
seems better right now [4].

[1] https://git.busybox.net/busybox/tree/configs/android_defconfig
[2] https://git.busybox.net/busybox/tree/configs/android_ndk_defconfig
[3] http://thekelleys.org.uk/gitweb/?p=dnsmasq.git;a=blob_plain;f=bld/Android.mk;hb=HEAD
[4] https://groups.google.com/forum/#!topic/android-ndk/cf9_f1SLXls

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

