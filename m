From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 13:11:00 +0200
Subject: [LTP] [PATCH v5 06/12] hotplug/memory_hotplug: Update TODO
In-Reply-To: <20171018111106.17215-1-pvorel@suse.cz>
References: <20171018111106.17215-1-pvorel@suse.cz>
Message-ID: <20171018111106.17215-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

_NEED_MIGRATE_PAGES definition was removed in commit 5ed9ed059
("Address the issue reported in the following email by installing all .c files.")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/hotplug/memory_hotplug/TODO | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/testcases/kernel/hotplug/memory_hotplug/TODO b/testcases/kernel/hotplug/memory_hotplug/TODO
index 35c18aa57..1460eb6a2 100644
--- a/testcases/kernel/hotplug/memory_hotplug/TODO
+++ b/testcases/kernel/hotplug/memory_hotplug/TODO
@@ -1,12 +1,7 @@
 memtoy:
 
-if migrate_pages(2) system call ever becomes standard, will need to change
-Makefile not to build and link against migrate_pages.o and not to define
-_NEED_MIGRATE_PAGES.
-
 More documentation?
 
-
 Desired features?
 
 	+ verify contents after migration?
-- 
2.14.2

