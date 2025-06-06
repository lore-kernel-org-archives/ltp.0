Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E93C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 10:16:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A5803C9AFF
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 12:16:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D1FC3C9ACC
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 12:15:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 931D510004AB
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 12:15:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 920B01F38E;
 Fri,  6 Jun 2025 10:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749204941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTx7f9cOwWq+b8tD/1DHVVASWj4P1UTHKq1SL/9bbcY=;
 b=NOZ4T4CWweNXg77kb5uiXCsyT6rohmlK1WGsnt/FVxcXykEcegTxCs2sAUhfVmDw5YFXg/
 Qzh8lTjTESpa7cedLo8MjGCJqAGSoCKT9H9MVScoF40rqtLExixdqo8nsMs672WMYrh0NK
 nDQB7HjE+XputDBB9yko8vkrmVCRAqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749204941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTx7f9cOwWq+b8tD/1DHVVASWj4P1UTHKq1SL/9bbcY=;
 b=8E2RFyGBLLiv87B37IYwARQqVfy+shqjAwtH2DG6xle4XzByP9eVoMUu2SXfWqR6sLSoS1
 bj9fqjXDMlkh8EAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749204941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTx7f9cOwWq+b8tD/1DHVVASWj4P1UTHKq1SL/9bbcY=;
 b=NOZ4T4CWweNXg77kb5uiXCsyT6rohmlK1WGsnt/FVxcXykEcegTxCs2sAUhfVmDw5YFXg/
 Qzh8lTjTESpa7cedLo8MjGCJqAGSoCKT9H9MVScoF40rqtLExixdqo8nsMs672WMYrh0NK
 nDQB7HjE+XputDBB9yko8vkrmVCRAqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749204941;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTx7f9cOwWq+b8tD/1DHVVASWj4P1UTHKq1SL/9bbcY=;
 b=8E2RFyGBLLiv87B37IYwARQqVfy+shqjAwtH2DG6xle4XzByP9eVoMUu2SXfWqR6sLSoS1
 bj9fqjXDMlkh8EAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D1121369F;
 Fri,  6 Jun 2025 10:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hk48Hc2/QmjoKwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Jun 2025 10:15:41 +0000
Date: Fri, 6 Jun 2025 12:16:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aEK_6WPCvW8abU-F@yuki.lan>
References: <20250605120702.213048-1-liwang@redhat.com>
 <aEKyXpEg3NoPKLfq@yuki.lan>
 <CAEemH2fKJY+_bSEtugZVMzjYwGOPG3DSnffZp7gBBuSQ8N3nkA@mail.gmail.com>
 <CAEemH2cVpKAh3aPOzz82Cbvik_gQzpzySu7SsoTePTvKtGZkOA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cVpKAh3aPOzz82Cbvik_gQzpzySu7SsoTePTvKtGZkOA@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] tst_atomic: drop legacy inline assembly
 and use __atomic or __sync builtins
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
> Or, do you think it's necessary to define a dedicated tst_atomic_t type,
> such as:
> typedef int32_t tst_atomic_t;
> and use it explicitly for all variables that are subject to atomic
> operations?
> 
> This way, we can clearly declare which values are intended for atomic use,
> improving type safety and code clarity.

Sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
