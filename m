From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 28 Jan 2019 12:14:37 +0100
Subject: [LTP] [PATCH 1/1] kernel/proc01: Whitelist /proc/pressure/*
Message-ID: <20190128111437.1964-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Kernel v4.20 added /proc/pressure/{cpu,io,memory}, when enabled
CONFIG_PSI ("Pressure stall information tracking").
When CONFIG_PSI_DEFAULT_DISABLED is also enabled (and psi=1 kernel
parameter is *not* set) these files are created, but not readable.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/proc/proc01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc/proc01.c
index c886e7e85..d917591bf 100644
--- a/testcases/kernel/fs/proc/proc01.c
+++ b/testcases/kernel/fs/proc/proc01.c
@@ -111,6 +111,7 @@ static const struct mapping known_issues[] = {
 	{"read", "/proc/sys/vm/nr_hugepages", EOPNOTSUPP},
 	{"read", "/proc/sys/vm/nr_overcommit_hugepages", EOPNOTSUPP},
 	{"read", "/proc/sys/vm/nr_hugepages_mempolicy", EOPNOTSUPP},
+	{"read", "/proc/pressure/*", EOPNOTSUPP},
 	{"", "", 0}
 };
 
-- 
2.19.2

