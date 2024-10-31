Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F95E68958
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 07:01:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64E4E3CBBA0
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 08:01:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6720A3CBAFE
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 08:01:32 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB8F7661618
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 08:01:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09DCC21BF7;
 Thu, 31 Oct 2024 07:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730358090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGnOfiq4KY80RhMAJhB0wc/Kh2/hwRDHB5VRoyDIKjQ=;
 b=dE77adoinVVTtSm7/MX5kLVNuJzyCJ1/jA0O1WhVDYNozcmjLsdgnGyGuImrC2GMJgr/Hk
 dQE2PgfCR5dsywXYdCdsqw4L0r4NFgec/B7PeAWaQU0vNAw0/J+HYr50DMx3ncv5U4X9Uk
 n2z4RCybWHJoM0Z2VVfynn7ro9fgAfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730358090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGnOfiq4KY80RhMAJhB0wc/Kh2/hwRDHB5VRoyDIKjQ=;
 b=XQUZ2+vrSfhLJETiiCBONGcCaDy5Vzt1IaM/vLyQQiP/7EFv7N1BIjSvIB6Lymu9ve2h7P
 XyXK1Pf/uChvwfCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730358090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGnOfiq4KY80RhMAJhB0wc/Kh2/hwRDHB5VRoyDIKjQ=;
 b=dE77adoinVVTtSm7/MX5kLVNuJzyCJ1/jA0O1WhVDYNozcmjLsdgnGyGuImrC2GMJgr/Hk
 dQE2PgfCR5dsywXYdCdsqw4L0r4NFgec/B7PeAWaQU0vNAw0/J+HYr50DMx3ncv5U4X9Uk
 n2z4RCybWHJoM0Z2VVfynn7ro9fgAfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730358090;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGnOfiq4KY80RhMAJhB0wc/Kh2/hwRDHB5VRoyDIKjQ=;
 b=XQUZ2+vrSfhLJETiiCBONGcCaDy5Vzt1IaM/vLyQQiP/7EFv7N1BIjSvIB6Lymu9ve2h7P
 XyXK1Pf/uChvwfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC2E6136A5;
 Thu, 31 Oct 2024 07:01:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GqnkKEkrI2c4fgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Oct 2024 07:01:29 +0000
Date: Thu, 31 Oct 2024 08:01:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <20241031070113.GA979201@pevik>
References: <20241030-convert_mmap14-v2-1-d0f66c5a7d18@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241030-convert_mmap14-v2-1-d0f66c5a7d18@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmap14: Convert to new API
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

Hi Ricardo,

...
> +	sz_ch = sz_after - sz_before;
> +	if (sz_ch == MMAPSIZE / 1024) {
> +		tst_res(TPASS, "mmap() locked %uK", sz_ch);
> +	} else {
> +		tst_res(TFAIL, "Expected %luK locked, get %uK locked",
> +				MMAPSIZE / 1024, sz_ch);
> +	}
> +
> +	SAFE_MUNMAP(addr, MMAPSIZE);
+1, you fixed my bug using sz_ch instead of MMAPSIZE.

Thanks a lot, nice work, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
