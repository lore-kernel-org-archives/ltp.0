Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A164BC83F17
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 10:52:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 193F53CAEE3
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 12:52:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE0803CA855
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 12:52:36 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1EFFC1A00646
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 12:52:35 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 163291D0022C;
 Thu, 10 Jul 2025 06:52:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 06:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1752144753;
 x=1752231153; bh=0gfneUvxMhMOudwcTkveb+Z5iH50FPbib15VirueTyI=; b=
 DgfJaqBEjtIWo2qVEqkhwea8XYJMPKrVGxlbUAi9PIu03TiZf7gJl3Zut9N7BKQ6
 qtZGybcI0toS7/KR5vVAjR7KbmO/MvBHGKdcndbniM5NgWipl6bX226HPiEsXUe+
 pXTa23UkM+VtnRuW7Ws5hJyVCKpN7RVb5KyOf/Ak0s48xr3SOIo92E6BbTwcPWCx
 Ta0KPigiRSTDtj1UIT+yjKBbUY7VhGHTlrv6GqRH+2AwlWDv/OqEX8SVuMEGlS3e
 5iFZO2oZJtSKndxmAOR5jhz2wi+BJVU1PgC97r8M/afkcR6dyf7t95+JtTTo0Zew
 Uehu2qceNyMAqAIat9n5cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752144753; x=
 1752231153; bh=0gfneUvxMhMOudwcTkveb+Z5iH50FPbib15VirueTyI=; b=E
 nmjG3mzp5sEJUZnbnQkz+hdKdkkioCFPR6lKGFY5qWNfnFMCsaZSHHsYeu9j17Kw
 FKhL0UCBDQRBLWSIOUFK1BpX4iB4NQJ856cXHbH+Kp9VHDFsGUEYxseeKJRE1ozf
 3yJuHUcaLnXi009fu34OUcyuKUNs/2ClWaanfE/GffphxmP07A2d/djGxiJ/2B2A
 RDRlYHWje9y9Z6IvSWikW66m7qc/VPiXT9vo/19F9BcmskS0Zr3MVBAtpyARG5Bm
 oW9XkC0tF9O2HhyMkY4xPchv5Gw0Z7CPKBdegZ8R3uhDXKnU/OTHNRlZwn8ze4JB
 L5oqs+zU+wQHN5YrwwIxg==
X-ME-Sender: <xms:cJtvaP005eWpEdmFaymEdxcaAJGkzaz37r65MTMJAr4lHADwgcBiHw>
 <xme:cJtvaOH5ZFfTGN5VZVK0i0mo_CvhVMsaInJ-0G8uzwtLfP1HfULVAqITYYNxp8mGS
 CbOqv4SDcVab_RwToY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtddvhecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
 uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
 hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
 esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtoheprgguohgsrhhihigrnhesghhmrghilhdrtghomhdprhgtphhtthhope
 grshhmlhdrshhilhgvnhgtvgesghhmrghilhdrtghomhdprhgtphhtthhopegvsghighhg
 vghrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrug
 drohhrghdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohep
 rghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
 gvlhdrohhrghdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheprghnuggvrhhsrdhrohigvghllheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:cJtvaAuqYlQlUJeKbet9nZFqgeMjEc0kOTwx088LF1qDjgKX5pD10Q>
 <xmx:cJtvaLIBWFqS9N-t8QW8M71CJ0Lo1iRci2SSJSr348iIK8fB5SfBSA>
 <xmx:cJtvaGM7cjVb2gvoebFnm7vkAvq5-ugmuPKDngwpOg5yN7A7dKafaw>
 <xmx:cJtvaLZcDAY_5q9FQvnhQByEAPz7-_IdJ_KFU4S1su_9Dql8BgBnTA>
 <xmx:cZtvaJS1pwPhZ921JckyTbzO7XnBE8E9IQ6WPHQMs8CCnqftNbveDcwy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id BE797700069; Thu, 10 Jul 2025 06:52:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tfdac8457399410f6
Date: Thu, 10 Jul 2025 12:50:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>,
 "Christian Brauner" <brauner@kernel.org>
Message-Id: <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
In-Reply-To: <aG92abpCeyML01E1@infradead.org>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <aG92abpCeyML01E1@infradead.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
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
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Eric Biggers <ebiggers@google.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 rbm@suse.com, linux-fsdevel@vger.kernel.org,
 Benjamin Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 10, 2025, at 10:14, Christoph Hellwig wrote:
> On Thu, Jul 10, 2025 at 10:00:48AM +0200, Christian Brauner wrote:
>> +       switch (_IOC_NR(cmd)) {
>> +       case _IOC_NR(FS_IOC_GETLBMD_CAP):
>> +               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
>> +                       break;
>> +               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
>> +                       break;
>> +               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
>> +                       break;
>> +               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
>> +                       break;
>> +               if (_IOC_SIZE(cmd) > PAGE_SIZE)
>> +                       break;
>> +               return blk_get_meta_cap(bdev, cmd, argp);
>> +       }
>
> Yikes.  I really don't get why we're trying change the way how ioctls
> worked forever.  We can and usually do use the size based macro already.
> And when we introduce a new size (which should happen rarely), we add a
> new entry to the switch using the normal _IO* macros, and either
> rename the struct, or use offsetofend in the _IO* entry for the old one.
>
> Just in XFS which I remember in detail we've done that to extend
> structures in backwards compatible ways multiple times.

There are multiple methods we've used to do this in the past,
but I don't think any of them are great, including the version
that Christian is trying to push now:

The most common variant is to leave extra room at the end of
a structure and use that as in your 1fd8159e7ca4 ("xfs: export zoned
geometry via XFS_FSOP_GEOM") and many other examples.
This is probably the easiest and it only fails once you run out of
spare room and have to pick a new command number. A common mistake
here is to forget checking the padding in the input data against
zero, so old kernels just ignore whatever new userspace tried
to pass.

I think the variant from commit 1b6d968de22b ("xfs: bump
XFS_IOC_FSGEOMETRY to v5 structures") where the old structure
gets renamed and the existing macro refers to a different
command code is more problematic. We used to always require
userspace to be built against the oldest kernel headers it could run
on. This worked fine in the past but it appears that userspace
(in particular glibc) has increasingly expected to also work
on older kernels when building against new headers.

Adding a new command code along with the new structure as in
cc68a8a5a433 ("btrfs: new ioctl TREE_SEARCH_V2") is probably
better here: While this does require userspace to have code
for calling either version, building an old program against
the new header still does the right thing and works on both
old and new kernels.

Christian's version using the copy_struct_{from,to}_user()
aims to avoid most of the problems. The main downside I see
here is the extra complexity in the kernel. As far as I can
tell, this has mainly led to extra kernel bugs but has not
actually resulted in any structure getting seamlessly
extended.

      Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
