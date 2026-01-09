Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96FF7D232C7
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 01:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767923509; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kG0jPHSGd6bWEEQsLpHbRmsSyA+EB0EZ6TbJwhwg0nA=;
 b=CTWSTJX1uGjD3MsFOH0MhtdrNzGauquK0Tnl7KsK4cGvVtcBKsRC4HsdGynUaan2EcTxT
 5vWcMeIUdSOaEq8Ad4NCHb/FI/d22225YEBONpHAZkuwbHTi+NXBySRP/lXYKNZNHVBhUoy
 ilTWS0NhIgscyKr/+U5WKNoYhqpZwso=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28B2F3C682F
	for <ltp@archiver.kernel.org>; Fri,  9 Jan 2026 02:51:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAC9C3C65DF
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 02:51:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F33D82009E5
 for <ltp@lists.linux.it>; Fri,  9 Jan 2026 02:51:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767923481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gf6TGLWwfqu6l0AcvS6nEgWyPVBJdNLPdQP+ufGLXnE=;
 b=FpLYlZTwxtxf64oKwqNqTk7HsHDwYKZXsmQhiMA4HErJ2sdhFabWTZW3BuHf5n1Ze9ZOKA
 /HP+gdt4ZefNVkWveOPJH4/GMQtHxyZxNXSNyt1ctIOjZFn6bt/Z8SkJOHNZd/CaeO6XCb
 5GwMlaKtS76BjU//JI5T9TclfOCakSY=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-UIcb_9OSM8CGcHIcxN8jfw-1; Thu, 08 Jan 2026 20:51:19 -0500
X-MC-Unique: UIcb_9OSM8CGcHIcxN8jfw-1
X-Mimecast-MFC-AGG-ID: UIcb_9OSM8CGcHIcxN8jfw_1767923478
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ae546fa935so17287593eec.1
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 17:51:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767923478; x=1768528278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gf6TGLWwfqu6l0AcvS6nEgWyPVBJdNLPdQP+ufGLXnE=;
 b=v3biX7aGwwZ9sxPM0SJSpKKiSatWbsl/ZQNeldFitbtiY49RL8tdZs+oVTY5fcGdZD
 hHAzXQJcqp7cgWuW7ahQ4yTohQvzKvzrXpWh94Ol9oBYx993KwIjLY2l2ayzDCAyigU+
 AJi46VbDzcTkITc3egt+wY2xiRsygF0fhZad+nRrLUbSqA8Y0XvvP5+Gzwte9kjbbDiJ
 4zrpEqPWLILaFy6XSvNcmZ1eCm8sumacm0B91WgeKb+AtFH4aWi7RKys0l9kN4nUvjps
 rFSDOLlG8iHv6PmQL+8q4jPwtP5Dz5/izs+VsPO7PxHd34itc7tuwKEj7uFwNh8IVI6W
 yfsA==
X-Gm-Message-State: AOJu0YzpGn7Lf7MdTdLN4LUrTDb85RxeqwGWNjYPTX2dQxPzSXgDr8JF
 wphD5v7Ts0MW57sB0lh3x5/m6AhMtdtJG1L2Lz/zuaCnZdoXVsZSP0cpIxCMrZXXaMnKCXYmyKa
 Z5siCtN35xnP7Z3eHXaK4AfTu2Ts8e2AXNz/l4bGlBZXSV3UGXpXQ7dGiBKZW5NL+nXADTVvYiY
 r8lDq5PvulPIk21ZcWfQh/Kbj/SyU=
X-Gm-Gg: AY/fxX7RDy2w0lBgO81ZCGwp+22PgqT/ip4ln1CHrsDc+TmvVR/DoVmUWzREcB7mPI4
 lcP8pYnqiOhrGzd+okMoxXE0gGxRmunomh03HUo0HLI7syr78xckyV7VsRwezECUf993MGfvzi7
 /EtcllSc37vvMhOMEtF4nY751E3uZork3m8Tqsu3gNqI49ojfusj5hXtgA+GJ/n/2RogQ=
X-Received: by 2002:a05:7300:f806:b0:2a4:3593:6474 with SMTP id
 5a478bee46e88-2b17d30fe63mr6349286eec.36.1767923478124; 
 Thu, 08 Jan 2026 17:51:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKnnojkpMmtsn71l/q5Dfz43gZbD8fdkzGhLAYFz7F+LQVOvetIAYk9BLzt2sd68sFnNLcDvaavTwJVeevSJc=
X-Received: by 2002:a05:7300:f806:b0:2a4:3593:6474 with SMTP id
 5a478bee46e88-2b17d30fe63mr6349276eec.36.1767923477699; Thu, 08 Jan 2026
 17:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20260108224409.165481-1-pradeep.susarla@gmail.com>
In-Reply-To: <20260108224409.165481-1-pradeep.susarla@gmail.com>
Date: Fri, 9 Jan 2026 09:51:05 +0800
X-Gm-Features: AZwV_QgVjmWgbxw8usCHAtqiTB7ZqHoRIQswQIVEowIYFE2A7TC0HzWv1a6L8uY
Message-ID: <CAEemH2e4v8OUSvnT+cbSpWSqX_naSw0bAxphSg1ZsGfQk6zSfA@mail.gmail.com>
To: Pradeep Susarla <pradeep.susarla@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vgrsKPfIGsHMnXKT8nwhXZS0AYjDjJ3hCuFtfbZvUbc_1767923478
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugetlb: migrate library and numa helpers to libs/
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

Pradeep Susarla <pradeep.susarla@gmail.com> wrote:


>  .../lib/hugetlb.h => include/tst_hugetlb.h    |  8 +-

This would be better named "libhugetlb.h", anything under the ltp/libs/*
should not have a prefix 'tst_' to distinguish the main LTP API.

Otherwise, people may be confused about tst_hugepage.h tst_hugetlb.h
and can't find the '*.c' achieved file in ltp/lib/.

>  include/tst_numa.h                            |  9 +++

Rename to libnuma.h.

There are some other libs/tst_*.c that should be renamed to prefix lib*,
but yes, this is not related to your patch.

>  libs/hugetlb/Makefile                         |  8 ++
>  .../hugetlb.c => libs/hugetlb/libhugetlb.c    | 10 +--
>  libs/numa/tst_numa.c                          | 79 ++++++++++++++++---
>  testcases/kernel/include/numa_helper.h        |  2 +-
>  testcases/kernel/lib/numa_cpuset.c            | 64 ---------------
>  testcases/kernel/mem/hugetlb/Makefile         | 28 ++-----
>  testcases/kernel/mem/hugetlb/Makefile.inc     | 24 +++---
...
>  testcases/kernel/mem/hugetlb/lib/Makefile     | 10 ---

>  testcases/kernel/mem/ksm/ksm02.c              |  5 +-

ksm02.c compile failed on CentOS 10 x86_64.


--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
