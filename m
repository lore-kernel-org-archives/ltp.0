Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE16C55173
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 20:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785528227; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=m0U3ZtJReXD9P17riZMD5C2KBqXkTAWXpGCjC2ZDR3Q=;
 b=DZtalwcpYb+yZFgvvWbqZb+vIRXGFleSzelnVdINCXZxI/q84z2zMMykvV940OGq8LzKd
 +U1wUAh+3+Kf9hJPuSFVuKYHZAtqoVpfP/S/psZxxFPQwXKvsX6dkJaD9O0uJrr9jSXp8Gh
 shHfRn0AdmjOECQSadcHueT9qIYIr0E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8A023E71E2
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 22:03:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 131ED3E25FB
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 22:03:26 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C7DE4200179
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 22:03:24 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so958935f8f.3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785528204; x=1786133004; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3g2dbpEoZL3E+KKWmeDSadY9w3IC/+20hG0P/e1zJVQ=;
 b=JORqgTcL+gc3bvUz3e4BUwMe2ntD0UdHnYRbg0qCFtoRsndyPZ80wwu/sTdoY8pfx2
 HH1+HcQ/XWwNLyvwynf0KuO+w8d0oIh8aLfqF94pE+ym1LHMlh+wVm8qaDBlNZSwjGeJ
 ZjobmUaEfpSwY+vfcHN1xmHFSehvpDFR4xXa1HUMjmRB/T20CBYoryFsljNOvI+MZ1qs
 q2wqvKcPfxPf68E/uEzhHEU2/HPx+wc6btpAGlPXoZedKJwIho8xH1vNM/ksSg42gVC3
 zmtt3Kv+Sm1D0ycL/9rpQzFed17tjzAX2A0cSLP8Uh3LjfMyMBwRq0dO2AEYEQDPqlNX
 82fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785528204; x=1786133004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3g2dbpEoZL3E+KKWmeDSadY9w3IC/+20hG0P/e1zJVQ=;
 b=p93uJAQHUvBFJ4bZdYDA0KbQES5Ya1qWlVRcLZnDy5kRy8/NRpl4Ve8m/to+d4aONv
 RMaCQWE7VdEGXsdTMcNIyG+xwYhRIh2EgYjamTR1xOeGRULKXIXesLK1R9gk5MhrKFn2
 lJne4tjpbxzfAIHvUQ+ZzmSJzOy8Nad9efKeUPISc1Zb1+ie4tyl0s5JZkw5TvKsMFLF
 e47WTB/0yTV0thBny83ou/ah7QWFFXxUAWuQxJkKS87vbriQpRI1lJkS8x1GPLUUu2SD
 oQpL7yWU+qt5oVQOffOZbLTHdQfMxCRzYUCt+d+IDET9yUVM05Z67baC1wFCkaNg/SnX
 1E2w==
X-Gm-Message-State: AOJu0YwbA6IAKSSMS0F4aF6+8Fi15fXP4rn23iuyZ5Q5S2VC/UJrTc2d
 2RK+oz96Y3auf5Bb1IJ0DVJmrERJ0gQPrnrgaoCKLE3H1LpE3DgRvDCqb5QjezjgVSAtrhrtnrq
 4r0wJugM=
X-Gm-Gg: AR+sD10qJPTLrn12V3McEIsgks/Zu4R+bXv/5c/sIP4OD3dEgaWv7u92rf5YZsjgoz7
 9EEs8jFqmqGYg94b/CB92jDxvMi/Wix7l/dPKfv6Dfsb08mDOEJ/Z0IFO5qgiL24CoEcMoj6kj3
 Ja34vz7BI6W+WB45cO4WiQPOWUx0cFwzEJiR9TPn6uonInzeJQv3sPlRV0qbRgxqLLtYavRDzGs
 ORXCxHZv5p5RS+qcCQ6yy05vohpyicaFItLQYIZzxiHZkm6rFKrSVx64qtHIoNTWVCDCvb5WyYZ
 iJEMYdxZ3uNGH5dpK59wsVUbWl3cNGcqzfofdYy8Xy85o+VlqDkKZWNIA7pAAMzYFGC5JBYFE/r
 c7WMm0zVeip/JllDompPwfvj0ThahaQaNydlCdnU2bVR8SCYg7P0xTvNh8RZIqqXDV6qkzIJxnf
 fh72TLtnpKYes8vSI5DuQiHzWn7gGLeBHjwMHj73IxPdyKFLrF6MrtU1JRlQ==
