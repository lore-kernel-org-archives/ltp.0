From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Apr 2018 08:23:43 +0200
Subject: [LTP] [PATCH v2 3/3] net/ipsec_lib.sh: Process getopts parameters
	with TST_OPTS and TST_PARSE_ARGS
In-Reply-To: <20180430062343.5582-1-pvorel@suse.cz>
References: <20180430062343.5582-1-pvorel@suse.cz>
Message-ID: <20180430062343.5582-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as this is a proper way of handling parameters by API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 1a2eef996..4b9b473cf 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -31,7 +32,8 @@ CALGO="deflate"
 IPSEC_REQUESTS="500"
 IPSEC_SIZE_ARRAY="${IPSEC_SIZE_ARRAY:-10 100 1000 2000 10000 65000}"
 
-while getopts "hl:m:p:s:S:k:A:e:a:c:r:6" opt; do
+ipsec_lib_parse_args()
+{
 	case "$opt" in
 	h)
 		echo "Usage:"
@@ -61,12 +63,12 @@ while getopts "hl:m:p:s:S:k:A:e:a:c:r:6" opt; do
 	a) AALGO=$OPTARG ;;
 	c) CALGO=$OPTARG ;;
 	r) IPSEC_REQUESTS="$OPTARG" ;;
-	6) TST_IPV6=6 ;;
 	*) tst_brkm TBROK "unknown option: $opt" ;;
 	esac
-done
-shift $(($OPTIND - 1))
+}
 
+TST_OPTS="hl:m:p:s:S:k:A:e:a:c:r:"
+TST_PARSE_ARGS=ipsec_lib_parse_args
 TST_USE_LEGACY_API=1
 . tst_net.sh
 
-- 
2.16.3

