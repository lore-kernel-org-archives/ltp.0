Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD854CF64A6
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 02:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763607473; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=s1/XfZNM3IO2R2GK+A/7021BkOW12Lb7lbgZOqLPoZk=;
 b=jGOlSDUlxtMf0TKmCZ8oY3PeasBjnaN6OtWuEsHbvLKNnbwZUTnYgsxG99IrFjUm4SQP8
 HAUr9k2z3vjMgiaWj6NUm8S31jCYqGuqMBHMu1oXfNtXcMLEwTZSiYZ8A0TS0vSSTe8bQJU
 B08cvAp8r6JJTcoN/VC1ahYcpoj6gsc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8B4D3D001E
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 03:57:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB3FA3CFE83
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 03:57:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA4BA1400FA2
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 03:57:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763607448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v22BbftygPunq2rNtYwtzQHF3qMmWP/lipwmjzfqa7M=;
 b=bpeFXvsIZHT8XGK8tYCboKra/Mxj61Ic3M6XD1uVsNM4BYERtklNKgNHjDPUMF5BFusntw
 4aBb11c8KVkAB1wh51gGjGIIIwU/ldLLSSPsFIe5017IYyUUIO19JyplO+8hPqT6C807hr
 v7k+2rB7aJ5oeiaixHmT5Q2N+Eg0kV8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-6kozNRgTPYeXWn2NQDG23Q-1; Wed, 19 Nov 2025 21:57:26 -0500
X-MC-Unique: 6kozNRgTPYeXWn2NQDG23Q-1
X-Mimecast-MFC-AGG-ID: 6kozNRgTPYeXWn2NQDG23Q_1763607445
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b99f6516262so1269026a12.3
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 18:57:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763607445; x=1764212245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v22BbftygPunq2rNtYwtzQHF3qMmWP/lipwmjzfqa7M=;
 b=vI1CRLiNUzAh1vYFUU3yrEp0QI0SFdbzDis19gVsrIuuNGIAIWwpE+/M2gaCkBGrmM
 NRos4Rm9zh9maq0iKDU5IKvBro7kuNh0GMHS6zKmuqpptlHKZ1OkgR5oRMjfWCXEtVeL
 CVGv+JQosBkBIlwFse5ZNcMlZjkU+i+nCvLuvukHSvE3MlN1tZNVE+Hzbqz6dsY1dbsn
 /Ec5cqNVIU9HsMG79XjupMspMRKB5j4WfknMk2BkhCC+Z5hkqsg0DN4kmOnWjPhN26I4
 rlmF+ZgxOuh4IWAPl9wF6rg1nfPKnJhQYXUXj6hiDLuxULWQXNolUdaLxrJ9OaaSqdFG
 fv3w==
X-Gm-Message-State: AOJu0YxAwXtDF71oeXgi9zvTzCZAaJ+MB3B8/vtOqSe14zlOrFf24A2h
 cStv9jOpRgD3m2RwXh8kDHBqWEMGSP2rFDLAFKY0oasU7IUdQ3VB2k58LayMIM9NAY4wglYFpTH
 5GaljNygZ+vF/7P1jxtlaYbLTpVS+5BSvxFQck9M4qKnauPwvXn8YOVFPwJQjInTYxEEjlWb7iG
 cSkWkqWwiD4j5884GpSpIGOXHxRKo=
X-Gm-Gg: ASbGncu2YbfDEpopbDaVeKA62hJKjlGCnzIhO073eMbQIXO8ne/YiBIgN8DXtYBFDzP
 IUBE6mpoDqLMsTd8gDn3wA20KsplMMO+gGZ50Hy+YKDTtw3G+X7/sd4nfWtrE9k36HUDL4CUmdw
 yK6+UbXrdF5gWJSDhM0pE5euaBoviaDNb1aINApeUAhsbI624jxqAZtt81p/YZkA/lufI=
X-Received: by 2002:a05:7301:1295:b0:2a6:9da9:57fc with SMTP id
 5a478bee46e88-2a6fd0437femr571850eec.12.1763607445118; 
 Wed, 19 Nov 2025 18:57:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0Ac71DagLgrNa8XLZc0K4mxVjCUK5cnZLBW1dkcukIzQ9uYt8kquJwsSqTzfXkSeXTBl5fyKkZUbaLCnhsrw=
X-Received: by 2002:a05:7301:1295:b0:2a6:9da9:57fc with SMTP id
 5a478bee46e88-2a6fd0437femr571845eec.12.1763607444678; Wed, 19 Nov 2025
 18:57:24 -0800 (PST)
MIME-Version: 1.0
References: <20251119185642.80816-1-sbertram@redhat.com>
In-Reply-To: <20251119185642.80816-1-sbertram@redhat.com>
Date: Thu, 20 Nov 2025 10:57:13 +0800
X-Gm-Features: AWmQ_bm1yftCLzMB_uvPI78R3ReTLLl4joak3H_pxUr8jhxz_W9TlgElGS0CkYM
Message-ID: <CAEemH2dDAnvC7E0jzbpxFsZ_eNEptF5A2SP5KRA3D8K07_Yh8w@mail.gmail.com>
To: Stephen Bertram <sbertram@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YPuIi_KR9EDC49ge_R-Pe3jHCJ9c7cbJFTh-lMln6_4_1763607445
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7] Add EPERM test for clone and clone3
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

I made some minor adjustments and pushed. Thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
