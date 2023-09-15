Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99409EE6447
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 08:50:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A557E3CE6A5
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 10:50:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C3D43CB148
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 10:50:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE13A200CF8
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 10:50:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B20B2185F;
 Fri, 15 Sep 2023 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694767813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p4z/WPgQeMDB41t1QkQolnzOff+bTwa9LXWZsznIMaE=;
 b=twy39WrdhpmkAZcMPacXjtuB23jh85Wr4xSvnf2M7iQ0n4/G31svKQryvxvRQUQb9FNcW4
 biu8dDCnlxjYDWj48snjCyiYaOVFe4Z1D19Vn8o5/YJRpvEHs0iKWKYfQIAQ3obpzeYrti
 v+KcSEFS8yimV24dthbqH2I5phep0Bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694767813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p4z/WPgQeMDB41t1QkQolnzOff+bTwa9LXWZsznIMaE=;
 b=d7J54YzGkun2kbCgl/MsDml50OTMSyVH+cK5gTokFMtNJ0Vi65FcLLc68+9x2Z21NhB735
 qkp7SJHQ8WqGL5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 176BD1358A;
 Fri, 15 Sep 2023 08:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EJeiBMUaBGVUTQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 15 Sep 2023 08:50:13 +0000
Date: Fri, 15 Sep 2023 10:50:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZQQa8iT30O2aDRmM@yuki>
References: <8ebe4638-fda2-43f0-98d6-8d49b9b5a1b5@suse.com>
 <ZP72f0JFeMhkNo9n@yuki>
 <0516136a-1e76-4e7e-9f0e-679894e4a632@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0516136a-1e76-4e7e-9f0e-679894e4a632@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Replacing runltp-ng with kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I guess it makes sense to live it under linux-test-project, since we 
> started from there. Then the rest comes easy.

I've created kirk repository under linux-test-project/ and added you
there as an admin.

I guess that we should archive the runltp-ng repository so that it's
clear that it's no longer maintained.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
