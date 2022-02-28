Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1147EC433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 11:37:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B9473CA227
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 12:37:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB1023C3344
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 11:55:45 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 29E451A00CC4
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 11:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646045743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sq+QjE2MzqPwbyRC6rmp8SrmBJF5/bIEYWz+PDrCKDU=;
 b=E/Vg6rYA24eKNTPM7DAOQewh0AujFC76dxdtyAxDPLt+c/SmDTFE9PXJhpa82KEBlAQuP8
 6MreNHoJswzvUXkcNOptwZYuBmvT8xqmaYrNC/ZwWlE7lB1FQ/swxHTCSmdcJ0yDaLDkC8
 E75JYUjfQ+RXXUNme1Nv9UODO0qy7n8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-KAgr5Z7sMt-Oe5pSs00pow-1; Mon, 28 Feb 2022 05:55:40 -0500
X-MC-Unique: KAgr5Z7sMt-Oe5pSs00pow-1
Received: by mail-wm1-f69.google.com with SMTP id
 z15-20020a1c4c0f000000b00380d331325aso5909130wmf.6
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 02:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:organization:in-reply-to
 :content-transfer-encoding;
 bh=sq+QjE2MzqPwbyRC6rmp8SrmBJF5/bIEYWz+PDrCKDU=;
 b=HitnrJnYCD9ZT8tTxxcd52GIp589CQoHczhNiEzAYPX28Iop5GWFIoZSMFM2tG98Vk
 80BAWmJeuVj9/qaJODLy41gzXtmLXbwYzkmCp1cJmcxHBIavkoRclSkS2WaGZutYiGss
 LPecWUHxpdbTS/Tu9zRIKAHslsPpbjqX7OeKQ2gnBtjYvDAt4R9tvTjuGAte/ouRAoHj
 idNcIM/QHV8C0Z0HfBJNhhXPfdJgZ9yyKw0LLzFEBBxXNplvis/YiNSc0qHdGmf0OnYi
 Gx4XljENkKL06sTBD5vw2JMLvt9eSmpbmOunZhnajYuKObonVsSXAOrN3NR/9VwFsXHW
 JkyQ==
X-Gm-Message-State: AOAM533CqGKEsbQpiW545Latbp1Qqg+4OvZiHjXCWNTW0BHl9RTU+Rca
 BarElIcja28QVgwExWK0LXA5uRjFa77mtr3wBKGHAq/JBmYpvP2FOcM0UzfLt+MebcYPIiJdjEx
 fkgpjAOGAD3o=
X-Received: by 2002:a05:600c:6003:b0:381:455d:b571 with SMTP id
 az3-20020a05600c600300b00381455db571mr8084510wmb.162.1646045739212; 
 Mon, 28 Feb 2022 02:55:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6hKJBSTr1zmkuTlXMi/bcb5A7zUW0bR7EwKOgR4H/NOPI8ArzjNHWSE/dNthpWF+IPOR1Hw==
X-Received: by 2002:a05:600c:6003:b0:381:455d:b571 with SMTP id
 az3-20020a05600c600300b00381455db571mr8084495wmb.162.1646045738977; 
 Mon, 28 Feb 2022 02:55:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:9700:f1d:e242:33b4:67f?
 (p200300cbc70297000f1de24233b4067f.dip0.t-ipconnect.de.
 [2003:cb:c702:9700:f1d:e242:33b4:67f])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a5d4ccf000000b001ed9e66781fsm10213209wrt.13.2022.02.28.02.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 02:55:38 -0800 (PST)
Message-ID: <1b5443e5-dd9a-6fa6-8a26-2c89752135ad@redhat.com>
Date: Mon, 28 Feb 2022 11:55:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To: kernel test robot <oliver.sang@intel.com>
References: <20220228060919.GD29932@xsang-OptiPlex-9020>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220228060919.GD29932@xsang-OptiPlex-9020>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 28 Feb 2022 12:37:36 +0100
Subject: Re: [LTP] 52335f0d68: ltp.madvise07.fail
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
Cc: lkp@lists.01.org, lkp@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 28.02.22 07:09, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 52335f0d68798290c6b469c2c095aedd084d6a04 ("PageAnonExclusive")
> git://github.com/davidhildenbrand/linux cow_fixes_part_2a
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20220129
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: xfs
> 	test: syscalls-05
> 	ucode: 0xec
> 
> test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> test-url: http://linux-test-project.github.io/
> 
> 
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> 
> <<<test_start>>>
> tag=madvise07 stime=1645700830
> cmdline="madvise07"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1433: TINFO: Timeout per run is 0h 25m 00s
> madvise07.c:45: TINFO: mmap(0, 4096, PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0)
> madvise07.c:54: TINFO: madvise(0x7f87c1430000, 4096, MADV_HWPOISON)
> madvise07.c:60: TFAIL: Could not poison memory: EBUSY (16)
> 

Not able to reproduce on the latest state (that commit is a bit old),
and looks like an unrelated/temporary issue with poisoning to me.


-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
