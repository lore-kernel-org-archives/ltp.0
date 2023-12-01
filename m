Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F02C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 10:14:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22B2C3CD931
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 11:14:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 761963CD3DA
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 11:14:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 522FC14098BF
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 11:14:18 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB50921BD5;
 Fri,  1 Dec 2023 10:14:17 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8558B1344E;
 Fri,  1 Dec 2023 10:14:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 7PtVHPmxaWXCcwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Dec 2023 10:14:17 +0000
Date: Fri, 1 Dec 2023 11:14:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231201101415.GB1710028@pevik>
References: <20230929004518.29632-1-wegao@suse.com>
 <20231201031512.27513-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231201031512.27513-1-wegao@suse.com>
X-Spamd-Bar: +++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [9.42 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(1.20)[suse.cz]; NEURAL_SPAM_LONG(0.73)[0.209];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: CB50921BD5
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] getcwd01: Use syscall directly check invalid
 argument
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

Hi Wei,

> Fixes: #1084

> User space wrap getcwd with different implementation, for example
> glibc will directly input parameter into kernel in normal situation
> but uclibc-ng and musl will malloc buffer when buffer is NULL, so for
> uclibc and musl the parameter size will be ignored. Use system call
> directly check invalid argument can be a solution.

For the sake of the correctness: there is no malloc() in musl [1] (nor in the
mirror source you posted to #1084), that's only in uclibc-ng [2] and glibc [3].

The reason why musl failed was already described by Richie and Cyril in #1084:
musl ignores the size parameter when buffer is NULL and allocates it with PATH_MAX
and passes this size to kernel.

Therefore I reword the commit message.

[1] https://git.musl-libc.org/cgit/musl/tree/src/unistd/getcwd.c
[2] https://cgit.uclibc-ng.org/cgi/cgit/uclibc-ng.git/tree/libc/sysdeps/linux/common/getcwd.c#n38
[3] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/getcwd.c;h=5b0b6879ed28f278f07ce494f9be30f504757daa;hb=HEAD#l47

...
> -	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
> +	TST_EXP_FAIL2(syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
While syscalls() would work everywhere, it's better is LTP wrapper tst_syscall()
(it TCONF in case when syscall is not implemented which is I admit nearly
impossible).

I used that and merged.
Thank you!

NOTE: we should implement .test_variants, where you just skip affected NULL
buffer test (it's enough to test it with raw syscall). Please send a patch or
let me know that you don't plan to do it and I'll do it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
