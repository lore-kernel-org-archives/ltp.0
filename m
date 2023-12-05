Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954E3C4167B
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 20:11:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 137703CFB35
	for <ltp@archiver.kernel.org>; Tue,  5 Dec 2023 21:11:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DC1E3CBF62
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 21:11:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1D2211A008AA
 for <ltp@lists.linux.it>; Tue,  5 Dec 2023 21:11:43 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 419C721FA2;
 Tue,  5 Dec 2023 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701807102;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcZp6Q9n1ETvC4Ib56t5rnRxOgltM3X6MJYxUgE55hk=;
 b=wzx0JPByAdUSw9rhbHnb+Eo+qtD539QYEhmSB+jxjYd8VtIVN9ughMfYx7MWaidkMjz4NI
 8j52TbZSfLYO27zNW6LO603ATIGo/Gk6bo1lINqhHHExSBzNjHX1KDG1neI7gthSa6kBf3
 mGmeOfU22U3chsEhyV4bBN/yr2F7teg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701807102;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NcZp6Q9n1ETvC4Ib56t5rnRxOgltM3X6MJYxUgE55hk=;
 b=rodEztmAhBHRJV6qQ5eDyO0W4TEoUK458V2Gk64/w3RM9159y9GBtNeum2yItrThl6xuNa
 WAc00vNoYfvAKPAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 54CAE13924;
 Tue,  5 Dec 2023 20:11:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id D4U2Ef2Db2UxbwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 05 Dec 2023 20:11:41 +0000
Date: Tue, 5 Dec 2023 21:11:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Stefan Roesch <shr@devkernel.io>
Message-ID: <20231205201139.GA128077@pevik>
References: <20231205180952.3843711-1-shr@devkernel.io>
 <20231205180952.3843711-3-shr@devkernel.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231205180952.3843711-3-shr@devkernel.io>
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[19.40%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] add ksm test for smart-scan feature
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

> This adds a new ksm (kernel samepage merging) test to evaluate the new
> smart scan feature. It allocates a page and fills it with 'a'
> characters. It captures the pages_skipped counter, waits for a few
> iterations and captures the pages_skipped counter again. The expectation
> is that over 50% of the page scans are skipped (There is only one page
> that has KSM enabled and it gets scanned during each iteration and it
> cannot be de-duplicated).

Thanks a lot, merged. We really appreciate when kernel developers writing new
tests.

(The previous patch was merged already as v3).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
