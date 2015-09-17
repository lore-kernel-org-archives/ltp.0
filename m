From: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Date: Thu, 17 Sep 2015 21:51:57 +0300
Subject: [LTP] [PATCH] Fix including config.mk and features.mk in env_pre.mk
Message-ID: <1442515917-8628-1-git-send-email-yuriy.kolerov@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If you try to run make in the clean sources tree then it leads
to the infinite loop.

So check if config.mk or features.mk exists before inclusing and
don't use "-include" form. The problem is that inclusion of these
files may lead to the infinite loop if these files don't exist.
It happens because config.mk and features.mk have recipes and
Make tries to generate them and include them in env_pre.mk again
and again until resources are exhausted.

Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
---
 include/mk/env_pre.mk | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
index 9c757e3..b8d47d4 100644
--- a/include/mk/env_pre.mk
+++ b/include/mk/env_pre.mk
@@ -98,8 +98,12 @@ endif
 # which are filtered below (e.g. clean). However these config files may be
 # needed for those targets (eg. the open posix testsuite is not cleaned even if
 # it's enabled by configure) thus it would be wise to do silent inclusion.
--include $(abs_top_builddir)/include/mk/config.mk
--include $(abs_top_builddir)/include/mk/features.mk
+ifneq ("$(wildcard $(abs_top_builddir)/include/mk/config.mk)","")
+include $(abs_top_builddir)/include/mk/config.mk
+endif
+ifneq ("$(wildcard $(abs_top_builddir)/include/mk/features.mk)","")
+include $(abs_top_builddir)/include/mk/features.mk
+endif
 
 # autotools, *clean, and help don't require config.mk, features.mk, etc...
 ifeq ($(filter autotools %clean .gitignore gitignore.% help,$(MAKECMDGOALS)),)
-- 
2.2.0

