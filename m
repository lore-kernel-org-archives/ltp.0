Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DC4CDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782303659; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=GppsO6vb4VE3Cj5jix6jTqxKJ+NtPcIBf/if3opruum1loXXbnNHSC6umh8O98WJ8k1Xm
 ++YUE1XDHSdDCHLTByKG6my8GWZLLhGroEvUwkhfGZAAIhn9GrmkxsJZHpsrW2QRmVSC3cq
 x7UpkFvr066eBss29yStr2/3sOYbPBU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08DFF3E6213
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:20:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E08D43E5928
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:20:38 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2A67F600A94
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:20:38 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso10024085e9.1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 05:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782303637; x=1782908437; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Cx7ZJbP5S3L9XMCHRu7cnGMUAIENgVJrOGyQpgCWWv4DUlunQS/1415fhtDrqDJaxo
 O+s4jreK3D2Jbm7P8PD7UQ5qktuC7FguscHKpV+N/mXXDYRi3IZ8AFgdYX+eHAS8GbJ4
 pJqyXhsc8Zm7EMGjYAWL5YKALa66hDCjy10YCpxgkipOTgEMElfxm7LB18ZetHsujvKt
 HVt1tYnJ+3McZQnqJQIcmYVq57IJYDlrp+QvmY+dxwHoz4QYs2u0QeKDRECkU4oh4TTn
 rku8xrBD9mGVb8f3SUgTYJ1qpnvTCfrcczfCZWtlDxjq8VIWEPmVgQQ57lZ6AztuZ/VC
 gsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782303637; x=1782908437;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=sajMgZaiZ0DY6BuTbYNO/Kzohi2yqO9vNgHpd/mkTL1vqqZ28Upgxto0MRNTU2Adir
 nJMRdv64cIG+PW8o79WnFMYT3YpDEFvhbfKD0iaK8LbjCA0zbf0x6NSDqQoqpEteUhA3
 /bzgpG2KWY48ZAZiriunP8xCNn2j8Hj9kVzDRvsi9w05TuDNbE+U1XVnblL9xcXsMC4B
 QTcbDqrpvhlEQgLiGZrMVJncVs61K3W6It3HzBdeT9362HkcfkPnifNs8Tsa5OwIvEyT
 /sWFFq8lLBsBfE9Q//F4gy3SlGAvh4VBok4PnHdyBlAw2GVXLHFC1Y96DF+dmiF0Zmfc
 ojSA==
X-Gm-Message-State: AOJu0YyygzIAxEeFBvDBraas6PTKMK3oHHyIIzQY8ycq4TVESUTj9P7N
 i94g/wM9JAGgcqvlcv5+LgEdFuQamSJG/KQ8YHcw9AsAqBnbvxLqDI+IkCBWQ4YmTUw=
X-Gm-Gg: AfdE7ckJPCbTWJWQJ/4D1WcyrYuPCOndXzkCSt2+hTILY+F/a3MiuGNylh4BQ055CLL
 iaHSO3L1+8oc56IuPNgSFZ0zK6SsDzVY140qvobnP2tByYQS8x6w8ThM1D4GcW6c1aO/Npt/48H
 UBSGkccoMGCeGAyEXNoezTWL0TNxh1hJSenu6Blttjsm5BVzYkUJMXxdEO4AaVbp3suBgEZCLdP
 gnJpZqoCacnmriAPBjOZeRhFGuE4pDyb5JBNdFOZTUnHOpgRctXwDLAfZqIPeYUC72fouD/+zhJ
 /+kqbwGPkspRth6CFSv0s8TAHoEocKZTs7MQz019CDNLZGRWQAv34R16RonEjhAH5355PbUwa2m
 196R4TG3g8RPNCpdplq1hGl6LgiaCzrdgyQ18nndSD5O8316Jwoj73b6ateHBE8E2CJRfujKOJd
 i8HHzEaQYBnNRFeRSK9L+A3EoZSjEZOJDJsjBnzuyPF4VdVBl8uflhXy0XRq8Haw==
X-Received: by 2002:a05:600c:a07:b0:492:59e4:f3fb with SMTP id
 5b1f17b1804b1-4926084a269mr44432625e9.3.1782303637484; 
 Wed, 24 Jun 2026 05:20:37 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279bc77sm5663376f8f.32.2026.06.24.05.20.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:20:37 -0700 (PDT)
Message-ID: <6a3bcb95.1fbd4401.2dc129.706b@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajvK8VLm1vdTCCCo@yuki.lan>
Date: Wed, 24 Jun 2026 12:20:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 06/13] mem/ksm05: Add proper runtime support
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
