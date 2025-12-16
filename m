Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A95ED5CCBB
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 10:11:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 341183D033D
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:11:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3E453D032C
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 11:11:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE08D2005E7
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 11:11:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C74A85BCC3;
 Tue, 16 Dec 2025 10:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765879881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnH1sINh0xSUoXLLZUV1EGwDSlSB2xCsDorWDQZCcPw=;
 b=VIsD5HqI0p5tWYrbQELuBoLJqwBi9AgSF1EKM9K8CZ59VcAfsRHbhIsHLMadtwPsCPAlog
 reOJRFU02fil/qj2dmiugp5vt2bDVexpOqZVKYwRiZPhSbo9gxd5J8lt3rlKSxm2M3Q3cg
 xze2HkwdzHBdvFDFL7cdATNi9vjYfls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765879881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnH1sINh0xSUoXLLZUV1EGwDSlSB2xCsDorWDQZCcPw=;
 b=6lOP9Z2bYAPswkBdwyBtCWiKrqH3XkbvPZyOEVd6J/PpxWxw7VgIKredL6HtOQqkr8+Bve
 HbmJMmEY08wTRjDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765879879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnH1sINh0xSUoXLLZUV1EGwDSlSB2xCsDorWDQZCcPw=;
 b=HtZ5KfSEE4K2HU5gs40tgW4YaQnGfYK/1rxGc/ET+/+W96+wPWCkNyrSlNRCXanpQd0vwd
 9diYrb+OhH6Y1UWLsi0ZHuHIsXqkp06cE/XD3fXrokiiwZhaEVaG8LFQcBnXMqgFln1PzU
 B8yvMcqWWbmWYVqqJ100TpjaNGGIycQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765879879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnH1sINh0xSUoXLLZUV1EGwDSlSB2xCsDorWDQZCcPw=;
 b=5jyIBa2gRwYWCQyVu6j+J/i5xcM/PTmWIk2F32hV3JBrJMin7hu4yNK7xpLbr+rE0A/gkT
 H5JO8N854O/XaYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 843183EA63;
 Tue, 16 Dec 2025 10:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5RiaHEcwQWliXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Dec 2025 10:11:19 +0000
Date: Tue, 16 Dec 2025 11:11:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251216101117.GA295306@pevik>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
 <20251215143048.GA267467@pevik>
 <CAEemH2cmuxr7jKBA32eXQHOwQLvq4tPMDsmcen_9C7di=eSpDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cmuxr7jKBA32eXQHOwQLvq4tPMDsmcen_9C7di=eSpDQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[qemu.org:url,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

...
> > [1]
> > https://lore.kernel.org/all/1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com/


> What a coincidence! I just spoke face-to-face with David Hildenbrand
> at LPC last Friday. He expressed concerns about the increasing amount
> of AI-generated code being sent to the LKML, pointing out that it does
> indeed place a considerable review burden on maintainers. Moreover,
> he himself rarely uses AI.

Nice :).

"DoS kernel maintainers with AI slop" is a real danger.

> Furthermore, some experts at Huawei told me that they only allow patch
> senders to review patches before sending them, but do not permit the
> use of AI-generated code.

+1. Is that due "AI slop" or legal issues?

While I also share the fear of "AI slop", I was surprised that QEMU really
strictly bans AI generated code due legal issues. I wonder if kernel endup the
same as well.

https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content

> And, of course, clearly flagging content as AI-generated code in the patch
> might help.

+1.

IMHO using AI for help with manual work, e.g. converting docs from asciidoc
to RST format is ok. For me the question is whether it can be used for
generating a test code (new tests from scratch, rewrite into into new API which
is often clearer write from scratch).

Anyway, because we already had some AI generated patches it'd be good to have an
AI policy.  But I would like not to block this patchset it (it'd be nice to get
the patchset merged before Christmas and solve AI policy afterwards).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