X-Received: by 2002:a5d:5002:0:b0:473:823:1924 with SMTP id
 ffacd0b85a97d-47fd7314b2cmr1384111f8f.39.1785528203898; 
 Fri, 31 Jul 2026 13:03:23 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456220esm8682780f8f.18.2026.07.31.13.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 13:03:23 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 31 Jul 2026 22:03:18 +0200
Message-ID: <20260731200322.161590-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH] network: Remove outdated DNS stress tests
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

These tests start a local named server and run $NS_TIMES
(default: 10) dig queries from the remote host, forward and reverse.
The check is that the first and last query return NOERROR with one
answer record, and that no dig call in between exited non-zero.
They are also broken: dns-stress02-rmt.sh passes 'dig -n' for ipv6,
an option removed from bind long ago. dig prints "dig: -n removed",
sends no query and exits 0.
Remove these old broken tests based on legacy shell API.

Follow-up: 99c0b167d ("network: Remove outdated TCP stress tests")

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 runtest/net_stress.appl                       |   5 +-
 testcases/network/stress/README               |   6 +-
 .../network/stress/dns/00_Descriptions.txt    |   7 -
 testcases/network/stress/dns/Makefile         |  29 ---
 .../network/stress/dns/dns-stress-lib.sh      |  41 ----
 testcases/network/stress/dns/dns-stress.sh    | 204 ------------------
 .../network/stress/dns/dns-stress01-rmt.sh    |  73 -------
 .../network/stress/dns/dns-stress02-rmt.sh    |  78 -------
 8 files changed, 4 insertions(+), 439 deletions(-)
 delete mode 100644 testcases/network/stress/dns/00_Descriptions.txt
 delete mode 100644 testcases/network/stress/dns/Makefile
 delete mode 100644 testcases/network/stress/dns/dns-stress-lib.sh
 delete mode 100755 testcases/network/stress/dns/dns-stress.sh
 delete mode 100755 testcases/network/stress/dns/dns-stress01-rmt.sh
 delete mode 100755 testcases/network/stress/dns/dns-stress02-rmt.sh

diff --git a/runtest/net_stress.appl b/runtest/net_stress.appl
index 0da12717e439..fdbcac3f5a7e 100644
--- a/runtest/net_stress.appl
+++ b/runtest/net_stress.appl
@@ -1,13 +1,10 @@
 #
-# Stress test for major application protocol (ssh, dns, http, ftp)
+# Stress test for major application protocol (ssh, http, ftp)
 #
 
 ssh4-stress ssh-stress.sh
 ssh6-stress ssh-stress.sh -6
 
-dns4-stress dns-stress.sh
-dns6-stress dns-stress.sh -6
-
 http4-stress http-stress.sh
 http6-stress http-stress.sh -6
 
diff --git a/testcases/network/stress/README b/testcases/network/stress/README
index b9537b1ce039..57427cac5db6 100644
--- a/testcases/network/stress/README
+++ b/testcases/network/stress/README
@@ -61,8 +61,8 @@ Attention for HTTP/FTP stress tests
 
 When you run http or ftp stress tests, you have to start http or ftp server
 before running the tests.
