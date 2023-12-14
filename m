Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3A7C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 15:21:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BE0D3CE7C0
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 16:21:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB3E43CE5BF
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 328F31400E64
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 16:20:08 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E02131F7D9;
 Thu, 14 Dec 2023 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKFgG/gek03AQGtzKYpNtq15LSBEgCHHgjwB4gfW9Gg=;
 b=IRy+8VKAEVWVF+Ol6mP3cyEOvtyQX9sr25ipT0UXa1jX/2CfAGIhRBQarGKHYfi1vYzHaj
 csKm236pPpLLozvF082Kz2DyG3k1U3e3iyEhWa8hDpK6nHG/fUxW2DmKz/NmidSVIMO/mH
 3Eww+VpfczTo6/2BioOoQ9C9DjgkREs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKFgG/gek03AQGtzKYpNtq15LSBEgCHHgjwB4gfW9Gg=;
 b=VE9h9ciXRFjMGWs1ny0BFjQy7iwmrV9xZZ0KVMADtri9JoRDsRVnw6LhEMZn8+8c6Wu3XG
 vnSXm7qvqTd8xXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702567207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKFgG/gek03AQGtzKYpNtq15LSBEgCHHgjwB4gfW9Gg=;
 b=IRy+8VKAEVWVF+Ol6mP3cyEOvtyQX9sr25ipT0UXa1jX/2CfAGIhRBQarGKHYfi1vYzHaj
 csKm236pPpLLozvF082Kz2DyG3k1U3e3iyEhWa8hDpK6nHG/fUxW2DmKz/NmidSVIMO/mH
 3Eww+VpfczTo6/2BioOoQ9C9DjgkREs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702567207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKFgG/gek03AQGtzKYpNtq15LSBEgCHHgjwB4gfW9Gg=;
 b=VE9h9ciXRFjMGWs1ny0BFjQy7iwmrV9xZZ0KVMADtri9JoRDsRVnw6LhEMZn8+8c6Wu3XG
 vnSXm7qvqTd8xXDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C3C7134B0;
 Thu, 14 Dec 2023 15:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id mOuRFycde2WpJwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 15:20:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Dec 2023 16:19:51 +0100
Message-ID: <20231214151954.840244-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214151954.840244-1-pvorel@suse.cz>
References: <20231214151954.840244-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 07/10] tst_netload(): Rename option -d => -f
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

-D will be used for enabling debug info, thus netstress.c -D parameter
needs to be renamed to -d.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh                   | 6 +++---
 testcases/network/busy_poll/busy_poll01.sh | 2 +-
 testcases/network/busy_poll/busy_poll02.sh | 2 +-
 testcases/network/busy_poll/busy_poll03.sh | 2 +-
 testcases/network/virt/virt_lib.sh         | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 6168db86b..0718a8ad1 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -745,12 +745,12 @@ tst_netload()
 	fi
 
 	OPTIND=0
-	while getopts :a:H:d:n:N:r:R:S:b:t:T:fFe:m:A:D: opt; do
+	while getopts :a:f:H:n:N:r:R:S:b:t:T:fFe:m:A:D: opt; do
 		case "$opt" in
 		a) c_num="$OPTARG" ;;
 		H) c_opts="${c_opts}-H $OPTARG "
 		   hostopt="$OPTARG" ;;
-		d) rfile="$OPTARG" ;;
+		f) rfile="$OPTARG" ;;
 		n) c_opts="${c_opts}-n $OPTARG " ;;
 		N) c_opts="${c_opts}-N $OPTARG " ;;
 		r) c_requests="$OPTARG" ;;
@@ -790,7 +790,7 @@ tst_netload()
 	fi
 
 	s_opts="${cs_opts}${s_opts}-R $s_replies -B $TST_TMPDIR"
-	c_opts="${cs_opts}${c_opts}-a $c_num -r $((c_requests / run_cnt)) -d $PWD/$rfile"
+	c_opts="${cs_opts}${c_opts}-a $c_num -r $((c_requests / run_cnt)) -f $PWD/$rfile"
 
 	tst_res_ TINFO "run server 'netstress $s_opts'"
 	tst_res_ TINFO "run client 'netstress -l $c_opts' $run_cnt times"
diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 65f4db3fe..fa4e57d11 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -39,7 +39,7 @@ test()
 	for x in 50 0; do
 		tst_res TINFO "set low latency busy poll to $x"
 		set_busy_poll $x
-		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x
+		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -f res_$x
 	done
 
 	tst_netload_compare $(cat res_0) $(cat res_50) 1
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index ebae4d2f5..363562112 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -31,7 +31,7 @@ test()
 	for x in 50 0; do
 		tst_res TINFO "set low latency busy poll to $x per socket"
 		set_busy_poll $x
-		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x -b $x
+		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -f res_$x -b $x
 	done
 
 	tst_netload_compare $(cat res_0) $(cat res_50) 1
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 04d5978f7..4fe958db9 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -33,7 +33,7 @@ test()
 	for x in 50 0; do
 		tst_res TINFO "set low latency busy poll to $x per $2 socket"
 		set_busy_poll $x
-		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x \
+		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -f res_$x \
 			    -b $x -T $2
 	done
 
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index e919bc3a5..dd7ac895b 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -284,10 +284,10 @@ virt_compare_netperf()
 	local expect_res="${1:-pass}"
 	local opts="$2"
 
-	tst_netload -H $ip_virt_remote $opts -d res_ipv4 -e $expect_res \
+	tst_netload -H $ip_virt_remote $opts -f res_ipv4 -e $expect_res \
 		-D ltp_v0 || ret1="fail"
 
-	tst_netload -H ${ip6_virt_remote} $opts -d res_ipv6 -e $expect_res \
+	tst_netload -H ${ip6_virt_remote} $opts -f res_ipv6 -e $expect_res \
 		-D ltp_v0 || ret2="fail"
 
 	[ "$ret1" = "fail" -o "$ret2" = "fail" ] && return
@@ -295,7 +295,7 @@ virt_compare_netperf()
 	local vt="$(cat res_ipv4)"
 	local vt6="$(cat res_ipv6)"
 
-	tst_netload -H $(tst_ipaddr rhost) $opts -d res_lan
+	tst_netload -H $(tst_ipaddr rhost) $opts -f res_lan
 
 	local lt="$(cat res_lan)"
 	tst_res TINFO "time lan IPv${TST_IPVER}($lt) $virt_type IPv4($vt) and IPv6($vt6) ms"
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
