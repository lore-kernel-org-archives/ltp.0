Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DAAD5B161
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765871443; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=KEnXcdOI9krAesr0vlzgIK7aE9+nFPec8529f5hsfxI=;
 b=AsM2LDfBTiqaiJlENCMjNWjElL6zarmylS3VbrvDudL9BLitHJLlx/5s6fHOjYd2xG7Sz
 q0mo8GO9aC3jqnIBjtA1bpTjwF38MJk/3mW5ZnpgDY2nrUN8eVHEUTNfr2aSTefba2cNvtE
 iuXZ3xfcWcbHuwRAatOb8+mBYYnXw+M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0FF93CECFD
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 08:50:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C56523C1817
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 08:50:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D9808140019F
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 08:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765871415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iFOKX+/QYmiOYJfn/vbsx72FtpRXFG8r2Zy8DjKQy48=;
 b=cuwbCFh1/hb1vq+ganiLzN8g8dcM2u8u/S8HUtGD6a0+57mFUGrwu5d49P4Xx4SMrtiVXk
 pFo/f1Lr3HsEaQ3iN++GPitAi7mrdKSFrxUxiGj6MSIWp4mjoFWRsiQVgYBUN1JPf0wnsU
 VLvCpAAin9ptpW/lkLFONZPkxPGb9Ao=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-VkeGCeBANzqBjCSHbSKPDQ-1; Tue, 16 Dec 2025 02:50:12 -0500
X-MC-Unique: VkeGCeBANzqBjCSHbSKPDQ-1
X-Mimecast-MFC-AGG-ID: VkeGCeBANzqBjCSHbSKPDQ_1765871412
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-bdf47c10220so7754665a12.3
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 23:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765871411; x=1766476211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFOKX+/QYmiOYJfn/vbsx72FtpRXFG8r2Zy8DjKQy48=;
 b=XHclBaCkJjCiMezPMPFYx20+U9DzPaRVaYsq5czgvgOJ9QTkrEC77ptENpJMEvzNb+
 QIOVt9gfZuo0FH37bjIWJCn3urA2p4EKOTDuBgtbtzI9QXamNxlouerxEBAjloQkVXzr
 geSPTrLH91f6rrdzeCpiWJst87sW/acwbb4PAPA+by69uIx9B8gz4yLeSyWBJdpcAK74
 WL9l1hqT+MTz/nBRWoQOg0xiEtwECbbVUErmfs0epkOrxa1rxZDOuqxNSSPdxhv+50xl
 NKHNggJx5+rIB/vtCIhytmm7y4joS3d0E40vcruqkek/cKvUMcoNkv2kST7VzdaHIbOw
 IttA==
X-Gm-Message-State: AOJu0YzPpFhF6QrGRFghgI9OZDw7UDTry2KwGUO1uLmG7dwhAFKTN6ms
 nxTmvtb0nua1pI3O67veEjwo9MkwzKZfQdei9GKPFN2HwiRXQ2XfArL21CHV2rS0AL1WijbyNFw
 sjOKx3fSQBdVl8WOFltFBn8d1ou7TBO36ULxu7DleW4xamVLW8jc031kgMKFtGyHvhqS15+tDwL
 R2EolYk1Io3be+sqtUpl6q3wbXarE=
X-Gm-Gg: AY/fxX76f43ffouVTnrHI4XvZTxHljTslaviRb1flGq9kDfVlDpHu/gpuuGqt9AKzq/
 I474+0tTipKmNgUgIx94yV7/1sSem3u2FfhU8+qb9Lg+Uzu6+hcb/qTwgFwfymdSprqeMyTTozO
 n/A+PKbyq81mdqVl69mZMyLiHUJtJ5IgJtUV4AyTtdva8eH/ZpJmpY0Yp9oygT8UJi9rI=
X-Received: by 2002:a05:7300:f78a:b0:2a4:7a85:f02c with SMTP id
 5a478bee46e88-2ac2f86fdb1mr9113077eec.7.1765871411496; 
 Mon, 15 Dec 2025 23:50:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRzo/2dU0rVTwnocutl1J92gnaycEXcbicHbyhwybCPOGa1FJPEHlPVZVORbMSebx8lKShcJ6p6yvYS5S78e0=
X-Received: by 2002:a05:7300:f78a:b0:2a4:7a85:f02c with SMTP id
 5a478bee46e88-2ac2f86fdb1mr9113069eec.7.1765871411088; Mon, 15 Dec 2025
 23:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20251215-fix_ci-v2-1-20d837cf9b8b@suse.com>
In-Reply-To: <20251215-fix_ci-v2-1-20d837cf9b8b@suse.com>
Date: Tue, 16 Dec 2025 15:49:58 +0800
X-Gm-Features: AQt7F2rct39tvQ-NrXphAIl3FBpwHcX4Cfl7fZGyuOseoe8M8eCrFbiV_ODNb8o
Message-ID: <CAEemH2dZChYkd0odYVpPfCuFn6HyYdpHEoNbi0LFd9xKdXLqHw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2fG5gxpuHp-MAWVOc_CR4KXkqO4TDNzMmywTz4j7_bg_1765871412
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] ci: fix patch download when using curl
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Andrea Cervesato <andrea.cervesato@suse.de> wrote:

From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> curl started to fail on CI after bots have been introduced to verify
> that a human is interacting with patchwork. This creates an issue when
> we need to download patches, since at the very first redirection we will
> miss the server hosting our patches. By using `--location-trusted`, we
> trust the bots redirection and we make sure that it's possible to
> download the patch which is going to be applied via `git am`.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
