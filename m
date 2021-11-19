Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4777C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 05:39:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC1D60F14
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 05:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEC1D60F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06CF83C89AE
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 06:39:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E20EE3C2E5C
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 06:39:01 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 80D8E600BEB
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 06:38:54 +0100 (CET)
Received: by mail-il1-x12a.google.com with SMTP id l19so9199278ilk.0
 for <ltp@lists.linux.it>; Thu, 18 Nov 2021 21:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f2aHJUlff+sHT0KB89Ar0wCxeN5RNH8wkzpd87A4xsk=;
 b=oAlT9paDS24Qy4Yiyrpr8LzhBDDyY6nuFPfoE5WZFi0CNco6Z0RyOAi/YjJZH6eLIv
 3Ztra06Kmrw2Sxn0fXMfJ7gJIFeTN3Ftacz2Uk0/yiQayzlqpvalFSQwDcIgLP5t1kay
 3syKNEWkQ+dkRBSPNJqHKYProaLHYWN0YbCNld2+Oc3QLDPL9IiB+vZHVt/71sz1Zaup
 nhJZxWzbLqliECWS8PLsBTIL2hf63nt21oS6vN74Cm2DV8DV6B2jbo1SRgOj5mCwmKl4
 aQa96+CMiBrp9ev6tWAoxD2XT6oKoegT14sB5S4GQKI9QamhdCPmu9GmeJw7u9pqJofQ
 6WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f2aHJUlff+sHT0KB89Ar0wCxeN5RNH8wkzpd87A4xsk=;
 b=BomSFdX7o23PxV8BNtvoSqauDFcciWWofPU4vx8KyyDsTLvivReW+Ormbneug3kJa8
 cEGtA2renRMg8jddy+v6NtDPUKitE3btV99/TBUNziWPp2GsE+lNIV3AZlDA/Fl+uj5U
 02WamVAJen4P3wDCsY4tdJo8T+8QLl7fEiJaTEnIMBy7RkSjARtgxosUx6j3T5uLC74l
 2bVVTTYZkgKvoYxFFxKIAIt3TGuS8PzKmmnPRQCR6Eb3zhNL4IGMtU/KFajxCJ9bFSaq
 frBfZDT7TNcGULE3tpqUmD/1rigfs/4ThZ1orNcycC9iAz9h1gyXa3VmhCyyw0eHW/EN
 hXag==
X-Gm-Message-State: AOAM533W79lV7hOmvvt2hajVZ1AYu63UTEviOTMrkGGgGhVlblxHrmOk
 ykgGfyMkXdmd+S7bW99fquLdqldt852fmptkDN0=
X-Google-Smtp-Source: ABdhPJyge6d8ROjZzxsBZyUPkRoblSllQwMAlbWsZDPUJx4cTNGX4/IFYezj1zcs6kCpZ2H+j9hO+ryU6FblamVSbKo=
X-Received: by 2002:a05:6e02:c87:: with SMTP id
 b7mr3301518ile.198.1637300333243; 
 Thu, 18 Nov 2021 21:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
 <20211118235744.802584-5-krisman@collabora.com>
In-Reply-To: <20211118235744.802584-5-krisman@collabora.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Nov 2021 07:38:42 +0200
Message-ID: <CAOQ4uxjk8J48ASw2yJhd-OR2LVN6kirg7p6xQbX=xEofGYUghw@mail.gmail.com>
To: Gabriel Krisman Bertazi <krisman@collabora.com>,
 Petr Vorel <pvorel@suse.cz>, Matthew Bobrowski <repnop@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/9] syscalls/fanotify22: Validate the generic
 error info
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
Cc: Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
 LTP List <ltp@lists.linux.it>, Khazhismel Kumykov <khazhy@google.com>,
 Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 19, 2021 at 1:58 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Implement some validation for the generic error info record emitted by
> the kernel.  The error number is fs-specific but, well, we only support
> ext4 for now anyway.
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v2:
>   - check for error record type in autotools (Amir)
> Changes since v1:
>   - Move defines to header file.
> ---
>  configure.ac                                  |  3 +-
>  testcases/kernel/syscalls/fanotify/fanotify.h | 32 ++++++++++++++++
>  .../kernel/syscalls/fanotify/fanotify22.c     | 37 ++++++++++++++++++-
>  3 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index 859aa9857021..a9dc2524966d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -160,7 +160,8 @@ AC_CHECK_MEMBERS([struct utsname.domainname],,,[
>  AC_CHECK_TYPES([enum kcmp_type],,,[#include <linux/kcmp.h>])
>  AC_CHECK_TYPES([struct acct_v3],,,[#include <sys/acct.h>])
>  AC_CHECK_TYPES([struct af_alg_iv, struct sockaddr_alg],,,[# include <linux/if_alg.h>])
> -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
> +               struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])

Doh! it seems like fanotify_event_info_pidfd was dropped between v2 ->
v3 in Matthew's patches.

Petr,

Can you please fix this.

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
