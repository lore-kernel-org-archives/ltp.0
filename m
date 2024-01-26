Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25291C47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 10:46:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68A4E3D00E2
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 11:46:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FA8C3CFAE3
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:46:04 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4652514098B6
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:46:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FE0821F6B;
 Fri, 26 Jan 2024 10:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706265962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JoZJvWG0l36eLheLMRHkfxKrPJDMZls87AcGCgnaUM=;
 b=kneWK0tFLZnhtegaMx8AqevFJRXSHbGl0ehF5Wbvlqo+R3v90voaDLN9noTCDM0rP9Ky+t
 DM56S1xa4dyN6Ys9J38+bwsRLwOGdQ6AVAVesQnv+Joiji+t/yn6dxERLDUcWOYaMeJ/xP
 ipxoFqPjAQ3ub7+CPv0CTJeAYM+q0nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706265962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JoZJvWG0l36eLheLMRHkfxKrPJDMZls87AcGCgnaUM=;
 b=Z2O/nihvrv2owE5vbpEdnu9wG1XKEo3kBq9ndk+N/++J6L/YYDI006q6CigfARO/ByftGh
 U/v4H0KcqywYvyDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706265962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JoZJvWG0l36eLheLMRHkfxKrPJDMZls87AcGCgnaUM=;
 b=kneWK0tFLZnhtegaMx8AqevFJRXSHbGl0ehF5Wbvlqo+R3v90voaDLN9noTCDM0rP9Ky+t
 DM56S1xa4dyN6Ys9J38+bwsRLwOGdQ6AVAVesQnv+Joiji+t/yn6dxERLDUcWOYaMeJ/xP
 ipxoFqPjAQ3ub7+CPv0CTJeAYM+q0nQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706265962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JoZJvWG0l36eLheLMRHkfxKrPJDMZls87AcGCgnaUM=;
 b=Z2O/nihvrv2owE5vbpEdnu9wG1XKEo3kBq9ndk+N/++J6L/YYDI006q6CigfARO/ByftGh
 U/v4H0KcqywYvyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2019B13A22;
 Fri, 26 Jan 2024 10:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vdsFB2qNs2UCJwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Jan 2024 10:46:02 +0000
Date: Fri, 26 Jan 2024 11:46:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZbONeGI3wsV3kSAr@yuki>
References: <20240124044548.2652626-1-liwang@redhat.com>
 <20240124192251.GB333483@pevik>
 <CAEemH2furScb5PPAFEK+Vq0xyF21B6OekqT-infZDByKUnUe3Q@mail.gmail.com>
 <ZbOD_yAeaj0fRFgW@yuki>
 <CAEemH2evCmByMS7GrrXmO2SeQm71Lxn7qQSE1S6Mnj_HCjr_NA@mail.gmail.com>
 <20240126103916.GA467134@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240126103916.GA467134@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.38 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.02)[54.56%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V4 0/6] improvement work on libswap library
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
> > But you're right, I can wait until the new release.
> 
> ack. BTW do we tag on Monday?

I hope so, we stil have the splice07 to solve I suppose.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
