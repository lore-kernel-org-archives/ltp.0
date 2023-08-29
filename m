Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC185C71153
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 05:38:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6CF93CC063
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 07:38:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B07633C93E5
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 07:38:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 81FA1100098C
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 07:38:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6416A2186F;
 Tue, 29 Aug 2023 05:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693287484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pI22/jwZp/dw1WxW8jGZeQbyniCt8v6NK+BDwlWZTd0=;
 b=Ichr7kmbiuQbmhP0XWZDDwTSJsOSutcSBz1ZrYyPS7x51raRpfysthjw3EA2Rpgs8HsMx7
 utSeoASwRe5K+v0aOI1gp7KiC7E+e6YIFLuKQJlSyNmeewdWWZyNnY4wAB1EEY3WU/A8U8
 uogI2TUlDl9jpIeodZbPF+BxmaAqgGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693287484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pI22/jwZp/dw1WxW8jGZeQbyniCt8v6NK+BDwlWZTd0=;
 b=wASX3+s3no2BycrY8Y+AhVyvfANhVHGw3wO9iJztU+zESOgt9nU6vSLSE46L4z5dcUgfIe
 ZRq/5ZDdTGP+bACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8F9513513;
 Tue, 29 Aug 2023 05:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TRDqJTuE7WQ3ZgAAMHmgww
 (envelope-from <akumar@suse.de>); Tue, 29 Aug 2023 05:38:03 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Tue, 29 Aug 2023 11:08:01 +0530
Message-ID: <2832137.Oz9D4KcPff@localhost>
Organization: SUSE
In-Reply-To: <1692963336-4007-2-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1692963336-4007-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692963336-4007-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] hugeshmctl03: Mark struct tcase and
 several functions as static
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang,

Changes looks fine, but I see that there are still make-check warnings for
both these tests. You may want to fix them also or maybe another commit.

Reviewed-by: Avinesh Kumar <akumar@suse.de>
for both the patches.

On Friday, August 25, 2023 5:05:36 PM IST Yang Xu wrote:
> To follow LTP conventions.
> 
> Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
> b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c index
> 21ec6bf78..61e9704bb 100644
> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
> @@ -44,7 +44,7 @@ static struct shmid_ds buf;
>  static uid_t ltp_uid;
>  static char *ltp_user = "nobody";
> 
> -struct tcase {
> +static struct tcase {
>  	int *shmid;
>  	int cmd;
>  	struct shmid_ds *sbuf;
> @@ -97,7 +97,7 @@ static void do_child(void)
>  	}
>  }
> 
> -void setup(void)
> +static void setup(void)
>  {
>  	long hpage_size;
> 
> @@ -118,7 +118,7 @@ void setup(void)
>  	ltp_uid = getuserid(ltp_user);
>  }
> 
> -void cleanup(void)
> +static void cleanup(void)
>  {
>  	rm_shm(shm_id_1);
>  }


--
Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
