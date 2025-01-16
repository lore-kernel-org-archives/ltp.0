Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561FDC02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 10:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737023779; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WNHVHjNdtpKNtEGRUDsKxX4VyFFl0uyRJTwco+Efed8=;
 b=paGq0KZDi4+B1sfZcT7Ifc6M36/r9/TTfDY/iCiXg02xcpQrJ5VZ2J9wigrmEjJ4dtadg
 CeLWI+irXUbeBvkegBWe3RNwNAheKoPSLwCY9md7YQ0HGqpZonenMgim6iH7H80zJglI1Lk
 rnEpBrU4+XqOzpShEpfEJrC71l7DqhU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DA603C7B53
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:36:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 573863C2032
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:35:57 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2236A7C3E5B
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:35:57 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f796586so6617945e9.3
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 02:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1737023756; x=1737628556; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GTN3/zOVfyJz5stuKBZXZjjBt5rXiuVUhKVamLYBo7s=;
 b=SfnNRg/LUWd2gem8NfJbDt1hsr45d3ZsqUQcqg5vVBCnYRHRSfhW/6p5i0KYRBOxDI
 FZr2pqC9s1g22Rhq94xMOpbwvU6kkPDkfiwWgNYBvNFPSKA0JGRb37O2AgDuhaD2EkJe
 TheXaqHTB66pEZaHT+/PjIx4iZdet0Ut35r3gM3MGo3z5F5o1+eIUiumKuAYnuw8c2uG
 qDHH73BQkhwtYA1YnHeUoh9MjfgKpAPCZpc0176bdcBlTlNo+AzQ3stjNnVnGaKKuDWX
 qEnEnGPBg7lWicoMoOul7n5sL3C5rzyDXHjfZItZWbu8OMqh7g/svYoldpKN81cS6Yp3
 2VGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737023756; x=1737628556;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GTN3/zOVfyJz5stuKBZXZjjBt5rXiuVUhKVamLYBo7s=;
 b=T588Of2yQozrkPmca7b5f6SsNM8AmSdDQlViC1pGHRNHJhhyh9GC5l8rFiY8cmCWMx
 /HTcExTSnuhn7nEQfVWbKSTPF7uJ/LIi3+L/VrGc4B6JE1t7kyw0gII+rTLBk6TqgN7i
 owPekaNFM/hB9KAxrzl3nhPp1JgUgmK762MX5GoqxQJbmWZLRZ1+ZA5z4oPFMtfvoCce
 hkCa3bvpQCMDUyTVt//WLHQUzMn9ZgmhG8lPzDDxMfokd6Gj07B1wwWbPag6K6QGt0G6
 8wxKVTZif0kfqY//Ifxk5lYTGxv/xB3O0AUg0WeeSRLiNKo3ZNBlfdmFir+15kB2xof8
 3pUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXFWQhhIijiehlrEstHDfqAlYF6G5EFxudVtMRcj2tEc/oZYNllpSl184pwZqkMJYDjrI=@lists.linux.it
X-Gm-Message-State: AOJu0YxxQPvxdaVcQCohAwz3CFcJHM4OGR6/qz1f0/BjdQf19tuafuMs
 cqWszAtUrultIMLtnm0y75HklFQlCb+C8Ex4kUjbV0/TvQoqm4O/fn/eq3Z/YSI=
X-Gm-Gg: ASbGncvFW/QIVrZMfoeEt8PRDIOT7iJLFcS0HAX3piPibfb8RysbOm4mY7wNRNDE4DB
 9Ek5pPZpJ9KnnPSyM8jPWkSjyCsyJGQLYhUPyXmqBhUVBx8SbTFUBGYNFYTNmvMZRtApzSTu+EK
 ZOkVEertAqqIUh3CYBSPL3R9mFBO+nTRWnMZ3oZhk+5FUIhORZS9FeSBB/GKEoMG5fQZ8nbCuMb
 Xoi5qE5Ra/ph7p/Ij7Rifwl8tlFo3aoD11i1v790S+kr5wcOw80HDAEtgG7sTeY1MJuYA==
