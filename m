Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D730C5478C
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 13:46:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 946833CF3D4
	for <ltp@archiver.kernel.org>; Fri, 23 Feb 2024 14:46:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 161F53CCD58
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 14:46:17 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5CB351000F71
 for <ltp@lists.linux.it>; Fri, 23 Feb 2024 14:46:17 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AE6921228;
 Fri, 23 Feb 2024 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708695976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xTE7j6PpIGyHIs9G5ODL1dxewnxWlA63UpQc6isn3OU=;
 b=Xs880MqwfJYTY1BMzWl9lnhWEQqOD3SknDyRHWCIQ06154hspD+IXqvzBTmZvqyWS741RQ
 vUwXf+U9mMljmxa4f7UcRPEbSzKpFUK2Lyfg8FdFNA0J/mi7krT0pZND9qXImsqm9anF3H
 IBsJzIE27bTHuoD7NhcpWvpynQJWfi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708695976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xTE7j6PpIGyHIs9G5ODL1dxewnxWlA63UpQc6isn3OU=;
 b=/UQbwZ3KalKx0cCsFwwYFXAh4mUxWDCtr16cgnAD3PHjkINJ2YeO9TDGaZxwIdL8GvfieU
 WMvSVZUMAI8mBBBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708695976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xTE7j6PpIGyHIs9G5ODL1dxewnxWlA63UpQc6isn3OU=;
 b=Xs880MqwfJYTY1BMzWl9lnhWEQqOD3SknDyRHWCIQ06154hspD+IXqvzBTmZvqyWS741RQ
 vUwXf+U9mMljmxa4f7UcRPEbSzKpFUK2Lyfg8FdFNA0J/mi7krT0pZND9qXImsqm9anF3H
 IBsJzIE27bTHuoD7NhcpWvpynQJWfi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708695976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xTE7j6PpIGyHIs9G5ODL1dxewnxWlA63UpQc6isn3OU=;
 b=/UQbwZ3KalKx0cCsFwwYFXAh4mUxWDCtr16cgnAD3PHjkINJ2YeO9TDGaZxwIdL8GvfieU
 WMvSVZUMAI8mBBBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B8D013776;
 Fri, 23 Feb 2024 13:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id or0TGaih2GWvewAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 23 Feb 2024 13:46:16 +0000
Date: Fri, 23 Feb 2024 14:46:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240223134610.GA1463543@pevik>
References: <20240104204614.1426027-1-pvorel@suse.cz>
 <20240104204614.1426027-9-pvorel@suse.cz> <Zdia_NubxCaWWg5q@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zdia_NubxCaWWg5q@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.34 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.84)[85.22%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 8/9] ci/debian: Allow to install packages only for
 docparse
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

Hi Cyril,

> Hi!
> This looks OK, but patch 9/9 seems to be missing from the patchset.

Indeed, I reposted it, but looking your comments there will be v2 anyway :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
