Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6041C55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 07:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785999763; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Q/plVgr3N2Hp8+bukj1A5mR0H+e9FvIouDhvX2YuTzk=;
 b=GUJc2GXiDf2DoNUsepFi3ve5JxLk74q3B23ijC8RXtwfTeZ2Jcbu30iMGCEKLE/hIVLAa
 Jo25mD5cvynHW+F4LLNaYWH8N3Q7WMJPxaiI+ZfkO8mW0IrD0ClWYDFEPy+oMj76qBkg3Yg
 H7/JuxLgrdRvkvCe6HPiFkCofnI5r0E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F1033E2800
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 09:02:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E84563C280E
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:02:24 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49DAE600860
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:02:24 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so13251285e9.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785999744; x=1786604544; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hMMj4Qj29qqUkZBis4keu+e5cwVIvfoXG20q1XTQVWA=;
 b=R8fjnY0x8m+yhySYNGokkvwS3QQrA/IEgFJIp/AiepVXx31JJWZvzsOPNi2ik2fGpe
 Tf4OCPsD12X7swiMVlCyvs/EORZ4u2FWsVlKk0ncx2ug8sn+EPhTksSn1ZyczFPpDrph
 hrz6PMFN5IpjsJzdIYWQHRZzL14kZ3UHd6BZYStok0lSL/LSQvTp+S25sMzkwLQTDBIZ
 vl7rYRHhrzZKBbRVrCiBhOzcT2oKsou2FFa55HtaZ4mmiIBUa0/lbS/NcGBwqmKLv1mP
 7RyIW15MNX0Fkb2dl0iKHXd60OFvVUvgObfe208LeiWJa3j4ReS8EnSdLilaB2bgvYOl
 ad6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785999744; x=1786604544;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hMMj4Qj29qqUkZBis4keu+e5cwVIvfoXG20q1XTQVWA=;
 b=mk9MRMDS+hcunjVAB/bVGhgej7NufaQfLvWIe9/OX987fy0PBKUifqf3RQE8/V76ZL
 vlwR6Zx4V4sIwTkL0ZL3mIQ+aUTgqlq5nOp8h6hoLaa/YvdJV+NPDd25NhdW5sf3qvNd
 C30Nr+e7tEuWeXYWgNkQb3PEsLlGC70PfWkB5epyxhG5H3ZCg7K2UvPuuBTrTALvuK+2
 I992ioqpTh5koPdlZoKPOjCYOHI7z+m5Bd5SR6BBFb7RXaYowAddum1f/7f/H/6gqjHR
 wg/iA0T75rrPc9N1MKEkrajGsO1bhvTG39G0egQ5XyD5qhaYI64lcFmZlCRAuU/aUxT6
 dUeQ==
X-Gm-Message-State: AOJu0YzOSC8eGqFl7xNETO//DEQNfsFlg/RpbFfwGvXT64bW0AdZdh2F
 L0Erd0PJYH3AdWY12DKixahwEtL+SqSrpO1QTRhNEMy6NuI075uZHHCwIu3/8dkQQqSmYTpfcpf
 mIzP25/Od1g==
X-Gm-Gg: AR+sD10wU9jhXknnrW1KmOuVZSTqBzxkEGVwjyVGJe96XtMBXWecv4lDx16emssVaST
 nbPNiTQp0/tuAWeemU+xFJWeFwVFtJWVLbuzlVX7tAWpV/uwrp3T2T2rgkG7/elokDa4yt6nl/T
 NR2ocaJG2EyUnt/GH2OZ/njyBiwnnyDmq1xeWhMKOgPZovAma7MLzej64eR3o2IQhACafZCwwE/
 c+TslAQWqoLU3J96qL6frGjwY37lpzJGoXFGkHCGvzBo8vEQq2iYmm22RSgmZyiegV7tNTg9gnU
 Um4uMyxejlEO/Ehcn1ZSVwgarFnVrIaED2RcIQV8aJqPtBwTdZEVQXVKtijI+kpUWO72qiqvnEc
 Egqbo8mxNqG83XKPYl06I0WiLW8Z5U7Gir3fvQtRQZ99nPyrDgXudJIjj3qd9IQ6O6206T+zD08
 nU6QnbHRZdaefVL+r+r9CpoT/zgPARSHoW7XnjCLVDi4p84aCUDl8h/DBf6qwwjpVgO05h6lAx+
 6j3v8YLiBOtzK8rRXRLZiA8pTzI6UvC1pcrx9/e7BESappx6Zyt9H+Ezf25ALZxwx20TnQ=
X-Received: by 2002:a05:600c:1550:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-4994e6c5521mr153419105e9.0.1785999743618; 
 Thu, 06 Aug 2026 00:02:23 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995422b741sm39687385e9.14.2026.08.06.00.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 00:02:23 -0700 (PDT)
Message-ID: <6a74317f.5b42f266.2b3442.f731@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260805151451.648990-2-pvorel@suse.cz>
Date: Thu, 06 Aug 2026 07:02:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/9] tst_kvercmp: Factor out error handling
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

Hi Petr,

We got 4 reviews..it seems like there's a problem with the CI
and the new instance is not setting the state correctly, which
is used by the script to recognize if patch was already reviewed
or not. I will fix it.

Anyway, we can say you had enough material to fix the series :-)

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
