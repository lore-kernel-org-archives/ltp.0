Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACE0C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 14:04:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0F523C9A1D
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 15:04:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D6543C6A7A
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 15:03:47 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2BCD8144F2C0
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 15:03:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 754AE222BD;
 Wed, 12 Feb 2025 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739369025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJfxBTRr5germ9xX0Cq+NYtXFwzhjUyKiqgKTYyTt/c=;
 b=AfsnM7ogAvIsAO50LJ+UExyBW9FJ+BKyDeli86pG0bHhBeVH3ho2Vanyr1cRo6yNTVq2gI
 Cq0InQlgQTrXWcTO806NUc8RhZt8s3YsiAIw/biio3WDjV4cK8q++NiYv1n6zYGmPdvUxb
 yKMPr2M8Qsee5f4nVi9hXvJALdloeEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739369025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJfxBTRr5germ9xX0Cq+NYtXFwzhjUyKiqgKTYyTt/c=;
 b=T06mYF1FCXCV1Jn4hzmUmiP6qnmP3+lTELC+9EWObd1h6iPk5G4UzzR1H6nxsEmRtePXEO
 GxDSQ+x/onlohiAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AfsnM7og;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T06mYF1F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739369025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJfxBTRr5germ9xX0Cq+NYtXFwzhjUyKiqgKTYyTt/c=;
 b=AfsnM7ogAvIsAO50LJ+UExyBW9FJ+BKyDeli86pG0bHhBeVH3ho2Vanyr1cRo6yNTVq2gI
 Cq0InQlgQTrXWcTO806NUc8RhZt8s3YsiAIw/biio3WDjV4cK8q++NiYv1n6zYGmPdvUxb
 yKMPr2M8Qsee5f4nVi9hXvJALdloeEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739369025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJfxBTRr5germ9xX0Cq+NYtXFwzhjUyKiqgKTYyTt/c=;
 b=T06mYF1FCXCV1Jn4hzmUmiP6qnmP3+lTELC+9EWObd1h6iPk5G4UzzR1H6nxsEmRtePXEO
 GxDSQ+x/onlohiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C9D513AEF;
 Wed, 12 Feb 2025 14:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y6MNFUGqrGf2KAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 14:03:45 +0000
Date: Wed, 12 Feb 2025 15:03:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250212140340.GA2054076@pevik>
References: <20250212131618.6810-1-chrubis@suse.cz>
 <20250212131618.6810-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250212131618.6810-2-chrubis@suse.cz>
X-Rspamd-Queue-Id: 754AE222BD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] metaparse: Add shell test parser
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Great, thank you!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Quick notes:

* Implementing help under -h would be a bonus (it segfaults on -h, metadata.c
  has it). But this should not block you merging it.

* Please merge with whitespace error
$ make check-metaparse-sh 
CHECK metadata/metaparse-sh.c
metaparse-sh.c:90: ERROR: code indent should use tabs where possible

* Resulting JSON has true, 1 instead would be nice. Again, tiny detail.

   "vma05.sh": {
   "doc": [
    "",
    "[Description]",
    "",
    "Regression test if the vsyscall and vdso VMA regions are reported correctly.",
    "",
    "While [vsyscall] is mostly deprecated with newer systems, there is",
    "still plenty of kernels compiled with CONFIG_LEGACY_VSYSCALL_NATIVE and",
    "CONFIG_LEGACY_VSYSCALL_EMULATE (see linux/arch/x86/Kconfig for option",
    "descriptions). First part of the test will check eligible kernels for",
    "regression for a bug fixed by commit 103efcd9aac1 (fix perms/range of",
    "vsyscall vma in /proc/*/maps).",
    "",
    "Second part of test checks [vdso] VMA permissions (fixed with commits",
    "b6558c4a2378 (fix [vdso] page permissions) and e5b97dde514f (Add",
    "VM_ALWAYSDUMP)). As a consequence of this bug, VMAs were not included",
    "in core dumps which resulted in eg. incomplete backtraces and invalid",
    "core dump files created by gdb."
   ],
   "needs_root": true,
   "needs_tmpdir": true,
   "needs_cmds": ["gdb", "uname"],
   "save_restore": [
    ["/proc/sys/kernel/core_pattern", "core", "TBROK"],
    ["/proc/sys/kernel/core_uses_pid", "0", "TBROK"]
   ],
   "tags": [
    ["linux-git", "103efcd9aac1"],
    ["linux-git", "b6558c4a2378"],
    ["linux-git", "e5b97dde514f"]
   ],
   "fname": "testcases/kernel/mem/vma/vma05.sh"
  }

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
