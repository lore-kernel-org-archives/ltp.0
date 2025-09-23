Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07132CAC5A5
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 08:03:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 640523CDE85
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 10:03:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EA253CAC1E
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 10:03:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83A35600A64
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 10:03:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2DAF11F76C;
 Tue, 23 Sep 2025 08:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758614592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f6Zws/2YSViZuxO1KzTXp44kmWyx6m9KMK2DRiCiTvY=;
 b=wrcK+UD/PoAcuujlyyic5wUOCzOPEYVuepi0+hNQ+rzcPJuOgAKrTv1ho7zMmBLcL5tldm
 Z9MMsT+eDjUwh8eF1jgL0cxZfGU74sd/2WJVeg/g4Q5BWifV4u8kInsH9yWuJVdKa+K8mo
 Jj6q4OkAKWiW3kjnDWGISmmhPHewKPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758614592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f6Zws/2YSViZuxO1KzTXp44kmWyx6m9KMK2DRiCiTvY=;
 b=+WAYrKNm6OV9F4g3C4IJ1KmjrCXs1oorify6vETSVTq2sOmdhucgM9p7tTfcHxPKAL4sA/
 TURQJSZoTVsLKICg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758614587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f6Zws/2YSViZuxO1KzTXp44kmWyx6m9KMK2DRiCiTvY=;
 b=fa/c+SRDiXlpdRpf/EHneN1zzFuFOHKMhOIVEDQ4zwUJZMf/UEHpZADQ69Qi4yvPFsQS5y
 KldGtbRDlWnYhPogibEJ5ltA7JEAeBM5G/KTjn3cp1RH+RlucHHas5ciwkuGGPrVP1s+Vv
 KQ+g9hsdHwC+2vjflDNkYMA4v+d1+vI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758614587;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f6Zws/2YSViZuxO1KzTXp44kmWyx6m9KMK2DRiCiTvY=;
 b=cCuH9hDWKCyY+rIG0ezr67ggM6yFBL5p+L96LXY7jc8MX1oWUCAdFdbvMtvJdJOCnsERWl
 wS9s1adHwkI8OvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16E5613AAF;
 Tue, 23 Sep 2025 08:03:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tJ90BDtU0mgEOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 23 Sep 2025 08:03:07 +0000
Date: Tue, 23 Sep 2025 10:03:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aNJUYxkKPS2rLfVx@yuki.lan>
References: <20250922-cve-2025-21756-v1-1-074da211288a@suse.com>
 <aNFd7UYkgVk3xgU_@yuki.lan>
 <4721ff31-7d9f-42a2-8217-6d1d4006f661@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4721ff31-7d9f-42a2-8217-6d1d4006f661@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 SEM_URIBL_UNKNOWN_FAIL(0.00)[suse.cz:query timed out];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve: add test reproducer for cve-2025-21756
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
> I guess we need to verify that, if system is not crashed, we should 
> check kernel messages in order to find any error. Is there a smart way 
> to do it? I could parse data via FILE_LINES_SCANF() macro, but that 
> would require multiple iterations. The alternative is just to parse the 
> entire /dev/kmsg via read() and to find:
> 
> 1. use-after-free message
> 2. test name after it
> 3. failing syscall vsock_release
> 
> WDYT? Maybe there are better ways to do it.

We have library functions to watch for kernel taint flags, that should
be enough to detect this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
