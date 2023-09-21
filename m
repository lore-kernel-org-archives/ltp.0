Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD26CD4938
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 01:17:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33CD33CE3D5
	for <ltp@archiver.kernel.org>; Thu, 21 Sep 2023 03:17:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80CEB3CA6A8
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 03:17:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98FAF1000C03
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 03:17:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695259062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GpntJXxrm1YqieVqwFW8RiTxiWeALkyBV4zsPhIIIW4=;
 b=THDF5aQt+TJwWGp9tsl9KkcR/nkRUJCawSqSDF3gz0/xvS7HZBESczt93e2VUd/wOdmj2H
 eiR4P2LxlrIkFiw36BI0XU8KYi4LGQFaxkkeZRoV9AfXVrTSnXE15kSr19l4GE0lUAMx0O
 8FzLF/5gXG2L9h8sissOz5ICztDWl1M=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-oLUbfV5LPIGF90-BXpzHzg-1; Wed, 20 Sep 2023 21:17:41 -0400
X-MC-Unique: oLUbfV5LPIGF90-BXpzHzg-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1d64f81e0daso590349fac.0
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 18:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695259060; x=1695863860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpntJXxrm1YqieVqwFW8RiTxiWeALkyBV4zsPhIIIW4=;
 b=MO4UzKhXxtV4zCY9qZMQtJZ7Gi6P51Kgon+ZgOa4TWfhaEwBD/Yqc8Sm9LHiHyq9pZ
 sU8pM2SJCfzMsZH/NE3kMzVz5em9Rd+LTYwMDOaAb0tH/gNAE/6q7RoNZOveiXdzRz+x
 ubsAP+m2p0YY8QZq4Gcm7c7jp+tkZYKMSClBlXRgMjP9YcHYK1RVsvROqZClsCmQ5mUp
 MprTOB2XggAdmVbX24smlhUwavNl9C3MFQs5VhEjYPPjfjxK8P8/9++FOjP5qLZ0O3bm
 ygA1Rk0/zNk2oClDBk9WlLivQeghGQYrYOGzD8gs3MYcKyOXGg9yaEt7GeGlq7vTaApw
 8cZg==
X-Gm-Message-State: AOJu0YybVSB+W7R0kd+107/EX4svIXwIHuV9FI5M9Jgjdrj9ER3don/w
 SJZlBkwGKkrZQazrKrcZM7LHxXL4Da0Zvqfhlyfcpzf93u2CaK05PzhCOdTddLnBVbyPWNHjEVu
 DFUi39MhcyCM=
X-Received: by 2002:a05:6870:568c:b0:1b7:3432:9ec4 with SMTP id
 p12-20020a056870568c00b001b734329ec4mr4501462oao.10.1695259060182; 
 Wed, 20 Sep 2023 18:17:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0dMSr9WNHVCqUOVEj/Fnh3QT/y/I8Ydj1BSjbUMYH+lpLsgrCLsvUhAAFDJrS1IYvR5TkUQ==
X-Received: by 2002:a05:6870:568c:b0:1b7:3432:9ec4 with SMTP id
 p12-20020a056870568c00b001b734329ec4mr4501457oao.10.1695259059946; 
 Wed, 20 Sep 2023 18:17:39 -0700 (PDT)
Received: from fedora19.localdomain ([2401:d002:2d05:b10a:c9ac:2dd7:6463:bb84])
 by smtp.gmail.com with ESMTPSA id
 i13-20020aa7908d000000b0068fe39e6a46sm138710pfa.112.2023.09.20.18.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:17:39 -0700 (PDT)
Date: Thu, 21 Sep 2023 11:17:34 +1000
From: Ian Wienand <iwienand@redhat.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZQuZrkayZ+04bC2f@fedora19.localdomain>
References: <ZPlxtKUwOta4GYh2@fedora19.localdomain>
 <65af05ae-bfd1-8153-4662-1bf61be855f3@suse.cz>
 <ZPpOuK9lyWr2wZWI@fedora19.localdomain>
 <845ca8fe-1ae2-13ba-c9e0-a53cf953c0ff@suse.cz>
 <ZP+4xTgAuTBepQge@fedora19.localdomain> <87r0n2gip5.fsf@suse.de>
 <ZQI14xCNkc4wjpC2@fedora19.localdomain> <87msxpgmf4.fsf@suse.de>
 <ZQLowDHRBq8QhQwu@fedora19.localdomain> <87edivhm0i.fsf@suse.de>
MIME-Version: 1.0
In-Reply-To: <87edivhm0i.fsf@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/device-drivers/zram/zram01.sh : don't
 fill from /dev/zero
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

On Mon, Sep 18, 2023 at 09:24:47AM +0100, Richard Palethorpe wrote:
> I did miss that, however it's actually more rigorous (read "complete")
> to test these things seperately. Or even better to test them seperately
> then together. Because if only writing out same-page's and a single page
> with some meta-data in results in a bug, then your method would not find
> that.

I've just posted v3 [1] that separates out the two testing paths which
I hope addresses these concerns.

Thanks

-i

[1] https://lore.kernel.org/ltp/ZQuYiFMOSq1tMTBs@fedora19.localdomain/T/#u


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
