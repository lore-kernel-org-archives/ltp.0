Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D47C433EF
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 07:47:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6828B3C9AD6
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 08:47:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E6813C951F
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 08:46:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1000B1000F5B
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 08:46:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643960817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5izIbiqyCjdDFVQcOPOroE/ITcn/WcL7cZtEWe7YyGI=;
 b=Z1nHlLhss9yn8VIBy2P11gpJpuos1Hw1HeJrREI20WHVGlVnB2//GfYGaB/zK2nAgm2RXB
 jWZx3Xw3mO1xHZIN1LLWFPVISBfeRvXkKv6D3hzz1KM35WWCyhIz0B03Zvu3zynpjvbbvm
 8XEQJ3a9NyZVVyKLK3erA/ebvQw9K5Q=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-w6J-3_7oOEGMVdiMGp-N9Q-1; Fri, 04 Feb 2022 02:46:54 -0500
X-MC-Unique: w6J-3_7oOEGMVdiMGp-N9Q-1
Received: by mail-oi1-f197.google.com with SMTP id
 w8-20020aca6208000000b002c7da950057so3223814oib.5
 for <ltp@lists.linux.it>; Thu, 03 Feb 2022 23:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5izIbiqyCjdDFVQcOPOroE/ITcn/WcL7cZtEWe7YyGI=;
 b=nK2mSXDnWj2FEFt35K7OoABKmrilOh6shvjrFB85SEO7026hRh6UYHN1gpbMwWHBAT
 vlUVGFwQdTA8Fr4xpSEXk8tZdVs4Cp22ZMV/33xNKJq3Q12D/W2TC8l15M2yoPW+aYtf
 8V944EyMQvqy1Uydsy/DG0zNYbtL+09180wQRk9ST7pW119ZzB5R5bAkCuvRORS3HOyt
 B8/1dYBnZ4aJX8TwuSXLEgtyXIRYIhADaKr0XP8ei47Dk2VgWRuPfFD8od3josJHUB3T
 0bRzyxm582tafMTYJt4zO6l9zwBAFOBi82+QVVceK7uHJfz29rYvoJOzaXlgfMLhxBc2
 cKeA==
X-Gm-Message-State: AOAM531jr5++0wm9CFjRJ240kM93oWVjPX61+CWg32h+P4bZI6yxXhwT
 4YqqMVeAmoIP8ylJosgF5VKY7faHxV6+lxfV2+6aMtVdRH3PO/NEsCmniEFdIFIzakO+VusvARo
 HlOpOr755AxI3tsDtslGammXffk4=
X-Received: by 2002:a05:6830:1493:: with SMTP id
 s19mr683460otq.85.1643960814252; 
 Thu, 03 Feb 2022 23:46:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQIDFESOn1iFnFgVkuu2GcrhkqGWpnd9KdlC1n0ioFWeQ2UD2M6OHSSrvwFsbVQskRJ+KXeT6O6A3IxQH4TTk=
X-Received: by 2002:a05:6830:1493:: with SMTP id
 s19mr683453otq.85.1643960813942; 
 Thu, 03 Feb 2022 23:46:53 -0800 (PST)
MIME-Version: 1.0
References: <YfPiW998P4/j7RWi@pevik>
 <20220203101803.10204-1-rpalethorpe@suse.com>
In-Reply-To: <20220203101803.10204-1-rpalethorpe@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 4 Feb 2022 08:46:38 +0100
Message-ID: <CAASaF6x=pZyivk2m3D1d-g7ONCBgpQqev6vMcspxs=_qZ9X5AQ@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Create policy for testing unstable kernel features
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Feb 3, 2022 at 11:18 AM Richard Palethorpe via ltp
<ltp@lists.linux.it> wrote:
>
> It's not clear if anything more than this is required for now.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

> ---
>
>  doc/test-writing-guidelines.txt | 10 ++++++++++
>  runtest/staging                 |  1 +
>  2 files changed, 11 insertions(+)
>  create mode 100644 runtest/staging
>
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 1fa751ed5..8ca014d45 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -334,3 +334,13 @@ It's easier to maintain a '.gitignore' file per directory with tests, rather
>  than having single file in the project root directory. This way, we don't have
>  to update all the gitignore files when moving directories, and they get deleted
>  automatically when a directory with tests is removed.
> +
> +7 Testing pre-release kernel features
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Tests for features not yet in a mainline kernel release are accepted. However
> +they must only be added to the +staging+ runtest file. Once a feature is part
> +of the stable kernel ABI the associated test must be moved out of staging.
> +
> +This is primarily to help test kernel RCs by avoiding the need to download
> +separate LTP patchsets.
> diff --git a/runtest/staging b/runtest/staging
> new file mode 100644
> index 000000000..ef1cdea15
> --- /dev/null
> +++ b/runtest/staging
> @@ -0,0 +1 @@
> +# Tests for features that are not yet in the stable kernel ABI
> --
> 2.34.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
