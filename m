Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C5AC25B10
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 13:35:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 645C03CE20E
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 15:35:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E3963CE1F0
 for <ltp@lists.linux.it>; Thu,  9 May 2024 15:35:15 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D55CD14011AA
 for <ltp@lists.linux.it>; Thu,  9 May 2024 15:35:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32E1B60070;
 Thu,  9 May 2024 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715261707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64cmaNyPp4WBM02Sap7RERyVjspsCY7+/PePobpHGzQ=;
 b=xTbM90hNk0qKsTGdSpbpDPdx9u1rvQzAxQVWAVGVBjgjuntWRnPyPvoEbCDIXkfHbuZxtX
 FeiiWq9MvqKO0PUwPADncT18+xXuFNfhwr/+RsmvZGiuZZpAVAUKTVuDVy8ZiNqs+ZQapV
 YOzPcIlIYzVXZHopJzsKicmsYqvcmEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715261707;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64cmaNyPp4WBM02Sap7RERyVjspsCY7+/PePobpHGzQ=;
 b=Gjs/vTFL+CpcZXYm+E3dQB/0vpPeOfQSbIEYJCXkCFXEdut79lXOkSNn7dzjIkDRCkM4bu
 7b96qtW+yC6kk+Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715261703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64cmaNyPp4WBM02Sap7RERyVjspsCY7+/PePobpHGzQ=;
 b=eD0pR2pwEFjpWmA86ivnAY3OWQWXu+ArDxvYA/w3/lOUSck07jYwsbvLZ2xNi1Htsw9JQu
 uUMsiVtAZsuZBNB1pdvtkTfwbHO9GOHUyEiV88jGtZ0KM5D4QVFyAgnkJ4LGn8YkWiRima
 eW2l4bUHZrB2YSqU34Vjt6ENBnsR/hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715261703;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64cmaNyPp4WBM02Sap7RERyVjspsCY7+/PePobpHGzQ=;
 b=tNTi+mOYfQkw7G4IOzDg5syyUa5dc85xx8QqbRl988Prr71+1H1LDl6iF69REtpUqJ+lt9
 ZY9jCqNvVfMnTbDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05AEB13941;
 Thu,  9 May 2024 13:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id i9BKAALRPGb7cgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 13:34:58 +0000
Date: Thu, 9 May 2024 15:34:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240509133456.GA292786@pevik>
References: <20240419124221.207445-1-pvorel@suse.cz>
 <20240419124221.207445-2-pvorel@suse.cz> <Zjyfukg9pEwAb4aP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zjyfukg9pEwAb4aP@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[];
 RSPAMD_EMAILBL_FAIL(0.00)[pvorel.suse.cz:query timed out];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 MSBL_EBL_FAIL(0.00)[pvorel@suse.cz:query timed out];
 RCVD_TLS_ALL(0.00)[];
 DBL_FAIL(0.00)[suse.cz:query timed out,imap1.dmz-prg2.suse.org:query timed
 out]; FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SURBL_MULTI_FAIL(0.00)[suse.cz:query timed out,imap1.dmz-prg2.suse.org:query
 timed out]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] doc: Clarify that the only public CI testing
 is build only
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

merged rebased version of this and previous patch.
Thank you all!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
