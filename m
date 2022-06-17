Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AD8C43334
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 14:00:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBD4B3C8CC5
	for <ltp@archiver.kernel.org>; Fri, 17 Jun 2022 16:00:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 392473C075E
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 16:00:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5256820004E
 for <ltp@lists.linux.it>; Fri, 17 Jun 2022 16:00:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A3051FDE2;
 Fri, 17 Jun 2022 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655474438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3rr3aPhLrEwOHHYNdteNM9KraN2JlMl7VuM/REa3rY=;
 b=PALWN24wJBJF6/jWaAZGLksrDH5woCHhkTwpnpN8I6RaBdSiGt5S2kh4tSd4hHTSKOcB02
 EAkVz6fAYdg7MyC39PF7bG+mWk9AoFlHRmHReKpRu2tXhUpy5/wNFXlxFIl6RxGLFwfQIL
 J/hWa45/RPwcxOEBtSyZ3/hy5ECQMDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655474438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q3rr3aPhLrEwOHHYNdteNM9KraN2JlMl7VuM/REa3rY=;
 b=6O7qtjOOWaWNeLL+pt+ZUF9sykl7Jx7/jwHeifCA1SVrix1YCBEyRBKXqRPC2jlT4VC2vG
 +BNYX6X19VGz2uAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D383113458;
 Fri, 17 Jun 2022 14:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0tZ1MgWJrGIKIwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jun 2022 14:00:37 +0000
Date: Fri, 17 Jun 2022 16:02:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YqyJh7ihWAeS6JEc@yuki>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-8-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220609214223.4608-8-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/9] tst_device: Add clear command
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
Cc: linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
 "J . Bruce Fields" <bfields@fieldses.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 Trond Myklebust <trondmy@hammerspace.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Looks good, but should go before the "add: $TST_ALL_FILESYSTEMS" right?

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
