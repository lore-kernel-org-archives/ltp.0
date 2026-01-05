Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E41C79F9D
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 14:30:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA6DC3C2B45
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 15:30:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 396633C2689
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:30:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8404E60011F
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 15:30:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59AD733746;
 Mon,  5 Jan 2026 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767623414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLknL8JR7xlHB2wW6SArCarGM7wy6yJVzNZdDnx8iPo=;
 b=NA8whvUlmdI2dTXP2X6egTA+n1VW2NaZiD/6Nx/A8BezNr+IwAwzaUODW8/Tma2XW7/G4S
 EMSGhfaoLmCfChsvNsQleXQeykIshIW2EUMwnV4tGrFPNsdjKlM0hd0kcpx0C0WYu+711f
 Owdz27D+M4hnRg4+GTVIxPz9hkZkVp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767623414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLknL8JR7xlHB2wW6SArCarGM7wy6yJVzNZdDnx8iPo=;
 b=5MlldGWym/wOMhJOD+tOUAtwpCZnxuHY1oMOh7zlvyLpkUWcsVDy5PWSg3SW5YHIRFQ4+n
 Wq2c83oV9B3SHTDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767623414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLknL8JR7xlHB2wW6SArCarGM7wy6yJVzNZdDnx8iPo=;
 b=NA8whvUlmdI2dTXP2X6egTA+n1VW2NaZiD/6Nx/A8BezNr+IwAwzaUODW8/Tma2XW7/G4S
 EMSGhfaoLmCfChsvNsQleXQeykIshIW2EUMwnV4tGrFPNsdjKlM0hd0kcpx0C0WYu+711f
 Owdz27D+M4hnRg4+GTVIxPz9hkZkVp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767623414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLknL8JR7xlHB2wW6SArCarGM7wy6yJVzNZdDnx8iPo=;
 b=5MlldGWym/wOMhJOD+tOUAtwpCZnxuHY1oMOh7zlvyLpkUWcsVDy5PWSg3SW5YHIRFQ4+n
 Wq2c83oV9B3SHTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25B203EA63;
 Mon,  5 Jan 2026 14:30:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id szhLCPbKW2lcBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Jan 2026 14:30:14 +0000
Date: Mon, 5 Jan 2026 15:30:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260105143012.GH654507@pevik>
References: <20250225114418.2940134-1-pvorel@suse.cz>
 <20250225114418.2940134-2-pvorel@suse.cz>
 <DF1CDYCKFHZL.3WIZKN5BWUHZ@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DF1CDYCKFHZL.3WIZKN5BWUHZ@suse.com>
X-Spamd-Result: default: False [-2.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; SUBJECT_HAS_CURRENCY(1.00)[];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.982]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_supported_fs_types: Ignore empty
 $LTP_SINGLE_FS_TYPE value
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

Hi Andrea,

thanks for a review, this patch merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
