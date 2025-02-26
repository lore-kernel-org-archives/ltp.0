Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878A1C18E7C
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 16:35:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C99CA3C9D1B
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 17:35:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 867FA3C29CB
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:34:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85D271011854
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:34:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4DEB1F79D;
 Wed, 26 Feb 2025 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740587692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8YXnEli0+57pTk2Jj3L2BBBTYM+7XSce+jPzM3Ptp0=;
 b=pUvJrRJZFZZBttuhWrapfOdPDtjkiGUSSZLxCU6tLZ9FXMFiPNEH7Fuk9u9vcVj5a4ctxv
 mPqjffQn1hdkit62VX9FBLr9DnL3in6nGsnAYOeDOxNVSQV/LD7mWnwzrZemceIZrW221K
 WC7zZL/kNs+OgZ/oN9cjGhXqgBaYfd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740587692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8YXnEli0+57pTk2Jj3L2BBBTYM+7XSce+jPzM3Ptp0=;
 b=aw+5uKdH65Q8m8RL2V6d3X4JtUn8PjbcEk/Utf0xH/H1rKslBJOCtyeMg6Dt3dTIlWX28c
 ow0lYBh7zxpRBKDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740587692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8YXnEli0+57pTk2Jj3L2BBBTYM+7XSce+jPzM3Ptp0=;
 b=pUvJrRJZFZZBttuhWrapfOdPDtjkiGUSSZLxCU6tLZ9FXMFiPNEH7Fuk9u9vcVj5a4ctxv
 mPqjffQn1hdkit62VX9FBLr9DnL3in6nGsnAYOeDOxNVSQV/LD7mWnwzrZemceIZrW221K
 WC7zZL/kNs+OgZ/oN9cjGhXqgBaYfd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740587692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y8YXnEli0+57pTk2Jj3L2BBBTYM+7XSce+jPzM3Ptp0=;
 b=aw+5uKdH65Q8m8RL2V6d3X4JtUn8PjbcEk/Utf0xH/H1rKslBJOCtyeMg6Dt3dTIlWX28c
 ow0lYBh7zxpRBKDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9433B1377F;
 Wed, 26 Feb 2025 16:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RFBEI6xCv2f2cAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 26 Feb 2025 16:34:52 +0000
Date: Wed, 26 Feb 2025 17:35:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <Z79CtMlApmlZxcav@yuki.lan>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
 <20250224-conversions-pause-v3-3-5e3989d37f1d@suse.com>
 <D80X6ZHMZ1SX.1KAXYMYMDCHKO@suse.com> <Z788OcCPwPz17CDM@yuki.lan>
 <D82IOHFBAC1P.1DMBD7WPNMXUW@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D82IOHFBAC1P.1DMBD7WPNMXUW@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] syscalls/pause02: Delete duplicated test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Will you also look into increasing the coverage for pause01.c as I
> > described (make it loop over different signals)?
> 
> I gave it a shot here https://lore.kernel.org/all/20250224-conversions-pause-v3-2-5e3989d37f1d@suse.com/
> 
> Is that similar to what you had in mind?

Looks like I missed that one, sorry, merged now, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
