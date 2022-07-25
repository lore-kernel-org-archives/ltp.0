Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09105C43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 11:23:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A76DB3CA0D3
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 13:23:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 912083C0775
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 13:23:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F90C2003B7
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 13:23:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7357E37B2A;
 Mon, 25 Jul 2022 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658748202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30PMsyCneGPUaPnCMuuwbmpYZCoGABKiNxx1usAfQ9g=;
 b=QjUn1Cln0d5UineNTqhCxwMd4ZaDRGSrbDy0kJNvQOckSzoR/Ylsfs+EmocMja4SwYKu+S
 eYPD4CR9oEfLUYLoKKmXxfwfuyiBCti52VY/Uspp/jC5Do+vzdLo8dLmnw1JbzQGG4uqaO
 lxRArewhGBBmby63VSAvfhcD0DES1y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658748202;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=30PMsyCneGPUaPnCMuuwbmpYZCoGABKiNxx1usAfQ9g=;
 b=1m4JJsycDt6SsUnPvyRHLnRBRYijIQYyLry27UONkd5wQyt5PfCHidthqsGyAqpSU+6gGD
 WPD5Fb/1AbuASvAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 358E913ABB;
 Mon, 25 Jul 2022 11:23:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZYXCCip93mK2RAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Jul 2022 11:23:22 +0000
Date: Mon, 25 Jul 2022 13:23:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <Yt59KJwnkIC8Dtkh@pevik>
References: <20220620132737.2015073-1-amir73il@gmail.com>
 <20220620132737.2015073-5-amir73il@gmail.com>
 <20220621083422.gsbc55oi6wbaplh6@quack3.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220621083422.gsbc55oi6wbaplh6@quack3.lan>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/fanotify09: Add test cases for merge
 of ignore mask
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
Cc: Matthew Bobrowski <repnop@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir, Jan,

> OK, after Amir cleared my confusing things looks good to me. Feel free to
> add:

Thanks for your work on fanotify tests.
Patches are good as always, merged.

Kind regards,
Petr

> Reviewed-by: Jan Kara <jack@suse.cz>

> 								Honza

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
