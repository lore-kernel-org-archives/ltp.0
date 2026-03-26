Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69DF10A3D8F
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774529033; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=X0hXaHkm0G6v1I+KFXKzu3MH+Bvj64eG4NGXlwPEDcw=;
 b=m4tkfmH2AZIhanJ44GX9jR8GcLxbQRFl6benbIsYeyL6SsNJA6AiIdTcoBvnBal4RxL7Z
 r54wMQE3Su/f/4IphtvjwNsXIbbMVh/CKn+2C1AbsltdxrPYq7yRSu9TpzmGPfsq86fXCLC
 MBxWMiA4L/krcJO5fYoxckfu4gUrqQw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AE853CBBCC
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 13:43:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 584943C67DC
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:43:29 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CE589601D06
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 13:43:28 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso8049425e9.1
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 05:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774529008; x=1775133808; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Hmh2MJacwzv3aj9Y7rme6AublsCP357JztvEdlYUG5Y=;
 b=AdkcBTNUDkhR+CvIDaq5rLA6Vd0wIAFaDj2reObiMjOSDYOgJ5jtfF1B9zqIbErD2R
 zVKeCuPUB3/zoiFihiyO4J1FhT9H1sr4QRh1hwcnW5QmVW1yY8cNb7pbpghZpWRccBvT
 utADqQzmF6RrjkXQHbgPkwc8j5MAmmLBnEn14IfLq2rtmq3DyyLhwZfnnTn2HUTuS+Oa
 RdcFBXXfNtw2jX/Z8TjkolAw8jsv10KCUt6c95lJK0dCrLSJtn6x4Es3jSV8VlBwIQLu
 w64uCkB70Obz5UQBErFNPA9nbOFHsuMX952gFfoGci3/D6S/j4E4I3+C9DcLwQpSaGO3
 N1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774529008; x=1775133808;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hmh2MJacwzv3aj9Y7rme6AublsCP357JztvEdlYUG5Y=;
 b=nxEwMWPTjHVVFEdd6oOhECNlII7RC2x0x8PFNf4y2JaBTQXkaB9ITViUuVfZ9rboAr
 q9obj5capa73BDPFMW7kfnFt2qa+O1i5aYtZ5nu9jCPkzC2+49WNZf/qSNfVHyBe/XR/
 bEUlZTpUFJ8FzxGlMAum8jlJocDYPhva50R5uWP3myPzchJuUVVqRmjM0+eZf3ABjBeJ
 +39e7IoXsW5W/gXKo4Wqw5ApR5fjEUz1OE/y69N1kJk2iHH5tt1N3mrO+HTcbCay6f6J
 uaEQbC1QewEtNvQdIiQcBxfC7l0FUsFpbnQFYmMIOhThq21PunidEtlvCZ5Vr7dT05bi
 wy/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI2gfUKsHVb2dy4jORBtMHpH0qvD0v+qFPCYgtRaypfUH3eKFQ2k2snmdmhLrQ8V+FqoA=@lists.linux.it
X-Gm-Message-State: AOJu0Yx5Rb2NhUgAvNyC5yK+aUeD4zTggpgbWfWKdjxn7Annc8zYGtf2
 0L9gSCPJvD7ZYiii+yM/NmFVHfioqQLbS4kpslgb9vCqmwjP4MessE6dbTeEagVLj6I=
X-Gm-Gg: ATEYQzzJbjIG+mm6UwYVCU2aiA4HCeqzZjSd+xM+ondT57E6OoNL3LYpTy8zyGpCqCW
 +rK1fMzQq2vXaEp1VhzUixBxSTkVSDQ1uG+Yh5S0YsQf92aB7BVoCJvig4LRChP3N88WFtpq57z
 mF/FRX399WpMEC4ujRTnDD39L5yBAKln9iYDINEPC0KBhgXHJ3OzmBDufek99BFlZZ64FM7uBOx
 eIFna8C9iI6Xo4Hc1gOANmlrpCcMDnNOS9s8g7zIWkENvIImrycAqj2fyW7v5LsBT4BMuh5yT7C
 Ipt/E1UnEoBU0j7+XmEsXfzuBnlLIC5Sg2JEkbOoVrRuFOvR6kn0sFWgwQm9+oerY3/6CksIldS
 CBuBYqeVpjqVmlNgYg9Gnd7dze8jqETloBQwCol10bV/r3Saewrq5Fnz3pgZC2UtqqX+g1nu3II
 A3L+e+9D5pZJ+syCxs49dRQ4i5Q7uouDW4owqAlxhY
X-Received: by 2002:a05:600c:1d0e:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-48715fef7bbmr109361545e9.10.1774529008190; 
 Thu, 26 Mar 2026 05:43:28 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4872090fb74sm17879335e9.7.2026.03.26.05.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 05:43:27 -0700 (PDT)
Message-ID: <69c529ef.050a0220.2ab184.8fc8@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260326123255.GB152048@pevik>
Date: Thu, 26 Mar 2026 12:43:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Minor fixes
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Yes, IMHO TFAIL.
> 

I guess we need to agree on the solution here, otherwise Ricard will be
puzzled :-)

I see TBROK as the right solution, since TFAIL should be used on the subject of
our tests. Also, if we receive the wrong event there's no purpose to continue
with the test because that means we have a kernel bug.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
