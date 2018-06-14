From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 14 Jun 2018 19:04:55 +0300
Subject: [LTP] [PATCH 2/4] network/busy_poll: use SPDX-License-Identifier
In-Reply-To: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
References: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1528992297-23920-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/busy_poll/Makefile         |   16 ++--------------
 testcases/network/busy_poll/busy_poll01.sh   |   17 ++---------------
 testcases/network/busy_poll/busy_poll02.sh   |   17 ++---------------
 testcases/network/busy_poll/busy_poll03.sh   |   15 +--------------
 testcases/network/busy_poll/busy_poll_lib.sh |   16 ++--------------
 5 files changed, 9 insertions(+), 72 deletions(-)

diff --git a/testcases/network/busy_poll/Makefile b/testcases/network/busy_poll/Makefile
index 8feb006..3a85c7d 100644
--- a/testcases/network/busy_poll/Makefile
+++ b/testcases/network/busy_poll/Makefile
@@ -1,17 +1,5 @@
-# Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
 
 top_srcdir		?= ../../..
 
diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index a9c8cbd..5c59643 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -1,21 +1,8 @@
 #!/bin/sh
-# Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-#
 
 TST_TOTAL=1
 TCID="busy_poll01"
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index 95eeee3..f0e4a0e 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -1,21 +1,8 @@
 #!/bin/sh
-# Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2015-2018 Oracle and/or its affiliates. All Rights Reserved.
 #
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-#
 
 TST_TOTAL=1
 TCID="busy_poll02"
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 699bee2..b5fb28e 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -1,21 +1,8 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016-2018 Oracle and/or its affiliates.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-#
 
 TST_TOTAL=2
 TCID="busy_poll03"
diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
index 271c01b..6b2de07 100755
--- a/testcases/network/busy_poll/busy_poll_lib.sh
+++ b/testcases/network/busy_poll/busy_poll_lib.sh
@@ -1,18 +1,6 @@
 #!/bin/sh
-# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
 
 # for more stable results set to a single thread
 TST_NETLOAD_CLN_NUMBER=1
-- 
1.7.1

