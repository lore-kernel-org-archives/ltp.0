Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3457CD6E49
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 16:26:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BBA53E76A4
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 18:26:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8400E3E2034
 for <ltp@lists.linux.it>; Fri, 29 May 2026 18:25:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E98FD6000F6
 for <ltp@lists.linux.it>; Fri, 29 May 2026 18:25:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C69F6739C;
 Fri, 29 May 2026 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780071950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yypKtHbHvt6XehRm/biPg8glYK3GRgrea/2OHDkIM8M=;
 b=gL6POBoui5p0WdvOku8nnggppPr0sL79K/e7QDYHhCQyvWDRqTaNy5FIwV7ezEh3JUcv7K
 I8pX/6IamhQR/wPWCfDu7XQwSbT6k4qaaUVZnGZ4VAmIbNvBacLonpcCW+RRsX8efWdwEc
 ZWJOQ4oMlz118J96o/+nBNGbQcggtQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780071950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yypKtHbHvt6XehRm/biPg8glYK3GRgrea/2OHDkIM8M=;
 b=Xn/19QpiiG/uoy3opGSxtm7q/Y1BaHLYcKSZ5qVAyQoEQpn4fPjbcC1vdS9v1OVnP6FoAd
 c5r2uMx+f8+I5gBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780071950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yypKtHbHvt6XehRm/biPg8glYK3GRgrea/2OHDkIM8M=;
 b=gL6POBoui5p0WdvOku8nnggppPr0sL79K/e7QDYHhCQyvWDRqTaNy5FIwV7ezEh3JUcv7K
 I8pX/6IamhQR/wPWCfDu7XQwSbT6k4qaaUVZnGZ4VAmIbNvBacLonpcCW+RRsX8efWdwEc
 ZWJOQ4oMlz118J96o/+nBNGbQcggtQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780071950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yypKtHbHvt6XehRm/biPg8glYK3GRgrea/2OHDkIM8M=;
 b=Xn/19QpiiG/uoy3opGSxtm7q/Y1BaHLYcKSZ5qVAyQoEQpn4fPjbcC1vdS9v1OVnP6FoAd
 c5r2uMx+f8+I5gBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8D7D779A7;
 Fri, 29 May 2026 16:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l3LBNg2+GWqPdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 29 May 2026 16:25:49 +0000
Date: Fri, 29 May 2026 18:25:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20260529162518.GA294659@pevik>
References: <20260528162920.914321-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260528162920.914321-1-amir73il@gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] fanotify21: fix test failure when running
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

this patch merged, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
