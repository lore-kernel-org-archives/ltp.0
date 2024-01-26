Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19749C47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 14:14:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C6203D0612
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 15:14:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEF983D060A
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:14:13 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C46B220EB4B
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 15:14:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CCFD121E6D;
 Fri, 26 Jan 2024 14:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706278449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU3YDUq4XYT3paZTELfwX8uAEqfbjF2DsI1q1a4vaLc=;
 b=Ui+DIOPq1he0DY0i1umB4JYDknMhNRddDky5rgw47epHRSjivGoRtT5uDIgs2vf9jAPPuM
 fTz1pWkHJzkrsV/o8NyfFoOhAx04l6e19QdaLvk8VenkAK5Jvsj4ZFXNXBeLaXjpA11ZEs
 oKl4N4tQr9V9adc2Pg8D/C8oFm39NQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706278449;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU3YDUq4XYT3paZTELfwX8uAEqfbjF2DsI1q1a4vaLc=;
 b=Si2GUU5oq2Z+14CzKyqBWBA0MoOu6G50IWzzJS8ssEIhJ9mmoYD6CTKlIDF7Reuahb64ZO
 dlBsn36zlcRl/wDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706278448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU3YDUq4XYT3paZTELfwX8uAEqfbjF2DsI1q1a4vaLc=;
 b=TcRooAvORaVYV3PzcY3iuBa7qD6wGNWFl/vADjKnfj4Oc5o16dxpZCg5ub7g6NhCT3yxYz
 K5r6jwp7I6kIBIwRljM+BNaGDUpgK5TKMuFdkV6/IE1vNS0Dm2CrOQxmYArjEj+FfibwV7
 We+Id2Rv8D1Kj9VP6T6BV8kQZxcGXZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706278448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HU3YDUq4XYT3paZTELfwX8uAEqfbjF2DsI1q1a4vaLc=;
 b=rxTgV/NOotyqIYr76Cv2oskWu8EcIti7+3UPQl2IUhKziWxGX8cO4FeBIzoun2SPtJShkF
 kGHlBk3xde+LqODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B281A13A22;
 Fri, 26 Jan 2024 14:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wkhiKTC+s2VcbAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Jan 2024 14:14:08 +0000
Date: Fri, 26 Jan 2024 15:14:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZbO-Pl9S7KH2cKkb@yuki>
References: <20240126121603.500470-1-pvorel@suse.cz>
 <34c177e9-394a-4338-a61d-816185a49f3c@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <34c177e9-394a-4338-a61d-816185a49f3c@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[43.57%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] splice07: Whitelist /dev/zero on pipe write
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> splice() works on /dev/zero and /proc/self/maps on older kernels at 
> least between v4.4 and v5.3.

My guess would have been that this stopped working after the changes for
set_fs removal, see:

https://lwn.net/Articles/832121/

and kernel commit 36e2c7421f02

The article explicitly cites that splice() stopped working for files
that does not implemente splice_read().

So splice for these two didn't work between 5.10 and 6.7.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
