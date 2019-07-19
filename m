From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Jul 2019 14:08:06 +0200
Subject: [LTP] [COMMITTED] [PATCH 2/2] sound/snd_timer01: Fix .gitignore
In-Reply-To: <20190719120806.24214-1-chrubis@suse.cz>
References: <20190719120806.24214-1-chrubis@suse.cz>
Message-ID: <20190719120806.24214-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/sound/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/sound/.gitignore b/testcases/kernel/sound/.gitignore
index 57eae0593..33692e690 100644
--- a/testcases/kernel/sound/.gitignore
+++ b/testcases/kernel/sound/.gitignore
@@ -1 +1 @@
-snd_timer
+snd_timer01
-- 
2.21.0

