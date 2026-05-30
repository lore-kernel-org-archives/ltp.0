Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41FCCD5BD0
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 11:27:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E5F53E48FA
	for <ltp@archiver.kernel.org>; Sat, 30 May 2026 13:27:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA9123CD545
 for <ltp@lists.linux.it>; Sat, 30 May 2026 13:27:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A3B8A600543
 for <ltp@lists.linux.it>; Sat, 30 May 2026 13:26:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBD546B7D6;
 Sat, 30 May 2026 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780140418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IkeXh1ws8Enzydtvl2FGDFYehBnur34FmjcJPRUiKwU=;
 b=BmI44+ArTkbBF0lFg0OYaOHZHn11IdAbSKFUdRzslA6oOpxn9R/LfydtnjoPCNdjeTcsQy
 SkEBf+0hsWV3i4qTd28jbgzPzpcs6TQK0xo181AMH55HUypwb/jY3Rn+1h2d87kmlFwXbQ
 221mf1QGya7nlT89WFTUvyBo0PordOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780140418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IkeXh1ws8Enzydtvl2FGDFYehBnur34FmjcJPRUiKwU=;
 b=Apas8WtsO43D5GpmSVaYlCadw65pvvDYxVXwEHgL5A73G1VQGGKWwvRrvn7QeMtXEvK+Yh
 z9TC92rtU20XRsBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780140418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IkeXh1ws8Enzydtvl2FGDFYehBnur34FmjcJPRUiKwU=;
 b=BmI44+ArTkbBF0lFg0OYaOHZHn11IdAbSKFUdRzslA6oOpxn9R/LfydtnjoPCNdjeTcsQy
 SkEBf+0hsWV3i4qTd28jbgzPzpcs6TQK0xo181AMH55HUypwb/jY3Rn+1h2d87kmlFwXbQ
 221mf1QGya7nlT89WFTUvyBo0PordOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780140418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IkeXh1ws8Enzydtvl2FGDFYehBnur34FmjcJPRUiKwU=;
 b=Apas8WtsO43D5GpmSVaYlCadw65pvvDYxVXwEHgL5A73G1VQGGKWwvRrvn7QeMtXEvK+Yh
 z9TC92rtU20XRsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE3BF779A7;
 Sat, 30 May 2026 11:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cA/8LYLJGmqXLgAAD6G6ig
 (envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:26:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 67A58A0EBD; Sat, 30 May 2026 13:26:58 +0200 (CEST)
Date: Sat, 30 May 2026 13:26:58 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <dfdpcyeo256ewdiylwklfacoy66rxiqlweisk7bpy6am7t2coj@dghyotveymbk>
References: <20260528151938.909301-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260528151938.909301-1-amir73il@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_LAST(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify13: fix test failure when running
 iterations
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 28-05-26 17:19:37, Amir Goldstein wrote:
> The test case for FAN_SELETE_SELF deletes the objects created in
> do_setup() so we need to re-create them for the next iteration.
> 
> This bring up a problem with ext2 and filesystem that do not support
> RENAME_EXCHANGE because overlayfs fails to re-create objects over a
> whiteout.
> 
> It is generally not interesting to test overlayfs over such base fs,
> but for now, let just exclude this type of base fs from the delete
> self event test case.
> 
> Reported-by: AnonymeMeow <anonymemeow@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/20260527195056.337081-1-anonymemeow@gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Petr,
> 
> The basic fix is taken from AnonymeMeow's patch.
> 
> I applied a skip instead of fix for the issue with test_variant 3 on
> ext2 base fs.

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One typo fix below:

> +#define TST_VARINAT_OVL_LOWER (tst_variant & 1)
		^^^^ typo here

> +#define TST_VARIANT_OVL_WATCH (tst_variant > 2)
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
