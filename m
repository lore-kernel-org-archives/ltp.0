Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10F7C38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 10:57:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C2B93CA83B
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 12:57:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651EF3C5FB7
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 12:56:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4BFF200A1A
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 12:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666781817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2U2U/Fr2lKEwLfoYPedYxWrVTtNh41R5wRv1cJcH2YQ=;
 b=Sckdrd8/jt7hTVGwp0PLqDJxOYMiiDds9RQWqrBza4gd/LenwK9FImcB9fCgeIEsqKRpaj
 EV+hdLmHLbzdpKv7a7aV3pk3KbcAtCJWJUvXkBlWVzgH6O/bk5JuLIBJ2+vaqsAWGRVpNE
 AJMNw/AzF8LomR+/hYMBFVB0lX/190Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-668-qe2Tu7EIMUSFE2r6HO6PXw-1; Wed, 26 Oct 2022 06:56:56 -0400
X-MC-Unique: qe2Tu7EIMUSFE2r6HO6PXw-1
Received: by mail-qv1-f71.google.com with SMTP id
 g1-20020ad45101000000b004bb5eb9913fso5746474qvp.16
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 03:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2U2U/Fr2lKEwLfoYPedYxWrVTtNh41R5wRv1cJcH2YQ=;
 b=kXAsMwElIA4a+LV5yn5PnRyBUPqfb5B7dH3pWrhC/Bcg8wbwpRQd/G+uwOCmQiIL/Z
 N90MJxSaX8dWX2DSVsjHqNAshqooynN7YthYjFQDHJ6xCvZP2Ns1PoDoejUJrPrus0rs
 OJIYB55k51euLorVO5I9SnLaTNw8gzhaU4CoeFEfgS3AlR+e0nwb5nODeXot+iOanwEU
 zQisPaeOY2c8nrUy4BdV0JNZVox4A3erRJXYaoOzHPBEK+Dy9HpkQCEspFwMTL2zad7n
 ghyU7x7NgvpTljcYC4Mr3NwwmiKDdIKXIHwoM9xT2bOEwUYmh7nM7gMaxHcLNUa/I9iN
 B2mQ==
X-Gm-Message-State: ACrzQf2hDjN9tEbv7QZVUiVNclYPQ+lp+9VDEecmGUIEUmMzKX+8o8Tr
 3acuo4VAVQJ8gx5SUfnChMBJbKISfzcDnj75f8IRVOOpivY52O+ynMlO6FqZU8GMA2Lsx3bUDW6
 ea1mVlo6YBg+8y72GpGySQE4+hUc=
X-Received: by 2002:a05:6214:f0c:b0:4b1:d497:732f with SMTP id
 gw12-20020a0562140f0c00b004b1d497732fmr35407035qvb.121.1666781815670; 
 Wed, 26 Oct 2022 03:56:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5GUzSA6V9uYO0j3wJO/HyKsJ9mBstIKVAE1nSmRtOsJOwpC1tAxjFDW/F19ToKCO9Ov/aSarhq2dJFrTFyZeU=
X-Received: by 2002:a05:6102:38c9:b0:3a9:7206:b99e with SMTP id
 k9-20020a05610238c900b003a97206b99emr24706867vst.65.1666781804962; Wed, 26
 Oct 2022 03:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <Y1eoJpgzrOWuX5Op@lab.hqhome163.com>
 <20221025145910.19565-1-rpalethorpe@suse.com>
In-Reply-To: <20221025145910.19565-1-rpalethorpe@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 26 Oct 2022 12:56:27 +0200
Message-ID: <CAASaF6z=ZZSGHDoqpBTOV_xXuhdqpfhb1ET2_4nimCPqr7kHKw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Oct 25, 2022 at 4:59 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> mountinfo doesn't always contain the correct device name. For example
> /dev/root may be displayed, but not exist in devtmpfs[1].
>
> The unevent file in sysfs is another way of finding the device name
         ^^ small typo here

> from the major and minor numbers. Possibly it always displays the
> proper device name.

major/minor numbers may still fail for btrfs, but that issue exists
outside of scope of this patch.

>
> One caveat is the sysfs can be disabled, so this commit does not
> remove the mountinfo method altogether, but leaves it as a fallback.

Could we add some TINFO message to output, so we know where dev_name
came from? (uevent vs mountinfo)

>
> Alessandro Carminati originally sent two patches[1] which added the
> uevent file method as a fallback. However it seems like the better
> method.
>
> [1]: https://lore.kernel.org/ltp/Y0023HcAOlhfAcJw@lab.hqhome163.com/
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> Reported-by: Alessandro Carminati <alessandro.carminati@gmail.com>

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
