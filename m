Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E2FC3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 10:47:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA17B3D1C62
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 12:46:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18D723C60BA
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 12:46:43 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 56904100112F
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 12:46:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A661621981;
 Fri, 26 Jul 2024 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721990801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jvd5y4wcXgaPiLJvo3N4AwT8hhLJE75iBlguWW5eW4=;
 b=PEuS0y8V4YejTMGBBdxbzzabJv1DPqAiVS+40cP2bIsh5eicUoqgXbs1rLwgYUMt7W9uwr
 /Z5dMEQgadzb5joHHaQqn2kkLHjKAGXHdoAt3GZJSzdeyeaPqh08RVVoA5rcoYI9LUpHj2
 +wz5u527rAof9jypZN5/bSo2YdiPEsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721990801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jvd5y4wcXgaPiLJvo3N4AwT8hhLJE75iBlguWW5eW4=;
 b=RAQe8XW/dqoh5Dt2cGL44YuBsmXwLw1Yn1JpBRmeRZlTdYwWKMcV7jFlKssiX1LHEXfG2p
 HyiPi18lCITXzmDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721990801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jvd5y4wcXgaPiLJvo3N4AwT8hhLJE75iBlguWW5eW4=;
 b=PEuS0y8V4YejTMGBBdxbzzabJv1DPqAiVS+40cP2bIsh5eicUoqgXbs1rLwgYUMt7W9uwr
 /Z5dMEQgadzb5joHHaQqn2kkLHjKAGXHdoAt3GZJSzdeyeaPqh08RVVoA5rcoYI9LUpHj2
 +wz5u527rAof9jypZN5/bSo2YdiPEsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721990801;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jvd5y4wcXgaPiLJvo3N4AwT8hhLJE75iBlguWW5eW4=;
 b=RAQe8XW/dqoh5Dt2cGL44YuBsmXwLw1Yn1JpBRmeRZlTdYwWKMcV7jFlKssiX1LHEXfG2p
 HyiPi18lCITXzmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25A2B138A7;
 Fri, 26 Jul 2024 10:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NRaOB5F+o2aQXAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 10:46:41 +0000
Date: Fri, 26 Jul 2024 12:46:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240726104629.GA1063546@pevik>
References: <2a6d16a7-0d43-496a-a6c1-579b9e751254@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2a6d16a7-0d43-496a-a6c1-579b9e751254@suse.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,lists.yoctoproject.org,linaro.org,sony.com,linuxfoundation.org,gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] kirk can be now installed via pip
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
Cc: Tim Orling <ticotimo@gmail.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ maybe more people interested :) ]

> Hi all,

> kirk, our official LTP runner, is now available in pypi.org[1] and it can=
 be
> installed via pip command:

> =A0=A0=A0 pip install kirk

> Have fun!


> Best regards,
> Andrea Cervesato

> [1] https://pypi.org/project/kirk/

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
