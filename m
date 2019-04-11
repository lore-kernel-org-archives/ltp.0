From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Apr 2019 01:31:15 +0200
Subject: [LTP] [RFC PATCH 3/3] make: Add
	-Werror-implicit-function-declaration for all targets
In-Reply-To: <20190411233115.32744-1-pvorel@suse.cz>
References: <20190411233115.32744-1-pvorel@suse.cz>
Message-ID: <20190411233115.32744-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Previously it was passed only to Android build, but it's good to check
it for all.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested in travis:
https://travis-ci.org/pevik/ltp/builds/518886113
---
 include/mk/env_post.mk | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
index 913bdf5d1..3ffdd0b7f 100644
--- a/include/mk/env_post.mk
+++ b/include/mk/env_post.mk
@@ -41,11 +41,9 @@ ifeq ($(UCLINUX),1)
 CPPFLAGS			+= -D__UCLIBC__ -DUCLINUX
 endif
 
-ifeq ($(ANDROID),1)
-# There are many undeclared functions, it's best not to accidentally overlook
-# them.
 CFLAGS				+= -Werror-implicit-function-declaration
 
+ifeq ($(ANDROID),1)
 LDFLAGS				+= -L$(top_builddir)/lib/android_libpthread
 LDFLAGS				+= -L$(top_builddir)/lib/android_librt
 endif
-- 
2.20.1

