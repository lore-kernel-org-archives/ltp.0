Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04FEE7717F
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 21:33:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E882C3ECFD1
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 22:33:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB28A3ECF94
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 22:32:51 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C60A1BD1736
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 22:32:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91D8B1F397;
 Tue, 17 Dec 2024 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734471168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F4r71vQJzD+r6LGCw8z2tPqltmoZRFcbyPvSgFfOLLs=;
 b=OGi9vnR2jt9p8oPfLH3GSJSpHEck3Rwh2I8mjakWRBaLFHseawG/G7hLIwjtUTJk2Wi6hf
 GRDnZVS55Zm2K2fq+nFHVspK95AUIIuwunqD9PulIRh9k9e9Auztj+98xAGBIS6MzOwf3f
 jEU9xlawhrb2WwtRtRmsy1hWc5Ae3Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734471168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F4r71vQJzD+r6LGCw8z2tPqltmoZRFcbyPvSgFfOLLs=;
 b=y1U4e3GWI5cTKzM3Q/w3ffYrx2BYoQI46U4pz7TCdRyBH6mEq/mLc84c9hX1kbLORDuopV
 biOqtUU+Qjns99AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734471168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F4r71vQJzD+r6LGCw8z2tPqltmoZRFcbyPvSgFfOLLs=;
 b=OGi9vnR2jt9p8oPfLH3GSJSpHEck3Rwh2I8mjakWRBaLFHseawG/G7hLIwjtUTJk2Wi6hf
 GRDnZVS55Zm2K2fq+nFHVspK95AUIIuwunqD9PulIRh9k9e9Auztj+98xAGBIS6MzOwf3f
 jEU9xlawhrb2WwtRtRmsy1hWc5Ae3Fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734471168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=F4r71vQJzD+r6LGCw8z2tPqltmoZRFcbyPvSgFfOLLs=;
 b=y1U4e3GWI5cTKzM3Q/w3ffYrx2BYoQI46U4pz7TCdRyBH6mEq/mLc84c9hX1kbLORDuopV
 biOqtUU+Qjns99AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 342A1132EA;
 Tue, 17 Dec 2024 21:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L/dgCgDuYWdNDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Dec 2024 21:32:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 22:32:45 +0100
Message-ID: <20241217213245.29778-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 1/1] tst_net.sh: Fix calling tst_brk with TFAIL
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

1878502f63 forbid using tst_brk with TFAIL but usage was not converted
to TFAIL. Use tst_res and add necessary return.

Fixes: 1878502f63 ("tst_test.sh/tst_brk(): Allow only TBROK and TCONF")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This fixes problem on failing netstress.c:

sctp_ipsec 1 TINFO: Running: sctp_ipsec.sh -6 -A rfc4106_192 -p esp_aead -m transport -s 100:1000:65535:R65535
sctp_ipsec 1 TINFO: Tested kernel: Linux susetest 6.4.0-150700.252.g83759b3-default #1 SMP PREEMPT_DYNAMIC Fri Dec 13 18:41:41 UTC 2024 (83759b3) aarch64 aarch64 aarch64 GNU/Linux
sctp_ipsec 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
sctp_ipsec 1 TINFO: add local addr 10.0.0.2/24
sctp_ipsec 1 TINFO: add local addr fd00:1:1:1::2/64
sctp_ipsec 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
sctp_ipsec 1 TINFO: add remote addr 10.0.0.1/24
sctp_ipsec 1 TINFO: add remote addr fd00:1:1:1::1/64
sctp_ipsec 1 TINFO: Network config (local -- remote):
sctp_ipsec 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
sctp_ipsec 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
sctp_ipsec 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
sctp_ipsec 1 TINFO: Using /tmp/LTP_sctp_ipsec.3UdSsZtTZM as tmpdir (btrfs filesystem)
sctp_ipsec 1 TINFO: timeout per run is 0h 15m 0s
sctp_ipsec 1 TINFO: IPsec[esp_aead/transport]
sctp_ipsec 1 TINFO: run server 'netstress -T sctp -S fd00:1:1:1::1 -d ltp_ns_veth1 -R 500000 -B /tmp/LTP_sctp_ipsec.3UdSsZtTZM'
sctp_ipsec 1 TINFO: run client 'netstress -l -T sctp -H fd00:1:1:1::1 -n 100 -N 100 -S fd00:1:1:1::2 -d ltp_ns_veth2 -a 2 -r 100 -c /tmp/LTP_sctp_ipsec.3UdSsZtTZM/tst_netload.res' 5 times
sctp_ipsec 1 TPASS: netstress passed, median time 4 ms, data: 4 4 4 4 4
sctp_ipsec 2 TINFO: run server 'netstress -T sctp -S fd00:1:1:1::1 -d ltp_ns_veth1 -R 500000 -B /tmp/LTP_sctp_ipsec.3UdSsZtTZM'
sctp_ipsec 2 TINFO: run client 'netstress -l -T sctp -H fd00:1:1:1::1 -n 1000 -N 1000 -S fd00:1:1:1::2 -d ltp_ns_veth2 -a 2 -r 100 -c /tmp/LTP_sctp_ipsec.3UdSsZtTZM/tst_netload.res' 5 times
sctp_ipsec 2 TWARN: netstress failed, ret: 6
sctp_ipsec 2 TWARN: netstress has warnings
netstress.c:577: TFAIL: recv failed, sock '6'
netstress.c:644: TBROK: Server closed
tst_tmpdir.c:317: TINFO: Using /tmp/LTP_netf5tGoS as tmpdir (btrfs filesystem)
tst_test.c:1890: TINFO: LTP version: 20240930
tst_test.c:1727: TINFO: Timeout per run is 0h 06m 30s
netstress.c:892: TINFO: IP_BIND_ADDRESS_NO_PORT is used
netstress.c:895: TINFO: connection: addr 'fd00:1:1:1::1', port '44481'
netstress.c:896: TINFO: client max req: 100
netstress.c:897: TINFO: clients num: 2
netstress.c:902: TINFO: client msg size: 1000
netstress.c:903: TINFO: server msg size: 1000
netstress.c:975: TINFO: SCTP client
netstress.c:478: TINFO: Running the test over IPv6
netstress.c:437: TWARN: client exit on '65' request
netstress.c:497: TBROK: client[0] failed: Cannot send after transport endpoint shutdown

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 1
sctp_ipsec 2 TBROK: tst_brk can be called only with TBROK or TCONF (TFAIL)

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 2
### TEST sctp6_ipsec10 COMPLETE >>> 6.

