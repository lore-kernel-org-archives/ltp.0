Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5953D5CC9D
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765879202; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/57fgEx3o0RdAo4sNR/sJfiX1NJTUTK4taQAzM7Ul+Q=;
 b=FVMdSvvh28OXkgldDQ3KX2hJ7Tk56lPhrPEmMQF7CUUec13MXBAE6bSP7Hyxzue8zGvlY
 M4zqD9uoHwQXPyTrq1i9VeWNMpEJLHIEnzPnrTVS2fqwskfXxE0cvjBZb0YivGi0cPMYBE+
 H70mykDBfFxmhE8M0UwrslTg9CfzW14=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 224373D0343
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:00:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A69993D0323
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 10:59:38 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A4FB12005E7
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 10:59:34 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42e2d52c24dso2253177f8f.1
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 01:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765879174; x=1766483974; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVTiC9V+0XS4BJddMQn9sQ12iY5evaxqoZP2z8gej94=;
 b=ATCHCN24o5KFDIt/Cg9y6xur86hlQ7xlwF+L5Y5fJqLJHEeUSxeejB4I82UgPgt6Zu
 CRvDRDjIcc2kgRoMjS2y8gMpzlqCMYQet19m8doibUJBhNHeI3bBqFiJ52XwsexZ5qlH
 T2U3O3IVBXuBf2ZvnOCs1NbLCB9ra6EgPFtZ0ebsE5utCUds9JPd8BVPQ+GAoA7sQLPk
 VQuQgQliPFqkCpFdE5vDD65r8sZ1m/5yQvAjIrPehxWXZsdjOLS/6rGHKQh9KxH/rG6b
 ufRPunUk+4ZbCuPN7q5bDZjSRUaCyJiBkdfxsk1bFbGR7DRpfArHtSqwR1A0aCsujE8q
 un3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765879174; x=1766483974;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JVTiC9V+0XS4BJddMQn9sQ12iY5evaxqoZP2z8gej94=;
 b=DuzCcKZB379PYbQqGARFTHETTJthgM3bvzt0IapsA9LvpHsy2B5BcGMOBhEmk3qaM5
 k52oOpD64DSLQof6lSwGrtSB1YQPneI4ibG2xOq52VHyTcHMH0zc4ho09O+FRzF2L1SU
 prxoVolz/37FagJhHyTKxX+cqy2jrjCWGOXvYE+y/RWCTuLJRBL0A70NlYNpflmt2Nsv
 9tWNUi9A48uSwgygmBKeoXsriHnQj3qduAS/6hNXsxE4TUZ0bro7KQ1LGOAXCN30gblQ
 XTALkVcJP7cfJAdJYgnWj0iGn24tT3Fqr/RaIl/pT3VtmvYhSlaoHZbS47DLMAGkm89r
 UBIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Y7C7KjIe/8P53THcdFwsBBuNxS9yX4B/MxF3g8Fkyuh/Bhn7E556yXdgvmpwJWxnKwU=@lists.linux.it
X-Gm-Message-State: AOJu0YxDNbloQt/gJE4QCoLS8XXnEInlAHmrZ4Eu8pd0QDDkIbdWLQh8
 hIkAL5VK3OGuCvnobnsbhU5B3WwBDLKuaQ7Pa8zc+iL0tdnUOs7TaTd5zawE6jtfG0MLoZO5wE8
 S+L/RF/M=
X-Gm-Gg: AY/fxX6fGvDncDOGtCmSx4/6Bjif7Zc4qgdnN1iqrAXGphp18p7DZK0Mt/RB97d+cT5
 PCSTqWmG7tSjAISAyoWaYq1XHUVNkkK4BR/7wUAuUI59eJSUsusewQgeptdcjirJNkoB7HGUUDc
 p/qqEfye4cucSumAiddhiWEtc1BzzHqA+F0NFTAn0lgHTkBreicBwa11LhxVl6fAHcYOiBylznj
 6cfJkAdss+DsWgUZzkdJ8pEX4goJybwxAEJ5cSG2t9r2krSDea+ZyjGseptvJW3aw/7ZUrbQdtU
 342OOQ71csf/PfgSZgHLo+pjZh3IpKrlB6Jws6r9arAJef1vrlK0RQjIMgaHqvf1y4OLIhNN8jH
 kw3dQS/0qK5qIcFujBS9SyNI/rKsUYmN+fn7knslr1V9oDQnE9NfsaE4450h58cpP1Tk5j6NdAN
 jhJfB2EKVtx5K7XBDxZAJ6+vNGE6Ffdg==
X-Google-Smtp-Source: AGHT+IFqCt9cH5JCPycL2XGL8QHvcTlH1EwTqpBMYQ13dXLpF6CN7SnVerPc+qPgo55ic3h/9rryvA==
X-Received: by 2002:a5d:5d09:0:b0:42b:2a09:2e59 with SMTP id
 ffacd0b85a97d-42fb42d8644mr14440040f8f.0.1765879173977; 
 Tue, 16 Dec 2025 01:59:33 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a66614sm33989556f8f.5.2025.12.16.01.59.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 01:59:33 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 16 Dec 2025 10:59:33 +0100
Message-Id: <DEZJX8WHVPQ2.F6D51LEPR1HK@suse.com>
To: "Pavithra" <pavrampu@linux.ibm.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251128044728.417921-1-pavrampu@linux.ibm.com>
In-Reply-To: <20251128044728.417921-1-pavrampu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH] Migrating the
 libhugetlbfs/testcases/ptrace-write-hugepage.c
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

the test is not using new API, so we can't approve it.
Please, rewrite it using new API:

https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
