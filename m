Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B96D7308D
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775186882; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1AjWsYmAUodEG+AzYVACGDLUwH/U0Q/SKz5hwpSJBDY=;
 b=IFU0roNLeuohctAmulAVOgCxFjds6dGGaOkXzQ6rw6CuPFk4sFiOfAxgqt29f2JAnsC+o
 r7utndXzdJiVpzWk3K+dI01FeASf+JnDoMXOC3rbydt4v2vpW4/X3qgJQRn0wowgPYuGGSl
 8wt5W11CCPX+/x35bEXyXN9/oCgFJiQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5CE63E54DA
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 05:28:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 933D23E2389
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:27:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 154771401107
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 05:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775186855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5eCS+OtAF0QP3sBhUUnVtIMQujdGkqwaL7fp5oeKRs4=;
 b=hdIfWlwGmb5u2xHian7JRBWKfi5ULBVoQlAUI9Ngivjf/e5bPX+KwAM0KoUgoJZ8GLd9U3
 TdfDJQpgtawxKhkdtmkDC9T3503Rij3dWDM5m7RyZaC9zFDUQoCQwnPh5ZdSlihvYBqavt
 Fni0/XZJnN5ix6zEOjGJXjW16343x10=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-veylHh3AOhW9YwuNQW1SPA-1; Thu, 02 Apr 2026 23:27:33 -0400
X-MC-Unique: veylHh3AOhW9YwuNQW1SPA-1
X-Mimecast-MFC-AGG-ID: veylHh3AOhW9YwuNQW1SPA_1775186853
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c895e7de52so3652879eec.0
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 20:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775186852; x=1775791652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eCS+OtAF0QP3sBhUUnVtIMQujdGkqwaL7fp5oeKRs4=;
 b=lyRI5UdgkQ5KrbQ04WiGymkwimcctpesxBHYS9QUk7keAELWARVZLaUgzVHrYEUVhY
 WT2zc8V3nEbpYL/t7fYMB+n0ez5+a8pSbzMHSLWxhepCPUfkKG0i0Z6RfN+UpPL+hipC
 AuSWc3jVWJ2giqn7ypM/gk2MvG/3u/zl0ETqqjPfWIK8+LfDCRF+zfOlXqbvobMtjTAD
 MEvFGxtAnQf4xSt5mDHU4FmHYYXRI1ho17ROFqSQXiNCSebOBPjetloXyDWoPgWl6K6v
 QPV/yAM0ZjOFz0zgO7L/nwDo4ZvsHUN/iO8OeFgx0zrcP2pcEIk0zYsTVzdUABSWdYow
 d57w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa4KPkmeIiKHvUMThpIbUzTCDk628KRC54f0oNzzBd+RJrurrJ2cn8HKSYn9hRFaoA6Ro=@lists.linux.it
X-Gm-Message-State: AOJu0Ywpqmlm5D8i8JLHKxVLS4rNEpM8Vfb3lnhJtVLAnSkz9baOk4/x
 DgdklX+Y0RcUlHq24mL4OuW/FxbP/3evSGWDl9X3RdNYgjKQSh6JeH8wOEV6sKxy3iI8vXa1Yws
 HiCrIFbOTIHCJ+3/At5nXLRPUIHkOznOG6MwocMv/grt03OkfZaaihugtCuanmJH4YIAHXBXgRa
 Nm3X7vVxYVu5IM90Yov4hoJixVrxHaqrn9wVHoxA==
X-Gm-Gg: AeBDietFkQwcVm1SyvwlFx1O+0kjoWFH6vnKAhLVaeDCtWA3HcNOF6wNK9Hswgmu1k7
 aQ5bgqN/dguZlwWHO/HiNloZ9AlYppjOlF95V+Uqv4/vSr08WrEdYD27/Tap91IkyYHBWRx2FSS
 y58p7MMgKd/MRuJJf2i4EQaAtCcLdTdHjjecEqH9EdF47VCVx2sa35kDrlDzwvkhdk/uojl02CL
 jv/Ig4=
X-Received: by 2002:a05:7300:571e:b0:2c4:4276:709f with SMTP id
 5a478bee46e88-2cbf9afdabfmr903138eec.1.1775186852099; 
 Thu, 02 Apr 2026 20:27:32 -0700 (PDT)
X-Received: by 2002:a05:7300:571e:b0:2c4:4276:709f with SMTP id
 5a478bee46e88-2cbf9afdabfmr903123eec.1.1775186851623; Thu, 02 Apr 2026
 20:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260331200026.244979-1-japo@linux.ibm.com>
 <ac8yq1ir6r_9Q6C9@redhat.com>
In-Reply-To: <ac8yq1ir6r_9Q6C9@redhat.com>
Date: Fri, 3 Apr 2026 11:27:19 +0800
X-Gm-Features: AQROBzAdAJ09_K84INEDDQ2jLjQf4nGM-poIce3PEVZfaLfR7t7w3isHqJqnOG0
Message-ID: <CAEemH2dtQLwOjjUUcKmfuDubAycc8RyyrAEo06_ky_xnZRh=kA@mail.gmail.com>
To: Jan Polensky <japo@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sQcLp9Psrtr62tTL7rAbvsqi0PAhM-K0Y3xomOgS2rg_1775186853
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] editorconfig: add consistent formatting
 rules for LTP
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This is a nice improvement, patch merged, thanks!

Oh, sorry, I actually merged another patch, but wrongly replied to this email.

  https://lists.linux.it/pipermail/ltp/2026-April/047395.html


--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
