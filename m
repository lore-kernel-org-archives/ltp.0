Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBD2C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 18:52:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AF4A3CFD84
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 20:52:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40AB53CE3F6
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 20:52:20 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 717AD602580
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 20:52:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9AA3A5F78F;
 Fri, 19 Apr 2024 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713552737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=omQQvLVHBbFVtwqoq6MJfJm038As5rAzZA/7YxsfIWI=;
 b=zQn6wmoGa/RTPEngOKpdXK0cAWjCenS74ZpCh7OXjJuJ3H2yN3OulREN7vR/ni2zh4sO0d
 x8uZCv3okeGAcih6/BBfNDTUw9OE+fR3bR12sVUX4U5SxdQSBQfKOZ7DbRA/tA9p4lmJxJ
 /Z1fEeiThoYXGoleKnhn+mNsSFVeFxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713552737;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=omQQvLVHBbFVtwqoq6MJfJm038As5rAzZA/7YxsfIWI=;
 b=iZp7Ib2cvkvqkfoAZIhXGr97n86aYWmnrLAQ96QuSmJNSOqMXnJoo7Gp/EtytMAFXEFDQn
 0IgBtjaXmH53eSAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r+uvp+bo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MHyvczK3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713552736;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=omQQvLVHBbFVtwqoq6MJfJm038As5rAzZA/7YxsfIWI=;
 b=r+uvp+bo/OqtR+c7qpn91zZ2j05QY1R1EWLDKxxxCQZ8I6PQU7um5pGy4Aiib9ef0SHNa3
 BMF/eB9gpKQcHvoW4l46F0fzdPT4jIEGnKldTNA57aG/jkhF4/VQq7Nm5Oeq816KsAexbP
 hX0qP9Zmox+Mk3r+T6xT56C69QWvCaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713552736;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=omQQvLVHBbFVtwqoq6MJfJm038As5rAzZA/7YxsfIWI=;
 b=MHyvczK33IEb3UfMhUcc/Tu9tKY05YT6qYd7sVmbWicwraFIGrIPf013RM6/NyzwX9gPA2
 2L4gQk8Tq57OVTCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23DD513687;
 Fri, 19 Apr 2024 18:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Sts6BGC9Imb3PQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Apr 2024 18:52:16 +0000
Date: Fri, 19 Apr 2024 20:52:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <20240419185209.GB38106@pevik>
References: <20240419140752.18003-1-andrea.cervesato@suse.de>
 <20240419184724.GA38106@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240419184724.GA38106@pevik>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9AA3A5F78F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,readthedocs.org:url,suse.cz:dkim,suse.cz:replyto];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] doc: introduce sphinx extlinks
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Andrea,

> NOTE: I still need to trigger doc build manually.

I'm sorry, this time it worked out of the box, great :).
I see green "passing" in the dashboard [1].

Although I still see "Could not add webhook for "linux-test-project". Please
connect your GitHub account." in project account [2].

Kind regards,
Petr

[1] https://readthedocs.org/dashboard/
[2] https://readthedocs.org/projects/linux-test-project/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
