Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB0FC8303D
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751421477; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5LiW9sAD0faiGFe06oTrddzVgXV81C4wQccXp3z7Ncg=;
 b=EMoPOTwBjZiSYevvlJOduJ1jM6TlbioEhtcOVZ7X1Vltq+S8kbTKLHjJYCfuPaqdOU/+S
 pAEw/mWzLOi1gvbG4YUj1tZQ7w81OnvqcdpgsX+lnvGfCWTcavtpBAkQaGFkirtEW6NusP2
 XUEwVvmWj+0GLedvHs24SV/SXmr3QiI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A08663C80A9
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 03:57:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6339B3C57BB
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 03:57:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6EACA1000483
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 03:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751421453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HbFeyBJdnhVxcjoE+vaheOa/DP+1p3ceO/ddL5f3km0=;
 b=OA49GGtNEorfLFumUK81QXRqwrLgsT/TZqh7KYoZDwR0L3ZrXeJ04ujRgHeoVx4QpVNLUM
 rmSVVVwwusK/Ucy0YDTAGiY6qcVqq4a5HTa50w6vIHU/6q1q1FmqkCX2JDqApobO/iw46Y
 i3pCKBf9y+oibzVTx/VSpRhkpfpI9co=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-G6Dli2FLPICS935u9p2CxQ-1; Tue, 01 Jul 2025 21:57:30 -0400
X-MC-Unique: G6Dli2FLPICS935u9p2CxQ-1
X-Mimecast-MFC-AGG-ID: G6Dli2FLPICS935u9p2CxQ_1751421449
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-313fab41f4bso8800137a91.0
 for <ltp@lists.linux.it>; Tue, 01 Jul 2025 18:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751421448; x=1752026248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HbFeyBJdnhVxcjoE+vaheOa/DP+1p3ceO/ddL5f3km0=;
 b=UjsBpNGrmRX3pmNDKGpU1yPOyVEzGeNt/VJRRbse3X93xjlSRbCPFKc7djbP147KNW
 EoNawDwndF8EvYmE0SJrFpIhvIqef+UW0lrFgXnttAW3aJ2DGTFGbsXt3CwVBLzb/4Yd
 hJX3smiL9GS8QVviq1XEWAx8PbfUH3Dixae0x3XJhPTDEmdhipYUUr9hbexwUZnM7BZ3
 r1ydbb/rR3iXNXKbpO94HXzacLC3Zr746dRUv3PrqfdeFaqtjQ8Ec06YJtyR9z5R2sZJ
 wRVo5Oo/Q0/4JPqcqtMjXUFmb5uFw10ItJSPPdOKdjavO+OIxOzPIHbwWxb5LMF1QjL3
 K09g==
X-Gm-Message-State: AOJu0YxdBGswlgAoc8w/KiRrFYLovoH/39BwvzAZHceaVmBdnGCykd4f
 XtGjxwTX8nlj83IptT38L6HWQIV6n7kQPpqm2mz0wFKBHTNxma8R0JDQzFv/A9/Vu7c3DA7rzZu
 061liOoDhgSrPLaB4BgrO/ET0rQby9Ay19VmC38kiLL7dUnTHfBMVyQvwRlc+/GvkWMUoAKodYr
 VWQn1C7g5cRlAhrk7Kt5uD/umNiagLsGq9LoX2Fg==
X-Gm-Gg: ASbGncuZ9CgqJKOO4zdkKCDK6xRwQGwlaVSF5cHVydwPg/3m7Kfqw2xrCpkvbtypFvp
 id5iTtwvg3NdoStWIluM3APA1yudaD/bJtcWL1zbjZhswyoUyoHHPIS1L+9mS8THEHkHstyBOpZ
 yQrSHP
X-Received: by 2002:a17:90b:5345:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31a90bcae27mr1904348a91.17.1751421447876; 
 Tue, 01 Jul 2025 18:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ6TRVeMPgAmtEXT+5175OdQVOPSBceRfn6zu1hlbhGBU74g0TR5Aj6MPnNyfZa8jc1WdZEwXaPptalFJmgoE=
X-Received: by 2002:a17:90b:5345:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31a90bcae27mr1904323a91.17.1751421447517; Tue, 01 Jul 2025
 18:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250624131413.63830-1-liwang@redhat.com>
 <aFviMs0k__9ilhvJ@MiWiFi-CR6608-srv>
In-Reply-To: <aFviMs0k__9ilhvJ@MiWiFi-CR6608-srv>
Date: Wed, 2 Jul 2025 09:57:13 +0800
X-Gm-Features: Ac12FXwOKke01XSV-afVcytDZxjHwMvARJxC6kpkHQz2PH-Lpe8e4jwth8iiVZ4
Message-ID: <CAEemH2eGEs6MKfO43B7FuOzOCSUrRM3cQ7Dup4rGugfv8LGjKw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>, Cyril Hrubis <chrubis@suse.cz>,
 Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YW0x4bQGrbjLy5UmRjAknuXaMlcc-LwW1JfnF-zZWHc_1751421449
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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

> Reviewed-by: Wei Gao <wegao@suse.com>
>

Thanks Wei for the review!

@Martin Doucha <mdoucha@suse.cz> @Cyril Hrubis <chrubis@suse.cz> @Petr Vorel
<pvorel@suse.cz>

Hi Martin and All,  do you have any more comments on this final patch?


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
