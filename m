Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282A6C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 12:51:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9734B3CCD79
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:51:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F29AF3CAF64
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 14:51:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B9841400252
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 14:51:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CABC3218D9;
 Wed, 23 Jul 2025 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753275088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wpRo6PiCvqav8lFhAiLDl66aoefAk/LOiujlLRzd5FQ=;
 b=3S33trH0B3Nm0iwtKpXABRyunOX1N3HR6skEeaf8icSYhiUp9Qrr7MAtP/ajvmu7A+6+L3
 /biMEfjJGQTy65jVS/o/mG26pSPYpefGOkeSjZej1N+6t5Rz7WQjVNBI6fxSjMDlrp3ORU
 Sb8N8dJevyCgItlnTQOIroWNyJ1GEJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753275088;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wpRo6PiCvqav8lFhAiLDl66aoefAk/LOiujlLRzd5FQ=;
 b=XjVOiC/xnrd/C78VZiWSQc7gv5uElyeogCfE5NBqqX2HJiiD+4cT6SMBphsom7vj6EA+DF
 apRFbDQC8Mgf4QCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753275087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wpRo6PiCvqav8lFhAiLDl66aoefAk/LOiujlLRzd5FQ=;
 b=nkbymFSsrHMVgLon0TRXp0UqgsWZ5cjXh5L/a4p4lpFxkjJtwTdJbXJ7pU8ApmR28ImxPc
 QMCIQATZSDnMSuU9Gvkre3cnIYJY0o5cuJIKgKaPdOhDtqDWiYwLKb8CS5lGxRycMnRTrx
 nCcYDhsk49vxEaUeetsYVIQeZ7WBRAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753275087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wpRo6PiCvqav8lFhAiLDl66aoefAk/LOiujlLRzd5FQ=;
 b=KAL3kYC4xow5+esgavHcgfrIvLUtws9xlgC6v0d5V11fZ3M56d4sFPRbcLI77tq7NNnwgp
 JJbaT64RsJV9/QBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9777313302;
 Wed, 23 Jul 2025 12:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id USoCJM/agGivFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Jul 2025 12:51:27 +0000
Date: Wed, 23 Jul 2025 14:51:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250723125126.GB154226@pevik>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <CAEjxPJ6WQRrfAnMtDzvUxYL6smYbKpDQNGp6rxs4dZ=DxC3M9A@mail.gmail.com>
 <CAEjxPJ7gbWRWgbrLv+1xE0dJUq+c9UpNzYUgyis2f8gmJUo1wQ@mail.gmail.com>
 <20250722134246.GA84869@pevik>
 <CAEjxPJ66s+UsDXAbgewkA+h3Djq31FMb6pBF2NSZiV7LCH_Jmg@mail.gmail.com>
 <54a9a8ba-4d1e-4476-81f5-dceaadc8a82a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54a9a8ba-4d1e-4476-81f5-dceaadc8a82a@suse.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.de,lists.linux.it,suse.cz];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
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

Hi all,

> On 7/22/25 3:48 PM, Stephen Smalley wrote:
> > I guess my only question here is whether the tests all require SELinux
> > to be enforcing or if some of them are just exercising SELinux
> > functionality that would also pass when permissive. And whether you
> > care about testing that case.

> Hi Stephen,

> this particular reproducer doesn't need more than knowing a LSM is up and
> running, so we can trigger the bug on listxattr.
> In our case, we chosen SELinux because it's popular and this approach is
> more practical than checking every single LSM implementation in the system,
> verifying if it's enabled or not, no matter SELinux is configured in
> permissive or enforcing mode.

Thanks for info. Feel free to merge this as is and add support for other LSM
later. Either you send a patch later or please share what's needed to be done.

FYI with disabled SELinux and using other LSM
$ cat /proc/cmdline
... BOOT_IMAGE=/boot/vmlinuz-6.16.0-rc1-236-g8c6bc74c7f891-1.ga27462d-vanilla security=selinux selinux=0 enforcing=0 ima_policy=critical_data

cat /sys/kernel/security/lsm
lockdown,capability,landlock,yama,bpf,ima,evm

and with modified your test to not check for SELinux does not reproduce the bug:
# ./listxattr04
...
listxattr04.c:52: TPASS: listxattr() correctly read attributes length

I suppose at least capability, IMA, EVM and BPF aren't triggering it (there are
definitely used by the kernel). Maybe it requires AppArmor or use other LSM
(which might require their own kernel command line).
Because any LSM means any kernel would be vulnerable. If it's just SELinux and
AppArmor fewer kernels are affected.

Kind regards,
Petr

> - Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
