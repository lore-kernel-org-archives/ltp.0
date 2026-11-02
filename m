Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AF606A326
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=DjcD3pQo;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=r+wz49CL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793617126; h=date : to :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bPzsKmtq9GlhVEi9pij/533wHTnMuXu79n0rcYmq+/8=;
 b=DjcD3pQoC7Gr6aklQIJG36Up8jqqSm67VWhOukMGsWr2t2/l3htfUFqp4czLvBgwShByp
 LmOQPLPO15fWI9dQT18nQLBxHNHxJpu6RH3uhhdEeFgTYDz9m22hl0USiIL30XD2z2yX+cG
 LowzFMKyNkHajCtIjqkv6o9g3CX9bT8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 131513E2781
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 11:58:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F8633CFD4A
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 11:58:25 +0100 (CET)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DEF9E6003AA
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 11:58:24 +0100 (CET)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id 3FF1C1A0E9386
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 11:57:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793617074; 
 s=s1; d=tuta.io;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
 bh=OpJ9MwtKTjYn4Oj6jWyRv3Ka95TBSeiUworjjQFroqs=;
 b=r+wz49CLiPS1ifvY9JZMXfHHk1p8Nr1pLwLsGYBPuZ3NnOQTgrOYFT4kPkcYDztX
 It7ufSgn5QjmZrviREr2tM27mST5nppMKdShnWqETEhz3LRijLkDiSv/MRTy/XMoeHm
 B5eTr7jDEBpYwFvcPt3bZcBaIEFCuI1HLLC0Srd9Xf6hdXBzc31qSgamDzhxWoUxrEk
 5+1RkTgVt7vT5kGvRNh56T6CbS/2VcWswDHx36JD5RllqBHLCc2JJt/jdt49TseC3lr
 J+EJX467MWo17YTVhyG7aIWmN5KdHd+S8jphWYbhaRJq3SwvpEuqC7pxoCnyGW+RBzi
 iGlX2daFkQ==
Date: Mon, 2 Nov 2026 11:57:54 +0100 (CET)
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <P5Qu8S_--F-9@tuta.io>
In-Reply-To: <CAOQ4uxhZL5Vk1NQ+Q4MW1f9kRLD0wWvAHZp-c8UwaESpyq+c-A@mail.gmail.com>
References: <P5I00QE--F-9@tuta.io>
 <CAOQ4uxhZL5Vk1NQ+Q4MW1f9kRLD0wWvAHZp-c8UwaESpyq+c-A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify26: Move from staging to syscalls
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Edvard Conrad via ltp <ltp@lists.linux.it>
Reply-To: Edvard Conrad <edvard@tuta.io>
Cc: Jan Kara <jack@suse.cz>, Edvard Conrad <edvard@tuta.io>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sun, Nov 1, 2026 at 5:46 PM Amir Goldstein <amir73il@gmail.com> wrote:
> So I think it is best wait for the other bug fix to land, hopefully
> sometime next week before moving the test out of staging.

Agreed. Petr, please drop this one. Once the directory fix has landed I
will send a single patch that moves fanotify26 to runtest/syscalls with
linux-git tags for both fixes, at whatever point you prefer for the
move.

Thanks,
Edvard

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
