Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D365AC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:19:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BC703E937A
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:19:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63BA03E9364
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:19:31 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 842C51401201
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:19:30 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 98e67ed59e1d1-39b2ad83680so209310a91.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788513569; x=1789118369; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KLkf2noe92nICk13AHw6DmOQv3wewbuYRyzPrnSkaAY=;
 b=TJPEk1B7ldOoOfWbVVBCcY7KSKnqIPxNlt8S7s5kP6NMzKQ27aXNEt2EDidrvdE6kO
 jaaP9KB3nLlxG+w4tf1tbrMOh0v+XVIg8ciKqISvhZnGI7uf5SkJUJrVp82uqNpmN4HI
 UxCKK+UL8KcRuAY7/GPCkiZnKYaN//HghrDVmjS1+gRC4b30W8H+xrBXhOrxdeYTGDep
 WiNcyYKwlhpgFZgO2WUYiMNvlohOEhsPPRt/8L9DrvIrwa6RIm0Y/9Uz4iTygCTBekfB
 2Z6el0g4qutHHapWdnxjn0V8e1o4TMtKhpyADL2nWXl7E3zta+IGfZnbCI2QNQyAVLem
 7f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513569; x=1789118369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KLkf2noe92nICk13AHw6DmOQv3wewbuYRyzPrnSkaAY=;
 b=gaNaF6ljP88LwCWbq5+RPbmROpIlxZdGSOv/ySlwsNHS90q1crZDcRwiJC4kLwMOpQ
 QVC/MoXH3e74IMU4F3NRVqNforEnD1o0abXtPetoQh4BPwd7hZwvArlmf4b7lVdIPqVT
 nZpTn2hixPdkHY8uiuSp7svvWiW9X04ufsnzPzEFGbYkaxDQco6jbdXLATu4o3D/iwfW
 1dUQKsIT7PXuSlaAlIbzgm9drFSloT84hylc/D1L1t0/9c0Cu619egkxEWLsd4wASwXk
 ogIumIWa1AFgEkNJzhjx9NRqDFKpSRuC/wijOYVbj/aclno+ViNswGLwZ5kZeOeTh9Pj
 eiyQ==
X-Gm-Message-State: AFuF++l+I6ZxZkIQU1zx77z5Nqb58PqHuPYtby5Aqi5OSTTwuNpjdUVU
 Iu7ph3dJ6th6/JNxHl0rLGQBGKze9KbFWFFrDy5tgTM2v12LYWgGOM/AJYPaRDIf
X-Gm-Gg: AYBFou1PFWn4KOtDqBNkMXwcUoVr1OvrE72e29WKOlmPjB5D1UZWvcUSSP0pGB5ufbi
 FYgNSkiM5oGZeTWXBtynzWxQOu1qJX8opfihLGBrX50PpNRzQOcSOILUkPo3SVGFqqDzxHF4ZGz
 wDrW0gaw9Tq90yWf+F56TNcZdtLeaumvakWKu4Cbh1aIu6pGTKkxb2iw0eAA1ONADMKfg24lF3N
 4CVUZL9MkyXa+LI7gE8a9bgG1lACLr1GdEYFPwe5SrjRIxDuytZwlPxbNo+/wO3HP9GZBC9tTLP
 wfwnZT0zAFq3UbX9+mQAJn9t41UnPmQiyPBwqi3oSW95ggsYRsIkDt7E/XGHvtf7QUOKYaCBXm4
 DtaEQbDoKdZCuKTS+BPjsX/z8BU9IGO8KP4YkU8deaHCk3HXstrveirYDi3Bm/uO178MpDYzslG
 via8f0dQ/bMW2p/70cx0MlSDWafHkQpr7ojt3YVKlNdVXcs6Ls1I5EJmll11dKnN/EzRss5wtUy
 dyJWjwYiLwwDHAEQNEnadAZ1Vh5480Us6Eq+7EDInPXE2zq7f3h2RW8ll3HZrRRQj9XqlopbvbM
 gduVCtia72ox+g==
X-Received: by 2002:a17:90b:5606:b0:398:9be6:f997 with SMTP id
 98e67ed59e1d1-39b262dfaeamr7780909a91.22.1788513568657; 
 Fri, 04 Sep 2026 02:19:28 -0700 (PDT)
Received: from
 runnervmejwal.ymvzq2soel4e5lxqzlhny3ygxg.dx.internal.cloudapp.net
 ([52.159.245.144]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa33e96sm5496857eec.12.2026.09.04.02.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 02:19:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri,  4 Sep 2026 09:19:26 +0000
Message-ID: <20260904091926.4048-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904085555.1202288-2-pvorel@suse.cz>
References: <20260904085555.1202288-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Remove testscripts/network.sh
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

On Fri, 4 Sep 2026, Petr Vorel wrote:
> Remove testscripts/network.sh

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
