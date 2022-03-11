Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC32C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 11:08:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D61B83C8C8E
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 12:08:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876263C80B1
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 12:08:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0D2E5140055C
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 12:08:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1EB341F38D
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 11:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646996912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubOYBTjWDgmWI/Pv3haZrH78vumkBC3uFOp6PPrhPFM=;
 b=zxhH5e3DpF9L9LnRmMTFdsrAADqJVX8v8UqhdtlOatQZkmaDvKHNsfoYwVtV8MZIG6Ylzp
 FooSpqd50k72WnaSPCuMEsausUNdGOUSwxUNqESSQxSs+mm8VjFyPbkjdo4lGWgcDFJ9ib
 kTdFbdwblWNQAb4Hfnr+8kUpkkPWfMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646996912;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ubOYBTjWDgmWI/Pv3haZrH78vumkBC3uFOp6PPrhPFM=;
 b=8ZI0V8feURbMnRc8KZaTn04MakkJRSvW1zqJJRP7odvm4fZXUrAQDncn7Bm0jDJUOmtY3N
 kuqTVPJP8K89/4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFA8E13A85
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 11:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id N58SOa8tK2KuCQAAMHmgww
 (envelope-from <pvorel@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 11:08:31 +0000
Date: Fri, 11 Mar 2022 12:08:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <YistrlFBJ1/MW++z@pevik>
References: <20220311110015.20951-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220311110015.20951-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] nfs01_open_files: Fix pattern for deleted
 files
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

> Fixes: 0989fe65f3 ("Corrected the export lines in nfs01 ...")

commit 0989fe65f306 in 2001 changed the names of created files from apt to ltp,
but didn't change the names of deleted files.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
