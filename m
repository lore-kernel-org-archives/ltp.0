Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0825C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 07:59:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47B173CE7C6
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 08:59:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3EFB3CB0B0
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 08:59:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48D47600B27
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 08:59:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31AC51F794;
 Wed,  3 Jan 2024 07:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704268766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+XgaVZhEtaaw71eJX+qMxtn9jHEUYxgF/derp86AW4=;
 b=rl0lataFPHqkUio9e5ekLXx/w262FSKIJgFL1WcabP++IkhBO1ahFHvovoEr0nxmqHwFmq
 NZciqrme8szOzS9eND5ajlawumGwyfmsEnQyX47/50ce0SuJeLH+akUHlycLuhbiDy88lf
 lkgjvg/dRN7mHIuEqdfUCp/gHVK4NoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704268766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+XgaVZhEtaaw71eJX+qMxtn9jHEUYxgF/derp86AW4=;
 b=5Xx/gzVBU6veHB+iKV38MqSgwtbdF+BH7l9XkLoA8lN9k7TLNKhTRyRDTOJFOH3PxUjwHC
 +Lw65Uc8PNV/KDDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704268765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+XgaVZhEtaaw71eJX+qMxtn9jHEUYxgF/derp86AW4=;
 b=PBRI/Ri2F/WXSJwjqaZbJNvD8BwU9WH44v1xxV+OxYpbuMn36fRf/fkIXwtPOhWRAWovvu
 WxiEmeP1diXGGpd0kCNeN4Hx/Ffz3+gi2oWjPGJ5cQAK23omsGJqLt+zSk4hx4gx/Pf0E/
 kKyZz8PChHrN/Lm6D3VsK8V3CjJmR9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704268765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+XgaVZhEtaaw71eJX+qMxtn9jHEUYxgF/derp86AW4=;
 b=Xx7QSCiPzC/NCSJzO38a0IrhSJv3Z8StejhPiO829nqo/zyo4D3Pcdro9w1OZQVKlqAG5U
 RmxIVpeAQSOfrVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AF3813AA6;
 Wed,  3 Jan 2024 07:59:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ruxGBt0TlWWwVgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 07:59:25 +0000
Date: Wed, 3 Jan 2024 08:58:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZZUTsDX8bKPimLgD@rei>
References: <20240103015240.1065284-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240103015240.1065284-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.76 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[12];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.16)[69.10%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/36] Remove UCLINUX from LTP
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
Cc: Jonathan Corbet <corbet@lwn.net>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> UCLINUX is broken in LTP and nobody really cares. Actually I dare to
> say UCLINUX is dead. Therefore I prepared patchset to remove UCLINUX
> from LTP. We have been actively removing UCLINUX from LTP during rewrite
> tests to new LTP API. This removes the rest from the old tests (which
> will be sooner or later rewritten to new API).
> 
> Because the patchset is quite big, I did not want to send it to mailing
> lists (but I can do it if you want).

I agree that this should be done, but I'm not sure if we want to get
this in before the January release. I guess that such change would be
safer to merge just after the release so that we have a few months to
actually catch possible problems.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
