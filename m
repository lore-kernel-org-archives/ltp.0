Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851E2C83F03
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 03:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751858824; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=N4VzqvPUxrb7ttViTFrhDpElzhbcll2oe82ml5B2D34=;
 b=kM70p/lrb0HWI4TRFQUeBNsRoZjeVax8Xs21CAW0PR08cqjlLaNSgF2csPLk3HiRLU9ig
 WQe9ONr1GDCDNxM2LGafTdCAyyJFyJdGfZzO18GVQ7N/dfVSWStmOmAKjg8cXjLmtcXGfQ2
 jlbT3UGwHG82hrI9NwqcYlHkfm29ceU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78C193C66AA
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 05:27:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63B283C2FB8
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 05:26:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DFB1360066A
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 05:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751858798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h1kvWJ1vUYd3z5u/ZzakjdZn6Y9MlK/HJZcOvZ5w5ck=;
 b=g/EvGhq40x/yz6QQD83e9WwZvudn03u0IY46uR7qYIeJHVIachLYUlx9ilQ3wxDre8tty1
 P2aPti2EewEUXs56xtN9zw436kXelBfNTofe7jJweYaqWjtwKE000pFGDKkoZ1Y9ce7r5D
 y52jox2AhCA/NOVuFjMBoOunETdqw0g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-mWyuB8i8MVGlmy9ZvXwb6A-1; Sun, 06 Jul 2025 23:26:36 -0400
X-MC-Unique: mWyuB8i8MVGlmy9ZvXwb6A-1
X-Mimecast-MFC-AGG-ID: mWyuB8i8MVGlmy9ZvXwb6A_1751858794
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31332dc2b59so1986872a91.0
 for <ltp@lists.linux.it>; Sun, 06 Jul 2025 20:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751858792; x=1752463592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1kvWJ1vUYd3z5u/ZzakjdZn6Y9MlK/HJZcOvZ5w5ck=;
 b=JUyhzhEYNEAeqpPFhKKVKdqF4WtxvwSMktBQdEkFFilJsjdR/eoo4z+NMZZr7Jakgs
 NtwG+invXP8gCVbRh2xoWi4h5zHuNo6+Rep5OW7R3HmsZGLd/qtdRe9CR1EYPeQqB3EA
 T/ftTrAzYtZsrmPOduWrF84PxoeDLi1KzcPrpibJ0qWT4H9LUZthVfGqlReZF+rOANxO
 nGA43Eni6Wc9FxrhmIgqAhvj2ThRtTU/OAQ0Y0qq9mBO63yX3LrJ0xDjoXG0IRg3bes6
 15JsaRqeu86NaNZuBzYa5sqpF1v3/59s8vevA6RBYpb3O1T62YklO2x7/36VWQ6NfN+L
 VwYw==
X-Gm-Message-State: AOJu0YyoT1GoxUUXU9JQoBgPkb1ht0kTWITwXiF3S1PlpiIs4j0ZHMAo
 rC0VqAwL+Co2c9oxDEfmGq+YANt3BFkwyaqQHmz6V+Du0SnWqkbJqwh5BdSeWercYaQ+f9Q+EjZ
 uqRgPAZojo3FfprJubE0GwztUZwVllyxoU0/TzgECUHa7AbLhhTAh73vo+E9GvVYpLPHaWp0hV6
 T10CGf1XwUha8liyNUPMln3Azc+HK9gsv8FyOn7A==
X-Gm-Gg: ASbGncvm3fEdGRYmby0DOnKw7lW0Si1E2B7irNscqHsgRCpA0RQNiVVGz3QgDyYuIQp
 b3j5v266FCJt0+nbX+6izOCyI582YqQzE7XJCTTswuOE/agiasjqW611dE8Oc0PG7QELFIi8L8m
 mZCW/B
X-Received: by 2002:a17:90a:c106:b0:312:ec3b:82c0 with SMTP id
 98e67ed59e1d1-31aba8dbbb9mr9254489a91.29.1751858792322; 
 Sun, 06 Jul 2025 20:26:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQp2TOkhvWxpNOo6nM8DynDbc34E9ExXZrYdXwat0AlklWFK67v8eXJUrr8foTUNm1fhglUh6CTs5ttFp4VxI=
X-Received: by 2002:a17:90a:c106:b0:312:ec3b:82c0 with SMTP id
 98e67ed59e1d1-31aba8dbbb9mr9254459a91.29.1751858791909; Sun, 06 Jul 2025
 20:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250704-conversions-munmap-v2-0-bac3a0aa117b@suse.com>
In-Reply-To: <20250704-conversions-munmap-v2-0-bac3a0aa117b@suse.com>
Date: Mon, 7 Jul 2025 11:26:18 +0800
X-Gm-Features: Ac12FXz66TIQaidSJSzw5BxOEgtqtPe6KluisFtZavNj-lhUZi9Kl8AOsmAONS8
Message-ID: <CAEemH2cR77S+N4S=2X-aqVgeZEPaGQE7TWZm5wYgSpMTkd_6vw@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DFhs98pWNHsM5-94PwfaxXF9DW9PlCpROscBG_P7LXQ_1751858794
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 0/3] syscalls: munmap: Convert to new API
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

For patch series:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
