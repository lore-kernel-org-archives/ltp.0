Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FFAC77B73
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 11:29:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31F613CE7CB
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 13:29:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F1503CAC01
 for <ltp@lists.linux.it>; Wed, 24 May 2023 13:29:07 +0200 (CEST)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5BD516007A3
 for <ltp@lists.linux.it>; Wed, 24 May 2023 13:29:07 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 466F05C014E;
 Wed, 24 May 2023 07:29:06 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Wed, 24 May 2023 07:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1684927746; x=1685014146; bh=Dk
 ZDQE6py1T70Nun2afUAHBUj+DwKgk6UL7vXpX8QhQ=; b=OuajjyOEvj2z0UCkI7
 8yNJDmgeFVs1eUVzmQ5GKJRwZqwMPElMNUE273nEdCDnUINRM3t7yJJhhoepWyyK
 ZNuzVOznd/3/kzU7bo7e9/CMTcIQCV8yOTyjuVL01iN1JepJg4BYZdSRLIh+NDhU
 g7XzTMI4cmf32JyyTYBQ+bio/yi4mrDh7Lzm8hT9n0WC9D7GUtd96mWeGMFTl0i8
 3fFHMJY9cDQEIZmgCZx/KX1qRGGvjXPHL4DUsHr3oDKV9D5PqMfXlzWee2BnjwLa
 CjUMmPHhydmWWjBC9ZClY5PvoUit0s0rTV1PaGF20AvCk3Vo7aFcqIVGru+i6FqL
 mQtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684927746; x=1685014146; bh=DkZDQE6py1T70
 Nun2afUAHBUj+DwKgk6UL7vXpX8QhQ=; b=lap2AWzgSkO2/ftKQvEQc+TE2KWFr
 vYBw6aE/5tK9iGQTlFTT4ukU+WrSyq2QGdbrOnahz0DvuzzfLnNFmshvCKTsWF4O
 5oDoq+AkiaiBO+GCP1dt9MBpb5CFO6pMpwW2VhCNVnwXd2Y++/KHjWByWT1tU99n
 541mExHgts3zT2nzGQQ2aHHkd9m6do9IVPHHlUbYb3FoeCQLcYPPWxeCPh7AfHRe
 68sGTQ8VfV6h6CIeu0Os0A7ZpQ9gvppDyUgIYO3nmYahiz09b9qMBe5UXJMKRDky
 7dZ9N244N353p/qBaOTFO/G3IKA0CfOK/XuHLcpGQK2mPa/fiBDwH2RkA==
X-ME-Sender: <xms:AfVtZG3gsNWYMMiA6FxF_mm37tpjTSU1iLWP12Ipl_8HYeOPSLCjog>
 <xme:AfVtZJGYY5jLeejDyC9ymqGBvpF_7DzCDoDpwDb7sexJYVn5nEnjmYHWgawOVpQ_c
 k1diJvq5m53fBIswco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgfeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepvdefjeevfefhvdevjeeuheefieetvdduheeludevtdefhfekleduhfdvjedt
 ieeinecuffhomhgrihhnpehlfihnrdhnvghtnecuvehluhhsthgvrhfuihiivgeptdenuc
 frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AfVtZO6Thrhqy1bi8COkH1ttpx9Wv6hEGizb6gfpceRrO3bIWqX4aQ>
 <xmx:AfVtZH08gIKPotE-OJ0TC6eyCBRYqM0xkdLfMxJMF1JFjbEuCLwnaQ>
 <xmx:AfVtZJHTcSwXtAolEWFq8t-pSj9nw1RR7dnlwvLXPpcgYOT4LaPFzA>
 <xmx:AvVtZIB2wYixFc3Fyw7Jh-UW_3NDtXrNPix_kcGBHItHZek46ErRZw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id A7548B60086; Wed, 24 May 2023 07:29:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <dca09245-5b59-438b-b7d6-c65db7a84a85@app.fastmail.com>
In-Reply-To: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
References: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
Date: Wed, 24 May 2023 13:28:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "LTP List" <ltp@lists.linux.it>, "open list" <linux-kernel@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
 "Jeff Layton" <jlayton@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: syscalls: statx06.c:138: TFAIL: Modified time >
 after_time
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
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, May 24, 2023, at 12:48, Naresh Kamboju wrote:

>
> ...
>
> [ 1192.088987] loop0: detected capacity change from 0 to 614400
> tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256'
> extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> [ 1192.337350] EXT4-fs (loop0): mounted filesystem
> dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
> mode: none.
> tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
>
> statx06.c:140: TPASS: Birth time Passed
> statx06.c:138: TFAIL: Modified time > after_time
> statx06.c:140: TPASS: Access time Passed
> statx06.c:140: TPASS: Change time Passed

I found a description in

https://lwn.net/ml/linux-kernel/20230503142037.153531-1-jlayton@kernel.org/

which indicates that this is expected. Added Jeff to Cc in case
I'm misreading his explanation.

     Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
