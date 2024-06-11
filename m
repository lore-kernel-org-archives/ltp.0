Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48166C25B76
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 13:18:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C697D3D0B31
	for <ltp@archiver.kernel.org>; Tue, 11 Jun 2024 15:18:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61A953C0326
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 15:18:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ACC7B206C50
 for <ltp@lists.linux.it>; Tue, 11 Jun 2024 15:18:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 577F221A9A;
 Tue, 11 Jun 2024 13:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718111910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv+hOIfmVd6B2RWJHzT9VlDkoVutpl1/z9Y40d1pku4=;
 b=CNvk2BumwvcZFazkVPGBD4ZhK7Vosg2RXoQQ7T+aRqsgaZ7+Pw+5d6UV8wNyQmNWyd8oLn
 DNEJFM06du4DvY0ap6tb+4rvap959NfwU+gyVWsEYM73nWHAcP98bFXQzlGv3Bj860VA/X
 kpqDo2FTJrRl+YPE0A0j+e9j/P+GwtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718111910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv+hOIfmVd6B2RWJHzT9VlDkoVutpl1/z9Y40d1pku4=;
 b=oaGnEu1gFSSfF/LU7klUD2+zBURBCG6o64edMPlHGmdcl+yBbz7cgokqex0SdIpCiCVTDH
 4w+NsOEdywla08Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718111910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv+hOIfmVd6B2RWJHzT9VlDkoVutpl1/z9Y40d1pku4=;
 b=CNvk2BumwvcZFazkVPGBD4ZhK7Vosg2RXoQQ7T+aRqsgaZ7+Pw+5d6UV8wNyQmNWyd8oLn
 DNEJFM06du4DvY0ap6tb+4rvap959NfwU+gyVWsEYM73nWHAcP98bFXQzlGv3Bj860VA/X
 kpqDo2FTJrRl+YPE0A0j+e9j/P+GwtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718111910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yv+hOIfmVd6B2RWJHzT9VlDkoVutpl1/z9Y40d1pku4=;
 b=oaGnEu1gFSSfF/LU7klUD2+zBURBCG6o64edMPlHGmdcl+yBbz7cgokqex0SdIpCiCVTDH
 4w+NsOEdywla08Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4328F13A55;
 Tue, 11 Jun 2024 13:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IDDvDqZOaGaKOgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 11 Jun 2024 13:18:30 +0000
Date: Tue, 11 Jun 2024 15:18:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZmhOnwT5NFwRmd-A@yuki>
References: <20240603123455.7968-1-chrubis@suse.cz>
 <20240603123455.7968-2-chrubis@suse.cz>
 <85b362c0-9126-45cb-90af-9fe09b848661@suse.cz>
 <20240611110203.GA34462@pevik>
 <590abdcd-9253-434b-889b-4e481cbe5e12@suse.cz>
 <ZmhBz97t8v4FuJPF@yuki>
 <954f2854-42b5-4af0-bb63-1818cd92d54d@suse.cz>
 <ZmhM6WCy5jHl16WB@yuki>
 <ef61d387-1662-43d0-9183-cbbd12aed0e1@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ef61d387-1662-43d0-9183-cbbd12aed0e1@suse.cz>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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
> You can make an exception for .fss[0] since it doesn't make sense to 
> have zero-length array there.

Good point, let me try...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
