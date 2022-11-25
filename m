Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474CCC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 02:06:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 746693CC955
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 03:06:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A0E33C0123
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 03:06:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4CD2B20075E
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 03:06:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669341960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c97puOWpM3IY+3HsKU0tyuQwuhD2QS3fKWRmSFYfSu4=;
 b=WiRdaz5Z75o8cyM7YCknrc7JA2Z7hCaxZdaJRm9fKvRVitBK4E7NoYdNIjYI0cNXhXWirk
 w9baliFZgSUbyh9yCIP1hFuVFjDimhSHmZoGKMtedWn6G93lYjNV+8XizMJxIkHxarasHT
 E7xL6UQG0ATVcl/UpJL9tEc9nj4R/Zc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-NTXHu2SHN7OwweUoJ8z4AQ-1; Thu, 24 Nov 2022 21:05:51 -0500
X-MC-Unique: NTXHu2SHN7OwweUoJ8z4AQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 c126-20020a1c3584000000b003cfffcf7c1aso3456797wma.0
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 18:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c97puOWpM3IY+3HsKU0tyuQwuhD2QS3fKWRmSFYfSu4=;
 b=JJscDrWN3xv0O16mDXe5UN98eSNXw7PPMO0Mgc7NcSXdElBxUO6LlVLDmVTWtyFIGq
 0wCYxQN2DyiO/sCOT9ImoHqsRpFWLDD3yifLVuCF2MiQWJ8N9QM2K4RV4Ne/bTUGds56
 N4QP8yz3/F1uJV8+SfI9mJk2FeTqyNr7FhicZHc8gLIrneg40QJpntvEVDq+s2iYdA3y
 P9bndUmf43GZTZ93YrIBXC8X2qSBwmz8GH73Ie/UR3xc158K0IhjBMhrRWLi56R21CYv
 r4M0GK2RmhWbtng5Ltzzr6BNTWqBt76NxXpPto67peJNzlhN/IWroT0K4ekOAWSLj56Y
 vq3g==
X-Gm-Message-State: ANoB5pnh0h+jvN4zPsComPevVOMPdyH+9LERnRsQ2G/55SiHoK8L85Ea
 Dncy6OFjfAemeo9zVe13w+1IxIus+Pac5TvMX1S280XWQXRE9Mo55ELqQXp9qlyKqvuoz9egAZk
 k0dmigAWZBTpgOvg/UgUAi3X6yZU=
X-Received: by 2002:a05:600c:3ba1:b0:3d0:47c:9ff5 with SMTP id
 n33-20020a05600c3ba100b003d0047c9ff5mr18878329wms.121.1669341950025; 
 Thu, 24 Nov 2022 18:05:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7u9dfEBxNpEGoqjSx0DadmMrPmaZaWd//cBD/rVe51aoNV0sqwWhvS450XQ+TzJhAxlMmWzJyRZndO07J1n7s=
X-Received: by 2002:a05:600c:3ba1:b0:3d0:47c:9ff5 with SMTP id
 n33-20020a05600c3ba100b003d0047c9ff5mr18878323wms.121.1669341949877; Thu, 24
 Nov 2022 18:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20221123161315.7891-1-akumar@suse.de>
In-Reply-To: <20221123161315.7891-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Fri, 25 Nov 2022 10:05:38 +0800
Message-ID: <CAEemH2eR3_oiiqWtKeg_ZJ52Fut_LrZVqU18SHisD2wqSr7=NA@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statfs03: Rewrite using new LTP API
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
Content-Type: multipart/mixed; boundary="===============0486541907=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0486541907==
Content-Type: multipart/alternative; boundary="000000000000ee734e05ee41f566"

--000000000000ee734e05ee41f566
Content-Type: text/plain; charset="UTF-8"

Merged, thanks!

-- 
Regards,
Li Wang

--000000000000ee734e05ee41f566
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div dir="ltr"><div class="gmail_default" style="font-size:small">Merged, thanks!</div></div><div><br></div>-- <br><div dir="ltr" class="gmail_signature"><div dir="ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000ee734e05ee41f566--


--===============0486541907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0486541907==--

