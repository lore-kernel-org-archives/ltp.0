Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB2C83F1D
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 10:12:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45CE73CAFCD
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 12:12:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 441523C218B
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 12:11:48 +0200 (CEST)
Received: from fout-b1-smtp.messagingengine.com
 (fout-b1-smtp.messagingengine.com [202.12.124.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8B8141000252
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 12:11:47 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal
 [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 748CE1D000CF;
 Thu, 10 Jul 2025 06:11:44 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-05.internal (MEProxy); Thu, 10 Jul 2025 06:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1752142304;
 x=1752228704; bh=ydaHlBV5gJlTgiENGrFYzr8bwPeWnPe7RkMn21aUeIM=; b=
 U48+wTGEOnDa0rOSVjCylRWZ4mgOPikGmxnGn6zgNKihmazbvsr7U0+UFWyvvrcw
 yW/7gfnf5XEPb7Z1stemw3LEdlE8jLr09LjTJLzm8tVuPjdgUDQP3BH5J6yuqQbz
 /xLvSJvqW0HxlAcMByG7jEhQI5tRmDJlpHyydLePkvUbdGWumU6foJMxdJLn4dcG
 5GLZT9hbAhvtoBhtBWuJq3Q2JdGjN/aUD1JFKy4fXr6xrJiVdlytoLHSAJQe+1xh
 XVOUYlclE7eChY3XX44no8J+8n3g9E+kxAbAD+KkLRRVFgf8bdHnNgsTrEFphPrW
 /WiNfXeGTgKIPcRwofBj2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752142304; x=
 1752228704; bh=ydaHlBV5gJlTgiENGrFYzr8bwPeWnPe7RkMn21aUeIM=; b=a
 S7MD8ca4kgudog25pPsFOzlN0Cg5w82G+y2083q8RY7l+scyECuzWqa5rZX2SgvN
 +J+jNYkaotWVW6wpJlkV2zVM59cGFKb2hQuMvl2kfbKS0p+pmBh5Zorhar1YzCP7
 4m3E+AU84M/gt+2ki6Do9mJv/t36WkXm6cUPYXgbbWjghYAjiZankWtNY6NgcpRi
 OZywdA9R6bnG/5NFqi+L9VYowuxINHEeCt2ZKpyNYY3tDCF2MeF2QFKUL2WRKQXy
 ASLS+GZGDXiLQnOUZwWS/OXQV5KQWZKXSBRCtQDGXbiMKlK+4tjeGuWyDm+Wu2gP
 5sGQavnvyltc3+9h9+pKg==
X-ME-Sender: <xms:35FvaDJFn-2y4V7KEfI0Uh8UTKDqPcODQ7KU_jVgLuxQ4Giqyahk1g>
 <xme:35FvaHJ-CbPByJZGY8DchBoPuZjBRroyUbdiS_0jLArK4dKAetXE4OjHTiMTF015H
 W6eYJUyI7fF_h5LAsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegtddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
 uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
 hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
 esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhht
 pdhrtghpthhtoheprgguohgsrhhihigrnhesghhmrghilhdrtghomhdprhgtphhtthhope
 grshhmlhdrshhilhgvnhgtvgesghhmrghilhdrtghomhdprhgtphhtthhopegvsghighhg
 vghrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrd
 gukhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghr
 rghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughjfihonhhgsehkvghrnh
 gvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdrrhhogigvlhhlsehlihhnrghrohdr
 ohhrghdprhgtphhtthhopegsvghnjhgrmhhinhdrtghophgvlhgrnhgusehlihhnrghroh
 drohhrgh
X-ME-Proxy: <xmx:35FvaCltc2zsvaaY_Md0KzCHB0PMLi4OisOpT4_ZCT0g2MVeVmWK7A>
 <xmx:35FvaO9EYyuoJqzan-TGmKsPz1_3lEWLrdnwjEaKCin3aDeWsDmW6Q>
 <xmx:35FvaDnrWPRhBYPyGervbtbFavwcCCIlGk8rYgBvqIqdtF_dqPvygg>
 <xmx:35FvaMmlCWdmTnvRpMa84ndCLVe5M3Ljd_d_-19qvs8bYgax4FYmCg>
 <xmx:4JFvaL6SHoLpYaV_TxPFRoEf_GlqruVC7gwsoNTvNnHh8X-YO7M_5h7V>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 27641700065; Thu, 10 Jul 2025 06:11:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Tfdac8457399410f6
Date: Thu, 10 Jul 2025 12:11:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Message-Id: <d2e1d4a9-d475-43e3-824b-579e5084aaf3@app.fastmail.com>
In-Reply-To: <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
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
Cc: Jens Axboe <axboe@kernel.dk>,
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

On Thu, Jul 10, 2025, at 10:00, Christian Brauner wrote:
> On Wed, Jul 09, 2025 at 08:10:14PM +0200, Arnd Bergmann wrote:

>> +	if (_IOC_DIR(cmd)  == _IOC_DIR(FS_IOC_GETLBMD_CAP) &&
>> +	    _IOC_TYPE(cmd) == _IOC_TYPE(FS_IOC_GETLBMD_CAP) &&
>> +	    _IOC_NR(cmd)   == _IOC_NR(FS_IOC_GETLBMD_CAP) &&
>> +	    _IOC_SIZE(cmd) >= LBMD_SIZE_VER0 &&
>> +	    _IOC_SIZE(cmd) <= _IOC_SIZE(FS_IOC_GETLBMD_CAP))
>
> This part is wrong as we handle larger sizes just fine via
> copy_struct_{from,to}_user().

I feel that is still an open question. As I understand it,
you want to make it slightly easier for userspace callers
to use future versions of an ioctl command by allowing them in
old kernels as well, by moving that complexity into the kernel.

Checking against _IOC_SIZE(FS_IOC_GETLBMD_CAP) would keep the
behavior consistent with the traditional model where userspace
needs to have a fallback to previous ABI versions.

> Arnd, objections to writing it as follows?:

> +       /* extensible ioctls */
> +       switch (_IOC_NR(cmd)) {
> +       case _IOC_NR(FS_IOC_GETLBMD_CAP):
> +               if (_IOC_DIR(cmd) != _IOC_DIR(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_NR(cmd) != _IOC_NR(FS_IOC_GETLBMD_CAP))
> +                       break;
> +               if (_IOC_SIZE(cmd) < LBMD_SIZE_VER0)
> +                       break;
> +               if (_IOC_SIZE(cmd) > PAGE_SIZE)
> +                       break;
> +               return blk_get_meta_cap(bdev, cmd, argp);

The 'PAGE_SIZE' seems arbitrary here, especially since that is often
larger than the maximum size that can be encoded in an ioctl command
number (8KB or 16KB depending on the architecture). If we do need
an upper bound larger than _IOC_SIZE(FS_IOC_GETLBMD_CAP), I think it
should be a fixed number rather than a configuration dependent
one, and I would prefer a smaller one over a larger one. Anything
over a few dozen bytes is certainly suspicious, and once it gets
to thousands of bytes, you need a dynamic allocation to avoid stack
overflow in the kernel.

I had already updated my patch to move the checks into
blk_get_meta_cap() itself and keep the caller simpler:

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 9d9dc9c32083..2909ebf27dc2 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -62,10 +62,13 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
        struct logical_block_metadata_cap meta_cap = {};
        size_t usize = _IOC_SIZE(cmd);
 
-       if (!argp)
-               return -EINVAL;
-       if (usize < LBMD_SIZE_VER0)
-               return -EINVAL;
+       if (_IOC_DIR(cmd)  != _IOC_DIR(FS_IOC_GETLBMD_CAP) ||
+           _IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP) ||
+           _IOC_NR(cmd)   != _IOC_NR(FS_IOC_GETLBMD_CAP) ||
+           _IOC_SIZE(cmd) < LBMD_SIZE_VER0 ||
+           _IOC_SIZE(cmd) > _IOC_SIZE(FS_IOC_GETLBMD_CAP))
+               return -ENOIOCTLCMD;
+
        if (!bi)
                goto out;
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 9ad403733e19..af2e22e5533c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
                               void __user *argp)
 {
        unsigned int max_sectors;
+       int ret;
 
-       if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
-               return blk_get_meta_cap(bdev, cmd, argp);
+       ret = blk_get_meta_cap(bdev, cmd, argp);
+       if (ret != -ENOIOCTLCMD)
+               return ret;
 
        switch (cmd) {
        case BLKFLSBUF:

Regardless of what upper bound we pick, that at least limits
the complexity to the one function that actually wants it.

> And can I ask you to please take a look at fs/pidfs.c:pidfd_ioctl() and

PIDFD_GET_INFO has part of the same problem, as it still fails to
check the _IOC_DIR() bits. I see you added a check for _IOC_TYPE()
in commit 091ee63e36e8 ("pidfs: improve ioctl handling"), but
the comment you added describes an unrelated issue and the fix
was incomplete.

> fs/nsfs.c:ns_ioctl()?

You tried to add a similar validation in commit 7fd511f8c911
("nsfs: validate ioctls"), but it seems you got that wrong
both by missing the _IOC_DIR check and by having a typo in the
'_IOC_TYPE(cmd) == _IOC_TYPE(cmd)' line that means this is
always true rather than comparing against 'NSIO'.

Overall my feeling is similar to Christoph's, that the added
complexity in any of these three cases was a mistake, as it's
too easy to mess it up.

     Arnd

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
