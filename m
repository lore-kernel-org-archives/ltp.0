Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FB0C64990
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 13:48:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F14F23CA48F
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 15:48:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 213F53C8CA7
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 15:48:06 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 91BDE140044D
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 15:48:05 +0200 (CEST)
Received: by mail-ua1-x92b.google.com with SMTP id x12so7991385uaf.0
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 06:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=PGIr/El/fr8gOJcbPBowO08BNtp6T3x0o7Z9hsSsu6Y=;
 b=kLNEm+LvXj2AQBAEsNafNCA0tT6p7dswbW+jj9fg4Oh86//LtRMRDH0Y986T0DW16I
 L3IK3QU/5zfUAV8a+RGCyJ9lz8QscY283dsx5/CvxI16CHHNgtuBcg0r7NTpLylm2tRU
 XMdkWfp3NMI0riRYM8PcZoV0QjrRlqR9Lr+m4IQdxNOBO091NAu+P2eDpNuL3jkY3yVw
 3fwLNg0eVzCnD1VltI1N9Utpr9pi9TnZcPezkYXzMMXf2MhAdNBI0fvROL0v3J8sA1Mv
 kkoOjK8a4O15mpx3Zuzp0DdPR0chXrve61XUpRCjgvsjckTBnj4aReu29EZ6dxPD77/d
 T2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=PGIr/El/fr8gOJcbPBowO08BNtp6T3x0o7Z9hsSsu6Y=;
 b=UFmdY5ffXlY30eGZQkK+iAOq0VRJMtbmJWFSbyP0Ktqh0RN67iCCP3r+D24HR57lQ4
 tpVkRCMhyZdR5MIrtFruRwBitHpkRjP/8wsmf7w/DlHjyiRsQR4FzLzCVZSXwf/d6kDA
 O6bsGah+joyr5ic0p5aIcE0KSI00upO152xNeu+ywJI2WmYdXH6yYt45WiME1Hu/U5iQ
 CYhk8LXWizsvRtbO/CGxPUC3mB1tjCH2JloEKKy1XkpXV910qGh5fp6ng6eRdJ5ULJDt
 ZqMCUKPAnWeIgxNMekjAgsXlfya6I0J++/1H3UjhLEx9BfyrxdW1UxBHarnnQ8Dbizzl
 d6fw==
X-Gm-Message-State: ACgBeo0QSDhm26rzvSinvKmRJOH07ZqXGQeZHw9qmXQyXZbSHFEjxdiV
 N2s77c2Q9XmLshowx5YH/LMXsN1S3JDIedv8Q4M=
X-Google-Smtp-Source: AA6agR5OnoZ1F6uTuUNZnrwSaP9H0l4sleuYOxS7yn7OYMqWqh4vfV1cXW5IoNo/etFYQF3CMQhJ1TwM/XvqeREnjto=
X-Received: by 2002:ab0:6dc5:0:b0:39b:fa5e:77f6 with SMTP id
 r5-20020ab06dc5000000b0039bfa5e77f6mr1390644uaf.114.1661435284384; Thu, 25
 Aug 2022 06:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-6-amir73il@gmail.com>
 <CAASaF6wSYFOTsuZUN-B6QNrvrRxVavpujhLNXS4FBSeysDBgDQ@mail.gmail.com>
 <CAOQ4uxj9Tq9NL2tic+6GtS6q5tBWdo-ixHPPkovKQdvU6NpHMQ@mail.gmail.com>
 <CAASaF6w2NqMNCNY+MEgOB6sUKz19foF6a27ZCO-7qFe9dCarpQ@mail.gmail.com>
 <CAOQ4uxiJ2kb42XzQc8P2cZ6LKdrYNK3-P9u_cLS_WHYx4LzwzA@mail.gmail.com>
 <CAASaF6y_KPnQh_ezG5njXaVOyFxtnTWDne2gf7S5XjMDZYa=rg@mail.gmail.com>
 <20220824152420.57scfzhhc6ufnwov@quack3>
 <CAASaF6zZC=PM7yvAApqXAMcKeJjznusUqiJrF4h33rEMbkouBA@mail.gmail.com>
In-Reply-To: <CAASaF6zZC=PM7yvAApqXAMcKeJjznusUqiJrF4h33rEMbkouBA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 25 Aug 2022 16:47:53 +0300
Message-ID: <CAOQ4uxgb4nerXNwFWu3zp0ztZRiexnM2Ya=+L3hxw=V-4UxjPQ@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/fanotify10: Add test cases for
 evictable ignore mark
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Is this still an issue?
>
> It still rarely fails - two instances in last 3 weeks:
> 6.0.0-0.rc1.13.test.eln
> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/08/15/redhat:613661619/build_x86_64_redhat:613661619_x86_64/tests/3/results_0001/job.01/recipes/12445146/tasks/10/logs/syscalls.fail.log
>
> 5.20.0-0.rc0.aea23e7c464b
> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/08/14/redhat:613063904/build_x86_64_redhat:613063904_x86_64_debug/tests/2/results_0001/job.01/recipes/12440847/tasks/9/logs/syscalls.fail.log
>
> > I didn't see anything happening in the fanotify10
> > test upstream. If the issue still happens, maybe something like the
> > attached patch may improve the situation? Jan, do you have a chance to test
> > it?
>
> I can't reproduce failure on demand. If the patch doesn't have any
> side-effects, then let's apply it, and we'll see in couple weeks.
>

Yes, let's do that please.

Acked-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
