Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C15C28B30
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 17:01:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 205983CAE41
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 18:00:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27B9F3CAE29
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 18:00:43 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A603F1A00CD7
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 18:00:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 531AC1F745;
 Thu, 20 Mar 2025 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742490041;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zG0sCnfO8G1YpW4OO12hLVQTKPeTEZQo881Ntw4nBiA=;
 b=NOzzStpg4TrzYaiaI9nED9yLT6+3nvxRgkeIGkNhBWg6KC604mx3aCbMmKYqXUkTPz6WCa
 ndJnWW1BmhqH1foQ4ldJu5f6u47pwmTd5+wmAFMKY8Nxdm5PZzdqV8S5WeZDImMkMGlwv3
 08RF3y68H/rnU2Z+sDAWJdi90iMw9t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742490041;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zG0sCnfO8G1YpW4OO12hLVQTKPeTEZQo881Ntw4nBiA=;
 b=xOo6HCYwSJ9Pi/AFTGOTSVOHLlNX5emQJifqg0PUSiCeQAftLye70MTLaRbMjPK8MMh5Or
 mXO2825a7BC+T1AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742490041;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zG0sCnfO8G1YpW4OO12hLVQTKPeTEZQo881Ntw4nBiA=;
 b=NOzzStpg4TrzYaiaI9nED9yLT6+3nvxRgkeIGkNhBWg6KC604mx3aCbMmKYqXUkTPz6WCa
 ndJnWW1BmhqH1foQ4ldJu5f6u47pwmTd5+wmAFMKY8Nxdm5PZzdqV8S5WeZDImMkMGlwv3
 08RF3y68H/rnU2Z+sDAWJdi90iMw9t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742490041;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zG0sCnfO8G1YpW4OO12hLVQTKPeTEZQo881Ntw4nBiA=;
 b=xOo6HCYwSJ9Pi/AFTGOTSVOHLlNX5emQJifqg0PUSiCeQAftLye70MTLaRbMjPK8MMh5Or
 mXO2825a7BC+T1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09DB513757;
 Thu, 20 Mar 2025 17:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jNLdALlJ3GdpEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Mar 2025 17:00:41 +0000
Date: Thu, 20 Mar 2025 18:00:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250320170039.GA113087@pevik>
References: <20250319192742.999506-1-amir73il@gmail.com>
 <20250319192742.999506-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250319192742.999506-4-amir73il@gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-0.998];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify24: add mmap() and user page fault to
 test
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> Commit 066e053fe208a ("fsnotify: add pre-content hooks on mmap()")
> in 6.14-rc7 added a pre-content hooh in mmap() before the final release
> of the fsnotify pre-content event feature.

> To test pre-content hook on mmap(), increase the size of the test file
> to 101 pages use mmap() to setup a buffer from the end of the test file.

> Change some of the test cases to allow the write() and use this buffer
> as the input buffer to write(), which tests deadlock avoidance by
> suppresing pre-content hook on user page faults.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify24.c     | 41 ++++++++++++++++---
>  1 file changed, 35 insertions(+), 6 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify24.c b/testcases/kernel/syscalls/fanotify/fanotify24.c
> index 2d2479b39..3a76f2c1b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify24.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify24.c
> @@ -46,6 +46,7 @@
>  static char fname[BUF_SIZE];
>  static char buf[BUF_SIZE];
>  static volatile int fd_notify;
> +static size_t page_sz;

>  static pid_t child_pid;

> @@ -68,7 +69,8 @@ static struct tcase {
>  		FAN_OPEN_PERM | FAN_PRE_ACCESS,
>  		{
>  			{FAN_OPEN_PERM, FAN_ALLOW},
> -			{FAN_PRE_ACCESS, FAN_DENY},
> +			{FAN_PRE_ACCESS, FAN_ALLOW},
> +			{FAN_PRE_ACCESS, FAN_ALLOW},

If I understand correctly, these doubled FAN_PRE_ACCESS, FAN_ALLOW are for
reusing the write buffer, right? Obviously it's needed but on the first look it
looks like error.

<snip>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
