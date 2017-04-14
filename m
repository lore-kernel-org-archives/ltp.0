From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Apr 2017 14:23:12 +0200
Subject: [LTP] [RFC PATCH 1/1] config.mk: Explicitly set used C and C++
	standard
Message-ID: <20170414122312.22734-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
IMHO If we really want to require old standard, we should explicitly say which one.
I suppose passing a flag is appropriate way than to use c89 as CC variable.
---
 include/mk/config.mk.default | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/mk/config.mk.default b/include/mk/config.mk.default
index dff3479db..ff67486a1 100644
--- a/include/mk/config.mk.default
+++ b/include/mk/config.mk.default
@@ -54,8 +54,8 @@ bindir			:= ${exec_prefix}/bin
 libdir			:= ${exec_prefix}/lib
 mandir			:= ${datarootdir}/man
 
-CPPFLAGS		:=
-CFLAGS			:= -g -O2
+CPPFLAGS		:= -std=c++98
+CFLAGS			:= -g -O2 -std=gnu89
 LDLIBS			:=
 LDFLAGS			:=
 
-- 
2.11.0

