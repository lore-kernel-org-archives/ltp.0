Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75077C83F09
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 14:10:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E13AA3CAD21
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 16:10:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8740F3C65DA
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 16:10:03 +0200 (CEST)
Received: from fout-a1-smtp.messagingengine.com
 (fout-a1-smtp.messagingengine.com [103.168.172.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2473606A6F
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 16:10:01 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.phl.internal (Postfix) with ESMTP id C1842EC04E8;
 Wed,  9 Jul 2025 10:09:59 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 10:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1752070199;
 x=1752156599; bh=OXiuJfa6GzzwWykYEMepJESwQapIIKQPPmHJ+Tf85BQ=; b=
 RU2Hgw1MuM8b2gVsM5NxXSn7wjdJEuabk3tdZCwVd9Y5SSD1DgZOmCjZgTMeAm8/
 Hifn/RJOq6PaGfgCl9V39D8zyZC6ZZQX3mCzllQ+njxcTYTiqcIlnC8CQ7IO2RU8
 hpJg4w1ntaLGXOioYOH1NtXONC+94Ds2KRxYa0M7EWsKywkNKHnfkMgX8xGY+42U
 bIddLRdDdecU3JzbvwXnvKT3OC/nmBjBJG26EV6fr0kqI3hWx5QiJOnWl23ejk9S
 URMoM96nbPolOSo372vR+HI5eOfcN77YfC5jJyp9CxEh8cFRB4qS13tLayBXpnhG
 5L7dmUuyTc/vldr0OwupBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752070199; x=
 1752156599; bh=OXiuJfa6GzzwWykYEMepJESwQapIIKQPPmHJ+Tf85BQ=; b=n
 9Q3AGEzMpSjTI0dCEGaf/0MZQw5OEUMcMsnLpP4IM3M5hmtgHiSXhCuzs8mJXHlX
 H8l2Dxg6tBjeeawP/oYPW9PhFOCL08im0LkMa3FDnfHIJWV8o0k0LZl27NWi28ec
 thIN4M6um3zt90IMcPozFNklW9dZXZoNjWHe0qm9/iUSjLCao581xHYw3X7W6OtC
 zZcZWjmAyQsWLRJxTMtjvZEm4Ad9NtTL8QbaGXlkCGlZ5buBEJJhuZN8NT5Y1M7Q
 geTMwiTonTMVHNPXTjgh/nvUE+avsoTbMjQx1wJorCHtIKjoDN9QvZHNBRNpaLMu
 GlL5GAWGBRuzkRMFw5WiQ==
X-ME-Sender: <xms:NnhuaLGNSpYSHqJVnMiULv2h0ByQ5qAww3mrZPb-KWk_64bi1PpGNQ>
 <xme:NnhuaIV2LV44mWStCa-ZwX2laSsrhz7JvmZmRM_kFXeDSQnXgifjZoL1FFDrKtIHL
 NQHcy9HJRrEqBAKw0k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejjecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
 uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
 hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
 esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
 grgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhn
 vghlrdhorhhgpdhrtghpthhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhord
 horhhgpdhrtghpthhtohepsggvnhhjrghmihhnrdgtohhpvghlrghnugeslhhinhgrrhho
 rdhorhhgpdhrtghpthhtohepuggrnhdrtggrrhhpvghnthgvrheslhhinhgrrhhordhorh
 hgpdhrtghpthhtohepnhgrrhgvshhhrdhkrghmsghojhhusehlihhnrghrohdrohhrghdp
 rhgtphhtthhopehlkhhfthdqthhrihgrghgvsehlihhsthhsrdhlihhnrghrohdrohhrgh
 dprhgtphhtthhopehlthhpsehlihhsthhsrdhlihhnuhigrdhith
X-ME-Proxy: <xmx:NnhuaOC3XXADYW-FsyPw-X5u6Qq5HKgoZ0V7N97HVOXeVgVXQTX4Jg>
 <xmx:NnhuaOTS5gAWkDPz0h6urrY8qLKIn-AbqiOtanzEdU-op6_jB-2bDA>
 <xmx:NnhuaPrx88Gi5Z0HpJNfzeNbDNymXSJSLp9-HwbRCkcNHIle_V6lTA>
 <xmx:NnhuaHWK0Ke-jQEy3F6nTSgH0tvn8A5dIwt1T5okM-EGcuxc_cjyGA>
 <xmx:N3huaFviz_ZIc3uK5VG5NJtYuRyA08PK23qjjhuZLall_bACdCY7Ixs0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 772AB700069; Wed,  9 Jul 2025 10:09:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tc5542b2421753b41
Date: Wed, 09 Jul 2025 16:09:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "LTP List" <ltp@lists.linux.it>, "open list" <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, linux-fsdevel@vger.kernel.org,
 linux-block <linux-block@vger.kernel.org>
Message-Id: <61787165-8559-4ad6-90db-5ab6ee5e6fd9@app.fastmail.com>
In-Reply-To: <CA+G9fYs=3LHdf1ge1MiCoCOUpW=VjPdVWrNJX8+wi7u6N18j3Q@mail.gmail.com>
References: <CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com>
 <CA+G9fYs=3LHdf1ge1MiCoCOUpW=VjPdVWrNJX8+wi7u6N18j3Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: syscalls: TWARN ioctl(/dev/loop0, LOOP_SET_STATUS,
 test_dev.img) failed EOPNOTSUPP (95)
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
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Matthew Wilcox <willy@infradead.org>,
 rbm@suse.com, Kanchan Joshi <joshi.k@samsung.com>,
 Benjamin Copeland <benjamin.copeland@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 9, 2025, at 15:48, Naresh Kamboju wrote:
> On Tue, 8 Jul 2025 at 18:28, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> Regressions were observed while testing LTP syscalls cachestat01 and
>> other related tests on the next-20250702 Linux kernel across several devices.
>>
>> The issue appears to be related to the inability to configure /dev/loop0
>> via the LOOP_SET_STATUS ioctl, which returned EOPNOTSUPP
>> (Operation not supported). This results in a TBROK condition,
>> causing the test to fail.
>
> Anders, bisected this down to this commit id,
>    # first bad commit:
>        [9eb22f7fedfc9eb1b7f431a5359abd4d15b0b0cd]
>        fs: add ioctl to query metadata and protection info capabilities

I see the problem now in

+       if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
+               return blk_get_meta_cap(bdev, cmd, argp);
+

This only compares _IOC_NR() but not _IOC_TYPE, so LOOP_SET_STATUS
is treated the same as FS_IOC_GETLBMD_CAP, since both use '2' in
the lower 8 bit.

include/uapi/linux/fs.h:#define FS_IOC_GETLBMD_CAP              _IOWR(0x15, 2, struct logical_block_metadata_cap)
include/uapi/linux/loop.h:#define LOOP_SET_STATUS               0x4C02

I checked a couple of other drivers using _IOC_NR(), and it seems
that they many of them have the same bug, e.g.:

drivers/accel/habanalabs/common/habanalabs_ioctl.c
drivers/block/ublk_drv.c
drivers/dma-buf/dma-heap.c

    Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