X-Google-Smtp-Source: AGHT+IFF0qPCwHKuilPLeoH9n5OunEvKvEacwmEV2ADrPSDJ97oDK/3bKxaaGAXdKb24hUZ2f8hijQ==
X-Received: by 2002:a05:600c:6b6f:b0:436:e86e:e4ab with SMTP id
 5b1f17b1804b1-436e86ee529mr313892425e9.30.1737023756462; 
 Thu, 16 Jan 2025 02:35:56 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499558sm55708265e9.8.2025.01.16.02.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 02:35:56 -0800 (PST)
Date: Thu, 16 Jan 2025 11:35:54 +0100
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Message-ID: <Z4jhCpFLe_Xgxlnl@tiehlicka>
References: <e66fcf77-cf9d-4d14-9e42-1fc4564483bc@oracle.com>
 <PH7PR10MB650583A6483E7A87B43630BDAC302@PH7PR10MB6505.namprd10.prod.outlook.com>
 <20250115125241.GD648257@pevik> <20250115225920.GA669149@pevik>
 <Z4i6-WZ73FgOjvtq@tiehlicka>
 <6ee7b877-19cc-4eda-9ea7-abf3af0a1b57@oracle.com>
 <Z4jL_GzJ98S_VYa3@tiehlicka>
 <4b9e0d85-7a75-426a-86fe-faf6107a3692@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4b9e0d85-7a75-426a-86fe-faf6107a3692@oracle.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Issue faced in memcg_stat_rss while running mainline
 kernels between 6.7 and 6.8
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
From: Michal Hocko via ltp <ltp@lists.linux.it>
Reply-To: Michal Hocko <mhocko@suse.com>
Cc: ltp@lists.linux.it, cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 16-01-25 15:34:38, Harshvardhan Jha wrote:
> Hi Michal,
> 
> On 16/01/25 2:36 PM, Michal Hocko wrote:
> > On Thu 16-01-25 13:37:14, Harshvardhan Jha wrote:
> >> Hello Michal
> >> On 16/01/25 1:23 PM, Michal Hocko wrote:
> >>> Hi,
> >>>
> >>> On Wed 15-01-25 23:59:20, Petr Vorel wrote:
> >>>> Hi Harshvardhan,
> >>>>
> >>>> [ Cc cgroups@vger.kernel.org: FYI problem in recent kernel using cgroup v1 ]
> >>> It is hard to decypher the output and nail down actual failure. Could
> >>> somebody do a TL;DR summary of the failure, since when it happens, is it
> >>> really v1 specific?
> >> The test ltp_memcg_stat_rss is indeed cgroup v1 specific.
> > What does this test case aims to test?
> >
> This test specifically tests the memory cgroup(memcg) subsystem,
> focusing on the RSS accounting functionality.
> 
> The test verifies how the kernel tracks and reports memory usage within
> cgroups, specifically:
> 
> - The accuracy of RSS accounting in memory cgroups
> - How the kernel updates and maintains the RSS statistics for processes
> within memory cgroups
> - The proper reporting of memory usage through the cgroup interface
> 
> The test typically:
> 
>  1. Creates a memory cgroup
>  2. Allocates various types of memory within it
>  3. Verifies that the reported RSS statistics match the expected values
>  4. Test edge cases like shared pages and memory pressure situations
> 
> I hope I explained it right @Petr?

Thanks. Yes this does clarify the test case. Unfortunatelly this could
be quite tricky to get right, especially on short lived processes. Due
to stats accounting optimizations all the changes to counters might not be
visible right a way. So there is some tuning required and to make it
worse that tuning might just not work with future optimizations.

All that being said, it is a question whether the specific testcases
brings a sufficient value to justify likely false negatives and constant
tuning to existing kenrnel implementation.

If this local imprecision is a problem for real workloads we might need
to provide means to sync up stats (similar to what we have for
/proc/vmstat) and test cases could rely on that rather than trying to
estimate in flight cached stats.
-- 
Michal Hocko
SUSE Labs

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
