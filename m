Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE7BF483F8
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 20:56:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E9493E6B7E
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 21:56:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E35B3E6BD2
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 21:56:10 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BBF521000A13
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 21:56:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D5C415BE50;
 Mon, 23 Mar 2026 20:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774299363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ti7SygAKOzSFJf2bDRe2H0mmpc8Sa5vVuLhvS5YicAM=;
 b=v04aSzR0X1gwb+OZ7FaGNiQIzAKriIHY1PCxiAnk24Vc5cuNZoBRRhXunPnq+wM+JX5V3C
 Nt4GsQXjfURjUc+GN2FH8baVJcekyFlwcYLsos6S2g2hYjYVSds8clm7FmCYwY+3Mj8rGe
 QfjWe+JMFGiEZxFLwRBq5zEDYblm/4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774299363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ti7SygAKOzSFJf2bDRe2H0mmpc8Sa5vVuLhvS5YicAM=;
 b=jnaSkp9MAc83Nnu8JtybIA7JCKy/ED0rVz+ITxGomxubL1z2vCqwhn8zfmlHHEuQS7jlHF
 wOiqByX+zyiRJoCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774299362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ti7SygAKOzSFJf2bDRe2H0mmpc8Sa5vVuLhvS5YicAM=;
 b=hOHrrDnH5N/eDYDwKR2MI7NgDzwcOYGvLONXZWXoA+R2eSHlwv5RLR0J75CckMQVWJqzVY
 doCWf9j8am5558bGk1QbRRyucZKK7EvPq3GVtiqQterq/nimKByBkHkeYs+Z51o3XKeFOY
 KC702LjFQMbYjM7C/apZ2qQ4OPNKqkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774299362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ti7SygAKOzSFJf2bDRe2H0mmpc8Sa5vVuLhvS5YicAM=;
 b=sU/3PO/8kSs6QFE0CH7Du+45bWt254XxKSmJAwfdmnFetzfLitKr26LvVggUyilaExTXJH
 /gl16M8+Za7c4CDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9916D43A8C;
 Mon, 23 Mar 2026 20:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MMmRJOKowWlqMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 23 Mar 2026 20:56:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 23 Mar 2026 21:55:44 +0100
Message-ID: <20260323205547.19058-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323205547.19058-1-pvorel@suse.cz>
References: <20260323205547.19058-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] network: Remove outdated ICMP stress tests
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tests are very old, ugly and were not part of any runtest file.
Some of them covered IPsec, which is tested via more up to date tests
icmp-uni-{basic,vti}.sh added in runtest/net_stress.ipsec_icmp.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/icmp/Makefile        |   2 +-
 .../icmp/multi-diffip/00_Descriptions.txt     |  56 ---
 .../network/stress/icmp/multi-diffip/Makefile |  29 --
 .../icmp/multi-diffip/icmp4-multi-diffip01    | 378 ------------------
 .../icmp/multi-diffip/icmp4-multi-diffip02    |  66 ---
 .../icmp/multi-diffip/icmp4-multi-diffip03    |  67 ----
 .../icmp/multi-diffip/icmp4-multi-diffip04    |  66 ---
 .../icmp/multi-diffip/icmp4-multi-diffip05    |  67 ----
 .../icmp/multi-diffip/icmp4-multi-diffip06    |  67 ----
 .../icmp/multi-diffip/icmp4-multi-diffip07    |  66 ---
 .../icmp/multi-diffip/icmp6-multi-diffip01    |  56 ---
 .../icmp/multi-diffip/icmp6-multi-diffip02    |  66 ---
 .../icmp/multi-diffip/icmp6-multi-diffip03    |  67 ----
 .../icmp/multi-diffip/icmp6-multi-diffip04    |  66 ---
 .../icmp/multi-diffip/icmp6-multi-diffip05    |  67 ----
 .../icmp/multi-diffip/icmp6-multi-diffip06    |  67 ----
 .../icmp/multi-diffip/icmp6-multi-diffip07    |  66 ---
 .../icmp/multi-diffnic/00_Descriptions.txt    |  56 ---
 .../stress/icmp/multi-diffnic/Makefile        |  29 --
 .../icmp/multi-diffnic/icmp4-multi-diffnic01  | 301 --------------
 .../icmp/multi-diffnic/icmp4-multi-diffnic02  |  66 ---
 .../icmp/multi-diffnic/icmp4-multi-diffnic03  |  67 ----
 .../icmp/multi-diffnic/icmp4-multi-diffnic04  |  66 ---
 .../icmp/multi-diffnic/icmp4-multi-diffnic05  |  67 ----
 .../icmp/multi-diffnic/icmp4-multi-diffnic06  |  67 ----
 .../icmp/multi-diffnic/icmp4-multi-diffnic07  |  66 ---
 .../icmp/multi-diffnic/icmp6-multi-diffnic01  |  56 ---
 .../icmp/multi-diffnic/icmp6-multi-diffnic02  |  66 ---
 .../icmp/multi-diffnic/icmp6-multi-diffnic03  |  67 ----
 .../icmp/multi-diffnic/icmp6-multi-diffnic04  |  66 ---
 .../icmp/multi-diffnic/icmp6-multi-diffnic05  |  67 ----
 .../icmp/multi-diffnic/icmp6-multi-diffnic06  |  67 ----
 .../icmp/multi-diffnic/icmp6-multi-diffnic07  |  66 ---
 33 files changed, 1 insertion(+), 2558 deletions(-)
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/Makefile
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip02
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip03
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip04
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip05
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip06
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip07
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip01
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip02
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip03
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip04
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip05
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip06
 delete mode 100644 testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip07
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/Makefile
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic01
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic02
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic03
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic04
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic05
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic06
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic07
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic01
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic02
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic03
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic04
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic05
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic06
 delete mode 100644 testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic07

