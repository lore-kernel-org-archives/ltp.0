From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 May 2020 17:17:30 +0200
Subject: [LTP] [PATCH 3/3] [COMMITTED] lib: Fix two strncpy() destination
 equal bounds warnings
In-Reply-To: <20200512151730.10201-1-chrubis@suse.cz>
References: <20200512151730.10201-1-chrubis@suse.cz>
Message-ID: <20200512151730.10201-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In function 'strncpy',
    inlined from 'tst_sys_conf_save_str' at tst_sys_conf.c:29:2:
/usr/include/bits/string_fortified.h:106:10: warning: '__builtin_strncpy' specified bound 4096 equals destination size [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'strncpy',
    inlined from 'tst_sys_conf_save_str' at tst_sys_conf.c:30:2:
/usr/include/bits/string_fortified.h:106:10: warning: '__builtin_strncpy' specified bound 4096 equals destination size [-Wstringop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In short we have to always copy dest-1 bytes and zero the last one, that
may still make us loose part of the path, but at least we will not
crash.

Maybe we should rewrite the code to just use strdup() instead.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_sys_conf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index 1ae875387..4ad9f8b9b 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -26,8 +26,11 @@ int tst_sys_conf_save_str(const char *path, const char *value)
 {
 	struct tst_sys_conf *n = SAFE_MALLOC(sizeof(*n));
 
-	strncpy(n->path, path, sizeof(n->path));
-	strncpy(n->value, value, sizeof(n->value));
+	strncpy(n->path, path, sizeof(n->path)-1);
+	strncpy(n->value, value, sizeof(n->value)-1);
+
+	n->path[sizeof(n->path) - 1] = 0;
+	n->value[sizeof(n->value) - 1] = 0;
 
 	n->next = save_restore_data;
 	save_restore_data = n;
-- 
2.26.2

