Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE14D6CFA5
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 21:33:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 799E53CB47C
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 22:33:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84FC53C7D88
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 22:32:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EBF956006F2
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 22:32:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 682455BEF4;
 Thu, 22 Jan 2026 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769117573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZZZhicGnMufWRhiv6SzNqdl7Ba6PT1xb1MZhJ32pbo=;
 b=KOYbL+WYnCjvv8Xoy+PEnSoBJagXGnpRJXv9YCwrjc9DrdKbRi0BrAS2t/h4CUIPmARiEj
 mVUYAUiJ4Q+rLI9E/DhAZ8bznyYELJS9kRIVaHrNtsXnspNgIjDZdJ6IlZajTfus07Irh3
 SHYxe7o2Ei1n5ZbJ2IV8Mqbdc4giMec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769117573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZZZhicGnMufWRhiv6SzNqdl7Ba6PT1xb1MZhJ32pbo=;
 b=a83YxaaPAhmlQ7NYuLZ68YjwDlD+4sfGJ+nP1B3bockMm2FeRqCJC5LLth7QbFln60MFvB
 ezSU5zNmHHYXnJCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769117573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZZZhicGnMufWRhiv6SzNqdl7Ba6PT1xb1MZhJ32pbo=;
 b=KOYbL+WYnCjvv8Xoy+PEnSoBJagXGnpRJXv9YCwrjc9DrdKbRi0BrAS2t/h4CUIPmARiEj
 mVUYAUiJ4Q+rLI9E/DhAZ8bznyYELJS9kRIVaHrNtsXnspNgIjDZdJ6IlZajTfus07Irh3
 SHYxe7o2Ei1n5ZbJ2IV8Mqbdc4giMec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769117573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xZZZhicGnMufWRhiv6SzNqdl7Ba6PT1xb1MZhJ32pbo=;
 b=a83YxaaPAhmlQ7NYuLZ68YjwDlD+4sfGJ+nP1B3bockMm2FeRqCJC5LLth7QbFln60MFvB
 ezSU5zNmHHYXnJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3700713533;
 Thu, 22 Jan 2026 21:32:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hKvyC4WXcmkhOAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 22 Jan 2026 21:32:53 +0000
Message-ID: <9fd4c53c-219e-4e11-b25c-f43e7d378897@suse.de>
Date: Thu, 22 Jan 2026 22:32:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20260122102210.87453-1-liwang@redhat.com>
Content-Language: en-US
From: Ricardo Branco <rbranco@suse.de>
In-Reply-To: <20260122102210.87453-1-liwang@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd05: allow TCONF when UFFD-WP is
 unsupported
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
Cc: Christian Amann <camann@suse.com>, Ricardo Branco <rbranco@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 1/22/26 11:22 AM, Li Wang wrote:
> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
> index c4edc2529..9cb0bb08f 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
> @@ -92,11 +92,11 @@ static void run(void)
>   
>   	uffdio_api.api = UFFD_API;
>   	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> -	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
> +		if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> +			tst_brk(TCONF, "UFFD write-protect unsupported");
>   
> -	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
> -		tst_brk(TCONF, "UFFD write-protect unsupported");
> -		return;
> +		tst_brk(TBROK | TERRNO, "ioctl_userfaultfd failed");
>   	}
>   
>   	uffdio_register.range.start = (unsigned long) page;
> -- 2.52.0

Acked-by: Ricardo Branco <rbranco@suse.de>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
