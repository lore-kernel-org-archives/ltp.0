Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4102C3ABB2
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 05:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748408954; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B0xkG7D3PITqplcFDMEdRWvu/jqPZtgpjyXl6ggGLmE=;
 b=D9uemDxmEzM2pJg8DTqt0b4NlpP8HORmxYdk9uRssZmfukTDbKEd9bmGv+cjHlSEdNRgt
 k3Guodd4+KwZGskUpj78K8FcNONYALJDibEtefKjaXqbBx4bi0s2r+rB0Q/abiZ18Y/5EDP
 UeuxeaSaP6JvKMsll+SY5MDfGkf9ZxQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A157D3C6CFE
	for <ltp@archiver.kernel.org>; Wed, 28 May 2025 07:09:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69E923C2C41
 for <ltp@lists.linux.it>; Wed, 28 May 2025 07:08:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BD770200771
 for <ltp@lists.linux.it>; Wed, 28 May 2025 07:08:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748408929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=HOdp7e8ibC1Ju2Itgbauh9jkrbPlVCJ8+U2d0HDcRG51Y3m/EhqQJvFnPNrE5hwZfFCnAg
 6cR2BIUh52KTVFWLrsrI0E1g2C4A0wFtTfCcXG27jl/ncjxml5Wy0COKnsP1zvNwid8u4R
 B7KOEX90uPnHenS45ct6e/58GtA8tAs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-HBkk1zWYMtKQHBGNEAIu-w-1; Wed, 28 May 2025 01:08:47 -0400
X-MC-Unique: HBkk1zWYMtKQHBGNEAIu-w-1
X-Mimecast-MFC-AGG-ID: HBkk1zWYMtKQHBGNEAIu-w_1748408927
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-30a59538b17so3700667a91.3
 for <ltp@lists.linux.it>; Tue, 27 May 2025 22:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748408926; x=1749013726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=afhwSY1IyyvXPT429jLFVRiDEds3lARk65CdhXsYSMyOy2ytxNfnkPbZNNwP+WPsn4
 fWRsjLF+Rf1pE7q35DjwUHdEflK8rh7j2ehe6WdL4qBYgRfcotcZLvbPzwMWjwawChEq
 ez/ZPw12a1F66/oSlKciyJlsdLXRIhsOFodhPCrAHvxrr/GdBSjtXmavx36XznSMBZHN
 WBrU5WINZdosoz0UUqfR4ecqvu0X3Or6LsTy4ea8WwTd97gBBe1fN/bV1eKF+7gwyQ2p
 /A5egd5ybFCByEovbk6tqp+6viY54j2qqv6srfNeuzl7AdoDq7jeI/Ek0NYQTgottlCr
 Nxmg==
X-Gm-Message-State: AOJu0YxHH6WP4pQqNTlXRq1CNij6vYhsR+Wxi2W/DRrWvgHksJKN2yQD
 PZaPRnuZv3PN0wS3aQ7J1FqCIsgNoYiM718EyxcwUs/p3LozuxaPGiYn5+hCy/zXk2oy6BKQvbA
 MAYrxCfLLUK3/PTt4jFR+zWDaJZJsyPXzrcIJa4+wkTknbdAiEHlWi+URebao46NVxB8pm6TE9C
 d/wikF8JTUFHqnt4zkKG97RPhmmP4=
X-Gm-Gg: ASbGncuEFCkklYw6igHabVkJlRsNLRFNtR5t1cJvxeqCpTocc503W/Q5gfwsQyWL6xR
 5kn7oDBR7ZDr5ATn2J3Kml1ZEq2YQcCLObvfUlB1DpFmPXqlvb2nyKGwDgz/+xzuiEIiTkw==
X-Received: by 2002:a17:90b:2e52:b0:311:ed2:b758 with SMTP id
 98e67ed59e1d1-311e73db536mr1470679a91.3.1748408926738; 
 Tue, 27 May 2025 22:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSobxGjxXfsIslIbdiyCs43yprByBGjoOXlnnUosdsgAYiYhI6CxhqOs6MGiInjpyMfKt5hRYWKClTH3a2904=
X-Received: by 2002:a17:90b:2e52:b0:311:ed2:b758 with SMTP id
 98e67ed59e1d1-311e73db536mr1470659a91.3.1748408926404; Tue, 27 May 2025
 22:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250527114757.14704-1-chrubis@suse.cz>
In-Reply-To: <20250527114757.14704-1-chrubis@suse.cz>
Date: Wed, 28 May 2025 13:08:34 +0800
X-Gm-Features: AX0GCFslTsknTrwzkD1Rmk6e8hgSXgfrmVtCCNU8fpowpjDupSJyXM_C7nDF1Ng
Message-ID: <CAEemH2dYGrPHNX26BzWrXbipnBTHind7ccs8DiWD7GRimVRaKw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kpxHzuodYRDIWIsjZB6-PQ4KV19qqrG_AQ53J5xmpyY_1748408927
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Move tst_get_supported_fs_types() to private
 header
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

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
