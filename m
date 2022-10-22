Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EA9C433FE
	for <ltp@archiver.kernel.org>; Sat, 22 Oct 2022 02:49:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D1B83CB287
	for <ltp@archiver.kernel.org>; Sat, 22 Oct 2022 04:49:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10B673CACEF
 for <ltp@lists.linux.it>; Sat, 22 Oct 2022 04:49:07 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA147140118F
 for <ltp@lists.linux.it>; Sat, 22 Oct 2022 04:49:06 +0200 (CEST)
Received: by mail-pf1-x433.google.com with SMTP id e4so369197pfl.2
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNHhdlOEimka32LkXZxJlWIuLH0GgMM2QFeSbuki00M=;
 b=b76Ws3na+nlt/CDK6f75pcVKNV4jZm4AA+qFx1iY2pu3fA7i4rtT6eKvENMS51NuVE
 g4mGF4WEyvSQB71OF0RUEHRcWku28d3KqNn7I07NuStq4i9VwI6gM6msfOzbXzvfQg3X
 pZz8sSAbYEJED+W3rdG0mDvjDOC0KAjyD3UJpyI4N/8Be5CJaa/M4WfXRekuJUM1Lhqf
 8LYv/j/5c3lUrOL9gOkqza9XNEHft1MjN+c90ILFU9fmyV/Uoq8PVVVQfdFbUxXsMa9T
 zxvqgck81KRlZPumyxE5fJE6hxLZbFlnNjeXHWSlNXZgEJQN962mdbm0mZ7mBbqGNYh/
 liFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNHhdlOEimka32LkXZxJlWIuLH0GgMM2QFeSbuki00M=;
 b=PxP/OjtIrGH+hS7xQKEUDhSDkGtmUgWYX9Y1VJAe5uduyxM3iboosbPfqIYsjaZhFB
 K64akGH19qyhI19gB5TysPz0+PHxEysKf195eEpIaIH/bCOUW6dFVeo6YiI6el0wSqWP
 6s3mcMiCDPuUQrX00Enu1THlS8xsIGVAUbINFRvMwbQrQ7sZWJwYuWzj9ei6lZZCI6BX
 IW267FM7vZWExilEp7VuuV4CF7T8VFijIzVT1jcH0p3vkYi+DXFcjW3cFQ2yRb+1CKFh
 3b6oXPLeQIjXai/XzJriHvu0lVSgHooXsmJRae1zOWlmJg9VG++diaQgdL7F4wtrtJLQ
 lN5g==
X-Gm-Message-State: ACrzQf1LSH0zSibAZlr2LEq7WkqAIzRh2J0y4kqxNSWuPmlxsXEA+oxQ
 +S95hAW5JADPYNmSuBdef/pOYg==
X-Google-Smtp-Source: AMsMyM5z8TQy01XCHmuGFq7MJ+gZnvCzzGgbFlsYcITdevGuKHL14Cq2Nhw5kJgNnVQjww7AO7fdTg==
X-Received: by 2002:a05:6a00:1487:b0:563:6367:8a17 with SMTP id
 v7-20020a056a00148700b0056363678a17mr22456585pfu.85.1666406945036; 
 Fri, 21 Oct 2022 19:49:05 -0700 (PDT)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419?
 ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a17090341d100b001867fd7c461sm1818207ple.230.2022.10.21.19.49.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Oct 2022 19:49:04 -0700 (PDT)
Message-ID: <34c0ff56-bed3-ade3-4936-6c96ecb8501d@daynix.com>
Date: Sat, 22 Oct 2022 11:49:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
 <Y1GWOPpb+Z8hwhQd@pevik> <Y1I6u1a7RAS1wmZL@pevik>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Y1I6u1a7RAS1wmZL@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] ftp/ftp01: Use tst_net.sh
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 2022/10/21 15:22, Petr Vorel wrote:
> Hi Akihiko,
> 
> I'm sorry I overlooked your message at v1
> https://lore.kernel.org/ltp/9894db50-6319-a818-c995-3ba9ab102c4b@daynix.com/
> 
> I guess script expects $PASSWD to be set.
> Also trying to follow the instruction, none of them (allowing root in
> /etc/ftpusers or filling /root/.netrc with machine localhost) work for me:
> https://github.com/linux-test-project/ltp/tree/master/testcases/network#ftp-and-telnet-setup
> 
> I suppose any ftpd implementation must be run on the remote server (localhost,
> if tst_net.sh uses netns - the default or on remote host, if ssh is used).
> Otherwise ftp command "user $RUSER $PASSWD" cannot work, right?
> 
> Although it should behave the same regardless netns or ssh is used,
> how do you test v3, with ssh or with netns (the default)? Or both?

Thanks for sharing your fork. I tried it with SSH, and I had to make the 
following modifications to run it correctly:
- I had to restore commented out "cd $TST_NET_DATAROOT".
- I had to change the arguments of test_get and test_put back to 
"binary" and "ascii".
   It is used to set the transfer mode (search for "echo $1").

> 
> It'd be nice if there was connection detection in the setup and tst_brk TCONF if
> login does not work. The best would be to have configuration in the setup() +
> cleanup in the cleanup()).
> 
> There are tests, which do vsftpd configuration: ftp-download-stress.sh,
> ftp-upload-stress.sh.
> 
> BTW in the past we seriously considered to delete these highlevel smoke tests.
> LTP is concentrated to test kernel API and internals, thus we didn't see much
> value with smoke tests like this (that's why they haven't been rewritten to use
> new API), specially if they require complex setup and get false positives when
> SUT not configured properly. That's why it'd be nice to at least TCONF (if not
> doing whole setup).

I just modified this test because it is annoying to set up rsh just to 
fix this test so I would rather not put more effort for further 
improvement. Personally I don't object to remove this test either.

Regards,
Akihiko Odaki

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
