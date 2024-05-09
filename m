Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFBAC10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 13:40:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936CF3CE2B0
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 15:40:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2D093CB172
 for <ltp@lists.linux.it>; Thu,  9 May 2024 15:40:32 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 77AB2140111E
 for <ltp@lists.linux.it>; Thu,  9 May 2024 15:40:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7F7A22233;
 Thu,  9 May 2024 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715262030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VR5A+ULRNrwToo9Ll16uU9Ae+BhB/uPjkO11BZ5kat4=;
 b=RQFLLSQTB2wnHBGBEZO1jxURxnNNli2k2W3nDDc7l64815c05qx/hu5Zqn8/IRJYvrnNdh
 1Y9PPMsgdpne7bw7SzyTp1v8rUdpmTiLIPDQWihzUJ6PpFWfW/9i8tmIsJLCcWMlq+cCJO
 ir7FYRh+4/cfd/1vw3XVN4BdJcd1lAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715262030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VR5A+ULRNrwToo9Ll16uU9Ae+BhB/uPjkO11BZ5kat4=;
 b=zgl7ve+qOuUUwmYisewAhzVXpbwF8OoSXG3po0T9BXA3X/gvUhsEol8SZeYFZektW7izEJ
 CaW0E6QFXShFu6Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715262030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VR5A+ULRNrwToo9Ll16uU9Ae+BhB/uPjkO11BZ5kat4=;
 b=RQFLLSQTB2wnHBGBEZO1jxURxnNNli2k2W3nDDc7l64815c05qx/hu5Zqn8/IRJYvrnNdh
 1Y9PPMsgdpne7bw7SzyTp1v8rUdpmTiLIPDQWihzUJ6PpFWfW/9i8tmIsJLCcWMlq+cCJO
 ir7FYRh+4/cfd/1vw3XVN4BdJcd1lAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715262030;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VR5A+ULRNrwToo9Ll16uU9Ae+BhB/uPjkO11BZ5kat4=;
 b=zgl7ve+qOuUUwmYisewAhzVXpbwF8OoSXG3po0T9BXA3X/gvUhsEol8SZeYFZektW7izEJ
 CaW0E6QFXShFu6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 888F213941;
 Thu,  9 May 2024 13:40:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id U8oVIE7SPGZ5dAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 13:40:30 +0000
Date: Thu, 9 May 2024 15:40:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240509134029.GA300682@pevik>
References: <20240509102802.20091-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240509102802.20091-1-liwang@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] madvise11: ignore EBUSY for MADV_SOFT_OFFLINE
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
Cc: Luis Goncalves <lgoncalv@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

...
> +++ b/testcases/kernel/syscalls/madvise/madvise11.c
> @@ -128,6 +128,8 @@ static int allocate_offline(int tnum)
>  				return -1;

>  			if (madvise(ptrs[num_alloc], pagesize, MADV_SOFT_OFFLINE) == -1) {
> +				if (errno == EBUSY)
> +					continue;

LGTM
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
>  				if (errno != EINVAL)
>  					tst_res(TFAIL | TERRNO, "madvise failed");
>  				if (errno == EINVAL)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
