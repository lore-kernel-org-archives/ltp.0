From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Jun 2018 08:18:12 +0200
Subject: [LTP] [PATCH v2] change type of variable to fix compile warning
In-Reply-To: <20180609030106.3927-1-sunlw.fnst@cn.fujitsu.com>
References: <20180609030106.3927-1-sunlw.fnst@cn.fujitsu.com>
Message-ID: <20180615061812.gto4adrda4hdm2dp@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Sun,

> Change the type of variable from int to unsigned intto fix complie 
> warning: "comparison between signed and unsigned integer expressions [-Wsign-compare]"

> Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>

You left some of the comparison warnings, can you please fix them?
move_pages_support.c: In function ‘alloc_pages_on_nodes’:
move_pages_support.c:70:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  for (i = 0; i < num; i++) {
                ^
move_pages_support.c:74:16: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  for (i = 0; i < num; i++) {
                ^
move_pages_support.c:91:8: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (i == num)
        ^~
symlink01.c: In function ‘get_tcs_info’:
symlink01.c:601:20: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  for (ctr = 0; ctr < (sizeof(all_tcses) / sizeof(struct tcses)); ctr++) {
                    ^

ebizzy.c: In function ‘thread_run’:
ebizzy.c:424:31: warning: unused parameter ‘arg’ [-Wunused-parameter]
 static void *thread_run(void *arg)
This one can be fixed with LTP_ATTRIBUTE_UNUSED
+#include "tst_common.h"
                               ^~~
-static void *thread_run(void *arg)
+static void *thread_run(void *arg LTP_ATTRIBUTE_UNUSED)


Kind regards,
Petr
