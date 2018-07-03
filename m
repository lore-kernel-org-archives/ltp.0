From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Jul 2018 09:42:06 +0200
Subject: [LTP] [PATCH v3 6/9] net/{stress,
	virt}: Use SPDX-License-Identifier GPL-2.0-or-later
In-Reply-To: <20180703074209.911-1-pvorel@suse.cz>
References: <20180703074209.911-1-pvorel@suse.cz>
Message-ID: <20180703074209.911-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to save space
+ add author in few cases.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh                      | 17 +----------------
 testcases/network/stress/dccp/dccp_ipsec.sh   | 15 +--------------
 .../network/stress/dccp/dccp_ipsec_vti.sh     | 15 +--------------
 .../network/stress/icmp/icmp-uni-basic.sh     | 18 ++----------------
 testcases/network/stress/icmp/icmp-uni-vti.sh | 15 +--------------
 testcases/network/stress/ipsec/ipsec_lib.sh   | 19 ++-----------------
 testcases/network/stress/sctp/sctp_ipsec.sh   | 15 +--------------
 .../network/stress/sctp/sctp_ipsec_vti.sh     | 15 +--------------
 testcases/network/stress/tcp/tcp_ipsec.sh     | 15 +--------------
 testcases/network/stress/tcp/tcp_ipsec_vti.sh | 15 +--------------
 testcases/network/stress/udp/udp_ipsec.sh     | 15 +--------------
 testcases/network/stress/udp/udp_ipsec_vti.sh | 15 +--------------
 testcases/network/virt/geneve01.sh            | 15 +--------------
 testcases/network/virt/gre01.sh               | 15 +--------------
 testcases/network/virt/ipvlan01.sh            | 15 +--------------
 testcases/network/virt/macsec01.sh            | 15 ++-------------
 testcases/network/virt/macsec02.sh            | 15 ++-------------
 testcases/network/virt/macvlan01.sh           | 15 +--------------
 testcases/network/virt/macvtap01.sh           | 15 +--------------
 testcases/network/virt/virt_lib.sh            | 16 +---------------
 testcases/network/virt/vlan01.sh              | 16 +---------------
 testcases/network/virt/vlan02.sh              | 16 +---------------
 testcases/network/virt/vlan03.sh              | 15 +--------------
 testcases/network/virt/vxlan01.sh             | 16 +---------------
 testcases/network/virt/vxlan02.sh             | 16 +---------------
 testcases/network/virt/vxlan03.sh             | 15 +--------------
 26 files changed, 30 insertions(+), 374 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index e55ac1ddc..65fbe2c28 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1,23 +1,8 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) 2016-2018 Petr Vorel <pvorel@suse.cz>
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
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
-#
 
 [ -n "$TST_LIB_NET_LOADED" ] && return 0
 TST_LIB_NET_LOADED=1
diff --git a/testcases/network/stress/dccp/dccp_ipsec.sh b/testcases/network/stress/dccp/dccp_ipsec.sh
index 624f8e0af..d1afd4569 100755
--- a/testcases/network/stress/dccp/dccp_ipsec.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=dccp_ipsec
diff --git a/testcases/network/stress/dccp/dccp_ipsec_vti.sh b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
index 878f88ccf..f5ff1029d 100755
--- a/testcases/network/stress/dccp/dccp_ipsec_vti.sh
+++ b/testcases/network/stress/dccp/dccp_ipsec_vti.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=dccp_ipsec_vti
diff --git a/testcases/network/stress/icmp/icmp-uni-basic.sh b/testcases/network/stress/icmp/icmp-uni-basic.sh
index 3099b6caa..b168a821c 100755
--- a/testcases/network/stress/icmp/icmp-uni-basic.sh
+++ b/testcases/network/stress/icmp/icmp-uni-basic.sh
@@ -1,23 +1,9 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Hangbin Liu <haliu@redhat.com>
-#
-################################################################################
+
 TCID=${TCID:-icmp-uni-basic}
 TST_TOTAL=1
 TST_COUNT=1
diff --git a/testcases/network/stress/icmp/icmp-uni-vti.sh b/testcases/network/stress/icmp/icmp-uni-vti.sh
index ea8b5c828..9a7fba59f 100755
--- a/testcases/network/stress/icmp/icmp-uni-vti.sh
+++ b/testcases/network/stress/icmp/icmp-uni-vti.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=icmp-uni-vti
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index afa7c7c75..e851d46e4 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -1,24 +1,9 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Hangbin Liu <haliu@redhat.com>
-#
-#######################################################################
 
 # Authenticated encryption with associated data
 AEALGO="rfc4106_128"
