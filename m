Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B01CC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 08:41:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57B063C7C2A
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 09:41:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14F323C796A
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:41:27 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A57A9230B02
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 09:41:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 942FF2117F;
 Fri, 17 Jan 2025 08:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737103285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=why5RmbLEeZCXU8Gfd7vkhnNbg/L+vQ5sB0Rfvvros8=;
 b=ngvLfq0aJdUJb8hpooaK/9d5vEhXVH/3RzoLBKgoXFi4yeZgopvlTPczH8IAx9IyvbJkcv
 W4714WGPBJOMf8XT2TnzyA6Jyj+sL+V3BXeMjqobNv8qQXtTwRMZvHTDUX+UeqGUTWCGJV
 qkSd4Nwm50VTcrQnEMK+kNqCCVcpXSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737103285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=why5RmbLEeZCXU8Gfd7vkhnNbg/L+vQ5sB0Rfvvros8=;
 b=APQe1q/Tdlz6kvfNC921X5xOYQWShIiHfNC2h+eTK4R1+efc85piohnvlX5ljZP8cs+D9p
 uY278C1zrLTkvtDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ngvLfq0a;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="APQe1q/T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737103285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=why5RmbLEeZCXU8Gfd7vkhnNbg/L+vQ5sB0Rfvvros8=;
 b=ngvLfq0aJdUJb8hpooaK/9d5vEhXVH/3RzoLBKgoXFi4yeZgopvlTPczH8IAx9IyvbJkcv
 W4714WGPBJOMf8XT2TnzyA6Jyj+sL+V3BXeMjqobNv8qQXtTwRMZvHTDUX+UeqGUTWCGJV
 qkSd4Nwm50VTcrQnEMK+kNqCCVcpXSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737103285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=why5RmbLEeZCXU8Gfd7vkhnNbg/L+vQ5sB0Rfvvros8=;
 b=APQe1q/Tdlz6kvfNC921X5xOYQWShIiHfNC2h+eTK4R1+efc85piohnvlX5ljZP8cs+D9p
 uY278C1zrLTkvtDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ADCE13332;
 Fri, 17 Jan 2025 08:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nZwsFbUXimf9VQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 08:41:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 09:41:18 +0100
Message-ID: <20250117084118.740225-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Rspamd-Queue-Id: 942FF2117F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[gmail.com,suse.com,redhat.com,suse.de,suse.cz];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[8]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real tests
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

Add a custom function which allows to avoid calling
tst_has_slow_kconfig() function on testcases/lib/ tools, which use part
of the API because they aren't tests.

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
NOTE: I'm not sure about the naming.
This supersedes Li's patch
https://patchwork.ozlabs.org/project/ltp/patch/20250117071758.120366-1-liwang@redhat.com/

Other option is to add variable to struct tst_test as Li suggested.

Kind regards,
Petr

 include/tst_test.h | 14 ++++++++++++++
 lib/tst_test.c     |  3 +--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 5b3889e647..79bf6266e1 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -47,6 +47,7 @@
 #include "tst_arch.h"
 #include "tst_fd.h"
 #include "tst_tmpdir.h"
+#include "tst_kconfig.h"
 
 void tst_res_(const char *file, const int lineno, int ttype,
               const char *fmt, ...)
@@ -725,8 +726,21 @@ int main(int argc, char *argv[])
 	tst_run_tcases(argc, argv, &test);
 }
 
+static inline int foo(unsigned int timeout)
+{
+	return timeout;
+}
 #endif /* TST_NO_DEFAULT_MAIN */
 
+static inline int tst_multiply_on_slow_config(unsigned int timeout)
+{
+#ifndef TST_NO_DEFAULT_MAIN
+	if (tst_has_slow_kconfig())
+		timeout *= 4;
+#endif /* TST_NO_DEFAULT_MAIN */
+	return timeout;
+}
+
 /**
  * TST_TEST_TCONF() - Exit tests with a TCONF message.
  *
diff --git a/lib/tst_test.c b/lib/tst_test.c
index b204ad975f..6a43c0633e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1702,8 +1702,7 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	if (timeout < 1)
 		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);
 
-	if (tst_has_slow_kconfig())
-		timeout *= 4;
+	timeout = tst_multiply_on_slow_config(timeout);
 
 	return timeout * timeout_mul;
 }
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
