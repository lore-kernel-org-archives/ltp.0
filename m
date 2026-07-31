Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8C6C54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 15:47:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 254B13E57D0
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 17:47:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E571A3E4A85
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 17:47:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5CBA5600477
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 17:47:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68F4B40AB;
 Fri, 31 Jul 2026 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785512822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpOrxcu7W5nBm2q00jGCm0PMRG2h+71voko+9pFgJI4=;
 b=DWM+Pe7CPH/KcuI9pRILEoVJdhoKxrg7W2dMV4slfuyegGCU9yPrDRvqqxokshGILdOi0k
 66S604IL1HYUuk5SgZTa2GGUqWePhUewj58Pgup/C5o7oxRTL6iuxFPlVbQUZsy78s/6sm
 4PAQYNA8Nnn9/MvwDmN0oK/PUrXAaOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785512822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpOrxcu7W5nBm2q00jGCm0PMRG2h+71voko+9pFgJI4=;
 b=+u3qIABCEBDIHUshihPIZBncFPFKKrkEtkvCsmlp2GXkeJdhlSXcog5QpEDKcKACkymM08
 YnQgqzy/4zliMMAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="c371/+ef";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="42LJF/41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785512821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpOrxcu7W5nBm2q00jGCm0PMRG2h+71voko+9pFgJI4=;
 b=c371/+efmXhBU48JbrYHdIArrUtx5X8tU9OmnDdYSmSkryh7/lKhFZXCqWvV2OCcHqvyzv
 /RiTCNNRzgC1Wk5bQ49O/jLD+HpZqajdvjatL2l+OmEbi3/G7M6tkDByeJiNlZRRhiWcuw
 zwkox+lxLcm6tV0BIh1GMPldIfg9YwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785512821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HpOrxcu7W5nBm2q00jGCm0PMRG2h+71voko+9pFgJI4=;
 b=42LJF/41qzFG3uPZZ5/E2AX2IYBwp3Fd5k51+I7WqsQnpDkGAIWNMe8Ir7y1kKfG/I3VmI
 Mw44UTLN9SEpmRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F4A1779B0;
 Fri, 31 Jul 2026 15:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QgpHEnXDbGq3SwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 31 Jul 2026 15:47:01 +0000
Date: Fri, 31 Jul 2026 17:47:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <amzDdOq7k69e1nPZ@yuki.lan>
References: <20260702134553.98581-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260702134553.98581-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 68F4B40AB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] rfim: add new test for verifying RFIM sysfs
 interface
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I've fixed the documentation comment and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
