Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A5FC3600C
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 11:05:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 607843CB386
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 13:05:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B67D3CB378
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:05:12 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16379600163
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 13:05:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC6611F38D;
 Tue,  8 Apr 2025 11:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744110309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ty2Bi1lnTki54o9Dg13LNoNZP2ZlcSvjc5T6N/f2vyY=;
 b=Vdiol6Dun4VxI8Q1gnFtyKkMENXDcBDxlY7k7ImqljUt96vyrG6A6Y1EZSSSkkjQiW7k7C
 4dY74P6LmCLJMOP38pFzJXoIHdLi0Nml9tcxZcAkOv6IQmVfAE+x9x1WmmyLoKYARO/mvq
 lDJe0owP8i0rUVBq5HPQmtK0BVqtdBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744110309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ty2Bi1lnTki54o9Dg13LNoNZP2ZlcSvjc5T6N/f2vyY=;
 b=HfK+WGandcx4WvtYAYSYklh+36tlDelsnPkqUpzG2j6A0XMkZuvKgknPTm8YfsRF7DiMhH
 eNW3rdBKLmIMhLDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744110309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ty2Bi1lnTki54o9Dg13LNoNZP2ZlcSvjc5T6N/f2vyY=;
 b=Vdiol6Dun4VxI8Q1gnFtyKkMENXDcBDxlY7k7ImqljUt96vyrG6A6Y1EZSSSkkjQiW7k7C
 4dY74P6LmCLJMOP38pFzJXoIHdLi0Nml9tcxZcAkOv6IQmVfAE+x9x1WmmyLoKYARO/mvq
 lDJe0owP8i0rUVBq5HPQmtK0BVqtdBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744110309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ty2Bi1lnTki54o9Dg13LNoNZP2ZlcSvjc5T6N/f2vyY=;
 b=HfK+WGandcx4WvtYAYSYklh+36tlDelsnPkqUpzG2j6A0XMkZuvKgknPTm8YfsRF7DiMhH
 eNW3rdBKLmIMhLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CE3213A80;
 Tue,  8 Apr 2025 11:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +yleIeUC9WeEAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 08 Apr 2025 11:05:09 +0000
Date: Tue, 8 Apr 2025 13:05:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250408110500.GA180787@pevik>
References: <20250407150133.115790-1-pvorel@suse.cz>
 <20250407150133.115790-4-pvorel@suse.cz>
 <a2197905-94b2-4f84-a19a-fb26b2ff65f4@suse.com>
 <20250408101412.GA174986@pevik>
 <fa9a3fe9-1ea4-4dfa-bc29-9897026e4122@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa9a3fe9-1ea4-4dfa-bc29-9897026e4122@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] doc/Makefile: Allow to create and use .venv
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
Cc: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi,

> On 4/8/25 12:14, Petr Vorel wrote:
> > > > Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > I hope you still agree with this ^. Or shell I wait for your ack?
> Yes, I just meant that you can feel free to stick with the initial idea of
> supporting bash only, so we get rid of the more complex scenario.

Thank you. You reported you're using fish, let's keep that support as well.

Kind regards,
Petr

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