-About ssh and dns tests, you don't need to run the ssh or dns server.  Each
-test runs named or sshd automatically.
+About ssh tests, you don't need to run the ssh server.  Each test runs sshd
+automatically.
 
 Those tests requires that the remote host has `curl' command in order to
 upload/download files to/from the local host.
@@ -159,7 +159,7 @@ Optional environment variables
  o NS_TIMES (for the repetition test)
    The number of repetition times for the repetition tests.
    This value affects IP adress add/del testcase, IP address change testcase
-   route add/del testcase and dns query tests.
+   route add/del testcase.
 
  o CONNECTION_TOTAL (for creating a large number of connection test)
    The total number of connection when the testcase requires plural connection.
diff --git a/testcases/network/stress/dns/00_Descriptions.txt b/testcases/network/stress/dns/00_Descriptions.txt
deleted file mode 100644
index bc6583c4157a..000000000000
--- a/testcases/network/stress/dns/00_Descriptions.txt
+++ /dev/null
@@ -1,7 +0,0 @@
-dns-stress01
-	Verify the dns server or the kernel is not down after handling
-	many name lookup queries
-
-dns-stress02
-	Verify the dns server or the kernel is not down after handling
-	many reverse lookup queries
diff --git a/testcases/network/stress/dns/Makefile b/testcases/network/stress/dns/Makefile
deleted file mode 100644
index 4c34ee24b6ab..000000000000
--- a/testcases/network/stress/dns/Makefile
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-#    network/stress/dns test suite Makefile.
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
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= *.sh
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/stress/dns/dns-stress-lib.sh b/testcases/network/stress/dns/dns-stress-lib.sh
deleted file mode 100644
index d85f6e3f3422..000000000000
--- a/testcases/network/stress/dns/dns-stress-lib.sh
+++ /dev/null
@@ -1,41 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
-
-. test.sh
-
-TST_CLEANUP=tst_rmdir
-
-dns_check_answer()
-{
-	local fname="$1"
-
-	if ! grep -q 'status: NOERROR' $fname; then
-		cat $fname
-		tst_brkm TFAIL "unexpected query status"
-	fi
-	if ! grep -q 'QUERY: 1, ANSWER: 1' $fname; then
-		cat $fname
-		tst_brkm TFAIL "unexpected number of query/answer"
-	fi
-}
-
-dns_check_send_requests()
-{
-	[ $num -eq $connect_quantity ] && return
-	tst_brkm TFAIL "some requests failed: $num/$connect_quantity"
-}
-
-tst_tmpdir
diff --git a/testcases/network/stress/dns/dns-stress.sh b/testcases/network/stress/dns/dns-stress.sh
deleted file mode 100755
index c90366605f1a..000000000000
--- a/testcases/network/stress/dns/dns-stress.sh
+++ /dev/null
@@ -1,204 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2005
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
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=dns-stress
-TST_TOTAL=2
-TST_CLEANUP="cleanup"
-
-TST_USE_LEGACY_API=1
-
-# Minimum host ID in the zone file.
-# The ID is used as the host portion of the address
-MIN_ID=2
-# Maximum host ID in the zone file.
-MAX_ID=254
-# Domain name for testing
-DOMAIN="ltp-ns.org"
-
-cleanup()
-{
-	# Stop the dns daemon
-	test -s named.pid && kill -9 $(cat named.pid) > /dev/null
-	tst_rmdir
-}
-
-common_setup()
-{
-	tst_require_root
-	tst_require_cmds named dig
-
-	if [ "$TST_IPV6" ]; then
-		record="AAAA"
-		net="fd00:cafe"
-		net_rev="0.0.0.0.0.0.0.0.e.f.a.c.0.0.d.f"
-	else
-		record="A"
-		net="10.23.0"
-		net_rev="0.23.10"
-	fi
-
-	trap "tst_brkm TBROK 'test interrupted'" INT
-
-	tst_tmpdir
-
-	ip6_opt=
-	[ "$TST_IPV6" ] && ip6_opt="listen-on-v6 { any; };"
-
-	ip_zone_opt="in-addr"
-	[ "$TST_IPV6" ] && ip_zone_opt="ip6"
-
-	cat << EOD > named.conf
-	options {
-		directory "$(pwd)";
-		pid-file "named.pid";
-		recursion no;
-		$ip6_opt
-	};
-
-	zone "$DOMAIN" {
-		type master;
-		file "ltp-ns.zone";
-	};
-
-	zone "$net_rev.$ip_zone_opt.arpa" {
-		type master;
-		file "ltp-ns.rev";
-	};
-EOD
-
-	# zone file
-	cat << EOD > ltp-ns.zone
-\$TTL 10
-@	IN	SOA dns.$DOMAIN. root.$DOMAIN. (
-	2005092701 ; serial
-	3600       ; dummy value
-	900        ; dummy value
-	604800     ; dummy value
-	86400      ; dummy value
-)
-	IN	NS	dns.$DOMAIN.
-EOD
-}
-
-setup_4()
-{
-	printf "dns\tIN\tA\t$net.1\n" >> ltp-ns.zone
-	local id=$MIN_ID
-	while [ $id -le $MAX_ID ]; do
-		printf "node$id\tIN\tA\t$net.$id\n" >> ltp-ns.zone
-		id=$(($id + 1))
-	done
-
-	# reverse zone file
-	cat << EOD > ltp-ns.rev
-\$TTL 10
-@	IN	SOA $DOMAIN. root.$DOMAIN. (
-	2005092701 ; serial
-	3600       ; dummy value
-	900        ; dummy value
-	604800     ; dummy value
-	86400      ; dummy value
-)
-        IN      NS      dns.$DOMAIN.
-EOD
-
-	id=$MIN_ID
-	while [ $id -le $MAX_ID ]; do
-		printf "$id\tIN\tPTR\tnode$id.$DOMAIN.\n" >> ltp-ns.rev
-		id=$(($id + 1))
-	done
-}
-
-setup_6()
-{
-	printf "dns\tIN\tAAAA\t$net::1\n" >> ltp-ns.zone
-	local id=$MIN_ID
-	while [ $id -le $MAX_ID ]; do
-		printf "node$id\tIN\tAAAA\t$net::%x\n" $id >> ltp-ns.zone
-		id=$(($id + 1))
-	done
-
-	# reverse zone file
-	cat << EOD > ltp-ns.rev
-\$TTL 10
-@	IN	SOA $DOMAIN. root.$DOMAIN. (
-	2005092701 ; serial
-	3600       ; dummy value
-	900        ; dummy value
-	604800     ; dummy value
-	86400      ; dummy value
-)
-        IN      NS      dns.$DOMAIN.
-EOD
-
-	id=$MIN_ID
-	local rev_ip="0.0.0.0.0.0.0.0.0.0.0.0.0.0"
-	while [ $id -le $MAX_ID ]; do
-		printf "%x.%x.$rev_ip\tIN\tPTR\tnode$id.$DOMAIN.\n" \
-			$(($id % 16)) $(($id / 16)) >> ltp-ns.rev
-		id=$(($id + 1))
-	done
-}
-
-start_named()
-{
-	chmod 770 .
-	chmod 660 ./*
-
-	port=$(tst_get_unused_port ipv${TST_IPVER} dgram)
-
-	tst_resm TINFO "Start named daemon, port $port"
-	named -$TST_IPVER -c named.conf -p $port || \
-		tst_brkm TBROK "Failed to run named daemon"
-
-	# Make sure named.pid is created.
-	while true ; do
-		test -s named.pid && break
-		tst_sleep 100ms
-	done
-}
-
-test01()
-{
-	tst_resm TINFO "Handling name lookup queries '$NS_TIMES' times"
-
-	tst_rhost_run -s -c "dns-stress01-rmt.sh $TST_IPVER $(tst_ipaddr) $port \
-		$DOMAIN $MIN_ID $MAX_ID $NS_TIMES"
-
-	tst_resm TPASS "Test is finished successfully"
-}
-
-test02()
-{
-	tst_resm TINFO "Handling reverse lookup queries '$NS_TIMES' times"
-
-	tst_rhost_run -s -c "dns-stress02-rmt.sh $TST_IPVER $(tst_ipaddr) $port $net \
-		$MIN_ID $MAX_ID $NS_TIMES"
-
-	tst_resm TPASS "Test is finished successfully"
-}
-
-. tst_net.sh
-common_setup
-setup_$TST_IPVER
-start_named
-test01
-test02
-tst_exit
diff --git a/testcases/network/stress/dns/dns-stress01-rmt.sh b/testcases/network/stress/dns/dns-stress01-rmt.sh
deleted file mode 100755
index 71b7d8de5083..000000000000
--- a/testcases/network/stress/dns/dns-stress01-rmt.sh
+++ /dev/null
@@ -1,73 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2005
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
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=dns-stress01-rmt
-TST_TOTAL=1
-
-. dns-stress-lib.sh
-
-# Check the arguments
-if [ $# -ne 7 ]; then
-	tst_brkm TBROK "Usage: $0 ip_ver srv_ipaddr port domain \
-min_id max_id connect_quantity"
-fi
-
-ip_ver="$1"
-srv_ipaddr="$2"
-port="$3"
-domain="$4"
-min_id="$5"
-max_id="$6"
-connect_quantity="$7"
-
-# Specify the record of dns accoring to the version of IP
-case $ip_ver in
-4)
-	record="A" ;;
-6)
-	record="AAAA" ;;
-*)
-	tst_brkm TBROK "$ver_opt is unknown IP version" ;;
-esac
-
-# Check the connectivity first
-dig @$srv_ipaddr -p $port node${min_id}.${domain} $record > ans.log 2>&1 || \
-	tst_brkm TBROK "Failed to connect $srv_ipaddr"
-dns_check_answer ans.log
-
-# Loop for a large number of name lookup queries
-num=0
-id=$min_id
-while [ $num -lt $connect_quantity ]; do
-	dig @$srv_ipaddr -p $port node${id}.${domain} $record \
-		> /dev/null || break
-	id=$(($id + 1))
-	[ $id -gt $max_id ] && id=$min_id
-	num=$(($num + 1))
-done
-
-# Check the connectivity again
-dig @$srv_ipaddr -p $port node${id}.${domain} $record > ans.log 2>&1 || \
-	tst_brkm TBROK "Failed to connect $srv_ipaddr"
-dns_check_answer ans.log
-
-dns_check_send_requests
-
-tst_exit
diff --git a/testcases/network/stress/dns/dns-stress02-rmt.sh b/testcases/network/stress/dns/dns-stress02-rmt.sh
deleted file mode 100755
index 58fd60f31a4e..000000000000
--- a/testcases/network/stress/dns/dns-stress02-rmt.sh
+++ /dev/null
@@ -1,78 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2006
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
-# Author: Mitsuru Chinen <mitch@jp.ibm.com>
-
-TCID=dns-stress02-rmt
-TST_TOTAL=1
-
-. dns-stress-lib.sh
-
-if [ $# -ne 7 ]; then
-	tst_brkm TBROK "Usage: $0 ip_ver srv_ipaddr port net \
-min_id max_id connect_quantity"
-fi
-
-ip_ver="$1"
-srv_ipaddr="$2"
-port="$3"
-net="$4"
-min_id="$5"
-max_id="$6"
-connect_quantity="$7"
-
-# Specify the option of dns according to the version of IP
-case $ip_ver in
-4)
-	opt=""
-	sep="."
-;;
-6)
-	opt="-n"
-	sep="::"
-;;
-*)
-	tst_brkm TBROK "$ver_opt is unknown IP version" ;;
-esac
-
-# Check the connectivity first
-dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${min_id} $record \
-	> ans.log 2>&1 || \
-	tst_brkm TBROK "Failed to connect $srv_ipaddr"
-dns_check_answer ans.log
-
-# Loop for a large number of reverse name lookup queries
-num=0
-id=$min_id
-while [ $num -lt $connect_quantity ]; do
-	dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${id} $record \
-		> /dev/null || break
-	id=$(($id + 1))
-	[ $id -gt $max_id ] && id=$min_id
-	num=$(($num + 1))
-done
-
-# Check the connectivity again
-dig @$srv_ipaddr $opt -p $port -x ${net}${sep}${min_id} $record \
-	> ans.log 2>&1 || \
-	tst_brkm TBROK "Failed to connect $srv_ipaddr"
-dns_check_answer ans.log
-
-dns_check_send_requests
-
-tst_exit
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
