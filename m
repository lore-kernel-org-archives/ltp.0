From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 28 Jul 2021 13:34:10 +0100
Subject: [LTP] [PATCH v3 6/8] Reference LTP-002 rule in Cocci scripts
In-Reply-To: <20210728123412.31858-1-rpalethorpe@suse.com>
References: <20210728123412.31858-1-rpalethorpe@suse.com>
Message-ID: <20210728123412.31858-7-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Avoid duplication of rule description

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 scripts/coccinelle/libltp-test-macro-vars.cocci | 6 +-----
 scripts/coccinelle/libltp-test-macro.cocci      | 4 +---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/scripts/coccinelle/libltp-test-macro-vars.cocci b/scripts/coccinelle/libltp-test-macro-vars.cocci
index ed5459a48..e0fe4e2a7 100644
--- a/scripts/coccinelle/libltp-test-macro-vars.cocci
+++ b/scripts/coccinelle/libltp-test-macro-vars.cocci
@@ -1,11 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // Copyright (c) 2021 SUSE LLC  <rpalethorpe@suse.com>
 
-// The TEST macro should not be used in the library because it sets
-// TST_RET and TST_ERR which are global variables. The test author
-// only expects these to be changed if *they* call TEST directly.
-
-// Find all positions where TEST's variables are used
+// Find violations of LTP-002
 @ find_use exists @
 expression E;
 @@
diff --git a/scripts/coccinelle/libltp-test-macro.cocci b/scripts/coccinelle/libltp-test-macro.cocci
index 7563d23aa..86c55c6c4 100644
--- a/scripts/coccinelle/libltp-test-macro.cocci
+++ b/scripts/coccinelle/libltp-test-macro.cocci
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // Copyright (c) 2021 SUSE LLC  <rpalethorpe@suse.com>
 
-// The TEST macro should not be used in the library because it sets
-// TST_RET and TST_ERR which are global variables. The test author
-// only expects these to be changed if *they* call TEST directly.
+// Find and fix violations of rule LTP-002
 
 // Set with -D fix
 virtual fix
-- 
2.31.1

