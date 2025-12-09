Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40141D3B7EA
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 10:12:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 360AF3CFFD7
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 11:12:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDCF93CF997
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 11:12:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2AF711A004E0
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 11:12:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BF9C3382B;
 Tue,  9 Dec 2025 10:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765275148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aFsPAhh7YvaowjLAbRrDxZ+GVoBw8gMGLBRu+Lrifrg=;
 b=qGYThUjJKBZC7wuETAM9bF1VABZi1m5M4grtP0aH76iVi0kMQ0edwl66WxyhvHwG3ODcCi
 uhEY7JD9ukVm1NPHGPR9K42+rYvhFLjq/FnprjjjzJejucD++tMqAr0RZnU65k6W4Jd350
 IggPZc/xDAaD6Uuttdf8I6O/M7G2af4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765275148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aFsPAhh7YvaowjLAbRrDxZ+GVoBw8gMGLBRu+Lrifrg=;
 b=crUjrcTvoXqsexHJieE1spdeUJ3JZvkDMr0Ej+3r4Jlv3VOAMaYXsnfqpcwHOo/gJAur1O
 W8eLwoPECb/5uLBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765275148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aFsPAhh7YvaowjLAbRrDxZ+GVoBw8gMGLBRu+Lrifrg=;
 b=qGYThUjJKBZC7wuETAM9bF1VABZi1m5M4grtP0aH76iVi0kMQ0edwl66WxyhvHwG3ODcCi
 uhEY7JD9ukVm1NPHGPR9K42+rYvhFLjq/FnprjjjzJejucD++tMqAr0RZnU65k6W4Jd350
 IggPZc/xDAaD6Uuttdf8I6O/M7G2af4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765275148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aFsPAhh7YvaowjLAbRrDxZ+GVoBw8gMGLBRu+Lrifrg=;
 b=crUjrcTvoXqsexHJieE1spdeUJ3JZvkDMr0Ej+3r4Jlv3VOAMaYXsnfqpcwHOo/gJAur1O
 W8eLwoPECb/5uLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01DB63EA63;
 Tue,  9 Dec 2025 10:12:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dFQsOwv2N2nSYQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 10:12:27 +0000
Date: Tue, 9 Dec 2025 11:12:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Masahiro Yamada <masahiro.yamada@canonical.com>,
 Christian Brauner <brauner@kernel.org>, ltp@lists.linux.it
Message-ID: <20251209101226.GA745959@pevik>
References: <20251203081226.1148236-1-masahiro.yamada@canonical.com>
 <20251208112335.GA683201@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251208112335.GA683201@pevik>
X-Spamd-Result: default: False [-3.47 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.17)[-0.833]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; SINGLE_SHORT_PART(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04: require kernel version 6.11
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

Hi Masahiro,

thanks, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
