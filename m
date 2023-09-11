Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA0D6EE7FF4
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 08:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEF2F3CB3D5
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 10:34:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D7263CB382
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 10:33:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C1AF66009DA
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 10:33:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694421230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9eW+qG4kJFRXdX943CpuXXlkTJ3yUPL56YSwZ4XKyw=;
 b=cc4rTa7EqZD/6W1tXAE28JMeZIWF5lf1fQvJB1AyAnjm7piIxBA2RpgT/OBNhoGU16Q38O
 0EasRgz59OCpaI8OPRGM4nRyxZbjvLTEk4K4fCxUY37p4EM2O4Ajo/hMc0Eo49xgXqEFQd
 oFxWGnntV09wEp3gkXN4EA8pkjgFfZ0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361--YXqOSCxMT6bQJM9hWUDkg-1; Mon, 11 Sep 2023 04:33:47 -0400
X-MC-Unique: -YXqOSCxMT6bQJM9hWUDkg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5007cabf295so2641313e87.0
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 01:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694421225; x=1695026025;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C9eW+qG4kJFRXdX943CpuXXlkTJ3yUPL56YSwZ4XKyw=;
 b=mR6p/IWN7udqwO+4GMEauM4+LJeURBKvtQAFPsXZJhh8qYJbkV/9SmzqqlPmel/gec
 MkLyBLUAkdsLx7kVcXg0JvSLtUFvRy23JumtGsHUWNnNkMfh3g4KQGg6jyWjWQdMQC0U
 cc58y70fGVd5UqGXCsVz0UXfVWS7qF3qH9ztKaE1V8BQLh9a6nOWtrWX/F0XD3NJpGkS
 2JUWDhLWipx0aNs0g9Bs5l/FVqM+oQG573k5gxFTX11dLfgGByODvdx0X7g0clvTO+ct
 icuvZz9pLvV41aedz3gfZS0QjdPG+qI8wKXXy0gyp4NrOUzKERwoBkQxJa3gPfKMpxBJ
 VkpQ==
X-Gm-Message-State: AOJu0YyY+HPk8whQct2X/QOFkFRU8vfn6VTrTO12tZJPNthRXrMaI7sS
 Yi9UcdnDwboaYzlyC6gm3us2CxmMnWFkMDDZ8mwdSNZbXA5U6ZiTcDkJRVlullVXrY12Udl6+GO
 mJ7JpWYE5XfozRk+iOu+aGfrOVbyqbvRI480htoXQbqk=
X-Received: by 2002:ac2:4db1:0:b0:500:7aba:4d07 with SMTP id
 h17-20020ac24db1000000b005007aba4d07mr2491902lfe.22.1694421224968; 
 Mon, 11 Sep 2023 01:33:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7DrvHvEbp7egd1OaJMQNihWsdFuJMKe35RC41OJSelA3Pza2aOJv5YQK0s/uKtm3BmWhYOLXQSMp6yyHqBM=
X-Received: by 2002:ac2:4db1:0:b0:500:7aba:4d07 with SMTP id
 h17-20020ac24db1000000b005007aba4d07mr2491899lfe.22.1694421224610; Mon, 11
 Sep 2023 01:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093930.43971-1-liwang@redhat.com>
 <20230911080233.1305942-1-liwang@redhat.com>
 <20230911080233.1305942-2-liwang@redhat.com>
In-Reply-To: <20230911080233.1305942-2-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 11 Sep 2023 16:33:32 +0800
Message-ID: <CAEemH2cPvpiKsb4OPtm7j7xtut45Q-U+yhzODfw_dZJ6AGoHwQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] hugemmap34: Test to detect bug with
 migrating gigantic pages
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Li Wang <liwang@redhat.com> wrote:


> +       if (tst_taint_check())
> +               tst_res(TFAIL, "Test resulted in kernel tainted");
> +       else
> +               tst_res(TPASS, "Test completed successfully");
>

Note:

As Cyril points out we just need to report PASS if nothing bad happens.
(taint initiate and check work has been completed in LTP-lib via
.taint_check)

    tst_res(TPASS, "Nothing bad happened, probably.");


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