diff --git a/testcases/network/stress/icmp/Makefile b/testcases/network/stress/icmp/Makefile
index 716f84dd67..55a4499761 100644
--- a/testcases/network/stress/icmp/Makefile
+++ b/testcases/network/stress/icmp/Makefile
@@ -8,4 +8,4 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= *.sh
 
-include $(top_srcdir)/include/mk/generic_trunk_target.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/icmp/multi-diffip/00_Descriptions.txt b/testcases/network/stress/icmp/multi-diffip/00_Descriptions.txt
deleted file mode 100644
index 4ac83b552a..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/00_Descriptions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Verify that the kernel is not crashed with receiving and sending various
-size of ICMP message at the different IP address(alias) simultaneously
-
-icmp4-multi-diffip01
-	IPv4
-
-icmp4-multi-diffip02
-	IPv4
-	IPsec [ AH / transport ]
-
-icmp4-multi-diffip03
-	IPv4
-	IPsec [ AH / tunnel ]
-
-icmp4-multi-diffip04
-	IPv4
-	IPsec [ ESP / transport ]
-
-icmp4-multi-diffip05
-	IPv4
-	IPsec [ ESP / tunnel ]
-
-icmp4-multi-diffip06
-	IPv4
-	IPcomp [ transport ]
-
-icmp4-multi-diffip07
-	IPv4
-	IPcomp [ tunnel ]
-
-icmp6-multi-diffip01
-	IPv6
-
-icmp6-multi-diffip02
-	IPv6
-	IPsec [ AH / transport ]
-
-icmp6-multi-diffip03
-	IPv6
-	IPsec [ AH / tunnel ]
-
-icmp6-multi-diffip04
-	IPv6
-	IPsec [ ESP / transport ]
-
-icmp6-multi-diffip05
-	IPv6
-	IPsec [ ESP / tunnel ]
-
-icmp6-multi-diffip06
-	IPv6
-	IPcomp [ transport ]
-
-icmp6-multi-diffip07
-	IPv6
-	IPcomp [ tunnel ]
diff --git a/testcases/network/stress/icmp/multi-diffip/Makefile b/testcases/network/stress/icmp/multi-diffip/Makefile
deleted file mode 100644
index 5fd73aadf9..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/stress/icmp/multi-diffip testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, October 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= icmp*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01 b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01
deleted file mode 100644
index d987788322..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip01
+++ /dev/null
@@ -1,378 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffip01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec is not used
-#
-#   *) This script may be read by the other test case
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=${TCID:-icmp4-multi-diffip01}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending various size of ICMP message at the different IP address(alias) simultaneously with the following conditions"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The number of IP address (alias)
-IP_TOTAL_FOR_TCPIP=${IP_TOTAL_FOR_TCPIP:-100}
-
-# The number of the test link where tests run
-LINK_NUM=${LINK_NUM:-0}
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# true, if ipsec is used
-DO_IPSEC=${DO_IPSEC:-false}
-
-# The value of SPI
-SPI=${SPI:-1000}
-
-# IPsec Protocol ( ah / esp / ipcomp )
-IPSEC_PROTO=${IPSEC_PROTO:-ah}
-
-# IPsec Mode ( transport / tunnel )
-IPSEC_MODE=${IPSEC_MODE:-transport}
-
-# Array of the echo request packet size
-ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65507"}
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Kill the icmp traffic server
-    killall_icmp_traffic
-
-    # Unset SAD/SPD
-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
-
-    # Clean up each interface
-    initialize_if lhost ${LINK_NUM}
-    initialize_if rhost ${LINK_NUM}
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Unset the maximum number of processes
-ulimit -u unlimited
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-tst_resm TINFO "- Target number of the connection is $IP_TOTAL_FOR_TCPIP"
-tst_resm TINFO "- Version of IP is IPv${IP_VER}"
-tst_resm TINFO "- Size of packets are ( $ICMP_SIZE_ARRAY )"
-
-if $DO_IPSEC ; then
-    message=`check_setkey`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "$message"
-	exit 1
-    fi
-
-    case $IPSEC_PROTO in
-	ah)
-	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]"
-	;;
-	esp)
-	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]"
-	;;
-	ipcomp)
-	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]"
-	;;
-    esac
-fi
-
-
-# name of interface of the local/remote host
-lhost_ifname=`get_ifname lhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the local host"
-    exit $TST_TOTAL
-fi
-
-rhost_ifname=`get_ifname rhost $LINK_NUM`
-if [ $? -ne 0 ]; then
-    tst_resm TBROK "Failed to get the interface name at the remote host"
-    exit $TST_TOTAL
-fi
-
-
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Loop to assign IP addresses
-ipaddr_pair_num=0
-while [ $ipaddr_pair_num -lt $IP_TOTAL_FOR_TCPIP ]; do
-    # Add new IP addresses
-    x=`expr $ipaddr_pair_num \/ 255 % 255`
-    y=`expr $ipaddr_pair_num % 255`
-    if [ $x -ge 255 ]; then
-	tst_resm TINFO "This script cannot add more than $ipaddr_pair_num addresses"
-	break
-    fi
-
-    case $IP_VER in
-	4)
-	network_part="10.${x}.${y}"
-	network_broadcast=${network_part}.255
-	network_mask=24
-	lhost_addr="${network_part}.2"
-	rhost_addr="${network_part}.1"
-
-	# Set IPv4 addresses to the interfaces
-	ip addr add ${lhost_addr}/${network_mask} broadcast $network_broadcast dev $lhost_ifname
-
-        ### delete before setting
-        if [ $? -eq 2 ]; then
-		ip addr del ${lhost_addr}/${network_mask} broadcast $network_broadcast dev $lhost_ifname 2>&1
-		ip addr add ${lhost_addr}/${network_mask} broadcast $network_broadcast dev $lhost_ifname
-        fi
-
-	if [ $? -ne 0 ]; then
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any IP address at the local"
-		exit 1
-	    else
-		tst_resm TINFO "The number of IP address at the local host seems to reach the maximum. The number is $ipaddr_pair_num"
-	    fi
-	    break
-	fi
-
-	ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr add ${rhost_addr}/${network_mask} broadcast $network_broadcast dev $rhost_ifname' ; echo $?'`
-
-        if [ $ret -eq 2 ]; then
-		$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr del ${rhost_addr}/${network_mask} broadcast $network_broadcast dev $rhost_ifname
-		ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr add ${rhost_addr}/${network_mask} broadcast $network_broadcast dev $rhost_ifname' ; echo $?'`
-        fi
-
-	if [ $ret -ne 0 ]; then
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any IP address at the remote"
-		exit 1
-	    else
-		tst_resm TINFO "The number of IP address at the remote host seems to reach the maximum. The number is $ipaddr_pair_num"
-	    fi
-	    break
-	fi
-	;;
-
-	6)
-	hex_x=`printf %x $x`
-	hex_y=`printf %x $y`
-
-	network_part="fd00:1:${hex_x}:${hex_y}"
-	network_mask=64
-	lhost_addr="${network_part}::2"
-	rhost_addr="${network_part}::1"
-
-	# Set IPv6 addresses to the interfaces
-	ip addr add ${lhost_addr}/${network_mask} dev $lhost_ifname
-
-        if [ $? -eq 2 ]; then
-		ip addr del ${lhost_addr}/${network_mask} dev $lhost_ifname 2>&1
-		ip addr add ${lhost_addr}/${network_mask} dev $lhost_ifname
-        fi
-
-	if [ $? -ne 0 ]; then
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any IP address at the local"
-		exit 1
-	    else
-		tst_resm TINFO "The number of IP address at the local host seems to reach the maximum. The number is $ipaddr_pair_num"
-	    fi
-	    break
-	fi
-
-	ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr add ${rhost_addr}/${network_mask} dev $rhost_ifname' ; echo $?'`
-
-	if [ $ret -eq 2 ]; then
-		$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr del ${rhost_addr}/${network_mask} dev $rhost_ifname
-		ret=`$LTP_RSH $RHOST 'PATH=/sbin:/usr/sbin:$PATH ip' addr add ${rhost_addr}/${network_mask} dev $rhost_ifname' ; echo $?'`
-	fi
-
-	if [ $ret -ne 0 ]; then
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any IP address at the remote"
-		exit 1
-	    else
-		tst_resm TINFO "The number of IP address at the remote host seems to reach the maximum. The number is $ipaddr_pair_num"
-	    fi
-	    break
-	fi
-	;;
-    esac
-
-    # Set SAD/SPD
-    if $DO_IPSEC ; then
-	ipsec_log=`mktemp -p $TMPDIR`
-	output_ipsec_conf src \
-	    $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
-		| setkey -c 2>&1 | tee $ipsec_log
-	if [ $? -ne 0 -o -s $ipsec_log ]; then
-	    rm -f $ipsec_log
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any SAD/SPD"
-		exit 1
-	    else
-		tst_resm TINFO "The number of SAD/SPD seems to reach the maximum at the local host."
-	    fi
-	    break
-	fi
-	rm -f $ipsec_log
-
-	$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
-	if [ -s $ipsec_log ]; then
-	    rm -f $ipsec_log
-	    if [ $ipaddr_pair_num -eq 0 ]; then
-		tst_resm TBROK "Failed to add any SAD/SPD"
-		exit 1
-	    else
-		tst_resm TINFO "The number of SAD/SPD seems to reach the maximum at the remote host."
-	    fi
-	    break
-	fi
-	rm -f $ipsec_log
-    fi
-
-    # Check the connectivity
-    case $IP_VER in
-	4)
-	ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "No IPv4 connectivity among ${ipaddr_pair_num}th IP address pair"
-	    exit 1
-	fi
-	;;
-
-	6)
-	ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "No IPv6 connectivity among ${ipaddr_pair_num}th IP address pair"
-	    exit 1
-	fi
-	;;
-    esac
-
-    if [ $? -ne 0 ]; then
-	tst_resm TFAIL "There is no connectivity."
-	exit 1
-    fi
-
-    ipaddr_pair_num=`expr $ipaddr_pair_num + 1`
-done
-
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-# Start to receiving/replying ICMP echo
-connection_num=0
-while [ $connection_num -lt $ipaddr_pair_num ]; do
-    # IP addresses
-    x=`expr $connection_num \/ 255 % 255`
-    y=`expr $connection_num % 255`
-
-    case $IP_VER in
-	4)
-	lhost_addr="10.${x}.${y}.2"
-	;;
-
-	6)
-	hex_x=`printf %x $x`
-	hex_y=`printf %x $y`
-	lhost_addr="fd00:1:${hex_x}:${hex_y}::2"
-	;;
-    esac
-
-    # Run a client
-    $LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-echoclient -S $lhost_addr -f $IP_VER -s \"$ICMP_SIZE_ARRAY\"" &
-    connection_num=`expr $connection_num + 1`
-done
-
-
-sleep $NS_DURATION
-killall_icmp_traffic
-wait
-
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip02 b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip02
deleted file mode 100644
index 770c1efa50..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffip02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffip02
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip03 b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip03
deleted file mode 100644
index f45d9606e5..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffip03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffip03
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip04 b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip04
deleted file mode 100644
index df7944d5e6..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffip04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffip04
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip05 b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip05
deleted file mode 100644
index b987ef4a94..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffip05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffip05
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip06 b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip06
deleted file mode 100644
index f2dd0a2e12..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffip06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffip06
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip07 b/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip07
deleted file mode 100644
index 9e4ece9202..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp4-multi-diffip07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffip07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#     - The version of IP is IPv4
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffip07
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip01 b/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip01
deleted file mode 100644
index d6d3d89863..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip01
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffip01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#     - The version of IP is IPv6
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffip01
-
-# The version of IP
-IP_VER=6
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip02 b/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip02
deleted file mode 100644
index c3c49bb48f..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffip02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffip02
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip03 b/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip03
deleted file mode 100644
index 222feb5645..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffip03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffip03
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip04 b/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip04
deleted file mode 100644
index 7d389613d4..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffip04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffip04
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip05 b/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip05
deleted file mode 100644
index c87ef478e4..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffip05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffip05
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip06 b/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip06
deleted file mode 100644
index 9775ac98dd..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffip06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffip06
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip07 b/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip07
deleted file mode 100644
index 6db8b45d51..0000000000
--- a/testcases/network/stress/icmp/multi-diffip/icmp6-multi-diffip07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffip07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different IP address(alias) with the following conditions
-#     - The version of IP is IPv6
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffip testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffip07
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffip01
diff --git a/testcases/network/stress/icmp/multi-diffnic/00_Descriptions.txt b/testcases/network/stress/icmp/multi-diffnic/00_Descriptions.txt
deleted file mode 100644
index 9cd82f571a..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/00_Descriptions.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Verify that the kernel is not crashed with receiving and sending various
-size of ICMP message at different NIC simultaneously
-
-icmp4-multi-diffnic01
-	IPv4
-
-icmp4-multi-diffnic02
-	IPv4
-	IPsec [ AH / transport ]
-
-icmp4-multi-diffnic03
-	IPv4
-	IPsec [ AH / tunnel ]
-
-icmp4-multi-diffnic04
-	IPv4
-	IPsec [ ESP / transport ]
-
-icmp4-multi-diffnic05
-	IPv4
-	IPsec [ ESP / tunnel ]
-
-icmp4-multi-diffnic06
-	IPv4
-	IPcomp [ transport ]
-
-icmp4-multi-diffnic07
-	IPv4
-	IPcomp [ tunnel ]
-
-icmp6-multi-diffnic01
-	IPv6
-
-icmp6-multi-diffnic02
-	IPv6
-	IPsec [ AH / transport ]
-
-icmp6-multi-diffnic03
-	IPv6
-	IPsec [ AH / tunnel ]
-
-icmp6-multi-diffnic04
-	IPv6
-	IPsec [ ESP / transport ]
-
-icmp6-multi-diffnic05
-	IPv6
-	IPsec [ ESP / tunnel ]
-
-icmp6-multi-diffnic06
-	IPv6
-	IPcomp [ transport ]
-
-icmp6-multi-diffnic07
-	IPv6
-	IPcomp [ tunnel ]
diff --git a/testcases/network/stress/icmp/multi-diffnic/Makefile b/testcases/network/stress/icmp/multi-diffnic/Makefile
deleted file mode 100644
index 63389ab558..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/stress/icmp/multi-diffnic testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, October 2009
-#
-
-top_srcdir		?= ../../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= icmp*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic01 b/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic01
deleted file mode 100644
index 2d8278fa63..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic01
+++ /dev/null
@@ -1,301 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffnic01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec is not used
-#
-#   *) This script may be read by the other test case
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-# The test case ID, the test case count and the total number of test case
-TCID=${TCID:-icmp4-multi-diffnic01}
-TST_TOTAL=1
-TST_COUNT=1
-export TCID
-export TST_COUNT
-export TST_TOTAL
-
-# Test description
-tst_resm TINFO "Verify that the kernel is not crashed with receiving and sending various size of ICMP message at different NIC simultaneously with the following conditions"
-
-# Make sure the value of LTPROOT
-LTPROOT=${LTPROOT:-`(cd ../../../../.. ; pwd)`}
-export LTPROOT
-
-# Check the environmanet variable
-. check_envval || exit $TST_TOTAL
-
-# Dulation of the test [sec]
-NS_DURATION=${NS_DURATION:-3600}      # 1 hour
-
-# The version of IP
-IP_VER=${IP_VER:-4}
-
-# true, if ipsec is used
-DO_IPSEC=${DO_IPSEC:-false}
-
-# The value of SPI
-SPI=${SPI:-1000}
-
-# IPsec Protocol ( ah / esp / ipcomp )
-IPSEC_PROTO=${IPSEC_PROTO:-ah}
-
-# IPsec Mode ( transport / tunnel )
-IPSEC_MODE=${IPSEC_MODE:-transport}
-
-# Array of the echo request packet size
-ICMP_SIZE_ARRAY=${ICMP_SIZE_ARRAY:-"10 100 1000 10000 65507"}
-
-
-
-#-----------------------------------------------------------------------
-#
-# Function: do_cleanup
-#
-# Description:
-#   Recover the system configuration
-#
-#-----------------------------------------------------------------------
-do_cleanup()
-{
-    # Kill the icmp traffic server
-    killall_icmp_traffic
-
-    # Unset SAD/SPD
-    output_ipsec_conf flush | setkey -c >/dev/null 2>&1
-    $LTP_RSH $RHOST ${LTPROOT}/'testcases/bin/output_ipsec_conf flush | PATH=/sbin:/usr/sbin:$PATH setkey -c' >/dev/null 2>&1
-
-    # Clean up each interface
-    link_num=0
-    while [ $link_num -lt $link_total ]; do
-	initialize_if lhost ${link_num}
-	initialize_if rhost ${link_num}
-	link_num=`expr $link_num + 1`
-    done
-}
-
-
-#-----------------------------------------------------------------------
-#
-# Setup
-#
-
-# Unset the maximum number of processes
-ulimit -u unlimited
-
-# Output the informaion
-tst_resm TINFO "- Test duration is $NS_DURATION [sec]"
-
-link_total=`echo $LHOST_HWADDRS | wc -w`
-rhost_link_total=`echo $RHOST_HWADDRS | wc -w`
-if [ $link_total -ne $rhost_link_total ]; then
-    tst_resm TBROK "The number of element in LHOST_HWADDRS differs from RHOST_HWADDRS"
-    exit 1
-fi
-if [ $link_total -lt 2 ]; then
-    tst_resm TBROK "This test case requires plural NICs."
-    exit 1
-fi
-tst_resm TINFO "- Target number of the connection is $link_total"
-
-tst_resm TINFO "- Version of IP is IPv${IP_VER}"
-tst_resm TINFO "- Size of packets are ( $ICMP_SIZE_ARRAY )"
-
-if $DO_IPSEC ; then
-    message=`check_setkey`
-    if [ $? -ne 0 ]; then
-	tst_resm TBROK "$message"
-	exit 1
-    fi
-
-    case $IPSEC_PROTO in
-	ah)
-	tst_resm TINFO "- IPsec [ AH / $IPSEC_MODE ]"
-	;;
-	esp)
-	tst_resm TINFO "- IPsec [ ESP / $IPSEC_MODE ]"
-	;;
-	ipcomp)
-	tst_resm TINFO "- IPcomp [ $IPSEC_MODE ]"
-	;;
-    esac
-fi
-
-# Initialize the system configuration
-do_cleanup
-
-# Call do_cleanup function before exit
-trap do_cleanup 0
-
-# Loop for NIC configuration
-link_num=0
-lhost_addrs=""
-while [ $link_num -lt $link_total ]; do
-    # name of interface of the local/remote host
-    lhost_ifname=`get_ifname lhost $link_num`
-    rhost_ifname=`get_ifname rhost $link_num`
-
-    # Set the IP address to each interface
-    case $IP_VER in
-	4)
-	network_part="10.0.${link_num}"
-	network_mask=24
-	lhost_host_part="2"     # local host
-	rhost_host_part="1"     # remote host
-	set_ipv4addr lhost $link_num $network_part $lhost_host_part
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to set IPv4 address at the local host"
-	    exit 1
-	fi
-	set_ipv4addr rhost $link_num $network_part $rhost_host_part
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to set IPv4 address at the remote host"
-	    exit 1
-	fi
-
-	# IPv4 address of the local/remote host
-	lhost_addr="${network_part}.${lhost_host_part}"
-	rhost_addr="${network_part}.${rhost_host_part}"
-	lhost_addrs="${lhost_addrs} ${lhost_addr}"
-	;;
-
-	6)
-	network_part="fd00:1:0:`printf %x ${link_num}`"
-	network_mask=64
-	lhost_host_part=":2"     # local host
-	rhost_host_part=":1"     # remote host
-	add_ipv6addr lhost $link_num $network_part $lhost_host_part
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to set IPv6 address at the local host"
-	    exit 1
-	fi
-	add_ipv6addr rhost $link_num $network_part $rhost_host_part
-	if [ $? -ne 0 ]; then
-	    tst_resm TBROK "Failed to set IPv6 address at the remote host"
-	    exit 1
-	fi
-	lhost_addr="${network_part}:${lhost_host_part}"
-	rhost_addr="${network_part}:${rhost_host_part}"
-	lhost_addrs="${lhost_addrs} ${lhost_addr}"
-	;;
-
-	*)
-	tst_resm TBROK "Unknown IP version"
-	;;
-    esac
-
-    # Configure SAD/SPD
-    if $DO_IPSEC ; then
-	ipsec_log=`mktemp -p $TMPDIR`
-
-	# Set SAD/SPD according to the variables
-	output_ipsec_conf src \
-	    $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr \
-		| setkey -c 2>&1 | tee $ipsec_log
-	if [ $? -ne 0 -o -s $ipsec_log ]; then
-	    rm -f $ipsec_log
-	    tst_resm TBROK "Failed to configure SAD/SPD on the local host."
-	    exit 1
-	fi
-
-	$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/output_ipsec_conf dst $IPSEC_PROTO $IPSEC_MODE $SPI $lhost_addr $rhost_addr' | PATH=/sbin:/usr/sbin:$PATH setkey -c' 2>&1 | tee $ipsec_log
-	if [ $? -ne 0 -o -s $ipsec_log ]; then
-	    rm -f $ipsec_log
-	    tst_resm TBROK "Failed to configure SAD/SPD on the remote host."
-	    exit 1
-	fi
-	rm -f $ipsec_log
-    fi
-
-    # Make sure the connectivity
-    case $IP_VER in
-	4)
-	ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv4_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "There is no IPv4 connectivity on Link${link_num}"
-	    exit 1
-	fi
-	;;
-
-	6)
-	ret=`$LTP_RSH $RHOST ${LTPROOT}/testcases/bin/check_icmpv6_connectivity $rhost_ifname $lhost_addr' ; echo $?'`
-	if [ $ret -ne 0 ]; then
-	    tst_resm TBROK "There is no IPv6 connectivity on Link${link_num}"
-	    exit 1
-	fi
-	;;
-    esac
-
-    link_num=`expr $link_num + 1`
-done
-
-
-#-----------------------------------------------------------------------
-#
-# Main
-#
-#
-
-connection_num=0
-while [ $connection_num -lt $link_total ]; do
-    field=`expr $connection_num + 1`
-    lhost_addr=`echo $lhost_addrs | cut -d ' ' -f $field`
-
-    lhost_ifname=`get_ifname lhost $connection_num`
-    rhost_ifname=`get_ifname rhost $connection_num`
-
-    # Run a client
-    $LTP_RSH $RHOST "${LTPROOT}/testcases/bin/ns-echoclient -S $lhost_addr -f $IP_VER -s \"$ICMP_SIZE_ARRAY\"" &
-    connection_num=`expr $connection_num + 1`
-done
-
-sleep $NS_DURATION
-killall_icmp_traffic
-wait
-
-#-----------------------------------------------------------------------
-#
-# Clean up
-#
-
-tst_resm TPASS "Test is finished successfully."
-exit 0
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic02 b/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic02
deleted file mode 100644
index c666b69db7..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffnic02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffnic02
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic03 b/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic03
deleted file mode 100644
index 183242e063..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffnic03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffnic03
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic04 b/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic04
deleted file mode 100644
index a640bbc342..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffnic04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#     - The version of IP is IPv4
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffnic04
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic05 b/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic05
deleted file mode 100644
index 50778e2f0b..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffnic05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffnic05
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic06 b/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic06
deleted file mode 100644
index eb9cba0ee5..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffnic06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#
-#     - The version of IP is IPv4
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffnic06
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic07 b/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic07
deleted file mode 100644
index 0793381e44..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp4-multi-diffnic07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp4-multi-diffnic07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#     - The version of IP is IPv4
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp4-multi-diffnic07
-
-# The version of IP
-IP_VER=4
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic01 b/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic01
deleted file mode 100644
index 0c2d8417d2..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic01
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffnic01
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#     - The version of IP is IPv6
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffnic01
-
-# The version of IP
-IP_VER=6
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic02 b/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic02
deleted file mode 100644
index 7b42012b4b..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic02
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffnic02
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(AH), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffnic02
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic03 b/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic03
deleted file mode 100644
index d91b2ce23b..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic03
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffnic03
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(AH), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffnic03
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ah
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic04 b/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic04
deleted file mode 100644
index b03e81aa22..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic04
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffnic04
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#     - The version of IP is IPv6
-#     - IPsec(ESP), transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffnic04
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic05 b/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic05
deleted file mode 100644
index 5237988c0b..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic05
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffnic05
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPsec(ESP), tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffnic05
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=esp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic06 b/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic06
deleted file mode 100644
index dfeb7d83f9..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic06
+++ /dev/null
@@ -1,67 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffnic06
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#
-#     - The version of IP is IPv6
-#     - IPcomp, transport mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffnic06
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=transport
-
-. icmp4-multi-diffnic01
diff --git a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic07 b/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic07
deleted file mode 100644
index 142c33cee0..0000000000
--- a/testcases/network/stress/icmp/multi-diffnic/icmp6-multi-diffnic07
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2005                 ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-##                                                                            ##
-################################################################################
-#
-# File:
-#   icmp6-multi-diffnic07
-#
-# Description:
-#   Verify that the kernel is not crashed with receiving and sending ICMP
-#   message at different NIC with the following conditions
-#     - The version of IP is IPv6
-#     - IPcomp, tunnel mode
-#
-# Setup:
-#   See testcases/network/stress/README
-#
-# Author:
-#   Mitsuru Chinen <mitch@jp.ibm.com>
-#
-# History:
-#	Oct 19 2005 - Created (Mitsuru Chinen)
-#
-#-----------------------------------------------------------------------
-# Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
-#
-# Variables -- Changed by each multi-diffnic testcase
-#
-
-# The test case ID
-TCID=icmp6-multi-diffnic07
-
-# The version of IP
-IP_VER=6
-
-# true, if ipsec is used
-DO_IPSEC=true
-
-# IPsec Protocol
-IPSEC_PROTO=ipcomp
-
-# IPsec Mode
-IPSEC_MODE=tunnel
-
-. icmp4-multi-diffnic01
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
