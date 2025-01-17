Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8789CC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:31:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E85C63C7BCA
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 15:31:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54E013C7B03
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 15:31:10 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D83E1BDB6EB
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 15:31:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4AA091F454;
 Fri, 17 Jan 2025 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737124269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7pGkguTvMt020jEBS+UQeGHESl2xeYrEoCdN1jm1WUo=;
 b=jrGP8r3A2cZs6SyjVIkNiOc0jUSOcXgeFUJcQgTRqJwgSOvg7jWxvnXM/ZdKP3ibqtOY/J
 BqurKS138Xl3L71G184f9Ae+7FYiTQN04QteW3hPWC+aXLbYJN3s1BcCqKz1qtxYZdWC9+
 uYS1BN1pN+tC7cE/5ZW+pP86f56r7A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737124269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7pGkguTvMt020jEBS+UQeGHESl2xeYrEoCdN1jm1WUo=;
 b=VM34PUwyjRkVQbaVL1X5aUst0xLKihhCycP2OtbE2u8Z0AZ3zvLLcP8pSygeOvRQ0elsIV
 x2SEWZdYWuvAvsCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737124269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7pGkguTvMt020jEBS+UQeGHESl2xeYrEoCdN1jm1WUo=;
 b=jrGP8r3A2cZs6SyjVIkNiOc0jUSOcXgeFUJcQgTRqJwgSOvg7jWxvnXM/ZdKP3ibqtOY/J
 BqurKS138Xl3L71G184f9Ae+7FYiTQN04QteW3hPWC+aXLbYJN3s1BcCqKz1qtxYZdWC9+
 uYS1BN1pN+tC7cE/5ZW+pP86f56r7A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737124269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=7pGkguTvMt020jEBS+UQeGHESl2xeYrEoCdN1jm1WUo=;
 b=VM34PUwyjRkVQbaVL1X5aUst0xLKihhCycP2OtbE2u8Z0AZ3zvLLcP8pSygeOvRQ0elsIV
 x2SEWZdYWuvAvsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1821139CB;
 Fri, 17 Jan 2025 14:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dq/pOKxpimfjEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 14:31:08 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 15:31:04 +0100
Message-ID: <20250117143105.777229-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.cz];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_net.sh: Ignore stderr on tst_rhost_run -c
 tst_net_iface_prefix
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

From: Petr Vorel <petr.vorel@gmail.com>

This is another way to harden against the problem, which was manifested by
893ca0abe7 and fixed by 02d5e99df3.

There were previously two problems:
1) Unneeded multiple slow kernel config detection (TINFO: CONFIG_LATENCYTOP ...).
2) Printing TINFO message to stderr from tst_net_iface_prefix which was
redirected by tst_rhost_run() to stdout and then used in "eval" in
tst_net_setup_network():
   eval: tst_kconfig.c:88:: not found
   [: tst_kconfig.c:88:: unexpected operator

    # ping01.sh
    ping01 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
    /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
    ping01 1 TINFO: add remote addr 10.0.0.1/24
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
    ping01 1 TINFO: add remote addr fd00:1:1:1::1/64
    tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
    tst_kconfig.c:667: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
    /opt/ltp/testcases/bin/ping01.sh: 1: eval: tst_kconfig.c:88:: not found
    /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
    /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
    /opt/ltp/testcases/bin/ping01.sh: 142: [: tst_kconfig.c:88:: unexpected operator
    /opt/ltp/testcases/bin/ping01.sh: 1: eval: tst_kconfig.c:88:: not found
    /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
    /opt/ltp/testcases/bin/ping01.sh: 1: eval: 34mTINFO:: not found
    ping01 1 TINFO: Network config (local -- remote):

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

It'd be nice to have it in the release, but we can solve it
next week (network tests works) or even after the release.

Kind regards,
Petr

 testcases/lib/tst_net.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ee0ae1cad7..9c7b2bac1f 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -209,6 +209,7 @@ tst_net_use_netns()
 # Options:
 # -b run in background
 # -c CMD specify command to run (this must be binary, not shell builtin/function)
+# -Q ignore stderr
 # -s safe option, if something goes wrong, will exit with TBROK
 # -u USER for ssh (default root)
 # RETURN: 0 on success, 1 on failure
@@ -218,16 +219,18 @@ tst_rhost_run()
 	local post_cmd=' || echo RTERR'
 	local user="root"
 	local ret=0
+	local stderr='2>&1'
 	local cmd out output pre_cmd rcmd sh_cmd safe use
 
 	local OPTIND
-	while getopts :bc:su: opt; do
+	while getopts :bc:Qsu: opt; do
 		case "$opt" in
 		b) [ "${TST_USE_NETNS:-}" ] && pre_cmd= || pre_cmd="nohup"
-		   post_cmd=" > /dev/null 2>&1 &"
+		   post_cmd=" > /dev/null $stderr &"
 		   out="1> /dev/null"
 		;;
 		c) cmd="$OPTARG" ;;
+		Q) stderr= ;;
 		s) safe=1 ;;
 		u) user="$OPTARG" ;;
 		*) tst_brk_ TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
@@ -254,10 +257,10 @@ tst_rhost_run()
 
 	if [ "$TST_NET_RHOST_RUN_DEBUG" = 1 ]; then
 		tst_res_ TINFO "tst_rhost_run: cmd: $cmd"
-		tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out 2>&1"
+		tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out $stderr"
 	fi
 
-	output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
+	output=$($rcmd "$sh_cmd" $out $stderr || echo 'RTERR')
 
 	echo "$output" | grep -q 'RTERR$' && ret=1
 	if [ $ret -eq 1 ]; then
@@ -1058,7 +1061,7 @@ tst_net_setup_network()
 	tst_net_use_netns && init_ltp_netspace
 
 	eval $(tst_net_iface_prefix $IPV4_LHOST || echo "exit $?")
-	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
+	eval $(tst_rhost_run -Q -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
 		|| echo "exit $?")
 	eval $(tst_net_vars $IPV4_LHOST/$IPV4_LPREFIX \
 		$IPV4_RHOST/$IPV4_RPREFIX || echo "exit $?")
@@ -1066,7 +1069,7 @@ tst_net_setup_network()
 	if [ "$TST_NET_IPV6_ENABLED" = 1 ]; then
 		tst_net_check_ifaces_ipv6
 		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
-		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
+		eval $(tst_rhost_run -Q -c 'tst_net_iface_prefix -r '$IPV6_RHOST \
 			|| echo "exit $?")
 		eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
 			$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
