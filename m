Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B42CCD187
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 11:01:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09AF83CE859
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 13:01:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9C7A3C0485
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 13:01:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D8991400F28
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 13:00:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C1E7C21BFE;
 Tue, 14 Oct 2025 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760439657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWnnhG8hhWdhDd+IeK3pSedHm3k1svP0J9Zy6uw9cvE=;
 b=c3m1ysHDPXfneW6mPe88PEMPxEHxuxaXXPhO58Uar+V9PJ9okT5AJjLvExLgkXSHy5bFZx
 THfHQ/BLQ9zr2QhbRH8b1veMFw6HD5Yk5l1z6tdheHXFOhwFmSnuTP7rnpqkPb0Egf+XIM
 cTLkIg+eDA8mj2/ABbaA6kqs+HL5RLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760439657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWnnhG8hhWdhDd+IeK3pSedHm3k1svP0J9Zy6uw9cvE=;
 b=6dkXXQzL0PedX/2J84mPju51H9dt/7nd681y1C454A50Mg497lrTGs3CTueJuxa0B1Ok12
 H8J3FMAf+dG9ZaCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c3m1ysHD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6dkXXQzL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760439657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWnnhG8hhWdhDd+IeK3pSedHm3k1svP0J9Zy6uw9cvE=;
 b=c3m1ysHDPXfneW6mPe88PEMPxEHxuxaXXPhO58Uar+V9PJ9okT5AJjLvExLgkXSHy5bFZx
 THfHQ/BLQ9zr2QhbRH8b1veMFw6HD5Yk5l1z6tdheHXFOhwFmSnuTP7rnpqkPb0Egf+XIM
 cTLkIg+eDA8mj2/ABbaA6kqs+HL5RLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760439657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JWnnhG8hhWdhDd+IeK3pSedHm3k1svP0J9Zy6uw9cvE=;
 b=6dkXXQzL0PedX/2J84mPju51H9dt/7nd681y1C454A50Mg497lrTGs3CTueJuxa0B1Ok12
 H8J3FMAf+dG9ZaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A604613A44;
 Tue, 14 Oct 2025 11:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WQCJJ2kt7mjELAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Oct 2025 11:00:57 +0000
Date: Tue, 14 Oct 2025 13:00:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20251014110056.GA154223@pevik>
References: <20251014-remove_todo-v5-1-2793dffdec2d@suse.com>
 <aO4WanlsicVtKsSw@yuki.lan> <DDHY1H984UNS.3R33TJJGW8UQB@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DDHY1H984UNS.3R33TJJGW8UQB@suse.com>
X-Rspamd-Queue-Id: C1E7C21BFE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Remove TODO
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

> Hi,


> > Maybe we should link the (now empty) shell API page here:

> > https://linux-test-project.readthedocs.io/en/latest/developers/api_shell_tests.html


> I don't know if it makes sense to link a documentation that is empty. It
> would be nice to write it first.

+1.

Let's merge it with 2 other typos/wording Cyril found.
And afterwards, if somebody writes shell loader doc, we can add it there and
link the document.

Kind regards,
Petr

> Kind Regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
