Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA908C3DA79
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 14:15:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E01E3CCB7C
	for <ltp@archiver.kernel.org>; Mon, 15 Jan 2024 15:15:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A5763CB3DC
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 14:34:42 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=damenly.org (client-ip=136.175.108.105;
 helo=mail-108-mta105.mxroute.com; envelope-from=l@damenly.org;
 receiver=lists.linux.it)
Received: from mail-108-mta105.mxroute.com (mail-108-mta105.mxroute.com
 [136.175.108.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E37AC1B601D0
 for <ltp@lists.linux.it>; Fri, 12 Jan 2024 14:34:40 +0100 (CET)
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta105.mxroute.com (ZoneMTA) with ESMTPSA id
 18cfde1abf30003727.005 for <ltp@lists.linux.it>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 12 Jan 2024 13:34:34 +0000
X-Zone-Loop: 694dcc78b987041cd980dd9b5afc9c2ca91f65fba84c
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
 ; s=x;
 h=Content-Type:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:To:
 From:References:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w063HSJyW1ImjwCr5PeZnn5DHNc2eDTl35iwzvMc8iU=; b=F57URQyRqOhdnflP2xaEA5e49y
 zrHK94RafbXZBNnGBh6LeplVvACf33wxkghqswER47SEwLM03rvvMEcBTwU4USCFL81zjvOebIaRv
 SGj1lHmtdiwdjgYPEmFg0bRSzu7pUc8mIPjHmNic7SQB9QDSnBwOqeRPzmNZqQUTVVINps6A9ee7J
 fm35yXrJUhHT1XUAFIPm5M7/N3xRc0memS0giQ/p01bmOBInQIHcG9G5kul+B7qcAGUmpmYnjRVlk
 +gW8iQkPV+8f+CBAnw3Y9+G/0SWlfJNryqnLGb71dmvdT6o5SWvjFqaM9EtPCQWPT935nI2o8xaGn
 dbBZT0IA==;
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-2-pvorel@suse.cz>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Date: Fri, 12 Jan 2024 21:18:18 +0800
In-reply-to: <20231207194011.273027-2-pvorel@suse.cz>
Message-ID: <frz27k44.fsf@damenly.org>
MIME-Version: 1.0
X-Authenticated-Id: l@damenly.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 15 Jan 2024 15:15:05 +0100
Subject: Re: [LTP] [PATCH v2 1/3] lib: Add Bcachefs magic
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
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 Richard Palethorpe <rpalethorpe@suse.com>, linux-bcachefs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On Thu 07 Dec 2023 at 20:40, Petr Vorel <pvorel@suse.cz> wrote:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v2
>
>  include/tst_fs.h  | 3 +++
>  lib/tst_fs_type.c | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/include/tst_fs.h b/include/tst_fs.h
> index eb9841165..06f5be896 100644
> --- a/include/tst_fs.h
> +++ b/include/tst_fs.h
> @@ -34,6 +34,9 @@
>  #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
>  #define TST_EXFAT_MAGIC    0x2011BAB0UL
>
> +/* fs/bcachefs/bcachefs_format.h */
> +#define TST_BCACHE_MAGIC		0xca451a4e
> +
>
Not object to the patch. There are three MAGIC values in
bcachefs_format.h: BCACHE_MAGIC, BCHFS_MAGIC, 
BCACHEFS_STATFS_MAGIC.

IIUC, BCACHE_MAGIC is the older one in superblock, BCHFS_MAGIC is 
the
new one. BCACHEFS_STATFS_MAGIC is for statfs.
Kent,
Would you please export needed magic values to 
include/uapi/linux/magic.h?
Since you are the maintainer also I'm confused about variables to 
be named.

--
Su

>  enum tst_fill_access_pattern {
>  	TST_FILL_BLOCKS,
>  	TST_FILL_RANDOM
> diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
> index d9c9c0817..7f0d61a8e 100644
> --- a/lib/tst_fs_type.c
> +++ b/lib/tst_fs_type.c
> @@ -36,6 +36,8 @@ const char *tst_fs_type_name(long f_type)
>  		return "9p";
>  	case TST_RAMFS_MAGIC:
>  		return "ramfs";
> +	case TST_BCACHE_MAGIC:
> +		return "bcachefs";
>  	case TST_BTRFS_MAGIC:
>  		return "btrfs";
>  	case TST_XFS_MAGIC:

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
