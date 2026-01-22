Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4CDC44536
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769042412; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zctf3pExos75W8UJlxtgz7DqbqHSnKobGi2xc4qev50=;
 b=DIvOu7w93PmCoaYGjoovdoXIJ279jnKvzOsoLyrX7AmpmTku8rIT43xqxc+p7oapBwfyQ
 t6gLr1cDn6hqTYzsVBRWdgJxqlEoWfEbnRMCQkqvC7b+lHaEmvr2U2zjBCPe4eUrrN2XN7z
 vJNwDM7z7zKu992T+g89wEsJct34R10=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E34C73CA57F
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 01:40:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C422F3C1E06
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 01:39:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 423081400C49
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 01:39:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769042386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/9vWnxfIq5lH9MhUmTit2P4IE+b4HXn7qTf6ly65jtY=;
 b=UYx9yJEXMRaO+DLOF04Jpz0uU09QW15Wh1LKU7d+gpRe7UELTssjkfOKnHjmDMsDhIGq6c
 chWGdKd8pEyLiER2r1HpGyjUdH71ineTwg8F/MGvQVKu0F5AtHSIgPDmOKAp//Lo8kW1O2
 FlsbCnL2VQLMaSI2z64xsxzwYVq1EJw=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-nq6SeWH-PJK2GOQ_N4TavQ-1; Wed, 21 Jan 2026 19:39:44 -0500
X-MC-Unique: nq6SeWH-PJK2GOQ_N4TavQ-1
X-Mimecast-MFC-AGG-ID: nq6SeWH-PJK2GOQ_N4TavQ_1769042383
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ae32686ed0so2681389eec.0
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 16:39:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769042383; x=1769647183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9vWnxfIq5lH9MhUmTit2P4IE+b4HXn7qTf6ly65jtY=;
 b=dniZci+hR+SUgQgPUPTGOSr2t2M25tmJ8dqUgwm+C7e/vUQNC3DvgKdGskM0O9C5pP
 bJ5SKRBoTRDkFlR6CUdhNX/ILy4QsNPKhhGAQozqE0zSnbrTlX5rPKRYlN+NZwbO/6Eq
 RmtTPNlcf8ZeLpur8ur2TT+DRXm+D3k0GW7AZw0YunNPrgi9qQwnu6Wuye2JhV3vZL8T
 mXX2XN1vlZpQEieUKqO4NYRgAqumcAvIagKd9Pc9SHKs3P0OBdCMlXdul5Rq1Z7iQ6ON
 SCEMNW3Dr+1Ez7yLv7fY3LyvrmQ7DXVm3YBldDKidroL2K2q4OnxayDQrZrnyeIq/xhI
 ov5g==
X-Gm-Message-State: AOJu0Yy0odgd4IDfOESbWBCRyIP6UQjoE572I41DdoFNobKgLbYSLQ0A
 Wn3hJhB+q7RBoGpE1IUKq+6U3VPT1pbhlvNPgyPLv7eo3Zg0xscSi6kAIgedkTtTMdvkuTfBjaq
 o1nF9EwPjghepOjuKzocdAAcZVtDiJ2p5RSpSukQ43D2qqJkRcPFQfEgdRdlLuixilp12SqfrIP
 FL2SwGfHkvuB+viHgMDPPtvZABFM0=
X-Gm-Gg: AZuq6aL6j42xXa/xD8LUi+zBEvODEm4kVuyuSAjhoNzer6UlU0RX9Tjujc4jKnj0ZUD
 DhDlRkQwqrXz4cGRjDWGzLpzsXjZbALLj1sHYK7ukrDids6BY6TwX+w7y6kCWrt4vlMIiSPAmAj
 k3cgpmIyhxgWUwkBlTuvjuuO6WwOOcd4NWydhHJMf7PqJ+VWcEfKJDpBfV4xN+85sAofE=
X-Received: by 2002:a05:7300:3b08:b0:2b1:7910:b102 with SMTP id
 5a478bee46e88-2b6fddb16bamr4248360eec.37.1769042383381; 
 Wed, 21 Jan 2026 16:39:43 -0800 (PST)
X-Received: by 2002:a05:7300:3b08:b0:2b1:7910:b102 with SMTP id
 5a478bee46e88-2b6fddb16bamr4248352eec.37.1769042382931; Wed, 21 Jan 2026
 16:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20260121090159.32686-1-liwang@redhat.com>
 <aXDVaT__f-LssTf0@yuki.lan>
In-Reply-To: <aXDVaT__f-LssTf0@yuki.lan>
Date: Thu, 22 Jan 2026 08:39:31 +0800
X-Gm-Features: AZwV_QiojLmT3Z_IVMjJ6LgSjUU8mOeZpiHhZTcJRZcbL9VAgoCSZf3CvaExjlw
Message-ID: <CAEemH2e6ohk7f2L=N+=ebDStcn34js9g=YfejD2irJ97tSnjRg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U7glO8jHpMbPxf5ibDP8lp2rgzLUGR8aQZU6xThklI4_1769042383
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/tls: remove the TLS support from i386
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

> Shouldn't we also set .supported_archs to x86_64 in clone10?

Nope, the others archs also work (aarch64, s390x, etc).

> Otherwise:
>
> Acked-by: Cyril Hrubis <chrubis@suse.cz>

Merged, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
