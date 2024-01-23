Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E614C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:28:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 295093CFB87
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 17:28:20 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1514B3CEE6D
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:58 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 413F8206C3F
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D8511F79E;
 Tue, 23 Jan 2024 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjguCVNPMRhwfV2eHD03VN9yeZBMfpAWwPB8EpLDDf0=;
 b=IzalHpHDKdsGjd8Z5WSMwjVN9/fznv7PfM+GDbcZEKuDkbEnwk0Qobhb21Waxdhpu3NGGQ
 cKeuCuCBpoPC9xRFpBe5r1R3AKkBDwh1mh/621ffF6UT709GFPUK31enfwazOpdO19GNr0
 1d9/9K5hxKZhG2hIRLtqTL4XTuwz2qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjguCVNPMRhwfV2eHD03VN9yeZBMfpAWwPB8EpLDDf0=;
 b=NOGLNHBgcJvC1foJ55v+S7rpd8TTblm4oZSJqceSJts/zVlHGluZNPHTgMsuvcC+lbJeb5
 C9lVvA2UKlbAUTAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjguCVNPMRhwfV2eHD03VN9yeZBMfpAWwPB8EpLDDf0=;
 b=IzalHpHDKdsGjd8Z5WSMwjVN9/fznv7PfM+GDbcZEKuDkbEnwk0Qobhb21Waxdhpu3NGGQ
 cKeuCuCBpoPC9xRFpBe5r1R3AKkBDwh1mh/621ffF6UT709GFPUK31enfwazOpdO19GNr0
 1d9/9K5hxKZhG2hIRLtqTL4XTuwz2qU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027216;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KjguCVNPMRhwfV2eHD03VN9yeZBMfpAWwPB8EpLDDf0=;
 b=NOGLNHBgcJvC1foJ55v+S7rpd8TTblm4oZSJqceSJts/zVlHGluZNPHTgMsuvcC+lbJeb5
 C9lVvA2UKlbAUTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D18E913786;
 Tue, 23 Jan 2024 16:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCRHLc7or2V+CwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 16:26:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 17:26:47 +0100
Message-ID: <20240123162647.210424-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123162647.210424-1-pvorel@suse.cz>
References: <20240123162647.210424-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] network: Fix tst_brk TFAIL
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It needs to be replaced with tst_res TFAIL and return

Fixes: 1878502f6 ("tst_test.sh/tst_brk(): Allow only TBROK and TCONF")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs06.sh     |  5 ++++-
 testcases/network/stress/route/route-lib.sh   |  8 +++++--
 testcases/network/stress/ssh/ssh-stress.sh    | 16 ++++++++++----
 testcases/network/tcp_cmds/host/host01.sh     |  5 +++--
 .../network/tcp_cmds/ipneigh/ipneigh01.sh     | 21 ++++++++++++-------
 testcases/network/virt/virt_lib.sh            | 12 +++++++----
 testcases/network/xinetd/xinetd_tests.sh      |  7 ++++---
 7 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs06.sh b/testcases/network/nfs/nfs_stress/nfs06.sh
index 560df05b1..09e55fe34 100755
--- a/testcases/network/nfs/nfs_stress/nfs06.sh
+++ b/testcases/network/nfs/nfs_stress/nfs06.sh
@@ -34,7 +34,10 @@ do_test()
 
 	tst_res TINFO "waiting for pids:$pids"
 	for p in $pids; do
-		wait $p || tst_brk TFAIL "fsstress process failed"
+		if ! wait $p; then
+			tst_res TFAIL "fsstress process failed"
+			return
+		fi
 		tst_res TINFO "fsstress '$p' completed"
 	done
 	pids=
diff --git a/testcases/network/stress/route/route-lib.sh b/testcases/network/stress/route/route-lib.sh
index 163c15423..29aa2e913 100644
--- a/testcases/network/stress/route/route-lib.sh
+++ b/testcases/network/stress/route/route-lib.sh
@@ -97,10 +97,14 @@ test_netlink()
 	tst_res TINFO "running $cmd $opt"
 	$cmd $opt || ret=$?
 	if [ "$ret" -ne 0 ]; then
-		[ $((ret & 3)) -ne 0 ] && \
-			tst_brk TFAIL "$cmd failed"
+		if [ $((ret & 3)) -ne 0 ]; then
+			tst_res TFAIL "$cmd failed"
+			return
+		fi
+
 		[ $((ret & 32)) -ne 0 ] && \
 			tst_brk TCONF "not supported configuration"
+
 		[ $((ret & 4)) -ne 0 ] && \
 			tst_res TWARN "$cmd has warnings"
 	fi
diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
index e7c4d45ce..c27c27a28 100755
--- a/testcases/network/stress/ssh/ssh-stress.sh
+++ b/testcases/network/stress/ssh/ssh-stress.sh
@@ -93,8 +93,10 @@ IdentityFile $TST_TMPDIR/id_rsa\n\" > $RHOST_SSH_CONF"
 
 test_ssh_connectivity()
 {
-	tst_rhost_run -c "$RHOST_SSH 'true >/dev/null 2>&1' >/dev/null"
-	[ $? -ne 0 ] && tst_brk TFAIL "SSH not reachable"
+	if ! tst_rhost_run -c "$RHOST_SSH 'true >/dev/null 2>&1' >/dev/null"; then
+		tst_res TFAIL "SSH not reachable"
+		return
+	fi
 }
 
 test1()
@@ -121,7 +123,10 @@ test1()
 		[ $? -ne 0 ] && num=$((num + 1))
 	done
 