diff --git a/testcases/network/stress/sctp/sctp_ipsec.sh b/testcases/network/stress/sctp/sctp_ipsec.sh
index 5f99bc7df..ee9018f01 100755
--- a/testcases/network/stress/sctp/sctp_ipsec.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=sctp_ipsec
diff --git a/testcases/network/stress/sctp/sctp_ipsec_vti.sh b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
index 3fa3a738b..ed851475a 100755
--- a/testcases/network/stress/sctp/sctp_ipsec_vti.sh
+++ b/testcases/network/stress/sctp/sctp_ipsec_vti.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=sctp_ipsec_vti
diff --git a/testcases/network/stress/tcp/tcp_ipsec.sh b/testcases/network/stress/tcp/tcp_ipsec.sh
index 86f455532..0f875948c 100755
--- a/testcases/network/stress/tcp/tcp_ipsec.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=tcp_ipsec
diff --git a/testcases/network/stress/tcp/tcp_ipsec_vti.sh b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
index a793ef63c..13a67d3bb 100755
--- a/testcases/network/stress/tcp/tcp_ipsec_vti.sh
+++ b/testcases/network/stress/tcp/tcp_ipsec_vti.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=tcp_ipsec_vti
diff --git a/testcases/network/stress/udp/udp_ipsec.sh b/testcases/network/stress/udp/udp_ipsec.sh
index 9b5ac07b2..9c46fc6c0 100755
--- a/testcases/network/stress/udp/udp_ipsec.sh
+++ b/testcases/network/stress/udp/udp_ipsec.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=udp_ipsec
diff --git a/testcases/network/stress/udp/udp_ipsec_vti.sh b/testcases/network/stress/udp/udp_ipsec_vti.sh
index 36a50bb3d..1b138afb6 100755
--- a/testcases/network/stress/udp/udp_ipsec_vti.sh
+++ b/testcases/network/stress/udp/udp_ipsec_vti.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-# along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=udp_ipsec_vti
diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index 1385604d3..91d03883d 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2016-2017 Oracle and/or its affiliates.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
 TCID=geneve01
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index 4da396986..efb78a940 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015-2017 Oracle and/or its affiliates.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # It requires remote host. Test will setup IPv4 and IPv6 virtual
diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index 36b07f027..426b2cb6b 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete ipvlan
diff --git a/testcases/network/virt/macsec01.sh b/testcases/network/virt/macsec01.sh
index 52d6f071a..cf038e7ca 100755
--- a/testcases/network/virt/macsec01.sh
+++ b/testcases/network/virt/macsec01.sh
@@ -1,18 +1,7 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test-case: setup two MACsec drivers and run TCP traffic over them
 # with default MACsec configuration, compare performance with similar
diff --git a/testcases/network/virt/macsec02.sh b/testcases/network/virt/macsec02.sh
index 617860d41..63c035e44 100755
--- a/testcases/network/virt/macsec02.sh
+++ b/testcases/network/virt/macsec02.sh
@@ -1,18 +1,7 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test-case: setup two MACsec drivers and run TCP traffic over them
 # with enabled frame encryption and replay protection, compare
diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
index cafca75e2..f37851f50 100755
--- a/testcases/network/virt/macvlan01.sh
+++ b/testcases/network/virt/macvlan01.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete macvlan
diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
index 7b90213a1..21fd96777 100755
--- a/testcases/network/virt/macvtap01.sh
+++ b/testcases/network/virt/macvtap01.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete macvtap
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 7579907ff..eaec33d8f 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -1,20 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # VxLAN
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index 5ac412b32..4dceae82f 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -1,23 +1,9 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create multiple VLAN interfaces.
-#
 
 TCID=vlan01
 TST_TOTAL=9
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
index 748f9c44c..2b84a7cd0 100755
--- a/testcases/network/virt/vlan02.sh
+++ b/testcases/network/virt/vlan02.sh
@@ -1,24 +1,10 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete VLAN
 # interface 4095 times.
-#
 
 TCID=vlan02
 TST_TOTAL=1
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 7a8f74295..33bfaf84c 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2015-2017 Oracle and/or its affiliates.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test-case 1: It requires remote host. Test will setup IPv4 and IPv6 virtual
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 6195b00b3..49bcb942a 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -1,23 +1,9 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create multiple VXLAN interfaces.
-#
 
 TCID=vxlan01
 TST_TOTAL=5
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index a93e7802d..dde1dabc8 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -1,24 +1,10 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Local test, check if we can create and then delete VXLAN
 # interface 5000 times.
-#
 
 TCID=vxlan02
 TST_TOTAL=1
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 37a172e4c..d8c533cb3 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -1,19 +1,6 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2014-2017 Oracle and/or its affiliates.
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
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # Test-case 1: It requires remote host. Test will setup IPv4 and IPv6 virtual
-- 
2.18.0

