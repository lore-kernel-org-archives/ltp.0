From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Wed, 10 Apr 2019 00:45:20 +0800
Subject: [LTP] =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
Message-ID: <db7687f3-40ca-495e-aa76-efcce204cda7.ruanzw@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Could anyone help me to review this patch? This is useful to cross-compile ltp for Android without specifying '-D__ANDROID__' in configure step.

Thanks!
Zhengwang


------------------------------------------------------------------
发件人：Zhengwang Ruan <ruanzw@xiaopeng.com>
发送时间：2019年4月9日(星期二) 12:05
收件人：ltp <ltp@lists.linux.it>
抄　送：Zhengwang Ruan <ruanzw@xiaopeng.com>
主　题：[PATCH v1] include/mk/env_post.mk: enable __ANDROID__ definition for Android build

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
-CFLAGS    += -Werror-implicit-function-declaration
+CFLAGS    += -Werror-implicit-function-declaration -D__ANDROID__

 LDFLAGS    += -L$(top_builddir)/lib/android_libpthread
 LDFLAGS    += -L$(top_builddir)/lib/android_librt
-- 
2.7.4

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190410/8684835f/attachment-0001.html>
