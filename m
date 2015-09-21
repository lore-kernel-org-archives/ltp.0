From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 21 Sep 2015 15:52:03 +0200
Subject: [LTP] [PATCH v2] avoid triggering config.mk/features.mk target in
	clean tree
Message-ID: <a10a17c27f9aa95c40f8852b9def41606ef95af0.1442843410.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After commit 60069253cbcd1bae213076b06f451a603f280064
  Include config.mk and features.mk in env_pre.mk for all targets

$ git clean -f -d -x
$ make autotools

  leads to an infinite loop, that is running help target:
make -C /usr/src/ltp help; false
make[1]: Entering directory `/usr/src/ltp'
make -C /usr/src/ltp help; false
make[2]: Entering directory `/usr/src/ltp'
make -C /usr/src/ltp help; false
make[3]: Entering directory `/usr/src/ltp'
make -C /usr/src/ltp help; false
...

because include/mk/automake.mk has rule for these 2 files, which
don't exist in clean tree. So, it spawns new make for help target,
which again includes env_pre.mk and loop continues.

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

