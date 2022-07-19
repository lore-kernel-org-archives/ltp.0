Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96335C43334
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 21:58:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BE9F3C87EF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 23:58:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D3C03C04EF
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 23:58:44 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 245196026DD
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 23:58:44 +0200 (CEST)
Received: by mail-pf1-x435.google.com with SMTP id b133so11058013pfb.6
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=iB+Doa+U4OC1AiyCS62LXMnAWLODLOGe+vIlNfYeSSQ=;
 b=q3WeXnNpMZDDGJrbPOkkRtIvLsEczAha4BSubg/MsNDr/uLkWey/iKZKknyWGvOVJq
 LAdic+xx7I0Z1bjaAT6cao6BUDdsUBrEPU1Tv20o2kwuIwOZNA/bskm0EEFkcokSjSqr
 KRQxBta0W0iclcmR2ULfgkd2GqUBZhZqUtpQX/jlUtPaB+TghiNqyWvrfpMtau0u5dVZ
 STh11j1m8N+CySqyUoshDvSnSIkm4vluagrtrbLCyJaDKf1tsp4T8xapkIfNiW7bibTt
 7wL2VoRFAa6xDz68EFOrPojd+if+2SGPRwL9jrUIbBjVkbwUvkCRbo5BjoK0KWe2avMy
 EFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iB+Doa+U4OC1AiyCS62LXMnAWLODLOGe+vIlNfYeSSQ=;
 b=WgAsJkypcDubY1ccdlJGdNIudLViSF0s15/oXrkP8aicGZ/QuwQ8gg9zSpGrSiKuhC
 /soBjmQAdpk13ozJR4mmtbth7M/I8MZPlYY5o7gtk4ninpNVw10bKm0WjvS4NnS3B2gP
 rPDMUhy9KaD2lQdQcqOnweI8mil5P/RcQ31Kj6ACpxL0pG7KUNNo+m88ai1pco1KdLOs
 OgNDqrCSXpG72HDCB5h62A5eOtWQtoBIWoaZfCQB6PfDbZhNyGmBYrVzH+Rp5xLtNMy1
 Mk9kc1mrQ6C/MFpVDTCslAnCfVH2BBLoOARorbDYTlrcVTYyOXt0l3ZzAilQ/KUrAXIu
 3wqg==
X-Gm-Message-State: AJIora8Xe8YOOzsr+0FhxUt1EVL3Q1OO//lYZXVlRHyUca6QNpNzPK5X
 Hp95ZfSJoz3beBaZutDX9doysA==
X-Google-Smtp-Source: AGRyM1uIt6S1YAM9OawtPfW2NxUYqNc0ruZ5ZvsvLTNsGEYvMK9hjXw4lSt3JUsyK/s2Wzmu7mFoJQ==
X-Received: by 2002:a05:6a00:a12:b0:527:dba9:c416 with SMTP id
 p18-20020a056a000a1200b00527dba9c416mr35484572pfh.33.1658267922250; 
 Tue, 19 Jul 2022 14:58:42 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:bb51:9a71:f8bb:2041])
 by smtp.gmail.com with ESMTPSA id
 x10-20020aa7956a000000b0052ac99c2c1csm12031608pfq.83.2022.07.19.14.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 14:58:41 -0700 (PDT)
Date: Wed, 20 Jul 2022 07:58:30 +1000
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YtcpBkevcBF6iycz@google.com>
References: <20220719095853.3373732-1-amir73il@gmail.com>
 <20220719095853.3373732-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220719095853.3373732-2-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/fanotify14: Encode the expected
 errno in test case
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 19, 2022 at 11:58:52AM +0200, Amir Goldstein wrote:
> So we can add test cases for errors other than EINVAL.

Just one optional nit. We can probably remove the comments which are
directly above the existing `if (errno == EINVAL)` checks as they're
specific to one expected errno value, but this is no longer the case
with ENOTDIR now in some fanotify_init/fanotify_mark cases.

Feel free to add RVB tags.

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify14.c     | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
> index 5d74b9b91..c99e19706 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify14.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
> @@ -41,38 +41,39 @@ static struct test_case_t {
>  	unsigned int init_flags;
>  	unsigned int mark_flags;
>  	unsigned long long mask;
> +	int expected_errno;
>  } test_cases[] = {
>  	{
> -		FAN_CLASS_CONTENT | FAN_REPORT_FID, 0, 0
> +		FAN_CLASS_CONTENT | FAN_REPORT_FID, 0, 0, EINVAL
>  	},
>  	{
> -		FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, 0, 0
> +		FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID, 0, 0, EINVAL
>  	},
>  	{
> -		FAN_CLASS_NOTIF, 0, INODE_EVENTS
> +		FAN_CLASS_NOTIF, 0, INODE_EVENTS, EINVAL
>  	},
>  	{
> -		FAN_CLASS_NOTIF | FAN_REPORT_FID, FAN_MARK_MOUNT, INODE_EVENTS
> +		FAN_CLASS_NOTIF | FAN_REPORT_FID, FAN_MARK_MOUNT, INODE_EVENTS, EINVAL
>  	},
>  	{
>  		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
> -		FAN_CLASS_NOTIF | FAN_REPORT_NAME, 0, 0
> +		FAN_CLASS_NOTIF | FAN_REPORT_NAME, 0, 0, EINVAL
>  	},
>  	{
>  		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
> -		FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, 0, 0
> +		FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, 0, 0, EINVAL
>  	},
>  	{
>  		/* FAN_REPORT_TARGET_FID without FAN_REPORT_FID is not valid */
> -		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME, 0, 0
> +		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_NAME, 0, 0, EINVAL
>  	},
>  	{
>  		/* FAN_REPORT_TARGET_FID without FAN_REPORT_NAME is not valid */
> -		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, 0, 0
> +		FAN_CLASS_NOTIF | FAN_REPORT_TARGET_FID | FAN_REPORT_DFID_FID, 0, 0, EINVAL
>  	},
>  	{
>  		/* FAN_RENAME without FAN_REPORT_NAME is not valid */
> -		FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, 0, FAN_RENAME
> +		FAN_CLASS_NOTIF | FAN_REPORT_DFID_FID, 0, FAN_RENAME, EINVAL
>  	},
>  };
>  
> @@ -88,12 +89,12 @@ static void do_test(unsigned int number)
>  		 * an invalid notification class is specified in
>  		 * conjunction with FAN_REPORT_FID.
>  		 */
> -		if (errno == EINVAL) {
> +		if (errno == tc->expected_errno) {
>  			tst_res(TPASS,
>  				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
> -				"failed with error EINVAL as expected",
> +				"failed with error %d as expected",
>  				fanotify_fd,
> -				tc->init_flags);
> +				tc->init_flags, tc->expected_errno);
>  			return;
>  		}
>  		tst_brk(TBROK | TERRNO,
> @@ -126,16 +127,16 @@ static void do_test(unsigned int number)
>  		 * specified on the notification group, or using
>  		 * INODE_EVENTS with mark type FAN_MARK_MOUNT.
>  		 */
> -		if (errno == EINVAL) {
> +		if (errno == tc->expected_errno) {
>  			tst_res(TPASS,
>  				"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, "
> -				"%llx, AT_FDCWD, %s) failed with error EINVAL "
> +				"%llx, AT_FDCWD, %s) failed with error %d "
>  				"as expected",
>  				ret,
>  				fanotify_fd,
>  				tc->mark_flags,
>  				tc->mask,
> -				FILE1);
> +				FILE1, tc->expected_errno);
>  			goto out;
>  		}
>  		tst_brk(TBROK | TERRNO,
> -- 
> 2.25.1
> 
/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
