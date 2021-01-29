From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 29 Jan 2021 17:03:01 +0000
Subject: [LTP] [PATCH v4 3/7] can: Add COPYING with dual license text
In-Reply-To: <20210129170305.27383-1-rpalethorpe@suse.com>
References: <20210129170305.27383-1-rpalethorpe@suse.com>
Message-ID: <20210129170305.27383-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This may be referred to with

SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)

The kernel version includes the syscall note, but the contents of the
syscall note have never been included within the LTP CAN tests.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 testcases/network/can/filter-tests/COPYING | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 testcases/network/can/filter-tests/COPYING

diff --git a/testcases/network/can/filter-tests/COPYING b/testcases/network/can/filter-tests/COPYING
new file mode 100644
index 000000000..2fa5eb911
--- /dev/null
+++ b/testcases/network/can/filter-tests/COPYING
@@ -0,0 +1,35 @@
+Copyright (c) 2010-2011 Volkswagen Group Electronic Research
+All rights reserved.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions
+are met:
+1. Redistributions of source code must retain the above copyright
+   notice, this list of conditions and the following disclaimer.
+2. Redistributions in binary form must reproduce the above copyright
+   notice, this list of conditions and the following disclaimer in the
+   documentation and/or other materials provided with the distribution.
+3. Neither the name of Volkswagen nor the names of its contributors
+   may be used to endorse or promote products derived from this software
+   without specific prior written permission.
+
+Alternatively, provided that this notice is retained in full, this
+software may be distributed under the terms of the GNU General
+Public License ("GPL") version 2, in which case the provisions of the
+GPL apply INSTEAD OF those given above.
+
+The provided data structures and external interfaces from this code
+are not restricted to be used by modules with a GPL compatible license.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+DAMAGE.
-- 
2.30.0

