Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669C1C3600B
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742918991; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=3G/fAsi0VfmHu9c+0WCtjzt6GtAN0VmDugma+mMLu3Y=;
 b=nA/rM6d6PLVlwLoqTEGOtI88wiGslf5OCnnkyBd0GFsV0+F2ljx8vfJGpOJxYv9o/8DMl
 prmXcU5LTzHm0+Eu8wkVW0Tmne2cXGRitqX+Q21OfyLPMly97wkoKst8hWAETFn9zy3n60m
 a82GXn5W5E2x7kNj0W5C/ta2OwjKYMM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 622753C9A88
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 17:09:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 390A33C726B
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 12:54:05 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54674140110E
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 12:54:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742817242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C2sfeu8L38fTcPcGuMWEFZogzyzrv4bdx0MHI8FDP0g=;
 b=AfxAKE80tvWdc0mV35bqtKNTkM4KAVxT59tzJlfzmGuXTkcoayM8BHmbJizA3iyBfJ+hrL
 tHWdKs+yucaNG8uECe086OZMxPUjGDfT54Dyfh7oGxlI4sTtxjWPAmCfR5NusLYBiJplAS
 dC7GQmCrYX0xZM3NRkTXxTKp+6DCqqc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-5QhNlWTFMwCuQEsg-aWc3g-1; Mon, 24 Mar 2025 07:53:58 -0400
X-MC-Unique: 5QhNlWTFMwCuQEsg-aWc3g-1
X-Mimecast-MFC-AGG-ID: 5QhNlWTFMwCuQEsg-aWc3g_1742817238
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4767261982eso79276081cf.2
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 04:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742817238; x=1743422038;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C2sfeu8L38fTcPcGuMWEFZogzyzrv4bdx0MHI8FDP0g=;
 b=j1LPolRe2d60SlHynvA/pBMxtUblNiFM0DVPKvgJyic1MVAjtbNp48YeZ7ZqH1xS+z
 PefNGd+BbcVmBQRi3uAx499BXo9o5S4cZBEfgvZc6EJaFkNL7VkLjaqv4M+ZPri64M4T
 qnVWvERoQgN8DaE92fKTPawyinJvDCR3U4UtZajVAL1lnPIicPC79/gcIeFPOM9Xeh/F
 tnnydXBM/e1ui/3m1Yhh/RxUCAn5yY5PqtBefVSNCPB/Rb+GMcCW1tMdbguRc7w9F7d7
 VpRcUr+j55SqLMQ99Ku+JvF8J8iWP17LdqgOvJRbQ1S7aGMR87TyqWwxiDDa45u1uvKP
 lN5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeADe7vQmQzRdwT+gz61YikQLOTu+OhJL8y7iCLqJpZ75HrPw3EHXSTxFaR5y/cMpWYwY=@lists.linux.it
X-Gm-Message-State: AOJu0Yx8RWkDvcilolsRsA5NTTab3CDhwucZc8cbwzAKCyq/99yFSWow
 Q3Yc5zpB3M8cTjDPNa5dzeUsTObri1Yt+zPdCC7GbNVcvRFiTt9V+BKPtYgS5FK78H2noT+shuf
 Zsjc/d46nBRX6Sg/GuRnqvI9zcOsLTpR6pzp/TGrJAIMkuPT+
X-Gm-Gg: ASbGncvhNrrw+lUZjP+A6JJC2ZN7csOUia74mbYO/hywle6j4jQ7RnnjIg0EUGwDBFS
 /EqoHcdY74tzTyRtQ4BCgRFFG+WD+AijzHCHgVfR/1LxWM4qpXn1Pei5uT8YoGYcsAlHhRIDDWh
 tFBGYD7IPR7jLsz9ELmYaliizzstdKjnV5+3VxUM+OoCdxurDC5KFv0RdsuCszRww4ykxLBOAoZ
 FOzvUVcwfIQhbkXJrpmcFur85Jsltyheta1MkYXgQyyEH/VZSLwt9gQzfQ667o97ekTDfg0J0CF
 GmZPSD4dw6Gq
X-Received: by 2002:a05:622a:1345:b0:477:1f59:2876 with SMTP id
 d75a77b69052e-4771f592a4dmr160264981cf.28.1742817238145; 
 Mon, 24 Mar 2025 04:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJX1ZUsULbp6GUHAiEzkOwnrqQhf5LhF8C61B07lJEt8sE2bo3aPiY2wZwMlVNZp1+6u1IWA==
X-Received: by 2002:a05:622a:1345:b0:477:1f59:2876 with SMTP id
 d75a77b69052e-4771f592a4dmr160264461cf.28.1742817237670; 
 Mon, 24 Mar 2025 04:53:57 -0700 (PDT)
Received: from [172.20.3.205] ([99.209.85.25])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176093sm46156621cf.19.2025.03.24.04.53.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 04:53:57 -0700 (PDT)
Message-ID: <73bea938-15a2-4b4a-8d31-0db9f9c476e0@redhat.com>
Date: Mon, 24 Mar 2025 12:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel test robot <oliver.sang@intel.com>
References: <202503241635.4c94156d-lkp@intel.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <202503241635.4c94156d-lkp@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9creBBPxmWNq_Hi1uzC6qZy8G0f3iZoAUUDiGrqkzXU_1742817238
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 25 Mar 2025 17:09:09 +0100
Subject: Re: [LTP] [akpm-mm:mm-stable] [mm] c25465eb76: ltp.swapon03.fail
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
From: David Hildenbrand via ltp <ltp@lists.linux.it>
Reply-To: David Hildenbrand <david@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>, Barry Song <v-songbaohua@oppo.com>,
 Karol Herbst <kherbst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>,
 Alex Shi <alexs@kernel.org>, lkp@intel.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jonathan Corbet <corbet@lwn.net>,
 Alistair Popple <apopple@nvidia.com>, ltp@lists.linux.it,
 Jason Gunthorpe <jgg@nvidia.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Lyude <lyude@redhat.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Liam Howlett <liam.howlett@oracle.com>, Jerome Glisse <jglisse@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, SeongJae Park <sj@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "Masami Hiramatsu \(Google\)" <mhiramat@kernel.org>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 24.03.25 09:49, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.swapon03.fail" on:
> 
> commit: c25465eb7630ffcadaab29c1010071512f8c9621 ("mm: use single SWP_DEVICE_EXCLUSIVE entry type")
> https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-stable
> 
> 
> in testcase: ltp
> version: ltp-x86_64-042eff32a-1_20250322
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: btrfs
> 	test: syscalls-04/swapon03
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

LTP needs fixing.

tst_max_swapfiles() detects the number of supported swapfiles by parsing 
the kernel config, expecting that with CONFIG_DEVICE_PRIVATE we'd use 4 
on newer kernels.

Now it's "3", and consequently we support one more swapfile which the 
test cannot deal with (expecting a failure)

So, all good from a kernel perspective.

-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
