Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95A3CD6E7D
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 15:44:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0FB63CF083
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 17:44:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 487833C8B01
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 17:43:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 955D51A00CD9
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 17:43:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5EDB221865;
 Wed, 11 Oct 2023 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697039029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9V5DZDbFTd2eug2bDAkvInXnEMxlN/GvAzZ9qKP8ZEo=;
 b=Af3cvUjl3/fAIPJJfxJEBzIm6jFEMglaOEO7rK391K1lRBwPSWjDegi25xpzGnK34ZRHGU
 3Rn7lXStAHudvzbdVq3zjN9qWjIYQ9egmnGOllw1VoNot1+Qln6QXtT4OTOlw2oxK3tvlK
 bq0eW4F7VtsJy0508LOAst7i/1/WnJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697039029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9V5DZDbFTd2eug2bDAkvInXnEMxlN/GvAzZ9qKP8ZEo=;
 b=3UKSV1kmGdRnEN5OGNsOa6/4/OOkZikSaxPnEKld9s0nLaGdOYm5r2UNlxL7YDEKpbHTB1
 F1aYZLP5baHouXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ACE3134F5;
 Wed, 11 Oct 2023 15:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e0nyDLXCJmVfFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Oct 2023 15:43:49 +0000
Date: Wed, 11 Oct 2023 17:43:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231011154347.GA540626@pevik>
References: <20231011152900.4274-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011152900.4274-1-mkittler@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.91 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.61)[81.99%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Avoid swapon01 failing with EPERM
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

> * Simply require root permissions like the other swapon tests do
> * Fixes #1091

Reported-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Fixes: 23fa0e045 ("syscalls/swapon/swapon01: Convert swapon01 to the new API")
Fixes: https://github.com/linux-test-project/ltp/issues/1091

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
