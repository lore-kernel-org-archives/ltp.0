From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Date: Mon, 25 Dec 2017 15:03:05 +0900
Subject: [LTP] [PATCH 1/2] execltp: fix scenario_group naming
In-Reply-To: <1514181786-6677-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1514181786-6677-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1514181786-6677-2-git-send-email-daniel.sangorrin@toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Commit 9d5dac6 modified the folder name "scenario-groups" to
"scenario_groups" but it seems it missed changing it on
the execltp script as well.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 execltp.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/execltp.in b/execltp.in
index 470a2dc..6d13ad1 100755
--- a/execltp.in
+++ b/execltp.in
@@ -307,7 +307,7 @@ def main():
 
     if len(args) == 0:
         # Default to scenarios also used by runltp.
-        fd = open(os.path.join(ltpdir, 'scenario-groups/default'), 'r')
+        fd = open(os.path.join(ltpdir, 'scenario_groups/default'), 'r')
         try:
             args = fd.readlines()
         finally:
-- 
2.1.4


