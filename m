Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE06C25B10
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 21:31:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D61F3CDA86
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 23:31:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61E1E3C0311
 for <ltp@lists.linux.it>; Mon,  6 May 2024 23:31:29 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 53D7165192C
 for <ltp@lists.linux.it>; Mon,  6 May 2024 23:31:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6408A2295D;
 Mon,  6 May 2024 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715031087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlkXP8zOhROkHPIj4bxLsc/0jApIzJ53iP4aZY5PGRA=;
 b=xZUj+ZCofxcxNYKtIuIHouVQ50fJLmJpyM2XzD6kF9n7dKzmkpY/d7ygMDrUAPgntnEpyy
 EbrfaWsqFNbEHKItC8XquNVFo4GBzTxB8Ck3ONghGkRDHhUbPCnPBcjPDfExZl50TT2taL
 WhQkViz2TXNqNOmO0tqmfRu+A4YBs/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715031087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlkXP8zOhROkHPIj4bxLsc/0jApIzJ53iP4aZY5PGRA=;
 b=3KdonEQLerHRECzZ4l+d+d9yDj6l7p9NqXx5YHXikO3vlfk9SBZvOc+LeWl4zYIXbRgLKd
 8PTZqIT+8y/go3Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715031086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlkXP8zOhROkHPIj4bxLsc/0jApIzJ53iP4aZY5PGRA=;
 b=UWD1K5OZ6C3UcNCmabXSZDf5OZ7G8fr3B30xokU8xBlNpz9a/mXbS3oDPf9+oPzp6t5xuK
 0611VHRXt6q7sxK0fRmg5AH2hUHAHBo4g7Xuv9BiCIBMzdKgg9GscoaKbAjRlm+2VZcwAb
 3d4VkDBMbz61IbmMLYhjeh1Tiifu+kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715031086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dlkXP8zOhROkHPIj4bxLsc/0jApIzJ53iP4aZY5PGRA=;
 b=RgEm90uOXYOY2JxenSg+UrTNWs2MppILuju9kycWYt8fFCAhPSVABNG1mXNHHXvYjZ/hc2
 0u0ZtrdGNn39ctAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E28213A25;
 Mon,  6 May 2024 21:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1fObCS5MOWYadgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 May 2024 21:31:26 +0000
Date: Mon, 6 May 2024 23:31:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240506213124.GA71396@pevik>
References: <20240325115034.643892-1-pvorel@suse.cz>
 <20240325115034.643892-2-pvorel@suse.cz>
 <7de3ea33-b6ea-4361-9303-a34d831ada4f@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7de3ea33-b6ea-4361-9303-a34d831ada4f@suse.cz>
X-Spamd-Result: default: False [-7.40 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-2.90)[99.55%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] lib/tst_tmpdir: Normalize user defined
 TMPDIR
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

Hi Martin,

> Hi,
> I don't like the approach of directly modifying the process environment.
> Also, if TMPDIR variable is not set, the newly added strdup() will lead to a
> memory leak because the function is called multiple times.

> I recommend adding a static pointer that'll hold the cleaned up path and the
> string cleanup will run only once on the first call. Then the pointer will
> be free()d during library cleanup.

Good, point, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
