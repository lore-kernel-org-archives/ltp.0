Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA205C52D71
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 10:21:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A56D3D207A
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 12:21:25 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D0133D1DE2
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 12:21:10 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5FC811001F42
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 12:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723112467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+84/Idf3agYGAQrtSnClZGggVnQtzz0+/xmkfKBqIfg=;
 b=XuKSNtGqIdx3CGh12ALpYiq8Ez5JqeegL150hrCbBrQG5dG0BvweOGLCG+Ekw9Kq1KbeK/
 R5xpUGir+CdvasrYQa0w45cd0fA9rOLjjBmbpqqZh0HqfDxGdrEVleW0WNNoVLJfGtpcOo
 ZGl+vAF47uJcteOy3okcozfpoEUePKA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-TdqfNx84PA2BKLlCQvkcSw-1; Thu, 08 Aug 2024 06:21:05 -0400
X-MC-Unique: TdqfNx84PA2BKLlCQvkcSw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cb4c2276b9so1029848a91.0
 for <ltp@lists.linux.it>; Thu, 08 Aug 2024 03:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723112463; x=1723717263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+84/Idf3agYGAQrtSnClZGggVnQtzz0+/xmkfKBqIfg=;
 b=uKOo5CrQfTZFgqTVa7sCR34jnRf3dS+vof0OJ9FdsakLvsk5FQJlKxPFaNecpGnovx
 RtnFpgxINhbEkvqUgyYswaDeSM2LGlLEbbN35+IxW1esibdgLv9QsVEGO7zedUoFq4+d
 l/HT9s8gF+aJwkTQ3dssqvnxlgPktYwYjKHMg5taTSMX+/xXUf7NeV9gKYIlVlxKHurV
 MokFw6xQNYNFBhkpeOIbPEwBWnIOvx+ErridYK1lhWD/Q/etqzqh+ekyt9Mc8EOzydzW
 0XMlXQgkKP8dS/65I60myVYxyzHspUrDZSFQXFwWb2ekF+1BWLVdOaNIHUpbw3Cyan7W
 oPLQ==
X-Gm-Message-State: AOJu0Yybxo9xBCqZUfhnAnv+16OTg+rNVm+XSijRBdUQObh8AAYySm7v
 Ktl5eNILVTPlN6Ajjiq0cOmx014/wExABAKsFCDSSv69YLpxKPorbOSwpMRo8wEN9l/AgZHE+k8
 yqCpElOnqrW267FaKdtR6fPib/waSev67JIo3PSQGzNaUPvKgyNKmjjJSpAXTs8RdkgZZV3L07m
 1f2j1Gf5Dg5JhorJSO8KifN8c94Rk8oetptg==
X-Received: by 2002:a17:90b:3503:b0:2cd:2f63:a447 with SMTP id
 98e67ed59e1d1-2d1c346b5ebmr1476767a91.36.1723112463303; 
 Thu, 08 Aug 2024 03:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKbJY7swiIMPCqELYSsKN1Iz/Z2pLFUNC5mOyiJcLZT9Q0uQP7acReQmY8JrVK8r82b/oGY4ZIrzsPm26u18U=
X-Received: by 2002:a17:90b:3503:b0:2cd:2f63:a447 with SMTP id
 98e67ed59e1d1-2d1c346b5ebmr1476756a91.36.1723112462983; Thu, 08 Aug 2024
 03:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240808065732.64328-1-liwang@redhat.com>
 <20240808074416.GA306790@pevik>
In-Reply-To: <20240808074416.GA306790@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Aug 2024 18:20:50 +0800
Message-ID: <CAEemH2cTymz-XGi+PLLSLLy2tYynKS0Rv6qhi-0LP_JNtp07vQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] pkey01: Adding test for PKEY_DISABLE_EXECUTE
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

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:


> > +     if (!execute_supported && (tc->access_rights ==
> PKEY_DISABLE_EXECUTE))
> > +             tst_brk(TCONF, "skip PKEY_DISABLE_EXECUTE test");
> NOTE due to possible tst_brk() it'd be good to keep PKEY_DISABLE_EXECUTE
> as a
> last test. Not sure if it's worth to add a comment (or replace with
> tst_res()
> and return).
>

Or, we can use 'tst_res + return' which is similar to tst_hugepages missing
way.

The rest comments all look good.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
