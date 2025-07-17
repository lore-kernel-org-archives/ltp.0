Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DBDC83F34
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 15:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6D7D3CC38E
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 17:38:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2D783CC200
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 17:37:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0406A600ABE
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 17:37:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D4CC21AAC;
 Thu, 17 Jul 2025 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752766664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROYaG3/Q0ndVXQzrIsVT/rfsIcURQ9qKlVzX/jWyCtk=;
 b=mPpqi3rloNOsBP2uq/GExqLF8nCXanqqGENZBguhFJRDyKl4L+ibUjMseHXX+S4D7tGHfX
 CDC/28XiAUMBOwktHzRABi8NgN7GGbyAT5UFbDOgZ/kWyIEYGhFgAyzXOquxykEjbceIe7
 m3fIyIkTkRCmkfzWd4033gopcbEN/Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752766664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROYaG3/Q0ndVXQzrIsVT/rfsIcURQ9qKlVzX/jWyCtk=;
 b=KpDJuileWw+fGLMKEOAQw6+FhcL6PKLUUa2adCUgwRIYDIBG8W9yi/NPtbyQCJyK/GMrIQ
 ofsPq1ApkEHhG/Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752766664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROYaG3/Q0ndVXQzrIsVT/rfsIcURQ9qKlVzX/jWyCtk=;
 b=mPpqi3rloNOsBP2uq/GExqLF8nCXanqqGENZBguhFJRDyKl4L+ibUjMseHXX+S4D7tGHfX
 CDC/28XiAUMBOwktHzRABi8NgN7GGbyAT5UFbDOgZ/kWyIEYGhFgAyzXOquxykEjbceIe7
 m3fIyIkTkRCmkfzWd4033gopcbEN/Vc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752766664;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ROYaG3/Q0ndVXQzrIsVT/rfsIcURQ9qKlVzX/jWyCtk=;
 b=KpDJuileWw+fGLMKEOAQw6+FhcL6PKLUUa2adCUgwRIYDIBG8W9yi/NPtbyQCJyK/GMrIQ
 ofsPq1ApkEHhG/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52C6313A6C;
 Thu, 17 Jul 2025 15:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0XRfE8gYeWiVRwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 17 Jul 2025 15:37:44 +0000
Date: Thu, 17 Jul 2025 17:38:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aHkY8lMBYtRcX41Z@yuki.lan>
References: <20250609124506.1454420-1-pvorel@suse.cz>
 <20250609124506.1454420-4-pvorel@suse.cz>
 <CAEemH2coV_yJM5Kg5JN9FVqx6b=_CLTLzhCtCfCwqHnP-_j=yA@mail.gmail.com>
 <20250717102611.GA905840@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250717102611.GA905840@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] shell lib: Add basic support for test setup
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
> @Cyril any more feedback before I'll send a new version (v4)?

No I don't have any.

It took me a while to remmeber and re-read why we have chosen to do
things as we do though...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
