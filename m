Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B4EC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 16:40:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24D083C71BB
	for <ltp@archiver.kernel.org>; Wed,  8 Dec 2021 17:40:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 183083C31DA
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 17:40:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9271B1000553
 for <ltp@lists.linux.it>; Wed,  8 Dec 2021 17:40:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E4261FD26;
 Wed,  8 Dec 2021 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638981625;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAaafqGQrlk0Ho4p+zbewOS3uaYuuSv/1FGkVApYYBY=;
 b=LqjqkzTxLDkNDFeABIAd+P+7VkZlDWNu762+Mu6HhZ+hRj3AD02TxhbnQDq8MUS+VTNB3p
 kCOOdTxgzVOv68OjhtRZnUCupuQt5tHnIn4y+ls4z2/Gj/weYrv5WpluyogDTdU7yrtkBe
 qq27h9pv1x07/LQD/l3ucD6Kv35QHaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638981625;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PAaafqGQrlk0Ho4p+zbewOS3uaYuuSv/1FGkVApYYBY=;
 b=xS3iSRD42+fpfKkBptykIYxdQVrYrfU15SgTPkIIDF+GuvbOBJ0Ho2tT2lO+v8q1AXOclg
 vBbJbtKJjL5+H0BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60C8F13C9B;
 Wed,  8 Dec 2021 16:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VNXGFfnfsGF/dgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Dec 2021 16:40:25 +0000
Date: Wed, 8 Dec 2021 17:40:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YbDf9/u9mwPmZbNK@pevik>
References: <20211208152038.17355-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211208152038.17355-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix INSTALL_TARGETS for nfs tests
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

Hi Martin,

> Fixes: 7fb7aeb71 ("nfs: Add *.sh extension to shell tests")
Thanks for fixing my error. Merged.

Maybe after adding new test we could just change the pattern to *.sh to not
having to update it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
