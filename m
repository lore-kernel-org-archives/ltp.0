Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11926CA0EED
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 02:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756346601; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VO5qy39KwAq/GO+aduRtiQcmvyM9U+qyO6XXoiKegvA=;
 b=bGxrmNw1QFOH8wx9SDDvXWd7QwJnv8j/1LilQTE0FXaD8LPeMss9nZrQe/MccwrKabnZA
 tuwxOvn6FeZ708DYRz4ReT1YV3yErnauV0IfH3VgbKdkPF60MQDRMn5RYSnSSeny+5iL16U
 /7H7OEnwVsj7qpxNWmsNmrAH6kWvbkg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 971FF3CD03B
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 04:03:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D10CF3CB957
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 04:02:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AC5741000348
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 04:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756346576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XeCHbK/N5e4YBh9qRYyn8F0iroM8QztFU7fSADdiINg=;
 b=QxLjdgfTvoE4IrPAcmPHu/WZgLg5QnppS8lKuT4MUitrLFweQ2T6wHbbmrWtadAupajgrG
 RwWe5htx0NSq3++21lCI4HN3uVbrI98nxHYQsVs6oEDFIef8IAN8UNHgsI4N4E2RzGlh/k
 nFxg8Ow1IryVsp0U4F6W+rtHZ5QVcEc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-p7m5TC7dPDWaqTc2cMnIlg-1; Wed, 27 Aug 2025 22:02:54 -0400
X-MC-Unique: p7m5TC7dPDWaqTc2cMnIlg-1
X-Mimecast-MFC-AGG-ID: p7m5TC7dPDWaqTc2cMnIlg_1756346573
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2445805d386so4704765ad.1
 for <ltp@lists.linux.it>; Wed, 27 Aug 2025 19:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756346572; x=1756951372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XeCHbK/N5e4YBh9qRYyn8F0iroM8QztFU7fSADdiINg=;
 b=xSVLo5ZoFTiKclIvTzgJXciymSwGGue8UyualiDS4YV4CFrYXxcGumlrvbrQgTsTEB
 PgMyz1LGRj+gTaMy5MVVQS7khnnfMOgUziK/FeQVacjwzEBouO+YM1Maf3SQTRaKgHrP
 xtwQ66Iw/iI5+lb4I/LJmM1uG1ThbGJtBaE0wKXpubSJklpWw/kfidx4KPYrMm+WkPs2
 ayIh8DhWNH8KA2WmJ1q6FL5BxXRCVa8BZRDeauWxNDueCcr1O4IgEfrpd/cEaf7yKRUU
 DrJgRycxquZYCM+PrW5SFDikB2/Lc5PYGW6QaqbKMvrvpgyvEo0UGWcAUfg5Lp/WtkbK
 is8g==
X-Gm-Message-State: AOJu0YxkgsTlyAOnag8bHOyIbFFhfF9XDJgt+SGw199f7QnuhwvywZ7f
 GmHkr5dAvOZF1hFLvCUSTlsokOPFe+9jAZ6yXy4HVfFCl/EVRCD9vO6pZYfFYsHdp3VxX1LOyi8
 JvKA/K3TJUUn8juYl1XABuzLYU3+uvRHwp/JlBA/wf4JGpR06ol7KIspANeedSJaQooA3wDD7jm
 1APS8Wb//YKafKXhUFR3d54sIg76baNWWyhSgxlA==
X-Gm-Gg: ASbGnctuyHiN4pBRU0Q01ryk0szJ1hSCnSFpP1i+zrBVj+0YQITYb+xpNy3eHTYjCqV
 VLt/b/8ZAFrTCHGwKZ1CRxLaVwWAW/8IctNFsoEvENsoTdFgqBMuNzmmuGRRj2EQiZ6sQleiuCY
 ZNNVflV7U3GA69adDkTFs+Cg==
X-Received: by 2002:a17:902:da89:b0:248:cd4c:d6e with SMTP id
 d9443c01a7336-248cd4c0defmr18679115ad.9.1756346571794; 
 Wed, 27 Aug 2025 19:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA9Pe85BO01Ih5j72RHYCyIQnKDbRxfSbtjgIH7VI+Y8rUCzbzOzeZlyMrPuiKP8tmZ6DKhZTM9vmboGD3008=
X-Received: by 2002:a17:902:da89:b0:248:cd4c:d6e with SMTP id
 d9443c01a7336-248cd4c0defmr18678935ad.9.1756346571458; Wed, 27 Aug 2025
 19:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250825-conversions-lchown-v3-0-2d261b3de236@suse.com>
 <20250825-conversions-lchown-v3-2-2d261b3de236@suse.com>
In-Reply-To: <20250825-conversions-lchown-v3-2-2d261b3de236@suse.com>
Date: Thu, 28 Aug 2025 10:02:38 +0800
X-Gm-Features: Ac12FXzEYYbG_EZDUr3kFzmo2dmHOPTSwx4p2XnTtuWYgm2Ag5nnO67j3PPiG8M
Message-ID: <CAEemH2eihyuZZCF-KSnciZJk2P1Tj9xhe2mprb-kVdU_-nZsag@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fbx5KtlHO84s96SdP9gTncO8afxOklwhLXhtQFUbOhY_1756346573
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/4] syscalls: lchown01: Convert to new API
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

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
