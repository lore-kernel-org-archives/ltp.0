Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C74FC4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 04:24:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 201493CFE89
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 06:24:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E80F3CF0BF
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 06:24:06 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C4498600FF0
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 06:24:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 86B9A2042D;
 Fri, 26 Apr 2024 04:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714105442;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0JvaMID6PhDQc0qy8XNkjJWudq4kyDom5Ojl2nS61s=;
 b=d5QCcIgEwO9Ze1xS9dTnow1JTlSg3MZnlATzua9UwnyZPZLUtecVfWpx+XYzKL3fpmS+at
 R+VJmmFAdtn/Q8aSU2yY/DggEIcE6MGtod+KgD6gtUOj6TuFGfcj8Qfz960wBlBOxhrmsf
 GbxcQUFXeJ3ThMZxcE7NEiusA/8s8PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714105442;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0JvaMID6PhDQc0qy8XNkjJWudq4kyDom5Ojl2nS61s=;
 b=I+FaLPf7xov03itSD2fRa3J+8rs7qBejonxjCCDvYhAEMWYuqMmZ+XqZXINQr+Us4QqAZK
 ZK+8wY0ysfVDI3CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714105442;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0JvaMID6PhDQc0qy8XNkjJWudq4kyDom5Ojl2nS61s=;
 b=d5QCcIgEwO9Ze1xS9dTnow1JTlSg3MZnlATzua9UwnyZPZLUtecVfWpx+XYzKL3fpmS+at
 R+VJmmFAdtn/Q8aSU2yY/DggEIcE6MGtod+KgD6gtUOj6TuFGfcj8Qfz960wBlBOxhrmsf
 GbxcQUFXeJ3ThMZxcE7NEiusA/8s8PM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714105442;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0JvaMID6PhDQc0qy8XNkjJWudq4kyDom5Ojl2nS61s=;
 b=I+FaLPf7xov03itSD2fRa3J+8rs7qBejonxjCCDvYhAEMWYuqMmZ+XqZXINQr+Us4QqAZK
 ZK+8wY0ysfVDI3CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E10F1398B;
 Fri, 26 Apr 2024 04:24:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8gIwGmIsK2aFVAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Apr 2024 04:24:02 +0000
Date: Fri, 26 Apr 2024 06:23:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240426042357.GA325890@pevik>
References: <20240425211042.299714-1-pvorel@suse.cz>
 <20240425211042.299714-2-pvorel@suse.cz>
 <CAEemH2ekBY=-DR0ksjB2SjK6di_9hDpnrE58AA+vwxix0R8chw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ekBY=-DR0ksjB2SjK6di_9hDpnrE58AA+vwxix0R8chw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] libswap: Add {SAFE_,
 }MAKE_SMALL_SWAPFILE() macros
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

Hi Li, all,

...
>  Reviewed-by: Li Wang <liwang@redhat.com>

Merged, thank you for your review!

> ---
> >  include/libswap.h | 18 ++++++++++++++++++
...
> > +/** 65536 bytes is minimum for 64kb page size, let's use 1 MB */
> > +#define MINIMAL_SWAP_SIZE_MB 1
> > +
> > +/**
> > + * Macro to create minimal swapfile.
This could have been done better, e.g.:

@swapfile: swap file name.

But I kept it the same, just to fix broken test. Ands I'm going to send patch
implement it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
