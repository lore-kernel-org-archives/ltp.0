Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA1C77B61
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 09:39:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50BD03CC4A9
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 11:39:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86B693CAE7B
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 11:38:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA0662009B1
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 11:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681378728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ni1hpxjxZwKFScjWPSo3zTjDaLoHDyopodIC3aDrE+g=;
 b=SYYtTI+Lk1k2qnDw4Uq7LHYtO+JXjdCg8hCjz77DUtjelrTwdciI4TlZ6wuJMccEJmRcUc
 40O/IpVWZoD67UgoRNQskHaAcBNate0rIgiWCFBL9iYnlFGgnTln9hV1NZ4WxAXCqsWcse
 Fj8HeTkAjQTSzZByNyGEpaa9c6aKnmM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-oxHu7vb9P8eDfnw0eRgb8g-1; Thu, 13 Apr 2023 05:38:39 -0400
X-MC-Unique: oxHu7vb9P8eDfnw0eRgb8g-1
Received: by mail-wm1-f72.google.com with SMTP id
 c19-20020a05600c0a5300b003f07515bce8so6426306wmq.5
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 02:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681378718; x=1683970718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ni1hpxjxZwKFScjWPSo3zTjDaLoHDyopodIC3aDrE+g=;
 b=SVtPq8IsHGsFNmOu7ysQytucxHPamvdzamzLcFvin0JwlQ3Hl5dX+34iaeTKsjVwws
 heHvI70GnCACKzWrWeK/3eodxSh9CwY43yvAGmI7EKsQAGekk2v/VDVDZTkNEE5x/+Xb
 EO1Q5LZmpb2HLlY4EUk6X0UZP1Leq5oIrPp8oaGvXU7JaVbhYSAliRytIPyTyTWdvuZF
 rImcab7SSJWGbjFSJp8rfm70NTjhkpRh82afYpConAISQ1Z66gP9qfCKNZHyesJkJk2k
 cN8pGq9+rxeGd7lOACOazI8s4F62lIwkf0Lye6KXzinCCR0rQAG6159p6o0l8ZsXpXfq
 TI4w==
X-Gm-Message-State: AAQBX9dR77G5oU4asaF5e+wMvd7cct5vz7aP5myMFWISuxSMBhzDZ7h3
 1UaFdcx0Rxkf3AcxIZCF/Az1jhe1LNiICeFjyy7tzrpKh11zD5NvhrYbGEl7SI6/dnKuLu/F34E
 MAWy0UBpxtowOKc0XrXIJow8wW3s=
X-Received: by 2002:a5d:4a8d:0:b0:2e6:e4df:a7bd with SMTP id
 o13-20020a5d4a8d000000b002e6e4dfa7bdmr207471wrq.7.1681378718043; 
 Thu, 13 Apr 2023 02:38:38 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yyf0+8i2ZNNFrdSTdHe40X1LgQD9EZhje236rKV0+JMhj5GOi+z+GB8xl87i0Nz16rDNGeksoaH8k1avEabsY=
X-Received: by 2002:a5d:4a8d:0:b0:2e6:e4df:a7bd with SMTP id
 o13-20020a5d4a8d000000b002e6e4dfa7bdmr207466wrq.7.1681378717778; Thu, 13 Apr
 2023 02:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1679293822-19378-2-git-send-email-xuyang2018.jy@fujitsu.com>
In-Reply-To: <1679293822-19378-2-git-send-email-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Apr 2023 17:38:26 +0800
Message-ID: <CAEemH2cCPNd6wkyGiBKp-pAVpjQ2-L3nEtff+s=oWJG+2PLGmQ@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/4] ipc/semget02,03,06: Convert into new api
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

Hi Xu,

I help tested and merged patch1/4 and 2/4.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
