From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 Mar 2017 18:37:06 +0100
Subject: [LTP] [PATCH 1/1] gitignore: Add a ctags generated file
Message-ID: <20170310173706.18074-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index cbaea6636..6d578252f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,7 @@ autom4te.cache
 /execltp
 /ltp-devel.spec
 /README.ltp-devel
+/tags
 /Version
 /include/mk/config.mk
 /include/mk/config-openposix.mk
-- 
2.12.0

