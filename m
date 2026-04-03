Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AABCC6B1D
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 01:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775180884; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7Q96r7xBLmSHciJHA69CAafb/yTq8kkGynMAjcb++DA=;
 b=amcY8SjxSxTJQ8+GgO5yuKlc1SN6OxMPm8ulOK+afvYZi56zQZIU27nquMpwDwV44dgcw
 wZ5BEnDvtr0nnsoUS9e2mWO0YGUBKzQEto1xFM2Kjn8VQDVjh/qjihgHFkebh7yGHgGw8H4
 AT6CIDL3o3mF2XRhU14yVvWDb2zM8Iw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60FD83E5493
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:48:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 575F33E16FD
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 03:47:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2E6E6023EC
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 03:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775180858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1kdRCMpquQQLHpt/z5OmWuoXyEg0BmIi5m7emlG0mPs=;
 b=UjoCIFCU9cEwJAxsh7ucpBQfV26dE+ksfpGK5UAVVD8ES89h4c78I2T/yb9/Qe7IOZTApk
 goSkeyG8QDEv0ad4p1l4JbNF/RW9NgtM6dG2bSRIyrCxF9bPphxbAiHhnzXsZdW1tplEGQ
 10Az9IrZ2IcbNURERv6RlE72SaYCSVQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-8WFBRRSIPvarFgfmMbBmFw-1; Thu, 02 Apr 2026 21:47:37 -0400
X-MC-Unique: 8WFBRRSIPvarFgfmMbBmFw-1
X-Mimecast-MFC-AGG-ID: 8WFBRRSIPvarFgfmMbBmFw_1775180856
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b0b0aae381so15316255ad.2
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 18:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775180856; x=1775785656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kdRCMpquQQLHpt/z5OmWuoXyEg0BmIi5m7emlG0mPs=;
 b=Jv43BcXxShZsmvrqX4j7wUP3niiv+qM1U8eDvAc6JMrTKaNNQV/B5A5YtD5gcmS2GU
 G1+lalWNhcQQ8mhmMD+DIQfQYKfl0wyJhM/bQ6YXrg19sZckihI+0/50CeetJirO6VPe
 hyJ9J60hs2H75QgRCc9fmU1l60BseuyqHxH12NYM0kBhkpPx246CqV5p7OxLTw02urCr
 SadsjpWaM2XPq9YvN4Zh1Xl8UhHHp4ykfgCQ4JW3+a+gX1xIcj0XLYvhIfWDU8N1hpe2
 SUrRypw+cVEimjJX9N6IT4thCjwQ7Ni3hl8GIzPI63Asy9DmH5Wj/DHNOVB95/kR5JcJ
 Jsvg==
X-Gm-Message-State: AOJu0Yyn/Q+m4IgOxV/tkwiaQj63PxVGx+ynTKAbYBLom7eOS6HPB3b4
 h6hRB2Viqk1DfHE0iXoQKDpSno+ySyuYBrSMyII1m8rniG4PAKeN8G6lV8ID6wkPTp9INe4Po0y
 jSxQ0uXoHlT98wNcx4VlRWiAJGG1KNlGhAQ5JA0/lbrztuTpnkSR1
X-Gm-Gg: ATEYQzyk4qBXF1fqNFD2XpplM4Ga66wnW6BuSa4QWAEi40WcwXwuAy2FYhLf0fVirQG
 gNuMZ+wvCO9Hw94ugv/KM2imcaM3O9a/8pogHAKcV5LYFGPulw/XyqDnF3cv1xgCES5wEK1eH11
 rTuAjaou+tnu8Mn6QHDsSP+UcdackZkao182Oo3QvLaF3X3z6EEEN5BRDBAbNhhKDRUmu6zCPHf
 /+AQEYy+SstolWZikRaNNu+tSsHJMRxNxZHkrQbKzeZoA5YQ8e1x+5YViw/ztNJYVYoGC2SJmSn
 c3sq35NGo8IJDLaXaVYfkshlilv1xobuSko4HaKhyMF6OTUoD0Hot170QyLnAvBdkHCOkKFrsMD
 TBEufIqxcuG4kKVsuhw==
X-Received: by 2002:a05:6a20:958e:b0:39c:787:f17a with SMTP id
 adf61e73a8af0-39f2efc1b23mr1011726637.41.1775180856158; 
 Thu, 02 Apr 2026 18:47:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:958e:b0:39c:787:f17a with SMTP id
 adf61e73a8af0-39f2efc1b23mr1011702637.41.1775180855711; 
 Thu, 02 Apr 2026 18:47:35 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c65812f4sm3919900a12.25.2026.04.02.18.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 18:47:35 -0700 (PDT)
Date: Fri, 3 Apr 2026 09:47:33 +0800
To: Soma Das <somadas1@linux.ibm.com>
Message-ID: <ac8cNRNYBVHWi0o9@redhat.com>
References: <20260402081258.3239096-1-somadas1@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20260402081258.3239096-1-somadas1@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HNVkn5_92_6zwOqM28_cS60C9lqzLdeqL65cKQaTHzQ_1775180856
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] zram: skip exfat on systems with large page size
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> exfat requires cluster size >= sector size, but defaults to 4KB.
> On systems with large page sizes (e.g., 64KB on POWER),
> zram uses page size as sector size, causing mkfs.exfat to fail.
> 
> Skip exfat filesystem creation when page size > 4096 to avoid test failure.

Or, can we specify the sector size with 'mkfs.$fs -c $page_size'
when detecting a large pagesize system?

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
