Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A41C636CD
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 05:28:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE39D3CB929
	for <ltp@archiver.kernel.org>; Fri, 10 Feb 2023 06:28:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2A803CAEE6
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 06:27:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 741291A0081B
 for <ltp@lists.linux.it>; Fri, 10 Feb 2023 06:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676006875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D0rOAVmALBtza1N6PMeiA0aLTdSXsnPtRvk7yZ6QCPo=;
 b=f7ygm3Wcm4WIpNB2uGN413K7d53KLtk0CLr/qLRAMyzjqhglLIAOgQ71Uk29tmI/vs6aLN
 zI8LjJcyqKvsMyIo69tRp5mZHrGSvEBqXxrOl86tuJFqOqOWFZld0EzSQRv7+i3XM/fM/I
 8+JXhekNxgsieOksYvktliJ3vYjuZNo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-ISzpuupIPG6u2Ra8RNms4A-1; Fri, 10 Feb 2023 00:27:53 -0500
X-MC-Unique: ISzpuupIPG6u2Ra8RNms4A-1
Received: by mail-wr1-f72.google.com with SMTP id
 by12-20020a056000098c00b002c3ea83975bso953189wrb.0
 for <ltp@lists.linux.it>; Thu, 09 Feb 2023 21:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D0rOAVmALBtza1N6PMeiA0aLTdSXsnPtRvk7yZ6QCPo=;
 b=nIWOc0aIVtyL5OMVWQt4mrihzIEt1MrW4OaWao3l91HRvOE1A7t/F3CPpCPHaQghtH
 /5c5KtFFaJ5f540reGqLBrO9uizdkkcSCEEwEWAMCvP4dFONa8hlTUjOLQ3hXqCfaDq+
 PSAvafP3GEbBn2v1K1dVCC/JnMUfAgP0o6TiNdWIAI1KwZVjR6xCakVkGsXzxNwAMbD8
 my7u8OSjffnibsYq0ug7E2uKjm/O79TQrAOm42kMG0EeKP/G8Qog7cyyiOtmGwOqNDia
 59EtgjLxsj80+2xhPdjdEulCHbKcnLGhHoqMYLcl9cQco8qg11TgylQDaHjdKxJPL7yz
 UVsA==
X-Gm-Message-State: AO0yUKUa+4yU0wfkGKRUOe3JWLoiimSeYliKhAZN73lQnEUhTf7TTo3a
 CdHsSnD+OsmUFvM5TtbzIteZm6VBuUlDst3oalHURhO5kZg12NG7tG8KG3sFGoAbdzS6zutOx38
 9+5t9AUyA+fsVES7dZtgyRjZySTI=
X-Received: by 2002:a5d:54ca:0:b0:2c3:df1e:f767 with SMTP id
 x10-20020a5d54ca000000b002c3df1ef767mr646861wrv.316.1676006872527; 
 Thu, 09 Feb 2023 21:27:52 -0800 (PST)
X-Google-Smtp-Source: AK7set87PPgxR4aNwwWNArAEdZShM/koIeQ5VNfa5H7YeI75g5UNeFv7ukVvE2KbAZvfeE/5yYzCcLGIUeiaSUyxq0Q=
X-Received: by 2002:a5d:54ca:0:b0:2c3:df1e:f767 with SMTP id
 x10-20020a5d54ca000000b002c3df1ef767mr646860wrv.316.1676006872366; Thu, 09
 Feb 2023 21:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20230209142016.494090-1-pifang@redhat.com>
 <a4e0b95e-47dd-0c05-9575-a844d1e05953@suse.com>
In-Reply-To: <a4e0b95e-47dd-0c05-9575-a844d1e05953@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 10 Feb 2023 13:27:41 +0800
Message-ID: <CAEemH2d2CoivWG_A+aDURAHSTaY_pE+djDYTeVu8tmWdGnw86g@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] aiocp: remove the check read unnecessary flag
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

Hi All,

Thanks for the patch and review, merged!!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
