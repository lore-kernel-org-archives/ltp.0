Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739E7CAC5A8
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 13:28:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2FB33CDE73
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 15:28:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB4B93C6EF3
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 15:28:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4E2BD200051
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 15:28:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 621D53369C;
 Mon, 22 Sep 2025 13:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758547710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAe7q7ZDuJyu4i7HdbI33glZFuD+yTCpNs1dzdmRrN0=;
 b=IxiPKmVgZkXBmhAGcUOriPvD9MT18i4F2KLzTOmcD7XBVc/P6WSujPyqWDYYvENLCxtlsZ
 1lSF2dHmXO9bYnusHT/a+Xmb/HjQJVKA4s6VDylcYhHHHt7lVRvgOpMr4DNstqdosi71A9
 GLeR408vIbKddk+pgj3q6blbrQRjr1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758547710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAe7q7ZDuJyu4i7HdbI33glZFuD+yTCpNs1dzdmRrN0=;
 b=ByASkTqmN0VmJE0Y3Ajpxg1EAB4nvVvQdPncFEMouZxS3wF3BsrTW4DG642vin+Ny5DbH0
 RMllgaJvUE4SC8Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758547710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAe7q7ZDuJyu4i7HdbI33glZFuD+yTCpNs1dzdmRrN0=;
 b=IxiPKmVgZkXBmhAGcUOriPvD9MT18i4F2KLzTOmcD7XBVc/P6WSujPyqWDYYvENLCxtlsZ
 1lSF2dHmXO9bYnusHT/a+Xmb/HjQJVKA4s6VDylcYhHHHt7lVRvgOpMr4DNstqdosi71A9
 GLeR408vIbKddk+pgj3q6blbrQRjr1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758547710;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAe7q7ZDuJyu4i7HdbI33glZFuD+yTCpNs1dzdmRrN0=;
 b=ByASkTqmN0VmJE0Y3Ajpxg1EAB4nvVvQdPncFEMouZxS3wF3BsrTW4DG642vin+Ny5DbH0
 RMllgaJvUE4SC8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F31F1388C;
 Mon, 22 Sep 2025 13:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qs6fCf5O0WjXeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Sep 2025 13:28:30 +0000
Date: Mon, 22 Sep 2025 15:28:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250922132828.GA38024@pevik>
References: <20250922-kirk_2-3-v1-1-af3fc729bbdf@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250922-kirk_2-3-v1-1-af3fc729bbdf@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: upgrade to v2.3
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

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks!

Please merge, so that people have time to test it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