-	[ $num -ne 0 ] && tst_brk TFAIL "$num ssh processes died unexpectedly during execution"
+	if [ $num -ne 0 ]; then
+		tst_res TFAIL "$num ssh processes died unexpectedly during execution"
+		return
+	fi
 
 	test_ssh_connectivity
 
@@ -216,7 +221,10 @@ test3()
 
 	# Setup an ssh tunnel from the remote host to testhost
 	tst_rhost_run -c "$RHOST_SSH -f -N -L $lport:$rhost:$port </dev/null >/dev/null 2>&1"
-	[ "$?" -ne 0 ] && tst_brk TFAIL "Failed to create an SSH session with port forwarding"
+	if [ "$?" -ne 0 ]; then
+		tst_res TFAIL "Failed to create an SSH session with port forwarding"
+		return
+	fi
 	RHOST_PIDS=$(tst_rhost_run -c "pgrep -f '^ssh .*$lport:$rhost:$port'")
 
 	# Start the TCP traffic clients
diff --git a/testcases/network/tcp_cmds/host/host01.sh b/testcases/network/tcp_cmds/host/host01.sh
index 6a4067495..9ed44bae3 100755
--- a/testcases/network/tcp_cmds/host/host01.sh
+++ b/testcases/network/tcp_cmds/host/host01.sh
@@ -21,11 +21,12 @@ do_test()
 	if addr=$(host $lhost); then
 		addr=$(echo "$addr" | grep address | tail -1 | awk '{print $NF}')
 		if [ -z "$addr" ]; then
-			tst_brk TFAIL "empty address"
+			tst_res TFAIL "empty address"
+			return
 		fi
 		EXPECT_PASS host $addr \>/dev/null
 	else
-		tst_brk TFAIL "host $lhost on local machine failed"
+		tst_res TFAIL "host $lhost on local machine failed"
 	fi
 }
 
diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index e67ff5cc8..4b818357e 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -57,8 +57,10 @@ do_test()
 
 	for i in $(seq 1 $NUMLOOPS); do
 
-		ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) -I $(tst_iface) > /dev/null || \
-			tst_brk TFAIL "cannot ping $(tst_ipaddr rhost)"
+		if ! ping$TST_IPV6 -q -c1 $(tst_ipaddr rhost) -I $(tst_iface) > /dev/null; then
+			tst_res TFAIL "cannot ping $(tst_ipaddr rhost)"
+			return
+		fi
 
 		local k
 		local ret=1
@@ -66,19 +68,22 @@ do_test()
 			$SHOW_CMD | grep -q $(tst_ipaddr rhost)
 			if [ $? -eq 0 ]; then
 				ret=0
-				break;
+				break
 			fi
 			tst_sleep 100ms
 		done
 
-		[ "$ret" -ne 0 ] && \
-			tst_brk TFAIL "$entry_name entry '$(tst_ipaddr rhost)' not listed"
+		if [ "$ret" -ne 0 ]; then
+			tst_res TFAIL "$entry_name entry '$(tst_ipaddr rhost)' not listed"
+			return
+		fi
 
 		$DEL_CMD
 
-		$SHOW_CMD | grep -q "$(tst_ipaddr rhost).*$(tst_hwaddr rhost)" && \
-			tst_brk TFAIL "'$DEL_CMD' failed, entry has " \
-				"$(tst_hwaddr rhost)' $i/$NUMLOOPS"
+		if $SHOW_CMD | grep -q "$(tst_ipaddr rhost).*$(tst_hwaddr rhost)"; then
+			tst_res TFAIL "'$DEL_CMD' failed, entry has $(tst_hwaddr rhost)' $i/$NUMLOOPS"
+			return
+		fi
 	done
 
 	tst_res TPASS "verified adding/removing $entry_name cache entry"
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index d7e694eb7..0aadbfdb9 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -174,8 +174,10 @@ virt_multiple_add_test()
 	tst_res TINFO "add $NS_TIMES $virt_type, then delete"
 
 	for i in $(seq $start_id $max); do
-		virt_add ltp_v$i id $i $opt || \
-			tst_brk TFAIL "failed to create 'ltp_v0 $opt'"
+		if ! virt_add ltp_v$i id $i $opt; then
+			tst_res TFAIL "failed to create 'ltp_v0 $opt'"
+			return
+		fi
 		ROD_SILENT "ip link set ltp_v$i up"
 	done
 
@@ -196,8 +198,10 @@ virt_add_delete_test()
 	tst_res TINFO "add/del $virt_type $NS_TIMES times"
 
 	for i in $(seq 0 $max); do
-		virt_add ltp_v0 $opt || \
-			tst_brk TFAIL "failed to create 'ltp_v0 $opt'"
+		if ! virt_add ltp_v0 $opt; then
+			tst_res TFAIL "failed to create 'ltp_v0 $opt'"
+			return
+		fi
 		ROD_SILENT "ip link set ltp_v0 up"
 		ROD_SILENT "ip link delete ltp_v0"
 	done
diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index 505dae5d7..25ec91d26 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -91,9 +91,10 @@ xinetd_test()
 
 	for a in $check_addr; do
 		p=$(echo $pattern | sed "s/ADDR/$a/")
-		echo '' | telnet $a 2>&1 | grep -qiE "$p"
-		[ $? -ne 0 ] && \
-			tst_brk TFAIL "not expected output for 'telnet $a'"
+		if ! echo '' | telnet $a 2>&1 | grep -qiE "$p"; then
+			tst_res TFAIL "not expected output for 'telnet $a'"
+			return
+		fi
 	done
 	tst_res TPASS "expected output with telnet $desc"
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
