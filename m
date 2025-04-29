Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE092C369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:46:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08AF73CBBFE
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 11:46:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C99F83CBBD5
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 11:46:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 758E12005ED
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 11:46:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1B9D1F7A9;
 Tue, 29 Apr 2025 09:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745919993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7ugRF02AClLq2bjKw0OcrwRrgvycfd79q8kpRQ82kk=;
 b=p71RqZyvLPIwCBP7DGA2X8I4lw8BXQikG/EYGYVaiovno+dXZdB8Cjqn7V79dZd8Ktb/Rh
 vpyVXLsJ3xbOv5fOV+TTdMUmeaNNQYZzvZZ0B7isNZHmcmPauIp8fKdu0gzEnxotSwjbmP
 YYRjqrbJ0QIkgecRcCiBzlebifPOQX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745919993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7ugRF02AClLq2bjKw0OcrwRrgvycfd79q8kpRQ82kk=;
 b=iYrapAQN1uU427BQbVldkVO/nGW/UOjdm9IOa5GvTlBgDjte+gfJI10mo42ZX77tlyoGxm
 L/cCIzwJWhTIg1BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wqer4Q8o;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SMP1nBug
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1745919991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7ugRF02AClLq2bjKw0OcrwRrgvycfd79q8kpRQ82kk=;
 b=wqer4Q8oTSuQiazXBxvYsiKgLbhj3WoHHFPo1MHC3g+hEpWnGRdMxlMasmCAlcSjZGgfIt
 IA68zzm3xyS7w6QAwNL+c6v8HOYbKHjk3px9fnbwrsiwinRmBvIhsSjKoJGmgbszTWUw2c
 JEax5xXt1bW7XKEEGdeZu8E8nM9Gbxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1745919991;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x7ugRF02AClLq2bjKw0OcrwRrgvycfd79q8kpRQ82kk=;
 b=SMP1nBugiDKVRTV1gzI6lYB/Ufc2plK6y4yRv7k237kWQFsmrN/0vppOXfm3TL+TAgj/2C
 13IS2gT4pHSYawDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEFE11340C;
 Tue, 29 Apr 2025 09:46:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P51kNfefEGhLIAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 29 Apr 2025 09:46:31 +0000
Date: Tue, 29 Apr 2025 11:47:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Xiao Yang <ice_yangxiao@163.com>
Message-ID: <aBCgHaiSIGxYDFPS@yuki.lan>
References: <20240925084921.16352-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240925084921.16352-1-ice_yangxiao@163.com>
X-Rspamd-Queue-Id: F1B9D1F7A9
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_TO(0.00)[163.com];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[163.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/{fanotify17,
 getxattr05}: Fix the ENOSPC error
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> If the value of max_user_namespaces is set to 10 but more than
> 10 user namspaces are currently used on system.  In this case,
> these tests fail with ENOSPC. for example:

What about we add a functionality to increment syfs files to the
save_restore API? I guess that this is going to be a pattern that we
have in several tests already.

Should look like (beware untested):

diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
index a221a9a0d..b84f05a50 100644
--- a/include/tst_sys_conf.h
+++ b/include/tst_sys_conf.h
@@ -12,6 +12,7 @@
 #define TST_SR_TBROK_RO 0x4
 #define TST_SR_SKIP_RO 0x8
 #define TST_SR_IGNORE_ERR 0x10
+#define TST_SR_INC 0x20

 #define TST_SR_TCONF (TST_SR_TCONF_MISSING | TST_SR_TCONF_RO)
 #define TST_SR_TBROK (TST_SR_TBROK_MISSING | TST_SR_TBROK_RO)
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
index 80cd83569..5d1de241a 100644
--- a/lib/tst_sys_conf.c
+++ b/lib/tst_sys_conf.c
@@ -55,6 +55,8 @@ void tst_sys_conf_save_str(const char *path, const char *value)
 int tst_sys_conf_save(const struct tst_path_val *conf)
 {
        char line[PATH_MAX];
+       char inc_val[32];
+       const char *new_val = conf->val;
        int ttype, iret;
        FILE *fp;
        void *ret;
@@ -105,7 +107,35 @@ int tst_sys_conf_save(const struct tst_path_val *conf)

        tst_sys_conf_save_str(conf->path, line);

-       if (!conf->val)
+
+       if (conf->flags & TST_SR_INC) {
+               long orig, inc;
+
+               if (!conf->val) {
+                       tst_brk(TBROK, "Increment value not defined!");
+               }
+
+               if (tst_parse_long(line, &orig, LONG_MIN, LONG_MAX)) {
+                       tst_brk(TBROK | TERRNO,
+                               "Failed to convert '%s' to long",
+                               conf->path);
+               }
+
+               if (tst_parse_long(line, &inc, LONG_MIN, LONG_MAX)) {
+                       tst_brk(TBROK | TERRNO,
+                               "Failed to convert increment (%s) for '%s' to long",
+                               conf->val, conf->path);
+               }
+
+               //TODO: Overflow?
+               orig += inc;
+
+               snprintf(inc_val, sizeof(inc_val), "%li", orig);
+
+               new_val = inc_val;
+       }
+
+       if (!new_val)
                return 0;

        fp = fopen(conf->path, "w");
@@ -116,7 +146,7 @@ int tst_sys_conf_save(const struct tst_path_val *conf)
                return 0;
        }

-       iret = fputs(conf->val, fp);
+       iret = fputs(new_val, fp);

        if (iret < 0) {
                print_error(__LINE__, conf->flags & TST_SR_IGNORE_ERR,


After this patch the val in tst_path_val is going to be interpreted as
an increment with TST_SR_INC flag.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
