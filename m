Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB8ED35661
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769561416; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hap8lkYIaBa0VHvpM6FlfB4awCOYzoDvHL7/61n0GRw=;
 b=lZn3tCFMI+sammsFFGhY4V69tNbWi84vtu1PBeODGnBH+c5mecWNglvpwp3ArFvTx+2vJ
 jytbnwwNVDaOt+pRsV32LullGQumnz0PM+QOw/Nf8i8Nn9DeAFDnhV1rGiELTU6oSFHtdp8
 Noi9MlekHctd6GSnVpfysyEV0b+wbm0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1787F3CA4DF
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 01:50:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D997F3C4F49
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:49:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 14BFC60026F
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 01:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769561389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=emTTzAeqH2pcKrKeu0VV+uC6EKOyKQsgHpI2zCyEKFA=;
 b=YXCZADr3bWWAYtUF3P9GzuhA8qFnRvKfpkSI/ZkPbTXJLkM8GazZp2+45z6wsNufux7Dg6
 F8+FvFhcUJi0orAXv7q9sIzTm/Z/g8PLCyEYPVLXVS1VSxHfoRxGu68m54X/Pa9Cyyxmpf
 wj8CE8ndEr3Cb6pFCr8JdUoSRgRxBOE=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-5fwxzXzdOAubeFvK5YNeJw-1; Tue, 27 Jan 2026 19:49:47 -0500
X-MC-Unique: 5fwxzXzdOAubeFvK5YNeJw-1
X-Mimecast-MFC-AGG-ID: 5fwxzXzdOAubeFvK5YNeJw_1769561386
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b74766fae7so5209358eec.0
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 16:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769561386; x=1770166186;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emTTzAeqH2pcKrKeu0VV+uC6EKOyKQsgHpI2zCyEKFA=;
 b=AWJIyrA/B/Igxor+JaW0dYWZDzw/Uc2KVfV4ipkQvt4Q4zoyq74ef67WJpURI21KqW
 0IOeAV3Xv0l8uz3hCMMYqQXmTxNwA9wXuDJepPt/TFxi99iCzF/h1oxEfkLvmgLnBEkH
 D3WKworGqAk3bu/jtkZ2BqEaiV6mrGq3UCq0BYJSrU68WXhm8NdFQVXP5rfALF/R11iC
 sLe9R3uxxTVqGzudV8y/kwiI6r3Ep4L+sMj6GE2L5N4MLvktJHCcEFk3zoH77BJz3yPQ
 wRq8h9xOeexlJyGSqJtaJLbEHQjLQUI4gy3hLzkouc63OAFlt1bQ/7+/6fN7sKNOy1cz
 cQJw==
X-Gm-Message-State: AOJu0YxdpJOo6ODQo3KliAI1Tbn6OFUBRS16Yh7Z28ndfFe9rn9RpwMn
 Atsv4bX+BFjg+RT2GA37mDTLeU7eoLbFWPiOol824HGXWWE6hiJa+OySI19L4ci2QRIt8Xa3Ax8
 jaH3Ue67naP4PZwWxfw39hVY4lqEzqh3Y0Pbruirzll+JkN6HX+25QiD0PI8yMO8qbWpGzFPIYf
 wu1FRcZ0hLR63r+2PavD5EeZIIHys=
X-Gm-Gg: AZuq6aLM/EWpE8xN7D9Rj5enr8uNz8PIKaI3GZoHECXsxmvVW2mtJ0M5JfObujYTnsm
 e7cUBuvfCy1mSeyBawR0RqJDGzwD4hU0//7f8tTi0Qq4GygCR1Aw2ZBfOy8/QyBSM3EObW8zw05
 dq/lEUl+5gdwK8kspUAMTvYtXQYzx8uolySYmA6KETFJ3OLn+L6D4cp2U54CuVkQKYknc=
X-Received: by 2002:a05:7301:1698:b0:2b7:1744:726f with SMTP id
 5a478bee46e88-2b78d8a6127mr2179451eec.2.1769561385931; 
 Tue, 27 Jan 2026 16:49:45 -0800 (PST)
X-Received: by 2002:a05:7301:1698:b0:2b7:1744:726f with SMTP id
 5a478bee46e88-2b78d8a6127mr2179442eec.2.1769561385503; Tue, 27 Jan 2026
 16:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20251113015242.799-1-wegao@suse.com>
 <20260123023635.29692-1-wegao@suse.com>
 <20260123023635.29692-2-wegao@suse.com>
In-Reply-To: <20260123023635.29692-2-wegao@suse.com>
Date: Wed, 28 Jan 2026 08:49:33 +0800
X-Gm-Features: AZwV_QiiHg83CWYHK8JWZujoh6hB8iD6e5NS6UTMNv4bwUSkPrYmU4Jzce0tvog
Message-ID: <CAEemH2cF23DAPeNr1qJ1arOAPjNxUR-ZmQ8ji2odoz6aWM3cDg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uq_StNTkdi0rHPqEh-HqSQIhFd06hopAnkyAK1HCYGM_1769561386
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 1/3] tst_filesystems01.c: Add test for
 .filesystems
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

Hi Wei, All,

Patchset merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
