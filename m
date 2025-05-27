Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555FEC54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:33:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F055B3C59ED
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:33:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64B643C5502
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:32:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E320E1A00A34
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:32:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2799A21ED2;
 Tue, 27 May 2025 09:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748338377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAcLGaVpZAaeoOgDn6wXmEllVL6BIfThP4XVCFDnjxI=;
 b=Er8/n/Xtn/FcasvHMUNICpvnFUjug/RSV9SuX3l+piCVMqt7m1ufkXXw6rKIDrirA/cqXJ
 Imzq2HQD6Osd5zgUQIkqzOeN4P6oydzmGpXpZCehBa3zGzUuuph40i2YcadoBVDE7JZauZ
 L/ju5teyFbTKgWM0wYc9+ap2/wplTHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748338377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAcLGaVpZAaeoOgDn6wXmEllVL6BIfThP4XVCFDnjxI=;
 b=RgMrQ4dzK3pbLf48jcVWbB3vHwWeas1Go7xz9vpIK3+aplz1JP279Oc3BBa3PDkQR4Ex8A
 y2ZsINlxuvQRLrAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748338377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAcLGaVpZAaeoOgDn6wXmEllVL6BIfThP4XVCFDnjxI=;
 b=Er8/n/Xtn/FcasvHMUNICpvnFUjug/RSV9SuX3l+piCVMqt7m1ufkXXw6rKIDrirA/cqXJ
 Imzq2HQD6Osd5zgUQIkqzOeN4P6oydzmGpXpZCehBa3zGzUuuph40i2YcadoBVDE7JZauZ
 L/ju5teyFbTKgWM0wYc9+ap2/wplTHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748338377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XAcLGaVpZAaeoOgDn6wXmEllVL6BIfThP4XVCFDnjxI=;
 b=RgMrQ4dzK3pbLf48jcVWbB3vHwWeas1Go7xz9vpIK3+aplz1JP279Oc3BBa3PDkQR4Ex8A
 y2ZsINlxuvQRLrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C62A136E0;
 Tue, 27 May 2025 09:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TPpIAcmGNWiZWQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 27 May 2025 09:32:57 +0000
Date: Tue, 27 May 2025 11:33:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aDWG5H2WmHvh7Rdk@yuki.lan>
References: <aBSURzY2zu2HGI2x@yuki.lan>
 <bd003583-648c-4793-866f-01b07e46b85d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bd003583-648c-4793-866f-01b07e46b85d@suse.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
> kirk will need to be updated as well to v2.1:
> 
> https://github.com/linux-test-project/kirk/releases/tag/v2.1

Send a patch then, so that we can merge that.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
