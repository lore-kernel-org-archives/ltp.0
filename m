Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93913C3DA7F
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 10:26:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 126783D21BC
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 12:26:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 293EE3D20B5
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 12:26:04 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=schwab@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7DD0C200774
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 12:26:02 +0200 (CEST)
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:92b1:1cff:fe69:ddc])
 by smtp-out2.suse.de (Postfix) with ESMTP id BE7EF1FFEA;
 Thu, 15 Aug 2024 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723717562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+W5bLMqfiFrdINX5gaEO8YLdIItfSdUFZil9Dunp9Tw=;
 b=m2v/k3zVYs0LgI77+xMNFCaoh88AcHgufUTRaJy38q6zg+w5iWSMSPi6CCUt2tibnTQRmh
 cj0mVYGnocFOf9ZcChOtcSaEIHN+Pr/Z4zcXbvGfInkLyFec6LmrCOCaOx2eTQsN8TGaS7
 hDp2HrW7cjk3j8sJwwQKjMnpH7CSIG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723717562;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+W5bLMqfiFrdINX5gaEO8YLdIItfSdUFZil9Dunp9Tw=;
 b=0kohWEAbI2lMHO/5Co4l0f5D0AjviUAkcwfRGv5w9p+BE0vw3d6h1axB5WpAlb9/Q67D2k
 KqCPE02EAFWY42Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G7JhjejK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LADiq3gs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723717561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+W5bLMqfiFrdINX5gaEO8YLdIItfSdUFZil9Dunp9Tw=;
 b=G7JhjejKNTCJX34oqHTzZldzMtWJ/IAb0M6fVZUwnf+xOo9ypgJI5qBhlnbz9MAImnqQiH
 I8hoGk+x4hirjr/+M06alzkiOepl8LMD6UmE+Fs3i3G8Txyo9DX2pzd6TM80eL5Qogv5MD
 tBGtxiO5jOtAbme+bmqyMZnFHH+R9eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723717561;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+W5bLMqfiFrdINX5gaEO8YLdIItfSdUFZil9Dunp9Tw=;
 b=LADiq3gs070trcn5o93mgMBaTRfLDKJUKXxlxIlQOcfrmRwi1Llk582klNNPAjkW9ULBxD
 X3S692icxYCXY7Cw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 943814A04EA; Thu, 15 Aug 2024 12:26:01 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Petr Vorel <pvorel@suse.cz>
In-Reply-To: <20240815101535.GA446806@pevik> (Petr Vorel's message of "Thu, 15
 Aug 2024 12:15:35 +0200")
References: <mvm34n6aziu.fsf@suse.de> <20240815101535.GA446806@pevik>
X-Yow: HELLO, little boys!   Gimme a MINT TULIP!!  Let's do the BOSSA NOVA!!
Date: Thu, 15 Aug 2024 12:26:01 +0200
Message-ID: <mvmy14y9j5y.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Spamd-Bar: /
X-Rspamd-Queue-Id: BE7EF1FFEA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.74 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; RDNS_NONE(2.00)[];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; ONCE_RECEIVED(1.20)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; RCVD_NO_TLS_LAST(0.10)[];
 NEURAL_HAM_SHORT(-0.05)[-0.265]; MX_GOOD(-0.01)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/perf_event_open01: Allow EINVAL
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

On Aug 15 2024, Petr Vorel wrote:

> Out of curiosity, what are you fixing?

perf_event_open01    1  TFAIL  :  perf_event_open01.c:156: perf_event_open PERF_COUNT_HW_INSTRUCTIONS failed unexpectedly: TEST_ERRNO=EINVAL(22): Invalid argument

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
