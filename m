Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5FFC71157
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 08:12:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387093CC221
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 10:12:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2C493C9C87
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 10:12:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE7DF600762
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 10:12:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 622141F38A;
 Tue, 17 Jun 2025 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750147944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzoCuzjEbVQg5f6X7Bzb0XeD3p1rXZxxp0yIZA8PLIs=;
 b=lN+jFgesuamAVEp25g1950VMLd3nkRkjlgmFBngqKu3MZWiJKrliw+g7VciXJi9+V8VZa2
 JmD89Ok94MSOVO9aHPqwp2FOpekvDoopawiOAJMniNhJqnV/clbp9S9DPBLDXdMMrDB3xI
 UQHmCXmUi7VgBAgwV/OlaaOgZyNOsDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750147944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzoCuzjEbVQg5f6X7Bzb0XeD3p1rXZxxp0yIZA8PLIs=;
 b=8gsmtWWOpMlRxcgFqMC/gBIrfo1IqSTqzRNVWIF22AjO4lSkskyhbiR4hPuH3Tnv2JCQKi
 Njw/DLx3nb6UaSAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750147944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzoCuzjEbVQg5f6X7Bzb0XeD3p1rXZxxp0yIZA8PLIs=;
 b=lN+jFgesuamAVEp25g1950VMLd3nkRkjlgmFBngqKu3MZWiJKrliw+g7VciXJi9+V8VZa2
 JmD89Ok94MSOVO9aHPqwp2FOpekvDoopawiOAJMniNhJqnV/clbp9S9DPBLDXdMMrDB3xI
 UQHmCXmUi7VgBAgwV/OlaaOgZyNOsDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750147944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzoCuzjEbVQg5f6X7Bzb0XeD3p1rXZxxp0yIZA8PLIs=;
 b=8gsmtWWOpMlRxcgFqMC/gBIrfo1IqSTqzRNVWIF22AjO4lSkskyhbiR4hPuH3Tnv2JCQKi
 Njw/DLx3nb6UaSAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47F5B13A69;
 Tue, 17 Jun 2025 08:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zjNYEGgjUWiFcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Jun 2025 08:12:24 +0000
Date: Tue, 17 Jun 2025 10:13:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aFEjjHY1B1k63imN@yuki.lan>
References: <20250617-doc_fix_table_generate-v1-0-e96beeb2bdf7@suse.com>
 <20250617-doc_fix_table_generate-v1-2-e96beeb2bdf7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250617-doc_fix_table_generate-v1-2-e96beeb2bdf7@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] docs: make sphinx verbose so it's easier to
 debug in CI
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
The traces looks much better with this :-).

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
