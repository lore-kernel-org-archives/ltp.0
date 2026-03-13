Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB674105F799
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773400880; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=/yM7+QH4Iw2B2I9t6QFdBDwd6AAaDxnQNzuJp4Cy568=;
 b=JmKPHMXs8/HtzL391fxelVAsLHViZ321xmUE/0SMg4OmT0gEkL//tfXwl5IUWCZfJUXAZ
 2RWwlMz7GRlIyTveLnVJn/54bizvbT0CV7KIavticoMuT6VV04JZUaxxFJ+t/ic+mgRvw9Q
 v+MkkLTvKijXC+Pk3P/LL1V90OtO7fc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 736263E52A5
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:21:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3DE43CBDE8
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:20:56 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 71FBA1000A22
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:20:56 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439cd6b09f8so1717295f8f.3
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 04:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773400856; x=1774005656; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=raviDmFtBNowqkTXQepekCJxyqJazHZ6aqSFH1Z0QVM=;
 b=c3hMg9czBloEbB5f4KUxi3bRj4QiOyqzfTKyXSXMdjXLNuZ+Xq7AkjktrWypcUATZR
 8Q40/1P1XPCEDzKuOWrqpJ8wPMug1ST6U7aGsTXo6SR3eSSS6Q5N+bZf4riitRdefu6w
 ITAhAfUHHn92vptpf66jYtAaL+G9WppjbUXHWc7AfFejxxkFH4OzuKbpSzPZnbqTftvq
 z5KFAgzfKxdLTYsrrKQDq6DlUWEAJLxA2Qc/iVHHS9bdNtVJaHos63cw7CNB7DBA1NH6
 l62lN3cprkU3ePJW1rkcOTzjIlN6fR/qnFXXrhjTnNPskMjWs29mHxvGmEQdMGL0PUJZ
 1c4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773400856; x=1774005656;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=raviDmFtBNowqkTXQepekCJxyqJazHZ6aqSFH1Z0QVM=;
 b=TRwJi4az0dQagZ6HDY26OfbP16ASUjszFF0EHXDWKwI6FzIPpA8W279W69yPDzUl8h
 u3NfXZV6Y8MzLP8O/kT41VFtfjx4PVda+tPmDE/2FUlbjpBK8wqagX2NFOkKeQIinmVP
 wmx+w+1Gny2YdGE+7j9RhyYCg3Y+qnCrppgzVTEst2IUS5OxPtRAKcnHybsHtNHKL6+C
 sN9k4sSwibj8nklXCKfhP2H0t5oG0eVlvf3i29ItELBLwRXS4s5Ze2xZyItuZKqC15/r
 fh6tz1EPn8USzvFfMhuk/IXHXNeKCBxOndpauXqU5+00ZxLaRGz2UbXB2w7slXvej0yU
 q2jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+LTQwMWsbTgnp2rLVtt9vNNubjL5PwGQH/kKE2eah0hkRYmiT20macmyTZzBhzYGl1AM=@lists.linux.it
X-Gm-Message-State: AOJu0YwTjRiwBqIDcx5zTyzO8tG2Q167Pi8JIaak1a41DmusN+aoOeSh
 BlhWN+Y9P9lQWxRUFWN70xoR9mWPBu2FksmP6RXhIwUK9cmiiemLaahvsjvER4hstwPJEx8ezw3
 4pwQyZeo=
X-Gm-Gg: ATEYQzxLmHK88Wevi6Df40RmmG4LwNRNt5RQtdgDNaRPPyNvDnNP4VXUs+n2zsYZANh
 3XV7Uov7C900ZX3/fsT5z/9b3GwhVIaJd5wj9jmyt6u/GAqioin62CCM21j8LwG49hpKjMhwCYS
 E+0w6tqUbi/fN/pVbie2esof5vYJIzbIOUh/aZgkhE9P9tpWw05Lrrxr5VctoX8LwbEAcsYciqE
 8QRXj+msZ0UGijNLDKJSoOptSDeZ+KOlOLwSM3AclmbpIGMrgUV7bxGQ6v3PJkdbx4EbJz4KtfN
 Nr5EQPrrXIoPOZNILI3QGUyWoGxj3KIn5pKEqD/Te+9qa4UN26cvFUKKnw3da/yI8MxY/GR0yZ3
 rGEp00Wi3SUKB8z1qn9jvQc2NFBTtf5x7/YNdgFz5E9CB8Oe7hStV5YZSx09COFMWRosQfDC9C9
 SFIAWaNGZHXEzoec04EQ1XIs8ZWeNj+degzYD4cIpAWrPkBn2MZlgRiJpgHsnEHQH9exFmMLHqk
 8QQUFMqGrKdi2S86FZ2y+1xKG4rvrN9VPlL/edUFv0Yo6OVDLjDFUSoA70Cg1m+Ys9VyUVYztAv
 3w==
X-Received: by 2002:a05:6000:609:b0:439:b0ed:2af6 with SMTP id
 ffacd0b85a97d-43a04d8b6c4mr5634641f8f.26.1773400855715; 
 Fri, 13 Mar 2026 04:20:55 -0700 (PDT)
Received: from p200300ef2f4fc90013ded37855cdb3ca.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe23afc5sm18682524f8f.39.2026.03.13.04.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 04:20:55 -0700 (PDT)
Message-ID: <69b3f317.5d0a0220.a5656.a17b@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, ltp@lists.linux.it
In-Reply-To: <20260313-listns-v1-0-04ef0081a377@suse.com>
Date: Fri, 13 Mar 2026 11:20:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] listns() testing suite
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

one thing for reviewers: listns tests are not linked into the runtest files.
That's the only thing which is currently missing.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
