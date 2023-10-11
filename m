Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E48CD6E43
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 08:51:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF4D73CD60C
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 10:51:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0BF63C62DB
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 10:51:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 251271402FAD
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 10:51:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6787E211F0;
 Wed, 11 Oct 2023 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697014303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zomvkG92xF6pqN1cg5MZ9f9ccJtQB3cKBdjAKIIZNk=;
 b=dCscXelRVLV2JXw1d0syrLDcoA3acbZNR6zilkU2yjKPYoFJrTAXBXO4tGecSLX1OoXTM1
 iIpQGHge4As60XC+ylAoQVGyeYI2lyZnUHRi4MJYdZJt2oSKWYiEEaqdTUNVoRP/ERy6B8
 dqRFjXhCHyXQTe+eRV018fxu9MABwlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697014303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zomvkG92xF6pqN1cg5MZ9f9ccJtQB3cKBdjAKIIZNk=;
 b=UeoeFs2q2evNxuwnhPk9EbQC/AQIZELAUVyn7J6RkfEBEoUXYgEXDx5SHW+0JZLLPbj1Hg
 gWvDYr/Jiz9QBADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52CD2134F5;
 Wed, 11 Oct 2023 08:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NQytEx9iJmVYLQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 11 Oct 2023 08:51:43 +0000
Date: Wed, 11 Oct 2023 10:52:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZSZiScYnMIGtc4du@yuki>
References: <20231004124712.3833-1-chrubis@suse.cz> <87o7h6zsth.fsf@suse.de>
 <ZSVPpG4_ui4k5nES@yuki> <87fs2hzgr4.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87fs2hzgr4.fsf@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Add tst_iterate_fd()
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This looks promising. I think it would be good to try this sooner rather
> than later.

Already rewriting the code...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
