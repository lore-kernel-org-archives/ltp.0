From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 21 Sep 2015 15:32:09 +0200
Subject: [LTP] [PATCH] include config.mk and features.mk in env_pre.mk only
	if they exist
Message-ID: <f1dfb6560fe17718bd189544b27c793251c1efca.1442842161.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

$ git clean -f -d -x
$ make autotools

now leads to an infinite loop, that is running help target:
make -C /usr/src/ltp help; false
make[1]: Entering directory `/usr/src/ltp'
make -C /usr/src/ltp help; false
make[2]: Entering directory `/usr/src/ltp'
make -C /usr/src/ltp help; false
make[3]: Entering directory `/usr/src/ltp'
make -C /usr/src/ltp help; false
...

because include/mk/automake.mk has rule for these 2 files, which
don't exist in clean tree. So it triggers help target, which again
includes env_pre.mk and loop continues.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/mk/env_pre.mk | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
index 9c757e35e455..a7674141c83c 100644
--- a/include/mk/env_pre.mk
+++ b/include/mk/env_pre.mk
@@ -98,8 +98,12 @@ endif
 # which are filtered below (e.g. clean). However these config files may be
 # needed for those targets (eg. the open posix testsuite is not cleaned even if
 # it's enabled by configure) thus it would be wise to do silent inclusion.
--include $(abs_top_builddir)/include/mk/config.mk
--include $(abs_top_builddir)/include/mk/features.mk
+ifneq ($(wildcard $(abs_top_builddir)/include/mk/config.mk),)
+include $(abs_top_builddir)/include/mk/config.mk
+endif
+ifneq ($(wildcard $(abs_top_builddir)/include/mk/features.mk),)
+include $(abs_top_builddir)/include/mk/features.mk
+endif
 
 # autotools, *clean, and help don't require config.mk, features.mk, etc...
 ifeq ($(filter autotools %clean .gitignore gitignore.% help,$(MAKECMDGOALS)),)
-- 
1.8.3.1

