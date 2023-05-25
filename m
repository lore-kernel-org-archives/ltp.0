Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC6AC77B7E
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 05:13:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23BC83CA775
	for <ltp@archiver.kernel.org>; Thu, 25 May 2023 07:13:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 363733CA6BC
 for <ltp@lists.linux.it>; Thu, 25 May 2023 07:13:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 657626009EE
 for <ltp@lists.linux.it>; Thu, 25 May 2023 07:13:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7502321D8C;
 Thu, 25 May 2023 05:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684991613;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0SIlV10f9etJ/hVWqX1RnakiGtEfXbpNiiYLqES+h8=;
 b=E9ctFZ3LGbiis1bWpruz85+5XZeWUaU+OG8h7Vhub3j0qe2MsxPY2BzMyIeQZYzs8kgwoD
 dP/EDs/HX2zsmlCi0ltrEY6C+A7rr2zcgXggi+E5IAwwM+YIjVGg0uaO7vtjvXe4mTELx1
 tOs8+2Inwgz8XR6HTsQau8O2ev9Rtq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684991613;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0SIlV10f9etJ/hVWqX1RnakiGtEfXbpNiiYLqES+h8=;
 b=q1K15xFPyCpyUPpcF7VZLzMLMXlUxpY6aW4DFoI7osR4co0coZAUH4LylSPuvLom4F/4Y/
 +ey9yO+bsrjbGlCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 497B813776;
 Thu, 25 May 2023 05:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jVWXEH3ubmR0ZAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 25 May 2023 05:13:33 +0000
Date: Thu, 25 May 2023 07:13:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20230525051331.GA709187@pevik>
References: <20230518113216.126233-1-jlayton@kernel.org>
 <68340cb2-87e1-ff17-2db8-5610beba761b@fujitsu.com>
 <c6c0ae90df044b883ed65ba1896db8b51dfa70d4.camel@kernel.org>
 <ZG3O0Oe2zlezT0ew@yuki>
 <b35f343590352d0c669a017428e815e54e49a9ca.camel@kernel.org>
 <20230524122818.GA691716@pevik>
 <b3eb4e95-b7b0-71d6-2929-e9321e1cbabe@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b3eb4e95-b7b0-71d6-2929-e9321e1cbabe@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx06: use a fine-grained timestamp
 for the second time fetch
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
Cc: Jeff Layton <jlayton@kernel.org>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

I merged the patchset, linking the original RFC patchset in kernel and
explaining that we merged it because the change is backward compatible anyway.

Thanks to all!

Kind regards,
Petr

[1] https://lore.kernel.org/lkml/20230411143702.64495-1-jlayton@kernel.org/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
