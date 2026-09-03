Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EABC624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 12:47:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B0633EAD97
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:47:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C18D3EAD82
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:46:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A833A1A006FC
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 14:46:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D22931FE3D;
 Thu,  3 Sep 2026 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788439610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmk7lNzZh4HmW8n+uR34GTkaffaV4fy/19VQJCivbLk=;
 b=YKKGfTg98g6tC8N9I5jxZ76ePhT3BjQpe/eJkDgkTOWajBCtx1fktB+jKYZA4mDISm3gMq
 SsgNrwqjF2bWLRETpTCX5apiZ+14y9ioR3TDgpOs7c/vzunXdrDgwfptA97ynwNWtkcTH9
 FPUr69XJxUHTIiN7rpIIvDeporTbiv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788439610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmk7lNzZh4HmW8n+uR34GTkaffaV4fy/19VQJCivbLk=;
 b=QUpUhJKypJeBZVuAgSOVWiblDlVyvGTdIMIQKWQGuqm6bnCvX/Ef2n78S2pLrlXFTITD9X
 jKYXcpiXBih0urCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788439605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmk7lNzZh4HmW8n+uR34GTkaffaV4fy/19VQJCivbLk=;
 b=p4KTs55IMidJHoywTCjohGRDwCySh6Y8FLFCsM4UiGpXmbAEv+FI0JTtVfg9Fko4cTgGBR
 akrsotRETxzYKDDSIXnpyXQEcupRJdkXK1tU/JajTS7PCXA1uIn9LqbixZIZcWcixzjo36
 0MsTbO8YG095247kfFMnsGqsFLgOwlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788439605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmk7lNzZh4HmW8n+uR34GTkaffaV4fy/19VQJCivbLk=;
 b=sZTj3Wl7OyyRBBlit4JPzO0LgRcsWnG/YPon4GXrOKxKS6avwPnaJjsrQYJY7VvWiAhDv0
 FtHB4/bOwhxnKLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D19413736;
 Thu,  3 Sep 2026 12:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8KcDGTVsmWqHLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 12:46:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Sep 2026 14:46:28 +0200
Message-ID: <20260903124631.1100746-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903124631.1100746-1-pvorel@suse.cz>
References: <20260903124631.1100746-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLh34zeb89e7jksgg3mmxfamc1)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/4] Remove testscripts/network.sh
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
Cc: Tim Bird <tim.bird@sony.com>, Steffen Jaeckel <sjaeckel@suse.de>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Script was using ltp-pan (already removed), kirk should now be used.

Fixes: 5e5fd4a1ae ("pan: Remove")
Reported-by: Steffen Jaeckel <sjaeckel@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/network.sh | 118 -----------------------------------------
 1 file changed, 118 deletions(-)
 delete mode 100755 testscripts/network.sh

