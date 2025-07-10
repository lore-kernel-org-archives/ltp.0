Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA6BC83F1A
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 08:14:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4A563CAE63
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 10:14:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15B7A3C65DA
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:14:40 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E98201A00A2A
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 10:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AJpJ7CHfROH+35o2twlxL0uolXlA5ZgQUcP1WJNCmfw=; b=l0rdLHvSj8mPHA/M6NJjtoeqEZ
 HL47DtEGcn6xNC4Ly08/V+oJYgC4V84kLlwFgwKPd6cS0HU9n0haUiO9+eww/Fh0rRDnuoKQoX5s2
 LangJNsBPEC51RKRX6HuJAkwTpvh4z+W7MPMcFvYdxawwCQkwlFonOxfpcMTEt2qXJOihPgPk3HGN
 x9Vh5DlX2taCyr0rc5THuIolRXXPurch77quBXqIXJCyJHVl3BUjUDZovAliFpHXCSwc09RkN+evT
 Nr2UaXnLjNwKFj5JC698Hnsk8KJ10SfyLXXNhLcYXA0KwqAfx7ALKGVHqMIMwwxrYZOgtJqz4VIdM
 Fs4ZbI/w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1uZmQL-0000000B8Rp-1YiR;
 Thu, 10 Jul 2025 08:14:33 +0000
Date: Thu, 10 Jul 2025 01:14:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <aG92abpCeyML01E1@infradead.org>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Eric Biggers <ebiggers@google.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-kernel@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 dan.carpenter@linaro.org, rbm@suse.com, linux-fsdevel@vger.kernel.org,
 benjamin.copeland@linaro.org, ltp@lists.linux.it,
 Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 10, 2025 at 10:00:48AM +0200, Christian Brauner wrote:
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
> +       }

Yikes.  I really don't get why we're trying change the way how ioctls
worked forever.  We can and usually do use the size based macro already.
And when we introduce a new size (which should happen rarely), we add a
new entry to the switch using the normal _IO* macros, and either
rename the struct, or use offsetofend in the _IO* entry for the old one.

Just in XFS which I remember in detail we've done that to extend
structures in backwards compatible ways multiple times.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
