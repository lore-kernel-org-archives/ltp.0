Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3630C83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 12:06:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 171933CCC97
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 14:06:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C68EE3CCBAA
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:06:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 491CB1A00166
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 14:06:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92D891F797;
 Tue, 22 Jul 2025 12:06:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C2EA13A73;
 Tue, 22 Jul 2025 12:06:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JplgFM1+f2j1UgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 12:06:37 +0000
Date: Tue, 22 Jul 2025 14:06:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250722120635.GB22975@pevik>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 92D891F797
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

[ Cc Stephen, the fix author in case I'm wrong with reproducing on enforcing=0 ]

> Add tst_selinux_enabled() utility in tst_security.h in order to verify
> if SELinux is currently up and running in the system.
...
> +int tst_selinux_enabled(void)
> +{
> +	int res = 0;
> +
> +	if (tst_is_mounted(SELINUX_PATH))
> +		res = 1;

I was wondering if it the test require enforcing or not therefore I retested it
and it's really reproducible with permissive mode, i.e. with kernel command line
security=selinux selinux=1 enforcing=0

Because if enforcing was required, I would be for using tst_selinux_enforcing(),
which checks /sys/fs/selinux/enforce for 1 as Wei suggested in v3:

https://lore.kernel.org/ltp/aHf839WS0BPIa5Zq@MiWiFi-CR6608-srv/

@Cyril @Andrea, just checking if /sys/fs/selinux/enforce exists would be faster
than looping /proc/mounts (via tst_is_mounted(SELINUX_PATH)). Can we just modify
the patch?

Kind regards,
Petr

+++ lib/tst_security.c
@@ -107,7 +107,7 @@ int tst_selinux_enabled(void)
 {
 	int res = 0;
 
-	if (tst_is_mounted(SELINUX_PATH))
+	if (access(SELINUX_STATUS_PATH, F_OK) == 0)
 		res = 1;
 
 	tst_res(TINFO, "SELinux enabled: %s", res ? "yes" : "no");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
