Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AD3C4332F
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 08:43:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 137883CC925
	for <ltp@archiver.kernel.org>; Thu, 24 Nov 2022 09:43:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23BCD3CC909
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 09:42:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7EAC21A007E3
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 09:42:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669279372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ymeL3do2fTGveq11ff8VvFo0OP3bpo7SY11cPdyoZA4=;
 b=B9OmhC8EO0dGysYxiXUzpjygfmoTkQtD3yg7PekRjw3QZYjPdlkZ4cU5FKhDCC8pi47WRL
 wbJbucy3w4pT8YiA3Bh3fiPHe7Y+szDMicAYOpVeGtnl5hOSAIfDDEKJAN+X4MbXfX8gdP
 PghMUx5xNoaUiwFiLv76RDpp3GNoxa8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-344-N0syrasiOBWxNp2vkFETvQ-1; Thu, 24 Nov 2022 03:42:48 -0500
X-MC-Unique: N0syrasiOBWxNp2vkFETvQ-1
Received: by mail-ua1-f69.google.com with SMTP id
 o43-20020ab0596e000000b0038421e4c7deso563317uad.19
 for <ltp@lists.linux.it>; Thu, 24 Nov 2022 00:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ymeL3do2fTGveq11ff8VvFo0OP3bpo7SY11cPdyoZA4=;
 b=mxqNiEpAmSRtW4uUkHvrYAbhEasGR36CTlADYP9hHVQ51PV0ua7h4T81GXjuG14PMV
 iWfiYsRxfEQOo9MU79teA1AxtvutC6xsKn5N61NP6SgsEfPEi6fiA0Rbbovx7VEESoLy
 IYULEsbN43ZawPmc0dXsDHbUNa3jno79Gg3/PD+/aeodMsEYXFBWLe/CWwDY2VzNuOy4
 0wdYcWjdRyMYbqiEwSjzbbCmUELL1HmeKOMN6QAE42iUbwq+DBmTIGeahZ9I+bHCj2by
 TxOiiOsgi2ZRvQsRR6rznDu3tLmu5tjZ9N+3PWvq54+O1/PFdY8kQCtEBiUzYw4c2V71
 dLmg==
X-Gm-Message-State: ANoB5pnF+kMpcRlmmCf3HjHydhLbsWDmbQw12SulYmGuLpEZTQx2KRpI
 CUeIf0bmI/lKsFGiXqpUm8Wj32wEiKP5P6tNu/PBnBjt4H0sXr7ovyfSDwcrRUUMQhPIrR3dSu9
 0jae0XSXmWtO0UDXlw68IK36ZjDE=
X-Received: by 2002:a1f:1182:0:b0:3ab:b376:f1d5 with SMTP id
 124-20020a1f1182000000b003abb376f1d5mr8097033vkr.2.1669279367628; 
 Thu, 24 Nov 2022 00:42:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Azji9BpbdWwR3ME/8DeIYzTe7sdY9A5MKNun+xoDRDRj/sj215ILHG3cN8AR+h/fqdTQaCkvDFY5Y9XtdDrc=
X-Received: by 2002:a1f:1182:0:b0:3ab:b376:f1d5 with SMTP id
 124-20020a1f1182000000b003abb376f1d5mr8097026vkr.2.1669279367376; Thu, 24 Nov
 2022 00:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20221123115546.786-1-pvorel@suse.cz>
In-Reply-To: <20221123115546.786-1-pvorel@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 24 Nov 2022 09:42:31 +0100
Message-ID: <CAASaF6zhxLAk3kmbXoT5t1NcSakp-PG-Uw3_q2g6MwBcXAYEcA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] Remove fs-bench
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

On Wed, Nov 23, 2022 at 12:56 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> fs-bench is horribly broken and there does not seem to be a lot of value
> in keeping it.
>
> Closes: https://github.com/linux-test-project/ltp/issues/994
>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

I don't recall seeing it used.

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
