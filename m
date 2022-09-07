Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470D2C38145
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 10:45:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A8953CA990
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 12:45:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766673C02C2
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 12:45:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F8881A00E5F
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 12:45:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4E2433CCB;
 Wed,  7 Sep 2022 10:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662547519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P549+kZ7ZjqJwZAqmBWWo0puT8U5CXFYaMA3mmLCo38=;
 b=T4Tsox2LycdoN7NS8hPl5Kgij1WdW2mKcfor6IcYtilNft9TuccuI9OqWH1TukqppC4T+L
 biGX89RQpytqf3LmTr+A4UzwvsLchv7DI/CGRMpkcVvdcJR08JTNNQnNT3MdQvq4rpXlk2
 tF9iovYtsQnCdSk2FO9ySAIfoMyXq6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662547519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P549+kZ7ZjqJwZAqmBWWo0puT8U5CXFYaMA3mmLCo38=;
 b=/+ZsyZ95Z/JNA8LXD9Dmo7XTlUrzJrYVIPgLHmL0mSnjKDTL+S77Xpa2zZ4sOTch8Fo7aI
 zyvagqncFKit09Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95B8B13A66;
 Wed,  7 Sep 2022 10:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cJQYIj92GGOFUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 07 Sep 2022 10:45:19 +0000
Date: Wed, 7 Sep 2022 12:45:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Yxh2Pbi4KSfYQ/vj@pevik>
References: <20220905154239.2652169-1-amir73il@gmail.com>
 <20220906153811.uigc6dfxsyes5fhi@quack3>
 <CAOQ4uxi1=4K5Epvx5oYEwbcL90o5Po=eySrkxt=uGuj-Whi7Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi1=4K5Epvx5oYEwbcL90o5Po=eySrkxt=uGuj-Whi7Hg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/9] Fanotify tests for FAN_MARK_IGNORE
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

patchset merged.

I tested it on various kernels, works as expected (old kernels TCONF; fanotify14
catches problems on 5.18.0 and 5.17.3, but 6.0.0-rc3 TPASS).

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
