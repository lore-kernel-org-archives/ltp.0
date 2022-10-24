Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD9FECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 13:17:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB4B03C97FA
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 15:17:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ADA93C0727
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 15:16:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BE2EC60074B
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 15:16:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 134811FD56;
 Mon, 24 Oct 2022 13:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666617416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2SZLgz/ZO0paBD8TZh+mTrF8A5anmdyg1zZEczE8ms=;
 b=KNW0CpTUMe99RVNiadhJNm9KFTYQj5m1Z/5yaD+9Sz66lJBA6kVu66Ni8krNYLgPIqfbAb
 RbPPxofuV2XIf8PhWS7cwnBkMmo9DRAyvVF8NyD5HkooUok8WNFa2JfHhQ9SIx/X5M40Zw
 bDO6n5NAAbyFBNXDPNFFgD2tRstVKpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666617416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2SZLgz/ZO0paBD8TZh+mTrF8A5anmdyg1zZEczE8ms=;
 b=ywH/qbDgHq0tgaXCTO5EYMAdH9iD1p5xEfq3theELsH4cy1Qtk1YtCvv5apFKJx3VOOdbP
 MooueRhc5oWyKICQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE25313357;
 Mon, 24 Oct 2022 13:16:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id O0pHOUeQVmNcdgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 24 Oct 2022 13:16:55 +0000
Message-ID: <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
Date: Mon, 24 Oct 2022 15:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 24. 10. 22 15:08, Amir Goldstein wrote:
> Why is skipping the test better than passing the test?
> 
> The test wants to know that a specific flag combination is not allowed.
> 
> It is particarly not allowed also on old kernels that do not support 
> either individual flag.
> 
> What's the difference?
> 
> Who is going to gain anything from this change?
> 
> Sorry for being strict on this point
> I may be missing something.
> 
> Please clarify what it is the problem use case is and I will suggest a 
> solution, because I disagree with this solution.

We're running fanotify14 on kernel 5.3 and one of the subtests (test 
case #8) is using a flag that was added in kernel 5.9. But in this case, 
fanotify_init() is supposed to pass and then fanotify_mark() is supposed 
to fail because of mismatch between mark() and init() flags. I'm trying 
to fix this particular subtest failure caused by wrong feature check.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
