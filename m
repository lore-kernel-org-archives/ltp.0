From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Apr 2018 13:44:13 +0200
Subject: [LTP] [PATCH 1/2] utils/compat_16: Add compat_tst_16.h for new
 API
In-Reply-To: <1519912139-18839-1-git-send-email-xuyang.jy@cn.fujitsu.com>
References: <1519912139-18839-1-git-send-email-xuyang.jy@cn.fujitsu.com>
Message-ID: <20180409114413.mzev4hpphsavhle3@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,
> From: yang xu <xuyang.jy@cn.fujitsu.com>

> 1) Make sure compat_16.mk can be used by both new API and old API
> 2) Remove unused TST_COMPAT_16_SYSCALL judgment in compat_16.mk

> Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/utils/compat_16.mk    |  11 +-
>  testcases/kernel/syscalls/utils/compat_tst_16.h | 157 ++++++++++++++++++++++++

Pushed with minor change (see below). We prefer not to add '__LTP' as a prefix to include
guards. I know it is in utils/compat_16.h, but that's legacy API and it's going to be
deleted sooner or later.


Kind regards,
Petr

diff --git testcases/kernel/syscalls/utils/compat_tst_16.h testcases/kernel/syscalls/utils/compat_tst_16.h
index bb30c6f08..3b86ef3e3 100644
--- testcases/kernel/syscalls/utils/compat_tst_16.h
+++ testcases/kernel/syscalls/utils/compat_tst_16.h
@@ -16,8 +16,8 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef __LTP_COMPAT_TST_16_H__
-#define __LTP_COMPAT_TST_16_H__
+#ifndef COMPAT_TST_16_H__
+#define COMPAT_TST_16_H__
 
 #include <errno.h>
 #include <grp.h>
@@ -154,4 +154,4 @@ int CHOWN(const char *path, UID_T owner, GID_T group)
 {
 	TST_CREATE_SYSCALL(chown, path, owner, group);
 }
-#endif /* __LTP_COMPAT_TST_16_H__ */
+#endif /* COMPAT_TST_16_H__ */
