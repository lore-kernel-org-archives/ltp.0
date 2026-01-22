Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C272ED6261F
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769086229; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=i2mqC+nMt1ZVtwHsw0Qp3Z5pvWqH1JnfCBtAqXG6VPc=;
 b=RR8zilVT3YZityrPcsjuXOKFJIXxPk+UQBwoTobUqUNSwXELH6LTZda94HGWjT3fntwmQ
 FFoYKFDpxKxhkAvzgBrdzLthN8kyse5405G1C6/MeonZMlq4ju0mrVGLX0kKk+RzSdH4fAc
 syslYoqEAySVXkj8geoo4SMZzKCVWiA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 667133CB58F
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:50:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3A1C3CB4C4
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:50:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0E349600A45
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:50:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769086203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qaUNCy+TjhUXzQbuguJ7X7Ge6Wubu92KfiKe29BVyqw=;
 b=O0nKYdGLNbvkQgaxbvOtoVBCvYPD9cbGr/HDejw9rPASSvD7ekulux33KnJcvHVz6SGtlW
 yawQ04IrFpCOTKxdfQgh0iYLHgVS3BzOVj93K76oAKJiRcaZvW26HFJ43PVdh+ap9B0xZa
 jyYB6wQgTFSGq/egmgXliCX49jRB3gs=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Qoo-djuUMR67NpwCv1k7Ng-1; Thu, 22 Jan 2026 07:50:02 -0500
X-MC-Unique: Qoo-djuUMR67NpwCv1k7Ng-1
X-Mimecast-MFC-AGG-ID: Qoo-djuUMR67NpwCv1k7Ng_1769086201
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b6a8afb513so1235472eec.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 04:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769086200; x=1769691000;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qaUNCy+TjhUXzQbuguJ7X7Ge6Wubu92KfiKe29BVyqw=;
 b=Jp/ae1auaeK2I0XBl9dB6X0dSkrkCA4n+KhlYp4IULVoC2PeU3+EOXopqHXZr4JBjK
 QpfufaQKreHNSOTHTn9As0ThxQZ+ca0SZE1n5vAtDU+cRcodinScEhf0LOTIqCbNrtiL
 FIkLdkEYiufTEDvNnaLd8PdMXpBna67EWVys2hh8/udJZpLlUk0Mh8W6PEjo8qYkHjQi
 03D7LKoNGQsI6R11DRPW1Rr0r25voPn5znzvW9fCiS9IvJbllLLtQcPCi9wCiumzyhd5
 yn7FlHqjKIpA0S9yUtZQ4CU2Yg9i9e5FL0kS6aQc4yLckUVxip9b1kI5KWWNCrIfi7LX
 5rhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpMl2GP+lY0udCbJYbh/lKYSc+SM9Q6kuDE4JZ89lzL2UqtjYo4Ct70TmypL3qD6CDsKc=@lists.linux.it
X-Gm-Message-State: AOJu0Yw52QOSM4d4Fi13kx1AFlXExrhq/DhcGTjAP5cg+jf50nO0kdfG
 HaLA9ZZDMf2soWmFJWlSPvBKpTFHU0UQzv86bs35seOMlcJZdnkjmNLYEc/AQO74PWiURja7VPb
 j8eFmYw3wrm/ymyNx47Nr0ipmx+FY+8qEWfPhk3pxISNrMnM3oQOJB12KV/gFHnhzZH6avOiOdt
 +gPTky5y9dPtKA39EP83aYS4Rw9a/l7o6fP5A=
X-Gm-Gg: AZuq6aKdzqjxbaanZQ0il80LjS0RZXmigX/0DdwpvRKXZh5EFNn+pyYDCoGqEqNA3H9
 eMZXS+vEqPtjTYZjBhh1s4FPTd7pX8D/Qb67Gl/2SR1FDPog3dQmO6Hze1mpJcKPyt8PAJO8IuK
 BX1jl2vRRrivwbBzbd0ZPYkTOXOyDu0OZK4wgs5AEe4MX08KdXealwa7njAYvcfNfDvxs=
X-Received: by 2002:a05:7301:3d0d:b0:2a4:3593:dde0 with SMTP id
 5a478bee46e88-2b6b46e7cf6mr13946133eec.13.1769086200171; 
 Thu, 22 Jan 2026 04:50:00 -0800 (PST)
X-Received: by 2002:a05:7301:3d0d:b0:2a4:3593:dde0 with SMTP id
 5a478bee46e88-2b6b46e7cf6mr13946117eec.13.1769086199750; Thu, 22 Jan 2026
 04:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20260122111810.91411-1-liwang@redhat.com>
 <20260122120604.GA64562@pevik>
 <aXIVnsZ54238nLbs@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aXIVnsZ54238nLbs@autotest-wegao.qe.prg2.suse.org>
Date: Thu, 22 Jan 2026 20:49:47 +0800
X-Gm-Features: AZwV_QgeAWY27svD9veQbLZrjRyBFzlwD6slJ_fkDjDYBq0yKdsBEATaW3At4G0
Message-ID: <CAEemH2dXVHp6netAWA2LFBh1uH3q0NoeXBmDJ=WmZGRTf0sqYw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D45Zw0o5puNTLSC4HhwuzcPNJa3Vj7ogz9qmMgc3dYc_1769086201
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vma05: fix the needs_cmds format
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

Thanks Petr, Wei.

Merged.


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
