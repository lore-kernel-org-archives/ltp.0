Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B8FD3941A
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 12:15:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C17B73E2F47
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 14:15:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E96C13E2F52
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 150C9600D60
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 14:14:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9740E4D333
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WmuSyuMYPXgpEKIuGobXLT9r285Nrwx2nEYwFtDVWc=;
 b=EfQ3SlG7/uQMetlk/jd956C2nawjsUYZlGOK66rJH6y4G5Q4IVkiAwIysuurtVEgdazKLE
 wgM3Iz3J0woeivGXsaN4Cw48QYaVluQbghO9KvnRgIPFsfNY/n8atWY0XBYaYtM5Bgs60r
 5DqTPa12pRsF8NEhYCszVkQ15Web2Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WmuSyuMYPXgpEKIuGobXLT9r285Nrwx2nEYwFtDVWc=;
 b=ZXu5TD9CNA+zBjTyV/b2t6UMSgmgt2KOehvaXJTI/MdGYzfPCCkRmFcCyiHBg1+MBvBuD8
 eVQTVKPsJjQBMdAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775132037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WmuSyuMYPXgpEKIuGobXLT9r285Nrwx2nEYwFtDVWc=;
 b=EfQ3SlG7/uQMetlk/jd956C2nawjsUYZlGOK66rJH6y4G5Q4IVkiAwIysuurtVEgdazKLE
 wgM3Iz3J0woeivGXsaN4Cw48QYaVluQbghO9KvnRgIPFsfNY/n8atWY0XBYaYtM5Bgs60r
 5DqTPa12pRsF8NEhYCszVkQ15Web2Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775132037;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5WmuSyuMYPXgpEKIuGobXLT9r285Nrwx2nEYwFtDVWc=;
 b=ZXu5TD9CNA+zBjTyV/b2t6UMSgmgt2KOehvaXJTI/MdGYzfPCCkRmFcCyiHBg1+MBvBuD8
 eVQTVKPsJjQBMdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 891AC4A0B0
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 12:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id caGTIIVdzmmmDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 12:13:57 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Apr 2026 14:13:43 +0200
Message-ID: <20260402121356.31266-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402121356.31266-1-chrubis@suse.cz>
References: <20260402121356.31266-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 04/17] lib: tst_kconfig: Add module presence checks
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

The .needs_kconfig and .needs_drivers fields in the tst_test structure
had overlaping functionality. Both were checking if a functionality was
build in into the kernel or compiled as a driver. Similarily to the
runtime checks added to tst_kconfig modules can be build but packaged
into separate packages and may not be installed on the system even if
corresponding config option was set to 'm'.

This commit adds a mapping table from CONFIG options to module names for
the modules we care about. Most of the time the mapping is trivial, but
some CONFIG options does not really match the module name, hence we need
a mapping. We may also be able to generate the table from kernel config
infrastructure later on, but at this point the number of options is
small enough to be manageable by hand editing.

Once we have that mapping we can run aditional check for a module
presence if the confing option was set to 'm' and if mapping exists in
order to disable the config option when the module was not found.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_kconfig.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 52dd6d726..c5dd97a45 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -144,6 +144,46 @@ static void runtime_check(struct tst_kconfig_var *var)
 	}
 }
 
+static struct module_check {
+	const char *config;
+	const char *module_name;
+} module_checks[] = {
+	{"CONFIG_KVM", "kvm"},
+	{"CONFIG_ZRAM", "zram"},
+	{"CONFIG_SQUASHFS", "squashfs"},
+	{"CONFIG_BLK_DEV_LOOP", "loop"},
+	{"CONFIG_TUN", "tun"},
+	{"CONFIG_BLK_DEV_RAM", "brd"},
+	{"CONFIG_HWPOISON_INJECT", "hwpoison_inject"},
+	{"CONFIG_QFMT_V2", "quota_v2"},
+	{"CONFIG_INPUT_UINPUT", "uinput"},
+	{"CONFIG_DUMMY", "dummy"},
+	{"CONFIG_CAN_VCAN", "vcan"},
+	{"CONFIG_CAN_RAW", "can-raw"},
+	{"CONFIG_CAN_BCM", "can-bcm"},
+	{"CONFIG_IP_SCTP", "sctp"},
+	{}
+};
+
+static void module_check(struct tst_kconfig_var *var)
+{
+	size_t i;
+
+	for (i = 0; module_checks[i].config; i++) {
+		if (strcmp(module_checks[i].config, var->id))
+			continue;
+
+		tst_res(TDEBUG, "Running module check for '%s'", var->id);
+
+		if (tst_check_module_driver(module_checks[i].module_name)) {
+			tst_res(TINFO, "%s=%c present but module '%s' not installed",
+					var->id, var->choice, module_checks[i].module_name);
+			var->choice = 'n';
+			return;
+		}
+	}
+}
+
 static inline int kconfig_parse_line(const char *line,
                                      struct tst_kconfig_var *vars,
                                      unsigned int vars_len)
@@ -222,6 +262,7 @@ out:
 			case 'm':
 				vars[i].choice = 'm';
 				runtime_check(&vars[i]);
+				module_check(&vars[i]);
 				return 1;
 			}
 		}
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
