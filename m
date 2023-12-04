Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68425C4167B
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 09:21:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1302A3CF5C7
	for <ltp@archiver.kernel.org>; Mon,  4 Dec 2023 10:21:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D95B43CC233
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 10:21:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BE7B6601901
 for <ltp@lists.linux.it>; Mon,  4 Dec 2023 10:21:21 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5247E1FE5A;
 Mon,  4 Dec 2023 09:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701681680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ty0yTdDAs4nKk5g6yRgnorCczR64opMfPe3fSt/XYmU=;
 b=xjHpI24tW7km+7dzN/uLWviffQXXN1mwYDN8gPGnQd8g3ylHIxAogZtfFFwGuCJX+l8W+K
 oYapMeF6vYZ+Uf6dPllygAs9qS7qKhPyxmdNykGNBNLvaWSaj5dZI3iuuO4tAQFksjGKHb
 L2m6AF4VvL5dbgW61oMS4xjD3nSaUlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701681680;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ty0yTdDAs4nKk5g6yRgnorCczR64opMfPe3fSt/XYmU=;
 b=roRCbqqsf9TAgoRhOhFcSQZM4HSKxallm68kC3LAfGQU/eC3G8mEymDq3N8Kw8RIkJgWff
 Msl2sPH9ljv88eBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C316613588;
 Mon,  4 Dec 2023 09:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id EH4GKg+abWWCLAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 04 Dec 2023 09:21:19 +0000
Date: Mon, 4 Dec 2023 10:21:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Stefan Roesch <shr@devkernel.io>
Message-ID: <20231204092118.GB8727@pevik>
References: <20231201210930.2651725-1-shr@devkernel.io>
 <20231201210930.2651725-3-shr@devkernel.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231201210930.2651725-3-shr@devkernel.io>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.32 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.02)[52.16%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] add ksm test for smart-scan feature
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
Cc: david@redhat.com, linux-mm@kvack.org, oliver.sang@intel.com,
 kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stefan,

>  testcases/kernel/mem/.gitignore    |  1 +
>  testcases/kernel/mem/include/mem.h |  1 +
>  testcases/kernel/mem/ksm/ksm07.c   | 69 +++++++++++++++++++++++++++++
>  testcases/kernel/mem/lib/mem.c     | 70 ++++++++++++++++++++++++++++++
You need to add 'ksm07 ksm07' line to runtest/mm.
If it's the only error, we can fix this before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
