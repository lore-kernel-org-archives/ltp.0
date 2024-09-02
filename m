Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE652CD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 07:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E09D3C3260
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 09:16:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D96D3C2F7E
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 09:16:26 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 807581400E61
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 09:16:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89A4A21B36;
 Mon,  2 Sep 2024 07:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725261381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5amRcHtjBb5BCEVXNFVnP/LhpC1Ao/P+3F+aZmJjAI4=;
 b=fGvrviZfRLGG/3bQWznjovvptx3Mdo1Kfx6Bs7AZ6TBCRn9edihiQ0u+dZYesUVtMZqhb6
 rxTeEdawi6pamsA3ZCf/w1kdDh08Dz42uXxEfSztZw5Ba0geuB9lWpj3mEvKCgDGGMGcVG
 VDVBXHh/HCpiclUofOz31lqNwqjNGZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725261381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5amRcHtjBb5BCEVXNFVnP/LhpC1Ao/P+3F+aZmJjAI4=;
 b=O3z9hTlfgi8jtNZWKSTfME+EJ1IxOy3mSD8S0ULIZTZ4uCD4u1BkHbh2Lr2n7FN+oEiqjO
 IkphcWdizzwJpCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725261381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5amRcHtjBb5BCEVXNFVnP/LhpC1Ao/P+3F+aZmJjAI4=;
 b=fGvrviZfRLGG/3bQWznjovvptx3Mdo1Kfx6Bs7AZ6TBCRn9edihiQ0u+dZYesUVtMZqhb6
 rxTeEdawi6pamsA3ZCf/w1kdDh08Dz42uXxEfSztZw5Ba0geuB9lWpj3mEvKCgDGGMGcVG
 VDVBXHh/HCpiclUofOz31lqNwqjNGZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725261381;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5amRcHtjBb5BCEVXNFVnP/LhpC1Ao/P+3F+aZmJjAI4=;
 b=O3z9hTlfgi8jtNZWKSTfME+EJ1IxOy3mSD8S0ULIZTZ4uCD4u1BkHbh2Lr2n7FN+oEiqjO
 IkphcWdizzwJpCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B2D013A7C;
 Mon,  2 Sep 2024 07:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fhTaC0Vm1WbPKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Sep 2024 07:16:21 +0000
Date: Mon, 2 Sep 2024 09:16:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240902071615.GA279460@pevik>
References: <20240902062738.267190-1-pvorel@suse.cz> <ZtVgcX/C4bDYIjsa@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZtVgcX/C4bDYIjsa@wegao>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[idcheck.sh:url,suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] isofs.sh: Use nobody user
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

Hi Wei,

> > +TEST_USER='nobody'
> > +
> > +setup()
> > +{
> > +	TEST_GROUP="$(id -g -n $TEST_USER)"
> > +	[ "$TEST_GROUP" ] || TEST_GROUP="$TEST_USER"
> If $TEST_GROUP can not be found then this case will failed unless we create new group.
> My suggestion is remove above line totally or we start create group for nobody user.

That check is a fallback if 'id' is not installed but there is requested
nobody:nobody or nobody/nogroup group set by IDcheck.sh or manually.

But sure, I can delete it if we expect id to be installed. I just did not want
to require 'id' for this test when there can be a workaround.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
