Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BDAC3ABD8
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 02:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747275450; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B0xkG7D3PITqplcFDMEdRWvu/jqPZtgpjyXl6ggGLmE=;
 b=EWz625L+8pZ4OGUcdFfsTmrEKwlZGD+hMdnx3WQGcLaDhb7idAYkNzaa0a7/c2fRD2ROl
 DBF257CErEPNY1J+3IK5M+6JTlk+fBlaYBoMWoqNKTz1QJmLyhpo45dB2GrqPIaCuVyInUm
 WvNDta2ZkJA0zpjNF1On+o9ecnCVDx8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BADE23CC3EF
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 04:17:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E78543CBFCA
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:17:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 06E9B10006AD
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:17:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747275420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=Qf6ctODQer++2prsgXUyK2d1CjTBT4PK4kfqBgCf8wyhPy7Q7Nq9r7WsUN/5u+0VGliVin
 u8PNZ5CPJu9QwyYafu8zkOk/Z9YyqnnP9kvBCaHI83tEUPdhXLO3AbkDraGpZOdu/yPft4
 Vm8r+sx3ND3paliqU4ZkOUhqXtQxJRk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-DRHCaUOJPuub230qIyBSXQ-1; Wed, 14 May 2025 22:16:59 -0400
X-MC-Unique: DRHCaUOJPuub230qIyBSXQ-1
X-Mimecast-MFC-AGG-ID: DRHCaUOJPuub230qIyBSXQ_1747275418
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22e7e0a86a0so4280515ad.3
 for <ltp@lists.linux.it>; Wed, 14 May 2025 19:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747275418; x=1747880218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=tcjMf294Ou4pvH2Sw0V8fbSF5Lp0e3lQgApLc3P3pGvztWASMJpyMqSiMJX87BE85d
 BMbkp3gaHYsIyxoRvQsNGx8PF/kwOssgTTikmhJskGKFrVa2qxXeKnpBcqeqOprIRU5Y
 uFSgPocwy22h8ceb16jjobyvoRClODEohw5mhC3sPJ45S0JrP3fruGQAV6sj2q5tCWgk
 O+r+cwk5pThBjtoFmtWZKGuylnOrZ5HKkWOvMN69e/Q4pSTWQWKiNlU3yH2wbj6HF96S
 q68NEFanK2Zz2BTELzM9jUv2LXbtNWMYV2d5JR+W0krK9FZ/mRHWr9YgmqcTrOpoeC3V
 CKgQ==
X-Gm-Message-State: AOJu0YxmqvnOQRcYzE3hai1TKDVs8d4pmDggeB7BQSLYG/8ZT7hIi2ZP
 v0kPWF3DPVlxvYNPf75SLgHUSx1C3KwUjGXRVGJeX4N142FkyxTMC/aY7pEsbv0QTQswlXT7Hr+
 bD3i7OggnDhV/brS7I6hxRsY5x01wvDVpR05KILWd7V9JMr0x/1ohQ7fH4KxadcvfPMOIJ3OA7M
 8Xm351R1J649a46qkWVVqY30k=
X-Gm-Gg: ASbGncvgKsuRsg3C0hMwDRheRZQeMJ7W7l9mn+JoPM0b98NS2LL+H6ru3ylB8iINqE1
 Flcou26xnjFYl5YFxb/lSmq1CNcoUf0/zZ3GAiSOYtF8QBKa78QND80WuPJuQ258RXWlVPQ==
X-Received: by 2002:a17:903:f86:b0:224:11fc:40c0 with SMTP id
 d9443c01a7336-231980cbea5mr81905545ad.11.1747275418380; 
 Wed, 14 May 2025 19:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaxA6VGrGNJEXy/DOtiXJx6W1SU1KMaOwFPToBOxKVRkooSSrwXXUnamTHncWV8i/HVwfuW3fd1/BcKp7f7Ew=
X-Received: by 2002:a17:903:f86:b0:224:11fc:40c0 with SMTP id
 d9443c01a7336-231980cbea5mr81905385ad.11.1747275418074; Wed, 14 May 2025
 19:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
 <20250514-conversions-kill-v1-2-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-2-cd633e941e8b@suse.com>
Date: Thu, 15 May 2025 10:16:46 +0800
X-Gm-Features: AX0GCFuIwP6RKQWXg-O2SN2bcnrrTfQipy-PAFgUxLP8tpqM52ygsQlcTlWr8Es
Message-ID: <CAEemH2cZxthfPX3H+GFmCoAi2D3baiTNWb1i02X546oi_cArjQ@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IAGOkw0qCrP9EKDl_D0fcXHXExom2Nuvrcebn-a8r4A_1747275418
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] syscalls/kill05: Fix test description metadata
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

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
