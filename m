From: Hangbin Liu <haliu@redhat.com>
Date: Tue, 22 Mar 2016 21:36:31 +0800
Subject: [LTP] [PATCHv3 2/3] network/stress: add ipsec lib
In-Reply-To: <56F13FEE.2070201@oracle.com>
References: <1458209056-18829-1-git-send-email-haliu@redhat.com>
 <1458209056-18829-3-git-send-email-haliu@redhat.com>
 <56F13FEE.2070201@oracle.com>
Message-ID: <20160322133631.GA8609@Leo.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

Thanks for all the advise. I will fix them soon.

Regards
Hangbin
On Tue, Mar 22, 2016 at 03:51:58PM +0300, Alexey Kodanev wrote:
> Hi,
> On 03/17/2016 01:04 PM, Hangbin Liu wrote:
> >Signed-off-by: Hangbin Liu <haliu@redhat.com>
> >---
> >  testcases/network/stress/ipsec/Makefile     |  29 ++++++++
> >  testcases/network/stress/ipsec/ipsec_lib.sh | 111 ++++++++++++++++++++++++++++
> >  2 files changed, 140 insertions(+)
> >  create mode 100644 testcases/network/stress/ipsec/Makefile
> >  create mode 100644 testcases/network/stress/ipsec/ipsec_lib.sh
> >
> >diff --git a/testcases/network/stress/ipsec/Makefile b/testcases/network/stress/ipsec/Makefile
> >new file mode 100644
> >index 0000000..0d7f1b6
> >--- /dev/null
> >+++ b/testcases/network/stress/ipsec/Makefile
> >@@ -0,0 +1,29 @@
> >+#!/bin/sh
> >+# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
> >+#
> >+# This program is free software; you can redistribute it and/or
> >+# modify it under the terms of the GNU General Public License as
> >+# published by the Free Software Foundation; either version 2 of
> >+# the License, or (at your option) any later version.
> >+#
> >+# This program is distributed in the hope that it would be useful,
> >+# but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+# GNU General Public License for more details.
> >+#
> >+# You should have received a copy of the GNU General Public License
> >+# along with this program; if not, write the Free Software Foundation,
> >+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> >+#
> 
> Forgot to change it here?
> 
> >+# Author: Hangbin Liu <haliu@redhat.com>
> >+#
> >+#######################################################################
> >+
> >+
> >+top_srcdir		?= ../../../..
> >+
> >+include $(top_srcdir)/include/mk/env_pre.mk
> >+
> >+INSTALL_TARGETS		:= *.sh
> >+
> >+include $(top_srcdir)/include/mk/generic_leaf_target.mk
> >diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
> >new file mode 100644
> >index 0000000..33716ce
> >--- /dev/null
> >+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
> >@@ -0,0 +1,111 @@
> >+#!/bin/sh
> >+# Copyright (c) 2016 Red Hat Inc.,  All Rights Reserved.
> >+#
> >+# This program is free software; you can redistribute it and/or
> >+# modify it under the terms of the GNU General Public License as
> >+# published by the Free Software Foundation; either version 2 of
> >+# the License, or (at your option) any later version.
> >+#
> >+# This program is distributed in the hope that it would be useful,
> >+# but WITHOUT ANY WARRANTY; without even the implied warranty of
> >+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >+# GNU General Public License for more details.
> >+#
> >+# You should have received a copy of the GNU General Public License
> >+# along with this program; if not, see <http://www.gnu.org/licenses/>.
> >+#
> >+# Author: Hangbin Liu <haliu@redhat.com>
> >+#
> >+#######################################################################
> >+
> >+. test_net.sh
> >+
> >+# tst_ipsec flush: flush the ipsec state and policy
> >+# tst_ipsec target protocol mode spi src_addr dst_addr: config ipsec
> >+#
> >+# target: target of the configuration file ( src / dst )
> >+# protocol: ah / esp / ipcomp
> >+# mode: transport / tunnel
> >+# spi: the first spi value
> >+# src_addr: source IP address
> >+# dst_addr: destination IP address
> >+tst_ipsec()
> >+{
> >+	if [ "$1" = "flush" ]; then
> >+		ROD ip xfrm state flush
> >+		ROD ip xfrm policy flush
> >+		tst_rhost_run -s -c "ip xfrm state flush && ip xfrm policy flush"
> >+		return 0
> >+	fi
> 
> I'd move it to another function, we could name ittst_ipsec_cleanup().
> And tst_ipsec() needs some general description like what it actually does.
> 
> >+	if [ $# -ne 6 ]; then
> >+		tst_resm TINFO "tst_ipsec parameter mismatch"
> >+		return 1
> >+	fi
> 
> Why not just tst_brkm() here?
> 
> >+
> >+	target=$1
> >+	protocol=$2
> >+	mode=$3
> >+	spi=$4
> >+	src=$5
> >+	dst=$6
> 
> It's better to make these variables to be defined in function scope
> (as local) and other variables which used only inside the function.
> 
> >+
> >+	# Encryption algorithm
> >+	EALGO="des3_ede"
> >+	EALGO_KEY=0x$(printf _I_want_to_have_chicken_ | hexdump -ve '/1 "%x"')
> >+
> >+	# Authentication algorithm
> >+	AALGO="sha1"
> >+	AALGO_KEY=0x$(printf beef_fish_pork_salad | hexdump -ve '/1 "%x"')
> 
> if we use hexdump, we should verify it with tst_check_cmds()
> (e.g. when we source the library).
> 
> >+
> >+	# Compression algorithm
> >+	CALGO="deflate"
> >+	# Algorithm options for each protocol
> >+	case $protocol in
> >+	ah)
> >+		algo_line="auth $AALGO $AALGO_KEY"
> >+		proto="ah"
> >+		;;
> >+	esp)
> >+		algo_line="enc $EALGO $EALGO_KEY auth $AALGO $AALGO_KEY"
> >+		proto="esp"
> >+		;;
> >+	ipcomp)
> >+		algo_line="comp $CALGO"
> >+		proto="comp"
> >+		;;
> >+	*)
> >+		tst_resm TINFO "tst_ipsec protocol mismatch"
> >+		return 1
> >+		;;
> >+	esac
> 
> I would add tst_brkm() here as well.
> 
> >+
> >+	if [ $target = src ]; then
> >+		spi_1="0x$spi"
> >+		spi_2="0x$(( $spi + 1 ))"
> >+		ROD ip xfrm state add src $src dst $dst spi $spi_1 proto $proto \
> >+			$algo_line mode $mode sel src $src dst $dst
> >+		ROD ip xfrm policy add src $src dst $dst dir out tmpl src $src \
> >+			dst $dst proto $proto mode $mode
> >+
> >+		ROD ip xfrm state add src $dst dst $src spi $spi_2 proto $proto \
> >+			$algo_line mode $mode sel src $dst dst $src
> >+		ROD ip xfrm policy add src $dst dst $src dir in tmpl src $dst \
> >+			dst $src proto $proto mode $mode level use
> >+		ROD ip xfrm state
> >+		ROD ip xfrm policy
> >+	elif [ $target = dst ]; then
> >+		spi_1="0x$(( $spi + 1 ))"
> >+		spi_2="0x$spi"
> >+		tst_rhost_run -s -c "ip xfrm state add src $src dst $dst spi $spi_1 \
> >+			proto $proto $algo_line mode $mode sel src $src dst $dst"
> >+		tst_rhost_run -s -c "ip xfrm policy add src $src dst $dst dir out \
> >+			tmpl src $src dst $dst proto $proto mode $mode"
> >+
> >+		tst_rhost_run -s -c "ip xfrm state add src $dst dst $src spi $spi_2 \
> >+			proto $proto $algo_line mode $mode sel src $dst dst $src"
> >+		tst_rhost_run -s -c "ip xfrm policy add src $dst dst $src dir in \
> >+			tmpl src $dst dst $src proto $proto mode $mode level use"
> >+		tst_rhost_run -s -c "ip xfrm state"
> >+		tst_rhost_run -s -c "ip xfrm policy"
> >+	fi
> >+}
> 
> Can we stick with lhost/rhost naming, and lhost to be default value?
> So it would be similar to test_net.sh...
> 
> Best regards,
> Alexey
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 

Thanks & Best Regards
Hangbin Liu <haliu@redhat.com>
Leo on #kernel-qe, #kernel, #eng-china
