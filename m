From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  5 Feb 2021 16:10:15 +0100
Subject: [LTP] [PATCH 4/4] net/multicast: Use SPDX-License-Identifier
In-Reply-To: <20210205151015.7465-1-pvorel@suse.cz>
References: <20210205151015.7465-1-pvorel@suse.cz>
Message-ID: <20210205151015.7465-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../mcast-group-multiple-socket.sh              | 17 +----------------
 .../grp-operation/mcast-group-same-group.sh     | 17 +----------------
 .../grp-operation/mcast-group-single-socket.sh  | 17 +----------------
 .../grp-operation/mcast-group-source-filter.sh  | 17 +----------------
 4 files changed, 4 insertions(+), 64 deletions(-)

diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
index e4cafc27d..abd2dabb3 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-multiple-socket.sh
@@ -1,22 +1,7 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2006
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
-#
-# Setup: testcases/network/stress/README
-#
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_NEEDS_ROOT=1
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
index 28c68c807..33df2e422 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-same-group.sh
@@ -1,22 +1,7 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2006
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
-#
-# Setup: testcases/network/stress/README
-#
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_NEEDS_ROOT=1
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
index 780eaf13c..10c65918f 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-single-socket.sh
@@ -1,22 +1,7 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2006
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
-#
-# Setup: testcases/network/stress/README
-#
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_NEEDS_ROOT=1
diff --git a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
index 4c5a6e4c7..19bd426a4 100644
--- a/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
+++ b/testcases/network/stress/multicast/grp-operation/mcast-group-source-filter.sh
@@ -1,22 +1,7 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017-2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) International Business Machines  Corp., 2006
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
-#
-# Setup: testcases/network/stress/README
-#
 # Author: Mitsuru Chinen <mitch@jp.ibm.com>
 
 TST_NEEDS_ROOT=1
-- 
2.30.0

