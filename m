Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3C8E9E311
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 15:41:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 032883CEF0B
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 16:41:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 189F43CACFD
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 16:41:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 886111A00A4A
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 16:41:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E01E55BE23;
 Wed, 11 Feb 2026 15:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770824456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CLk+NxcpNRhtLLbKp1z1TKY5YfJ5d4ql7FA0KPC7qw4=;
 b=p4kfmoBBKKQP/HC3gGyY9CvVq1m9sAvttG0OLuZwT2EuinD+ZKx0teWZVhL2u79ma6HI57
 35kCK9LgEph3i6d29oEaTM1G8qbv2UUSNOPle7Ov6wdq8QVO1bGYCXHedYsaVOzXoir2/f
 OPPwMkIjW2ZYCLsvynCM/Eu4clivzRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770824456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CLk+NxcpNRhtLLbKp1z1TKY5YfJ5d4ql7FA0KPC7qw4=;
 b=bMtky2WhksJeJuEtEDWMd3ik69YR0NB2pJy8U5X639dr0/XeJ3FOIgejbjOYQ+vILdNHfy
 hKc7AWWHPIbgb3BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770824455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CLk+NxcpNRhtLLbKp1z1TKY5YfJ5d4ql7FA0KPC7qw4=;
 b=XgBn7UZ9vmTuSOcSjp/hUCFTb8a58Ykr2AgenDLkOIVoCRxWf8EkJFdO/YJC1qZOrfoEL8
 Bzp5HQVnDR+UwYTfY6S902Ser2SazCYDh5Ivxz0W8PceHxWIPeV+v6er6cZRQInyXndYaL
 upwUdiYXc4LjiMb6mBgam7QOKNLQ/Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770824455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CLk+NxcpNRhtLLbKp1z1TKY5YfJ5d4ql7FA0KPC7qw4=;
 b=uPkdJ1ZvWeQn3UvrzOJT1y91A+FKkulIXjYTdVGGmrpo9K1VX4hekQ5bdS6ODKO0R50Sgd
 h45HcyAqxNECucAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB4AE3EA62;
 Wed, 11 Feb 2026 15:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6eXCLAejjGmXfQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 11 Feb 2026 15:40:55 +0000
Date: Wed, 11 Feb 2026 16:40:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYyjCRqEtW_yKtss@yuki.lan>
References: <20260122132059.24503-1-chrubis@suse.cz>
 <20260122132059.24503-3-chrubis@suse.cz>
 <20260123090733.GB93219@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123090733.GB93219@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] metadata: metaparse: Add bool mappings to
 typemap
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
> Later (after the release) it'd be nice to add a minimal doc (i.e. describe
> structs in data_storage.h).

Added to my TODO, not sure when I get to it though.


Thanks for the reviews, patchset pushed.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
