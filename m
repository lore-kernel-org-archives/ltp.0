Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986D5C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 13:09:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 030713C7B97
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 14:09:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69B033C7B97
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 14:09:41 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 81B54100860C
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 14:09:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 94F9F1F797;
 Thu, 16 Jan 2025 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737032979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+G5iA5GfYCtinG7mNq4qE+zOt34aBgC+032apDFnNgk=;
 b=OtekLjLvQvxyqu+Q3419HBJNYdiBgbfDwF6DF2xvHYoqVecZSBQfjjgJRiLewDPJe1CNgg
 gaOa9RaD73PZE2kl6WxALhPYDHI4DNx86FpWeY4zc5J3e8VuESmQnlgOzlzQGy5eUfYFYs
 K9JTCIAW0MYjzKRQuzulFbd7N4WAsq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737032979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+G5iA5GfYCtinG7mNq4qE+zOt34aBgC+032apDFnNgk=;
 b=ZWS8RtAkFSK/Enf82eneKbFWHrUhaWcx1MBEcdKe/dw9DeiwVGTESbePZydakslrrKbbkU
 DmMQq6Wm1oiqL7Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OtekLjLv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZWS8RtAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737032979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+G5iA5GfYCtinG7mNq4qE+zOt34aBgC+032apDFnNgk=;
 b=OtekLjLvQvxyqu+Q3419HBJNYdiBgbfDwF6DF2xvHYoqVecZSBQfjjgJRiLewDPJe1CNgg
 gaOa9RaD73PZE2kl6WxALhPYDHI4DNx86FpWeY4zc5J3e8VuESmQnlgOzlzQGy5eUfYFYs
 K9JTCIAW0MYjzKRQuzulFbd7N4WAsq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737032979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+G5iA5GfYCtinG7mNq4qE+zOt34aBgC+032apDFnNgk=;
 b=ZWS8RtAkFSK/Enf82eneKbFWHrUhaWcx1MBEcdKe/dw9DeiwVGTESbePZydakslrrKbbkU
 DmMQq6Wm1oiqL7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40CFF13332;
 Thu, 16 Jan 2025 13:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gbyVCxMFiWcaIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jan 2025 13:09:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Jan 2025 14:09:36 +0100
Message-ID: <20250116130936.700441-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Rspamd-Queue-Id: 94F9F1F797
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_net.sh: Filter out tst_ns_exec TINFO messages
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

This is a workaround to filter out tst_ns_exec.c TINFO messages printed
on stderr by tst_has_slow_kconfig(). tst_ns_exec.c is used by default by
$LTP_NETNS in tst_rhost_run().

This fixes errors on shell tests on netns backend (the default):

    # PATH="/opt/ltp/testcases/bin:$PATH" ping01.sh
    ...
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
    ping01 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
    ping01 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24

Fixes: 893ca0abe7 ("lib: multiply the timeout if detect slow kconfigs")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

alternative to Li's TST_NO_SLOW_KCONFIG_CHECK suggestion:
https://lore.kernel.org/ltp/CAEemH2d6RJ8yd4TcLt-z49fmNKt7eAGg=VhdASkNtE=7cR7bgg@mail.gmail.com/

Maybe even both could be applied.
WDYT?

Kind regards,
Petr

 testcases/lib/tst_net.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ee0ae1cad7..4e8786b704 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -265,6 +265,8 @@ tst_rhost_run()
 		[ "$safe" ] && \
 			tst_brk_ TBROK "'$cmd' failed on '$RHOST': '$output'"
 	fi
+	# strip out tst_ns_exec TINFO messages
+	output=$(echo "$output" | grep -v 'TINFO:')
 
 	[ -z "$out" -a -n "$output" ] && echo "$output"
 
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
