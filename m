Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE98C54798
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:35:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2BFD3CFF78
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 14:35:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C953D3C06DF
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 14:35:09 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A988E100065A
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 14:35:08 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BCDC61F7AF;
 Fri, 23 Feb 2024 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708695307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34AOCj+QkaoiamGhRlaJlOe6i9QgvlGuQ4RqHkVz+FQ=;
 b=ahjZn+8qfJq1fmDNKE9I4fpjqIbRTktWyBfGxjJaQ9eaTFvEd9aYWHXQl9Ukf5KF7n76Wh
 dFIlPoY8am4yaxqjNXjNhBpwExrqcr/Hj+hIjTIff/M2I4pWydz4nviXl1ME+Gb7uwvKKJ
 /uKJo7JIsr/MmMfu6l8+907XGdN1zRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708695307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34AOCj+QkaoiamGhRlaJlOe6i9QgvlGuQ4RqHkVz+FQ=;
 b=4TSVUEsk95eCsYyd89zzYjH8tl0EZyyeU2UQUzgpWl+VJb/OA6B2up9ywJy4T86+alN9mo
 J62GfBnfDT1eunDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708695307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34AOCj+QkaoiamGhRlaJlOe6i9QgvlGuQ4RqHkVz+FQ=;
 b=ahjZn+8qfJq1fmDNKE9I4fpjqIbRTktWyBfGxjJaQ9eaTFvEd9aYWHXQl9Ukf5KF7n76Wh
 dFIlPoY8am4yaxqjNXjNhBpwExrqcr/Hj+hIjTIff/M2I4pWydz4nviXl1ME+Gb7uwvKKJ
 /uKJo7JIsr/MmMfu6l8+907XGdN1zRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708695307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34AOCj+QkaoiamGhRlaJlOe6i9QgvlGuQ4RqHkVz+FQ=;
 b=4TSVUEsk95eCsYyd89zzYjH8tl0EZyyeU2UQUzgpWl+VJb/OA6B2up9ywJy4T86+alN9mo
 J62GfBnfDT1eunDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E3AFE13776;
 Fri, 23 Feb 2024 13:35:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id LKiUMwqf2GVPeQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 13:35:06 +0000
Date: Fri, 23 Feb 2024 14:35:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240223133505.GA1461644@pevik>
References: <20231103123427.1072050-1-pvorel@suse.cz>
 <be71af00-0f9d-4043-b6f6-f2205907ae8d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be71af00-0f9d-4043-b6f6-f2205907ae8d@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[34.10%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Minor programming doc improvements
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

Hi Andrea, Marius,

> Hi!

> The whole patch is fine for me. Please merge and keep also Marius comment.

Thanks for your review, merged!

I overlooked that because I watch more patchwork than the mailing list itself.
I really need to look more into mailing list.

Could you, please, also reply to all when comment on mailing lists?
Cover letters does not your RBT (only patches themselves) + some non-regular
contributors may have unsubscribed or random people who got Cced may never has
been subscribed. Also kernel developers may not subscribe at all, because all
mailing lists on lore don't require subscription for posting messages (I've met
kernel developers posting without a subscription for this reason).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
