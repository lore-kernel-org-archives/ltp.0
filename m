Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4080EC3DA4A
	for <ltp@archiver.kernel.org>; Sat,  3 Aug 2024 02:38:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4AA43D1F6A
	for <ltp@archiver.kernel.org>; Sat,  3 Aug 2024 04:38:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FB523D1ED0
 for <ltp@lists.linux.it>; Sat,  3 Aug 2024 04:38:38 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 207981A0080C
 for <ltp@lists.linux.it>; Sat,  3 Aug 2024 04:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722652715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g4CFhRWPOLgEPLT0lSuVMgPPu8MKR7nwSMKxnCovSJU=;
 b=gy8q+LJfBJHCKJ8kBbzUiK1ZJymioRMXoQyCGB4C3qVOlV/lE+U00ir/apnLUC4pHOgcF0
 10xsQdydfEr+D22PJmmj76SfCYD/TQkvzwMJReBc3jPYZzG5AEFpZ/Su68VNFJNMeFRfhz
 JxU1X3uLtgWMiegaYUlPv+3Lg4Ga8yU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-WdVpoThhOaW-tt2KmOwXSQ-1; Fri, 02 Aug 2024 22:38:33 -0400
X-MC-Unique: WdVpoThhOaW-tt2KmOwXSQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb5ba80e77so10515967a91.1
 for <ltp@lists.linux.it>; Fri, 02 Aug 2024 19:38:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722652712; x=1723257512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g4CFhRWPOLgEPLT0lSuVMgPPu8MKR7nwSMKxnCovSJU=;
 b=h3IzDtpuVfVi+IjJsShh7IFS75bC4OQTHP8oaZ/0YDlMpwGChRsh8YDOfvMVTRmEfi
 D6MkON2+qVlIf40ik9lwpVLndmq4bAq7feqYm9PZ3IVz/zS0WnerPIadsvvd+IIpwtnD
 pwXxwa0Qzz0RrSaN2KxH28L3onTJLfbiSydHdBsLDV2t25TC9Wi7FsHyZqHsqcMiO15t
 cuJPFDKTGQMmVQ2c6R2KStlVrfmfc2W8NE0fFu+8gqvNp8V/TE61lIgtFdxf1XjqYeW4
 x/vxhrdugbLgD8AZlk4zViznBDPyVmsmke8Vzo9xMj/jeYc8THNbuqFcx5+Zd6Yvs0p+
 cyMQ==
X-Gm-Message-State: AOJu0YyXX5QCSjOJphFYKDm7MYZW6StIAywe4IOCRj6jV6JTVqbj8VDZ
 Zgh3bNHbjMWHwoqd6ZS/8xmKQkkl68IDnXUKMXDafsz9y4bUgRa08wlBJpf47oFBUluQuX56/ML
 HIM0dnx6TMqEugDFvVNxTDW5N9KFAaPRSNmlM4UyjO3MfNmHj+rumLEOP+bawaIAhe0g69XoZfl
 mpCjBAMwvfdOxRWAr6Aw7PVoQ=
X-Received: by 2002:a17:90b:4a46:b0:2ca:a625:f9e9 with SMTP id
 98e67ed59e1d1-2cff955f207mr6233430a91.42.1722652712536; 
 Fri, 02 Aug 2024 19:38:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6SCGvzzruGW8DOp67cl34220uJG61M9Qhb8VakiRwVtESIJRYBy6DIjpLwCYPTanQqi9wm3dYddCQdR1wuLk=
X-Received: by 2002:a17:90b:4a46:b0:2ca:a625:f9e9 with SMTP id
 98e67ed59e1d1-2cff955f207mr6233408a91.42.1722652711994; Fri, 02 Aug 2024
 19:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240802100816.1617563-1-pvorel@suse.cz>
In-Reply-To: <20240802100816.1617563-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 3 Aug 2024 10:38:20 +0800
Message-ID: <CAEemH2d_779D8gEJfz0aOej-zW0R91FDsMf3fBfxrAgOf3RcQw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] doc: Document "No new API functions for old
 API" rule
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
