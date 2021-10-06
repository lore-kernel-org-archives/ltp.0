Return-Path: <SRS0=CJzs=O2=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A0BC433EF
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 18:45:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B79161151
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 18:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B79161151
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 911C73C9F6C
	for <ltp@archiver.kernel.org>; Wed,  6 Oct 2021 20:44:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD2123C663F
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 20:44:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3F398140052D
 for <ltp@lists.linux.it>; Wed,  6 Oct 2021 20:44:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BCC01FEF6;
 Wed,  6 Oct 2021 18:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633545886;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDmbrCKhWwX6iqiVBjbdelCjcM/jh9fKGuFPUIDf9b4=;
 b=ebNepZCH4VAzSKdOq0i0cVISdF2uJopLpI34hE81H9pU6GyZZcC9lWCxKEEDmADhZQjNc4
 vaGtDH51gGEgjXLIZ53XVLpZZAxdsfS17lnst44KiN8wUPF/5dciItNORlfjKn7d/cFmIs
 pZwkyv1bUl8XQMjW3vb+YL/X7dpYMRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633545886;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDmbrCKhWwX6iqiVBjbdelCjcM/jh9fKGuFPUIDf9b4=;
 b=htNducp8gFoCVn1/pVYIvz0aYSp1MaqCkLCUwEQfK7lkhXV7xR3id1JWSmYb1i2xkhudEx
 W0vRsyXPfocq7KAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F7DE13E68;
 Wed,  6 Oct 2021 18:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VSf9AZ7uXWGdfAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 06 Oct 2021 18:44:46 +0000
Date: Wed, 6 Oct 2021 20:44:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YV3unO2KOG5sfxSK@pevik>
References: <20211004084015.16100-1-pvorel@suse.cz>
 <YV2iuKQyO/ZhpqoW@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YV2iuKQyO/ZhpqoW@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] setgroups03: Fix running more iterations
 (-i 2)
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

> Hi!
> > +	ltpuser = SAFE_GETPWNAM(cleanup, uid);
> > +	SAFE_SETEUID(cleanup, ltpuser->pw_uid);

> Can we please push the GETPWNAM() to the test setup and pass only uid to
> the test setup functions?
Ah, sure, sorry for overlooking obvious improvement.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
