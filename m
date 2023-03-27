Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAB9C7619A
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 10:41:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 962383CCBBF
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 12:41:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53F6B3CA2FE
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:41:13 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AE9C5140075E
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679913671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/gUjbVAkQDuX7AHmDh+6W0gG4fg46RKC4P0+iu7RtYI=;
 b=NTP+TRBu+/R0j/OOXEzJSWfcYfMTjG1OSxv7B2UNFpgJhGDGJI7/Ajd/UwOpxs3hYrmtok
 ZZICXILuRg4fnDCgJIFWOXL5qIvNDN8FhH3k+Q73Es5Lu/zyoyPEXzg0X+W8KzuJoUGyGS
 G4MLiR6cfqrBZLJcV9kBYBbRk/ENkoM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-oGolkF9EO16VNhNa55h5dA-1; Mon, 27 Mar 2023 06:41:09 -0400
X-MC-Unique: oGolkF9EO16VNhNa55h5dA-1
Received: by mail-wm1-f72.google.com with SMTP id
 n33-20020a05600c3ba100b003ee6335b6adso4491360wms.3
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 03:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679913668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/gUjbVAkQDuX7AHmDh+6W0gG4fg46RKC4P0+iu7RtYI=;
 b=BFUkzRvpOr+cVi+PZEnsmRxyVvVNkTRit3PTfick/UU0Y8vCJYb3nXa1S8rz4Ht47N
 UWg5xcq0W+2g2QEn/TTHCKiDfUwok6zBQrxHzUCqYOL6h0CRK1gzZ0Kyet1Jk3J8H8gj
 L1yYcVTVbHTU/d1lkftdNEli9G9qGb9m2wSEmHjxI0gsWOdaSpW0RcBTAMroD7yo0UCh
 vEBtT+7Q2Mg7+561rmqgmoygGJ60ubfFnDf7Ssv/IXUaph6gtT3JEZboAgiWt47oU9gM
 io/WiXbWLPLDKZbXAH/qUbYICYVDXxbdkbDp+bvxynf1nWMcQnv0t+36P0QHKuy7VCkG
 1RzQ==
X-Gm-Message-State: AAQBX9eWQpXssQghEe5oGatoIrRcimcXvN/2W6vsQYbfEKprZU/qU26w
 jdJKEChuG6Ok90k5rckEVciC10RAQX9m9wW6x9MpcuH7PDwr/1dhVKrgInJwGxcnj6DbvIW9HSK
 Eu5MxzJfzSd9r3N3p+oXAbPR8G/U=
X-Received: by 2002:a05:6000:511:b0:2c5:5817:f241 with SMTP id
 a17-20020a056000051100b002c55817f241mr1830415wrf.7.1679913668482; 
 Mon, 27 Mar 2023 03:41:08 -0700 (PDT)
X-Google-Smtp-Source: AKy350YMTy8MQDNXf37j0019Mqr5VDXL2wP4qgT7V0hrIo7YHgpQvggrDXUERCe1rt3MgMjxIxD3ZxvVLQqLhF/hnQs=
X-Received: by 2002:a05:6000:511:b0:2c5:5817:f241 with SMTP id
 a17-20020a056000051100b002c55817f241mr1830412wrf.7.1679913668259; Mon, 27 Mar
 2023 03:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <1679913040-4675-1-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1679913040-4675-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 27 Mar 2023 18:40:56 +0800
Message-ID: <CAEemH2cu7sXXyAC=D8pLXqEbFfctdMrafgRMNh5s67vX1MrYLA@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RESEND PATCH] runtest/cve: sort by cve number
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

Thanks for doing this, looks like you're a bit perfectionism :).

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
