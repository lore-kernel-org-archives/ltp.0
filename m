Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34602C83F1D
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 11:53:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B42E33CAEE3
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 13:53:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6B723C4F8C
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 13:53:24 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 399FE600734
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 13:53:21 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 240371D000FD;
 Thu, 10 Jul 2025 07:53:19 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 07:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1752148398;
 x=1752234798; bh=sje5hVMNJ8lPTMZdAUbJxjg9+p9H/ddbEIFabV5Qvsk=; b=
 H5g/QZFUxQ7xVn9yddlLHQ0YjxLDnqSf1BIV8mBUShvFeRMBDKhXER5GYcjHDGHd
 1fu88NUSLA5oyMVQRmQWMz1B7+4l9ejbI+srWjmtrTrLWXDQOpKyDL9MmErGWz61
 Se0y3wkbZ8xrJG8Dux+VBRUXWjvTMER0jxMNvpSriT8f/nY6/YURf69x7/YA0veZ
 jNolUp6MYMkGsJzyWOMrD52NUhyxW7XFRDftUTHcjHTnnFHB5YPw5Hh1aNA/R1nC
 +xDVH6GSJwS6MFWri1nJVOm58y+5ng76NnLNtWAXAgAWHLErjF2+Su5HLSNwkDim
 xRvgj/F+iSQg7w4UZ5BakQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752148398; x=
 1752234798; bh=sje5hVMNJ8lPTMZdAUbJxjg9+p9H/ddbEIFabV5Qvsk=; b=O
 PezGPcZCPi7/YI6RyX0H7hEWY6gO8J+wGDeVAv8ZJNDoAK9DK5xH5s7hL8PxkjCA
 2Q2Had7guZJC/veJIiFvpld6N2QkbQVd5zUkX/6kwgL+XLSgVa1/Pu6sxiiu/AZO
 Ug/3hVOYqetr6DcvUbuGcKkvTlgiuFJ4Ny7pSsK8z7nUnsOQxYd2fBVvrDwxM+tj
 6e6XjA9stwjgjlsXj++o68ZAOUMgn4UBQiCR1EwpXoEdKl9ysMIxh9BDEOxR/IY8
 1gzoFt6GaFcLmqtEFZSLiyEnWZyO8iTEa+nOCgT1kRGw0ZFzhTCt4Dr2Lh5RZNwm
 1HeSxPKYkwIXtnyfgio4g==
X-ME-Sender: <xms:rqlvaIL-OWtGobJ1BygHkArXG8NxhDInoaWQkevKsHA7E038cYk2Pw>
 <xme:rqlvaIJFKGavDtgfz1irQKtYLyk-9KN7jUFP1eDfAaVXq-jOCmvuWO7bN7R70Nt6-
 SB2zWaItmBeF_FGN9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtdefjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:rqlvaJgth2K4VWfvfXK_ydRAItC1dpGByAKUCbDdSiaZcbVLkOagTA>
 <xmx:rqlvaLuyELow4oH9maxfs-PYJk0tTRDa9z1vpUQQNzGdumf9o2makg>
 <xmx:rqlvaDiyb-hS6MjVhM7nn1HGTWos7O7P53HGbsfC_EI6u9pCX8xfmw>
 <xmx:rqlvaGdTFzdFQOPw6oZ3qgf08FBCwlB89Uvp3NIzEqAQUoD-Mo747Q>
 <xmx:rqlvaE2LP-vm7ChxAYptsC5zW5BZrB0ztKgF6gt4f-68g-j3q0sERj7d>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id F28FA700065; Thu, 10 Jul 2025 07:53:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tfdac8457399410f6
Date: Thu, 10 Jul 2025 13:52:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@infradead.org>
Message-Id: <50e77c3f-4704-4fb8-a3ac-9686d76fad30@app.fastmail.com>
In-Reply-To: <aG-dI2wJDl-HfzFG@infradead.org>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <aG92abpCeyML01E1@infradead.org>
 <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
 <aG-dI2wJDl-HfzFG@infradead.org>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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
 Christian Brauner <brauner@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Eric Biggers <ebiggers@google.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>, rbm@suse.com,
 linux-fsdevel@vger.kernel.org,
 Benjamin Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 10, 2025, at 12:59, Christoph Hellwig wrote:
>> I think the variant from commit 1b6d968de22b ("xfs: bump
>> XFS_IOC_FSGEOMETRY to v5 structures") where the old structure
>> gets renamed and the existing macro refers to a different
>> command code is more problematic. We used to always require
>> userspace to be built against the oldest kernel headers it could run
>> on. This worked fine in the past but it appears that userspace
>> (in particular glibc) has increasingly expected to also work
>> on older kernels when building against new headers.
>
> This is what I meant.  Note that the userspace in this case also keeps a
> case trying the old structure, but that does indeed require keeping the
> userspace somewhat in lockstep if you do the renaming as in this example.

Right, it's fine for applications that keep a copy of the uapi
header file, because they can implement both versions when they
update to the new version of that file.

Redefining the ioctl command code does break if you have an
unmodified application source tree that unintentionally uses
the updated /usr/include/linux/*.h file. In this case there is
no benefit from the new header because it isn't aware of the
new struct member but it still ends up failing on old kernels.

   Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
