Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DE1C44501
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:36:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87B7B3E5CC7
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:36:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 617B53C17CE
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:36:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9BFF81A006E0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:36:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42CAF77472;
 Mon, 13 Jul 2026 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783942564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmcCL69v+Oe4WFfzayqMn1N4+7GUZM4be63lLIsP3hA=;
 b=RMiFgLr7i02gYLmcCCN3Al+YHhmlUIdZ8db1PsaLCANrMUdcxBZf+/NTtiEHJIMxK6maPL
 v75z1SBKTEOrx6qasay9wawuMxxkWOhT52TdOIjXQzrnS/b5832TvqDefXm86Gdlwo+6Yv
 YKkOUASfWqUtv3YKFua2SP+t+Y8peDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783942564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmcCL69v+Oe4WFfzayqMn1N4+7GUZM4be63lLIsP3hA=;
 b=/niClBMk7L8gEnI3Ybb4JGDUPvN2H/Af4Qe7ZUjPLdMchfpb3fJO7XJOUPY8fe8Kkclo2t
 YIJjKYfp/IJxloBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783942564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmcCL69v+Oe4WFfzayqMn1N4+7GUZM4be63lLIsP3hA=;
 b=RMiFgLr7i02gYLmcCCN3Al+YHhmlUIdZ8db1PsaLCANrMUdcxBZf+/NTtiEHJIMxK6maPL
 v75z1SBKTEOrx6qasay9wawuMxxkWOhT52TdOIjXQzrnS/b5832TvqDefXm86Gdlwo+6Yv
 YKkOUASfWqUtv3YKFua2SP+t+Y8peDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783942564;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zmcCL69v+Oe4WFfzayqMn1N4+7GUZM4be63lLIsP3hA=;
 b=/niClBMk7L8gEnI3Ybb4JGDUPvN2H/Af4Qe7ZUjPLdMchfpb3fJO7XJOUPY8fe8Kkclo2t
 YIJjKYfp/IJxloBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15401779AE;
 Mon, 13 Jul 2026 11:36:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5oKNAqTNVGq+egAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jul 2026 11:36:04 +0000
Date: Mon, 13 Jul 2026 13:36:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260713113602.GA224249@pevik>
References: <20260706-fix_make_check_landlock-v2-1-4949150d17e4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260706-fix_make_check_landlock-v2-1-4949150d17e4@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] landlock: fix make check warnings/errors
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Thanks for your effort!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

https://lore.kernel.org/ltp/20260706200306.3982-1-linuxtestproject.agent@gmail.com/
Also, it'd be nice to teach the agent that splitting string into multiline
comments is worse than long lines.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
