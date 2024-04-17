Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1E4C04FFF
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 13:38:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96F2D3CFB9E
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 15:38:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEEF23CFB89
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 15:38:12 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 56F1E1A0C261
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 15:38:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 751D933CF9;
 Wed, 17 Apr 2024 13:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713361091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1V8yL78o8GQngWZr3Trcn5XA17Q14+7OOtjqyCP3WEg=;
 b=2Krw1kuimxVbZk3TEn8GXWmOQ/u4aNhzf8qxG96f1LxuT5UOtZJ8J8YMrtZIAKAu8xfejg
 mx3GNnwZ9TMANfwYaDMLtMOmRLYEzWCbOyIeLausPA0U377F4CBcRmwWmtR0MOHgolnJ1P
 qQLYEXUhOoBdscBEFiz1rPeNhBG5fZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713361091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1V8yL78o8GQngWZr3Trcn5XA17Q14+7OOtjqyCP3WEg=;
 b=OGpCSXe663/f8eQhi0ORlFp4/jISOVOUNEqAzo1JrbWZfFrOSamuwTntB2Y5BHaE9yrU+d
 DXmxfwpn6S/GsrDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713361091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1V8yL78o8GQngWZr3Trcn5XA17Q14+7OOtjqyCP3WEg=;
 b=2Krw1kuimxVbZk3TEn8GXWmOQ/u4aNhzf8qxG96f1LxuT5UOtZJ8J8YMrtZIAKAu8xfejg
 mx3GNnwZ9TMANfwYaDMLtMOmRLYEzWCbOyIeLausPA0U377F4CBcRmwWmtR0MOHgolnJ1P
 qQLYEXUhOoBdscBEFiz1rPeNhBG5fZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713361091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1V8yL78o8GQngWZr3Trcn5XA17Q14+7OOtjqyCP3WEg=;
 b=OGpCSXe663/f8eQhi0ORlFp4/jISOVOUNEqAzo1JrbWZfFrOSamuwTntB2Y5BHaE9yrU+d
 DXmxfwpn6S/GsrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6630613957;
 Wed, 17 Apr 2024 13:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xDnhF8PQH2byNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Apr 2024 13:38:11 +0000
Date: Wed, 17 Apr 2024 15:37:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zh_QlPB2Sjo-kUAN@yuki>
References: <20240417101201.715518-1-pvorel@suse.cz> <Zh-lvOimOYLd2Z4H@yuki>
 <20240417121910.GA727397@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240417121910.GA727397@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: documentation: Fix typo other => older
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> BTW how does these spellchecker feature in sphinx works? Did you find it to run something
> (tox -e spelling -r [1] or did you spot it manually?

You have to run make spelling as described in the documentation.

> I hoped that errors like this would be caught, e.g. we might want to have CI
> check for it, right?

The problem is that there are false possitives, so we can't simply plug
it into a CI as it is now.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
