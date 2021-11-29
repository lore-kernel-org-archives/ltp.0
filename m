Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A23CC433EF
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 10:16:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E170C3C4E1D
	for <ltp@archiver.kernel.org>; Mon, 29 Nov 2021 11:16:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABFB23C1044
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 11:16:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 468981000DE3
 for <ltp@lists.linux.it>; Mon, 29 Nov 2021 11:16:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86C7F212B8;
 Mon, 29 Nov 2021 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638180985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfEac5HxFHcFcgXk57EblIkEkE7CFTnGQIaTOmSgvCg=;
 b=oVTtF09CYmDGMghI1S9G7+74wrGXWywdXFt7lS6KMGWrxnhXcf9sc+Dx9n5JyxcsOTX1qF
 q4FziKewutyJhK5k9lmzP8enqy2yjqnxtzz3/feG3/E50Cexwybe55UXRqn26oiNg4l4yN
 Zdz0rxe+62dlPpTrKVXhSjRmwvxAzVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638180985;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfEac5HxFHcFcgXk57EblIkEkE7CFTnGQIaTOmSgvCg=;
 b=AkmjfnjuyHqcX7oKRzkS/1HqjrrBcZIf35c1SACuw7Lup6vXlDb7ewdQV5lAebDDr1F+bU
 zSPZZswf+ZWzwMCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5DD6D13B6B;
 Mon, 29 Nov 2021 10:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p26vFXmopGECbgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 29 Nov 2021 10:16:25 +0000
Date: Mon, 29 Nov 2021 11:17:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YaSov/lABpoDlsXN@yuki>
References: <20211123124348.31073-1-rpalethorpe@suse.com>
 <20211123124348.31073-3-rpalethorpe@suse.com>
 <YZ3nXUuDjePQxOt6@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZ3nXUuDjePQxOt6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] doc: Add LTP-003 and LTP-004 static and tst
 API prefix rules
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> BTW It'd be nice to have some check for shell library (maybe shellcheck would be
> able to do it).

Actually the check is in the shell library script.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
