Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0017C47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 09:42:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFA193CE30B
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 10:42:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58EBA3CC959
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:41:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BAC8D608A83
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 10:41:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9545921FCE;
 Wed, 17 Jan 2024 09:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705484511;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/0Sdu71aJlQxUQzOsLJjLPGYDDf135LkZR+VNZkZP4=;
 b=xrxGEgfQ5c2BkTlsmd9AffEhMKQRVjcN8/InkJa/eJu86iw4oQm1pMMLimUDTGG1UDLlNb
 Q7H+0O2e6fyrVt+HWKn3TIvkOVSnVh9mjsCpqzkiPXBdL5jIppv/MmWPhUhPOBVAKoPFTY
 T34RimUeEeVT1YZq9iFcQxbnH0Ofuzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705484511;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/0Sdu71aJlQxUQzOsLJjLPGYDDf135LkZR+VNZkZP4=;
 b=m6DaevjJQWLw5yHcFttvaXh/Lq5YS3IBdiN8u4mLNCuCL2LSiPN7M4YFJXHKd5yIzaYQu5
 ktosGKfrjmIdhgDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705484511;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/0Sdu71aJlQxUQzOsLJjLPGYDDf135LkZR+VNZkZP4=;
 b=xrxGEgfQ5c2BkTlsmd9AffEhMKQRVjcN8/InkJa/eJu86iw4oQm1pMMLimUDTGG1UDLlNb
 Q7H+0O2e6fyrVt+HWKn3TIvkOVSnVh9mjsCpqzkiPXBdL5jIppv/MmWPhUhPOBVAKoPFTY
 T34RimUeEeVT1YZq9iFcQxbnH0Ofuzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705484511;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/0Sdu71aJlQxUQzOsLJjLPGYDDf135LkZR+VNZkZP4=;
 b=m6DaevjJQWLw5yHcFttvaXh/Lq5YS3IBdiN8u4mLNCuCL2LSiPN7M4YFJXHKd5yIzaYQu5
 ktosGKfrjmIdhgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C201137EB;
 Wed, 17 Jan 2024 09:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aeSbD9+gp2XOIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 09:41:51 +0000
Date: Wed, 17 Jan 2024 10:41:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ice_yangxiao@163.com
Message-ID: <20240117094149.GD2665992@pevik>
References: <20240113144940.133746-1-ice_yangxiao@163.com>
 <20240113144940.133746-2-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240113144940.133746-2-ice_yangxiao@163.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.14 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FREEMAIL_ENVRCPT(0.00)[163.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.982]; FREEMAIL_TO(0.00)[163.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.64)[82.49%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/pwritev: Make make check happy
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

Hi Xiao Yang,

Thanks for this cleanup.

Here it applies the same to previous patch:

* use docparse.
* mention relicense in git commit message.
* I vote for adding also LTP copyright (sources were modified by more people)

Or, maybe docparse change can be in separate commit from license + other
checkpatch warning cleanup.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
