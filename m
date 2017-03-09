From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Mar 2017 14:34:09 +0100
Subject: [LTP] [PATCH 1/2] daemonlib: Update docs
Message-ID: <20170309133410.8540-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 4256427f2..521773b4f 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1796,7 +1796,7 @@ correct daemon name.
 | start_daemon()   | Starts daemon, name is passed as first parameter.
 | stop_daemon()    | Stops daemon, name is passed as first parameter.
 | restart_daemon() | Restarts daemon, name is passed as first parameter.
-| status_daemon()  | Returns daemon status, TODO: what is return value?
+| status_daemon()  | Detect daemon status (exit code: 0: running, 1: not running).
 |==============================================================================
 
 .Variables with detected names
-- 
2.12.0

