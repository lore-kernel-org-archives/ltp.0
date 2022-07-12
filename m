Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB32C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 07:41:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC8203CA821
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 09:41:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E260E3CA596
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 09:41:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 04B621A007FE
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 09:41:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657611667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=elQFUEObcuKV4iLen61JafWVf4bQPanj2/JCJsqs9xk=;
 b=aNpZgFWQlEMmi3I3Lmv2ySQiw1XWY+sYS9D0K5R1wztso5qrxG1euoooB2by0hsFh0KbWk
 stdcoSE09weqDbfTz7MQ0r2asJAnDUvjcmyUOTXXf91uDvCPlrA/SHhuj0NyAcFyNE+m96
 TK4GvsR0glw461fXR3ccHmE6kIS3u08=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-JDHYW8tCPVaGjpdT4A4BXw-1; Tue, 12 Jul 2022 03:41:05 -0400
X-MC-Unique: JDHYW8tCPVaGjpdT4A4BXw-1
Received: by mail-lj1-f200.google.com with SMTP id
 m16-20020a2e8710000000b0025d46f0cfb1so874414lji.16
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 00:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=elQFUEObcuKV4iLen61JafWVf4bQPanj2/JCJsqs9xk=;
 b=X/tVv/AYitssHuSVc1CgNXWFfcElZAKgzIuAhAg9kbeGsNsOmxBBUAqzKNMOwGl3VC
 YUI1+M2d82Z7bdVXkk9RVsu+cWanqJLWOBYtiO1RPVko473XB397pe3iPqAmFnWDFk6w
 jAeBfBUA35urJcUGctvDIH4/q0AzRMhuRPxTnEiocLClFWm2YFydg8yAxcacIFPjJ+P/
 ANfgEb25CrOg0oAiElgGKbwEpq08MBgWYPxbdawB8g3vcjSHd7N75NSSqoSHz4vMfejV
 9c9eQpLGwJHGUB6SG44e6ksJoLQp3BHu4cHxcSstmkkQmOgS0wWLcL46giJHq2pzTfCk
 ekAw==
X-Gm-Message-State: AJIora+R010E4AvARmVDU5o2n1+lna6nUxHyCIAps7MbmRHscZTsfpTG
 qTgDdRnUC+9ZVo0AAFkBg8rQ3k8a/axoSRMnVks9JApLssDWPqJpOlJuJU0KGywlC7dGTL4r/0H
 c6pVVwvg5ufj5VSDETC27lPCJpag=
X-Received: by 2002:a05:6512:398e:b0:481:154b:a92 with SMTP id
 j14-20020a056512398e00b00481154b0a92mr15207146lfu.110.1657611664410; 
 Tue, 12 Jul 2022 00:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urwNBM/dVYOJvTZm8WBA66muNL0T7oQwSn/UMqN6YnpACeK4U6bzQ7B09wz+Oz+A2xHyzTeTVrPogimeD9yRU=
X-Received: by 2002:a05:6512:398e:b0:481:154b:a92 with SMTP id
 j14-20020a056512398e00b00481154b0a92mr15207132lfu.110.1657611664035; Tue, 12
 Jul 2022 00:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <f710f7cc103a61c20d5ee907d9717fa384810553.1657198689.git.jstancek@redhat.com>
 <62C7A730.3020206@fujitsu.com>
In-Reply-To: <62C7A730.3020206@fujitsu.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Jul 2022 09:40:44 +0200
Message-ID: <CAASaF6zXQ0OQSxy+jKXvYmzcz_f3sWOq==8mJtKP1REmgXgk5w@mail.gmail.com>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] commands/df01.sh: print more logs when test fails
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jul 8, 2022 at 4:40 AM xuyang2018.jy@fujitsu.com
<xuyang2018.jy@fujitsu.com> wrote:
>
> Hi Jan
>
> Looks good to me,
> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Pushed.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
