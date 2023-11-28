Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C2BC07E98
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:06:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D18043CDAB5
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 12:06:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26F0F3CD97E
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:06:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED0F21019AD9
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:05:09 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 082781F855;
 Tue, 28 Nov 2023 10:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701168835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lnwqIW6Ay2/Asx7BSwfGL3MeIMmvJ+3SwMn7RkrqlJM=;
 b=vQkrxv6n8Mjw+OYxrCpDyX4lNS9jaUsHxSPXq8YtodYYyeYF/k8k9rgJalyQ5dd4QdYtFx
 bhtos6AtR7icHUicsbLZW4JcgLpK2aNHPNgkaDbT6Gse0S3Tf4M359ZSFyQmwFZZkR1VLt
 jF5E3ogIeCZGCR5JrL3drUmmUZc/Cj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701168835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lnwqIW6Ay2/Asx7BSwfGL3MeIMmvJ+3SwMn7RkrqlJM=;
 b=t2djBNUTneI73RGuCj8GI5rGpll6Bs8412n+bXLqlm8geDfLmp4qajhfORm5XLd3/sCpc1
 25LAgdmE7/XrNXAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D7180139FC;
 Tue, 28 Nov 2023 10:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id SCw6M8LGZWUdbQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 10:53:54 +0000
Date: Tue, 28 Nov 2023 11:53:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231128105353.GB362098@pevik>
References: <20230928084408.21125-1-wegao@suse.com>
 <20230929004518.29632-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230929004518.29632-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.48 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_SPAM_LONG(3.50)[1.000]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.53)[97.87%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] getcwd01: Use syscall directly check invalid
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

Hi,

> +++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
> @@ -14,8 +14,8 @@
>   *
>   * Expected Result:
>   * 1) getcwd(2) should return NULL and set errno to EFAULT.
> - * 2) getcwd(2) should return NULL and set errno to ENOMEM.
> - * 3) getcwd(2) should return NULL and set errno to EINVAL.
> + * 2) getcwd(2) should return NULL and set errno to EFAULT.
> + * 3) getcwd(2) should return NULL and set errno to ERANGE.
NOTE: actually before this change we tested getcwd(3), 2 is for raw syscalls, 3
for libc wrappers.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
