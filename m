From: Yuan Gao <aiden.gaoyuan@gmail.com>
Date: Wed, 29 Jul 2020 18:53:44 +0000
Subject: [LTP] [PATCH v2] hotplug/memory_hotplug: Remove unused goto label
Message-ID: <20200729185344.3318703-1-aiden.gaoyuan@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove unused goto label in parse_command_line_args function

Change from v1
1. Remove a redundant blank line

Signed-off-by: Yuan Gao <aiden.gaoyuan@gmail.com>
---
 testcases/kernel/hotplug/memory_hotplug/memtoy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/hotplug/memory_hotplug/memtoy.c b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
index 8ac9600de..e647f86b6 100644
--- a/testcases/kernel/hotplug/memory_hotplug/memtoy.c
+++ b/testcases/kernel/hotplug/memory_hotplug/memtoy.c
@@ -447,7 +447,6 @@ int parse_command_line_args(int argc, char *argv[])
 			break;
 		}
 	}
-done:
 
 	return (error);
 }
-- 
2.28.0.rc0.142.g3c755180ce-goog