And yes, using shell runner to run netstress as a child would probably
help, but logs would need to be printed immediately to be visible before
calling tst_brk() from netstress.
NOTE: Despite macro name TST_BRK_SUPPORTS_ONLY_TCONF_TBROK() the
original concept in 0738e3753c allowed TFAIL as well.

    This patch adds simple build-check that allows only
    TFAIL, TBROK and TCONF as parameter for tst_brk().

    TFAIL is currently quite commonly used as a shortcut for
    TFAIL + exit() by many tests. I kept it for now, since
    it doesn't go against current doc description.

And indeed C API allows tst_brk(TFAIL). Should we allow this also in
shell API?

Also Cyril suggested for C API different approach:

https://patchwork.ozlabs.org/project/ltp/patch/20241115164101.17983-1-chrubis@suse.cz/

Therefore we should probably agree what to do with C API and then unify shell API.

Kind regards,
Petr

 testcases/lib/tst_net.sh | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ee0ae1cad7..d44115d758 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -713,9 +713,17 @@ tst_wait_ipv6_dad()
 
 tst_netload_brk()
 {
+	local res="$1"
+	local msg="$2"
+
 	tst_rhost_run -c "cat $TST_TMPDIR/netstress.log"
 	cat tst_netload.log
-	tst_brk_ $1 $2
+
+	if [ "$res" = TFAIL ]; then
+		tst_res_ "$res" "$msg"
+	else
+		tst_brk_ "$res" "$msg"
+	fi
 }
 
 # Run network load test, see 'netstress -h' for option description
@@ -825,28 +833,31 @@ tst_netload()
 		fi
 
 		if [ "$ret" -ne 0 ]; then
-			[ $((ret & 32)) -ne 0 ] && \
-				tst_netload_brk TCONF "not supported configuration"
+			[ $((ret & 32)) -ne 0 ] && tst_netload_brk TCONF "not supported configuration"
 
-			[ $((ret & 3)) -ne 0 -a $was_failure -gt 0 ] && \
+			if [ $((ret & 3)) -ne 0 -a $was_failure -gt 0 ]; then
 				tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
+				return
+			fi
 
 			tst_res_ TWARN "netstress failed, ret: $ret"
 			was_failure=1
 			continue
 		fi
 
-		[ ! -f $rfile ] && \
+		if [ ! -f $rfile ]; then
 			tst_netload_brk TFAIL "can't read $rfile"
+			return
+		fi
 
 		results="$results $(cat $rfile)"
 		passed=$((passed + 1))
 	done
 
 	if [ "$ret" -ne 0 ]; then
-		[ $((ret & 4)) -ne 0 ] && \
-			tst_res_ TWARN "netstress has warnings"
+		[ $((ret & 4)) -ne 0 ] && tst_res_ TWARN "netstress has warnings"
 		tst_netload_brk TFAIL "expected '$expect_res' but ret: '$ret'"
+		return
 	fi
 
 	local median=$(tst_get_median $results)
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