diff --git a/testscripts/network.sh b/testscripts/network.sh
deleted file mode 100755
index afe9c7a977..0000000000
--- a/testscripts/network.sh
+++ /dev/null
@@ -1,118 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (c) Linux Test Project, 2013-2019
-
-cd $(dirname $0)
-export LTPROOT=${LTPROOT:-"$PWD"}
-echo $LTPROOT | grep -q testscripts
-if [ $? -eq 0 ]; then
-	cd ..
-	export LTPROOT=${PWD}
-fi
-
-export TMPDIR=/tmp/netpan-$$
-mkdir -p $TMPDIR
-CMDFILE=${TMPDIR}/network.tests
-VERBOSE="no"
-NO_KMSG=
-QUIET_MODE=
-TEST_CASES=
-
-export PATH="${PATH}:${LTPROOT}/testcases/bin"
-
-usage()
-{
-	echo "Usage: $0 OPTIONS"
-	echo "  -6    IPv6 tests"
-	echo "  -m    multicast tests"
-	echo "  -n    NFS tests"
-	echo "  -s    SCTP tests"
-	echo "  -t    TCP/IP command tests"
-	echo "  -c    RPC and TI-RPC tests"
-	echo "  -d    TS-RPC tests"
-	echo "  -a    Application stress tests (HTTP, SSH, DNS)"
-	echo "  -e    Interface stress tests"
-	echo "  -b    Stress tests with malformed ICMP packets"
-	echo "  -i    IPsec ICMP stress tests"
-	echo "  -T    IPsec TCP stress tests"
-	echo "  -U    IPsec UDP stress tests"
-	echo "  -D    IPsec DCCP stress tests"
-	echo "  -S    IPsec SCTP stress tests"
-	echo "  -R    route stress tests"
-	echo "  -M    multicast stress tests"
-	echo "  -F    network features tests (TFO, vxlan, etc.)"
-	echo "  -f x  where x is a runtest file"
-	echo "  -q    quiet mode (this implies not logging start of test"
-	echo "        in kernel log)"
-	echo "  -Q    don't log start of test in kernel log"
-	echo "  -V|v  verbose"
-	echo "  -h    print this help"
-}
-
-while getopts 6mnrstaebcdiTUDSRMFf:qQVvh OPTION
-do
-	case $OPTION in
-	6) TEST_CASES="$TEST_CASES net.ipv6 net.ipv6_lib";;
-	m) TEST_CASES="$TEST_CASES net.multicast";;
-	n) TEST_CASES="$TEST_CASES net.nfs";;
-	s) TEST_CASES="$TEST_CASES net.sctp";;
-	t) TEST_CASES="$TEST_CASES net.tcp_cmds";;
-	c) TEST_CASES="$TEST_CASES net.rpc_tests";;
-	d) TEST_CASES="$TEST_CASES net.tirpc_tests";;
-	a) TEST_CASES="$TEST_CASES net_stress.appl";;
-	e) TEST_CASES="$TEST_CASES net_stress.interface";;
-	b) TEST_CASES="$TEST_CASES net_stress.broken_ip";;
-	i) TEST_CASES="$TEST_CASES net_stress.ipsec_icmp";;
-	T) TEST_CASES="$TEST_CASES net_stress.ipsec_tcp";;
-	U) TEST_CASES="$TEST_CASES net_stress.ipsec_udp";;
-	D) TEST_CASES="$TEST_CASES net_stress.ipsec_dccp";;
-	S) TEST_CASES="$TEST_CASES net_stress.ipsec_sctp";;
-	R) TEST_CASES="$TEST_CASES net_stress.route";;
-	M) TEST_CASES="$TEST_CASES net_stress.multicast";;
-	F) TEST_CASES="$TEST_CASES net.features";;
-	f) TEST_CASES=${OPTARG};;
-	q) QUIET_MODE="-q";;
-	Q) NO_KMSG="-Q";;
-	V|v) VERBOSE="yes";;
-	h) usage; exit 0;;
-	*) echo "Error: invalid option..."; usage; exit 1;;
-	esac
-done
-
-if [ "$OPTIND" -eq 1 ]; then
-	echo "Error: option is required"
-	usage
-	exit 1
-fi
-shift $(($OPTIND - 1))
-
-rm -f $CMDFILE
-
-for t in $TEST_CASES; do
-	cat  ${LTPROOT}/runtest/$t >> $CMDFILE
-done
-
-cd $TMPDIR
-
-cmd="${LTPROOT}/bin/ltp-pan $QUIET_MODE $NO_KMSG -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE"
-
-if [ ${VERBOSE} = "yes" ]; then
-	echo "Network parameters:"
-	echo " - ${LHOST_IFACES} local interface (MAC address: ${LHOST_HWADDRS})"
-	echo " - ${RHOST_IFACES} remote interface (MAC address: ${RHOST_HWADDRS})"
-
-	cat $CMDFILE
-	${LTPROOT}/ver_linux
-	echo ""
-	echo $cmd
-fi
-
-$cmd
-
-if [ $? -eq "0" ]; then
-	echo ltp-pan reported PASS
-else
-	echo ltp-pan reported FAIL
-fi
-
-rm -rf $TMPDIR
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
