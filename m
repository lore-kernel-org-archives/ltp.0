Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80AAC3271E
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 08:54:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36A753D3A01
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 10:54:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B44113D115C
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 10:54:38 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C7B161000233
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 10:54:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFB11219AD;
 Mon,  8 Jul 2024 08:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720428877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwNGfprEIWiWiw3170NC+4E+1z/2/MW41eLYrUjzCLM=;
 b=1iBrVG9vK5sCtofb1jaZshTiXdb+88aCg+tZAkjDuDQsT0SH4iNETRYo3aP7WF0rUVeK3f
 JUEScU4Y11Irn82MyR4GOpyLkZG4T5oiVMFQalnoY/r8jHwhCbwpCIj8oqEa/r52vDpryu
 8b1IRuE44KKRg82/ruyUWrrixU5qjjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720428877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwNGfprEIWiWiw3170NC+4E+1z/2/MW41eLYrUjzCLM=;
 b=XqGXYE6wPzmCgf9KnCKpu3XTQfb/vyXHZm5QIAiiedZGbAd8rt/kDoe7eIXTxPIiNJymy8
 GIuvZWVlFagB5GDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720428876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwNGfprEIWiWiw3170NC+4E+1z/2/MW41eLYrUjzCLM=;
 b=pmAD7tlvKphYFPzqQ7EAKHgbM84DFMKtQr7QdTSzmtDn5T+AEI4RA/HSKZcM3MgtUKyKg+
 I99VnMveI3WKmTX23dQLOCHXBpZZbDSovE21j/ajlc98Ca5cqjjNij3HPZRXgjDKKHSB0U
 pU0JprOPvJdDtHRuZWKgOwLaG12LaVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720428876;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwNGfprEIWiWiw3170NC+4E+1z/2/MW41eLYrUjzCLM=;
 b=B0aYoDjpoIplC8W/Xn/csmoq7FdrkkBX/kJYW30rpfWSn3/vrY6bpXM+4KGzPHnIXhXIJr
 8ySn0pVZmgC7YLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2C811396E;
 Mon,  8 Jul 2024 08:54:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wQajMUypi2bXKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Jul 2024 08:54:36 +0000
Date: Mon, 8 Jul 2024 10:54:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: =?utf-8?B?6Lev5paQ?= <lufei@uniontech.com>
Message-ID: <20240708085430.GA122879@pevik>
References: <20240606065506.1686-1-lufei@uniontech.com>
 <20240624015245.54968-1-lufei@uniontech.com>
 <20240624015245.54968-2-lufei@uniontech.com>
 <20240708042318.GA119348@pevik>
 <tencent_3E63AE5B3A162AF97E6505AD@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_3E63AE5B3A162AF97E6505AD@qq.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] acct01: add EFAULT errno check.
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
Cc: LTP <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Lu,

> Hi Petr, Cyril.
> Really thanks for the advises. Each of them makes me learned.

You're welcome. Also looking at XHTML entity '&gt;' and '&nbsp;' in your reply below,
it would be great if you could set your email client (MUA) which you use for LTP
mailing list to use plain text (not XHTML).

Here are some tips:
https://www.kernel.org/doc/html/latest/process/email-clients.html

Kind regards,
Petr

> Sorry for the patches not so good I've sent, I'm trying to make it better in the future.
> I will make warnings clearnup patches after this one merged.


> Best reguards.
> Lu Fei
> &nbsp;
> ------------------&nbsp;Original&nbsp;------------------
> From: &nbsp;"Petr&nbsp;Vorel"<pvorel@suse.cz&gt;;
> Date: &nbsp;Mon, Jul 8, 2024 04:23 AM
> To: &nbsp;"ltp"<ltp@lists.linux.it&gt;; "lufei"<lufei@uniontech.com&gt;; 
> Cc: &nbsp;"Cyril Hrubis"<chrubis@suse.cz&gt;; 
> Subject: &nbsp;Re: [LTP] [PATCH] acct01: add EFAULT errno check.

> &nbsp;

> Hi 
> &gt; Add EFAULT errno check in acct01 testcase.

> &gt; Signed-off-by: lufei <lufei@uniontech.com&gt;

> I guess you don't mind if I change this to following before merge:
> Signed-off-by: Lu Fei <lufei@uniontech.com&gt;

> &gt; ---
> &gt;&nbsp; testcases/kernel/syscalls/acct/acct01.c | 13 +++++++++++++
> &gt;&nbsp; 1 file changed, 13 insertions(+)

> &gt; diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> &gt; index 1b53a32f2..ed1817bc5 100644
> &gt; --- a/testcases/kernel/syscalls/acct/acct01.c
> &gt; +++ b/testcases/kernel/syscalls/acct/acct01.c
> &gt; @@ -33,6 +33,7 @@
> &gt;&nbsp; #define FILE_TMPFILE		"./tmpfile"
> &gt;&nbsp; #define FILE_ELOOP		"test_file_eloop1"
> &gt;&nbsp; #define FILE_EROFS		"ro_mntpoint/file"
> &gt; +#define FILE_EFAULT		"/tmp/invalid/file/name"
....

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
