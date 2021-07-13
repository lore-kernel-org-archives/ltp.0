From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jul 2021 12:13:33 +0200
Subject: [LTP] [PATCH v4 2/7] tst_net.sh: Declare prefix variable as empty
In-Reply-To: <20210713101338.6985-1-pvorel@suse.cz>
References: <20210713101338.6985-1-pvorel@suse.cz>
Message-ID: <20210713101338.6985-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in tst_ipaddr_un(). This is required to fix problem on dash, which
(unlike bash and busybox ash implementation) takes value of previously
defined variable, i.e.  guarding with local does not work:

$ foo=ee; bar() { local foo; echo "foo: '$foo'"; }; bar
foo: 'ee'

It requires declare it as empty:
$ foo=ee; bar() { local foo=; echo "foo: '$foo'"; }; bar
foo: ''

This problem seems to be on various dash versions from 0.5.8 to
0.5.11+git20200708+dd9ef66-5 (on Debian oldstable, stable, testing).
It'd require to set all variables, but now fix just prefix, which is
used in build.sh and it's quite common name.

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 testcases/lib/tst_net.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index db1db4790..511fb7eb1 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2016-2019 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2016-2021 Petr Vorel <pvorel@suse.cz>
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 [ -n "$TST_LIB_NET_LOADED" ] && return 0
@@ -408,7 +408,7 @@ tst_ipaddr_un()
 	local max_net_id=$default_max
 	local min_net_id=0
 
-	local counter host_id host_range is_counter max_host_id min_host_id net_id prefix tmp type
+	local counter host_id host_range is_counter max_host_id min_host_id net_id prefix= tmp type
 
 	local OPTIND
 	while getopts "c:h:n:p" opt; do
-- 
2.32.0

