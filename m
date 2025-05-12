Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021EFC3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 13:29:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 852813CC2BA
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 15:29:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 158F53C1A7F
 for <ltp@lists.linux.it>; Mon, 12 May 2025 15:29:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9C3EA600157
 for <ltp@lists.linux.it>; Mon, 12 May 2025 15:29:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 819DF21180;
 Mon, 12 May 2025 13:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747056548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q6GczYTG7qx0A5ij5B/Y5/pHfYAbsfNEwj8Cpx6ZnNM=;
 b=QA5qpDJYIcwmgvDbDl/5GYf5ZpERq3rz6evh0NDPhnJ4vV1qcYsJYoKwfKR1bXPZ8tbguw
 GjFxPfcoyWmy+08OVf0jRY0Nl9PLNO/7V7eNPTxauG9ydl9nOI5y6teRarVO9icP2NjQYm
 2Ee4NKDa4zG5amjsb/7VX2/OG8IuEHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747056548;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q6GczYTG7qx0A5ij5B/Y5/pHfYAbsfNEwj8Cpx6ZnNM=;
 b=talUf8MWv/15ZEN6VamE9+/pzuDUVjjFKDbtsiP3REAjO2mmGk5dIZ7rt+0+rM6y4201s/
 kZn1vJlZ0HpLC6DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747056547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q6GczYTG7qx0A5ij5B/Y5/pHfYAbsfNEwj8Cpx6ZnNM=;
 b=IXokl3xdY3vFMZ6hXhmrD0EdckbDteSgTX/oAMinR9VvEvvAarqUZo32fPrZeD9Dlv1AwL
 A1x4+s1ViGr6IaUC5b9ma0UWT45hsD/JPka1S7w/9x5W2nQwJjbZAUJdlNFi0Ora9asMhq
 8eFlmth//n0Gbn31COvUZBL2SvHVl8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747056547;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q6GczYTG7qx0A5ij5B/Y5/pHfYAbsfNEwj8Cpx6ZnNM=;
 b=5m612y7FVEoTkRMLF2fwpn84aQKH6ny4nesHWba2ksdH9e99CURym1NZQfkIDJDl7GrgbO
 DwnAqwAPyv9ArXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D866137D2;
 Mon, 12 May 2025 13:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +cR0IaL3IWhgKAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 May 2025 13:29:06 +0000
Date: Mon, 12 May 2025 15:28:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250512132856.GA214177@pevik>
References: <20250509113206.59574-1-mdoucha@suse.cz>
 <CAEemH2dAyvezGCmPM_eHz0=SBuFpQVxDxEc83k5_M=jomJ=RsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dAyvezGCmPM_eHz0=SBuFpQVxDxEc83k5_M=jomJ=RsQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmap_24-1: Change vm.max_map_count if needed
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

Hi all,

merged, thank you!
@Li, please merge your follow up fixing comment.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
