Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1587CA1013
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 12:32:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEA723CD501
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 14:32:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 117153C5695
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 14:31:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 41FF6600B22
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 14:31:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 22D9835078;
 Fri,  5 Sep 2025 12:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757075505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxpEg8A8Umi5zIeNaXKsfeEL6Ty5GevLX7huptMbaEs=;
 b=pXrHnIDKY6pkptoJC1Q2EgjYcJ6yQ9nk/430FDzcGC/HXSoZpvHpbyPbkuAcEwDIOeLgPe
 uUSajlzK2/2WRTJ7NiYTrQKm+ql4dE1CAx9LLvEqigsXJULtjGoYc2Ra/PiVTdPRmduA2r
 AdjCQJhQMvUrJ4ymL+uak6PGKYsRg/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757075505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxpEg8A8Umi5zIeNaXKsfeEL6Ty5GevLX7huptMbaEs=;
 b=3ku63QB9uZPUx8S5m/xSK2Vo/2NkS6SUA5CjzfFtulGBR5JKhCC4Z+8hzBL7MtjBqQ1cEu
 iMLr6vB9Ca3STNAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757075505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxpEg8A8Umi5zIeNaXKsfeEL6Ty5GevLX7huptMbaEs=;
 b=pXrHnIDKY6pkptoJC1Q2EgjYcJ6yQ9nk/430FDzcGC/HXSoZpvHpbyPbkuAcEwDIOeLgPe
 uUSajlzK2/2WRTJ7NiYTrQKm+ql4dE1CAx9LLvEqigsXJULtjGoYc2Ra/PiVTdPRmduA2r
 AdjCQJhQMvUrJ4ymL+uak6PGKYsRg/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757075505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fxpEg8A8Umi5zIeNaXKsfeEL6Ty5GevLX7huptMbaEs=;
 b=3ku63QB9uZPUx8S5m/xSK2Vo/2NkS6SUA5CjzfFtulGBR5JKhCC4Z+8hzBL7MtjBqQ1cEu
 iMLr6vB9Ca3STNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1414B13306;
 Fri,  5 Sep 2025 12:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2cTrAzHYumjDYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 05 Sep 2025 12:31:45 +0000
Date: Fri, 5 Sep 2025 14:32:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aLrYUvN7UMpd64iJ@yuki.lan>
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
 <aLqq9o9Dkbhr957V@yuki.lan>
 <CAEemH2cRQVq4N-SdRTFEuUzyUbqfCVg_mpQ58t1BeaNSO9NuvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cRQVq4N-SdRTFEuUzyUbqfCVg_mpQ58t1BeaNSO9NuvQ@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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
> This has improved something, but still observes sporadic fail on RHEL stock
> kernel.
> However, both the RHEL RT-kernel and the mainline v6.17-rc4 stock kernel
> pass.

Maybe add a short usleep() before the referee sets the kickoff_flag so
that the system has more time to shuffle processes?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
