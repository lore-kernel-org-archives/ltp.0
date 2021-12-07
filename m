Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511E3C433F5
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 12:58:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17F5A3C5795
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:58:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 961B23C21F9
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 13:58:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 236DC1A0049E
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 13:58:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37E7A1FDFE;
 Tue,  7 Dec 2021 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638881895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxSGfioTyCCndJbpEnhcOsO+YEGbPLQ3L1XIZgPzhiI=;
 b=c8EijVvCgG5W10+QTEWffn2RYQyVJMjSI9ivEPhTZ/4ENEJVSR+s9nlg1ywVOB9xelSZZI
 uvnIdbR6cabsCh8RFXSXPvzQkbtZ/xf4p0zCbT0nubH0GDHSfIUolXy+WNjTZP9ge0qO0f
 nwm67vJErBe1p5W2Td4wAu5v1zTmZZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638881895;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxSGfioTyCCndJbpEnhcOsO+YEGbPLQ3L1XIZgPzhiI=;
 b=aoQU420WZTWdSuexzAMYHMbYZz/cMwrqRubL+PueYBz2G5HhhTbDhB/iMqavnQ/CX2bxny
 6rYmepTH8RfMenCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E41213A78;
 Tue,  7 Dec 2021 12:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vYPhBmdar2GbPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 07 Dec 2021 12:58:15 +0000
Date: Tue, 7 Dec 2021 13:59:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Ya9as97Bo46XvDtO@yuki>
References: <20211130114527.5942-1-chrubis@suse.cz>
 <20211207125420.32538-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211207125420.32538-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] check: Deprecated API symbols
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
> The old API represents a big source of complication. It invalidates a
> lot of assumptions we can make when writing checks specifically for
> the new API.
> 
> Cyril proposed ignoring these symbols altogether in a previous
> patch. This is a counter proposal to print a warning, but then abandon
> checking the symbol any further.
> 
> The reasoning is that ignoring them altogether might hide errors. Also
> the existence of the old API may be a surprise to new developers. This
> change will alert them that a test needs updating and that it is not
> to be used as a reference.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Sounds good to me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
