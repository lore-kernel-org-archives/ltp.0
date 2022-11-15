Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528A1C433FE
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 10:20:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6685B3CD147
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 11:20:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 475F93C94F3
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 11:19:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9940714002A9
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 11:19:52 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id BB279226A5;
 Tue, 15 Nov 2022 10:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668507591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BDvPXyzSHsKbGhIZgKYzBDGIvxPRJq4UFFcgKRvw9yk=;
 b=a1YQ50Y4BJuBO9bXpDlUGkk40UrD/utJlBjIIsGwG3wA51xzgpM2a2oABWO7anJl+nMM4R
 EVJWmRX1wtULYoiJ6dXUH2slNutp/JuycFyTTMwI0Xmwfk3dcr5C2AoRnx392UaQGwd4xM
 lXlJhxIOo2A45tsGn8B8lmoB9EaOhmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668507591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BDvPXyzSHsKbGhIZgKYzBDGIvxPRJq4UFFcgKRvw9yk=;
 b=5lqEG2YzJ/YFOEai279CWKiWjWEQV7YLQB+0SSzRXRCZCZAiWoqBY2oW4LKnZeyS7CIQqq
 uSoDOKys0ncjLNCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7B8662C142;
 Tue, 15 Nov 2022 10:19:51 +0000 (UTC)
References: <20221114062008.999566-1-jie2x.zhou@intel.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Jie2x Zhou <jie2x.zhou@intel.com>
Date: Tue, 15 Nov 2022 10:15:17 +0000
Organization: Linux Private Site
In-reply-to: <20221114062008.999566-1-jie2x.zhou@intel.com>
Message-ID: <87cz9osens.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_robind.sh: fix BROK: mkfs.f2fs /dev/sdb1
 failed
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
Reply-To: rpalethorpe@suse.de
Cc: Philip Li <philip.li@intel.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Merged, thanks!

Jie2x Zhou <jie2x.zhou@intel.com> writes:

> Error output:
> test_robind 1 TINFO: Formatting /dev/sda1 with f2fs extra opts=''
>
>         F2FS-tools: mkfs.f2fs Ver: 1.14.0 (2020-08-24)
>
> Info: Disable heap-based policy
> Info: Debug level = 0
> Info: Trim is enabled
>         /dev/sda1 appears to contain an existing filesystem (f2fs).
>         Use the -f option to force overwrite.
> test_robind 1 TBROK: mkfs.f2fs /dev/sda1 failed
>
> Reason:
> Test error is caused by miss "-f" option when do mkfs.f2fs.
>
> Signed-off-by: Jie2x Zhou <jie2x.zhou@intel.com>
> ---
>  testcases/kernel/fs/fs_readonly/test_robind.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
> index bab2648f4..2d9a87b7e 100755
> --- a/testcases/kernel/fs/fs_readonly/test_robind.sh
> +++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
> @@ -200,6 +200,8 @@ for fstype in $FSTYPES; do
>  		opts="-F"
>  	elif [ "$fstype" = "xfs" ]; then
>  		opts="-f"
> +	elif [ "$fstype" = "f2fs" ]; then
> +		opts="-f"
>  	elif [ "$fstype" = "btrfs" ]; then
>  		opts="-f"
>  	fi
> -- 
> 2.38.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
