Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34FCC369DC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745910018; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=TbhLjXXxmGzbYSeIhl6PDoBm5/ut1EkWOzKfBHqrcGk=;
 b=mhROrOvZ+t9zMzZBYWF/5yxsRn5Z4/F6FOR1LYoggTUW65IBbfP9hDMlSgtAyIdyuUUta
 LQsRHeVxKXhloos63EeZ/sWjYMoZxfBDKeeNpuV2Ig+/QuGFSQ55SjetxFw3gfSZ0y8SpA7
 C/1ClU+GbJOzeXh+g5LXFM8K+Ft/n1E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4D223CBBFF
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:00:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52C803CA658
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 08:59:56 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 08398140026D
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 08:59:54 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso54506745e9.1
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745909994; x=1746514794; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5IuAxPuNn7PKD6qTwBzKZ6vGtqwkAvFcEymHNEnp7SI=;
 b=eFcNwpdTj/JeGNmO0VVlOveBR1YZaqAdibE+F7kMgGasZvk917FpsyCeYZSPyQ5biE
 u5FRjC+p2sicanYZ9z53qs4oYCC33t+1uNLAAxzl44U+3hVgpOg1Thm12nVOOS8y1dsT
 B7Dt9FYzlrNhjZmGrrfCsAN87nRVZ8f3pKVDMBSDY9IL9ZaEuobtEeFOLt1dOXFoo58i
 +irTOZp0mQsssnqIR0oHV4J8p6VhaMDHe6TSXbmCdV8kQs6bHFfQR74XM0c3fheIXGeI
 RqiNtp3dLoATgrfpd0PQoCWEGTI/pbR+I/Xcymvz/eLB5JLwZFvAPImDB/iWPJjHXYAx
 evJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745909994; x=1746514794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5IuAxPuNn7PKD6qTwBzKZ6vGtqwkAvFcEymHNEnp7SI=;
 b=s7fbKMUrF75wZ+pbCL5OwFvGm9jgu2yDDDXfwhfEpFJ5K0PnCjbgPlAaYTSVjaXxxL
 dM4feHVa/A8a1/GxxONovC/roz1zGZfnYX/6u7TdXRFGaRSfGe3hd/YQWWAztDdt6Z+U
 DmWqvkgHuodC7uLVwfTMFDbT6wPvV0M3ccm55KGxngARF4AFKhZ57VFMoqe65USV03wG
 EmjE9NnsPjTQhuK0hZ+AfmMF8uPKz1Gw3hHbHWyCb3Bix/co6bptdB8degMYwBxYkThq
 Rg0mn1RX0wcNrKRqjl53NY0WjU76X/BPCBOzmh4h7QR7b3t/nB7vxlVYaWuJMXZi5eA7
 BPtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKW7wbmq/cXKqpa9yy9M4aCs7tBh13yNhgeb9vHLNNEmY6lgD8298pZ25f8F0b3HZnojw=@lists.linux.it
X-Gm-Message-State: AOJu0YxBd3Ek5K3lCewtT/O2pKZVCqy3cBZwvSKwGccDmEcx8DeqQLfU
 ODyltXI1+OBoV4s2NZYV1+XZodCvfEC5Fw3SR5+Vda7i9phRAUdSDDvwinfDl8A=
X-Gm-Gg: ASbGncsz5uh+15iuhE1Ugk2akFGq9GhvE5Xoy5QqovwAg4ETCTEkCWIb5sSAUdo6Qpi
 krxQSfSTlvbSZ/YlnOVelhbQiGXpsIpEaBWd6typ6ctSBVjrC8afizOK7MRYHX4Uf1Q/+Gy06IZ
 OaDnit+bxrsP3zpAaoAAygBOWDpxk+Sycdb1idyY18IU6LUpHnRxtvcYgrAUQSm3MbLjD7PkGoO
 M37HOHEh/uc31nkaLcW620grF8pn3a8eACtN4xnx6RNV4GfCPdVt/dhB49Ow40bnEG7fjAJVHn7
 x5JLk38c5vc8vrZSP5FjU5GxiKDzNC9NH8lnzJMKKDWAnTteMhyVN94AIyr/U9gr1hxsG3RWoAK
 G6DfJeSy+RekU2Zxl/gl2dni9hKvOgs/gSkG2Iw7IwoeMNZQ2zTvY9HQfXMWlTMPM/QXg0fS3AF
 XRswltViTssSU0dQ==
X-Google-Smtp-Source: AGHT+IGuxJ7m4vzalC0TiMQQYm+xi7tcigjbh5Yf2OOb8whAyMjPpaEothkG3RH0nRVUNhujpPycvQ==
X-Received: by 2002:a05:600c:1e11:b0:43d:762:e0c4 with SMTP id
 5b1f17b1804b1-440ab8709c8mr99022155e9.27.1745909994347; 
 Mon, 28 Apr 2025 23:59:54 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a538f4aasm144435005e9.38.2025.04.28.23.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 23:59:54 -0700 (PDT)
Message-ID: <03467184-c7b7-4fc4-a5e7-e758e2a82492@suse.com>
Date: Tue, 29 Apr 2025 08:59:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250429052247.GA144682@pevik>
Content-Language: en-US
In-Reply-To: <20250429052247.GA144682@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP in valgrind :)
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

what a nice surprise :-) I guess polishing and fixing LTP somehow helped.

Kind regards,
Andrea Cervesato

On 4/29/25 07:22, Petr Vorel wrote:
> Hi all,
>
> in case you haven't read the news in LWN, LTP is now part of valgrind [1]:
>
> 	The Linux Test Project (ltp) is integrated in the testsuite try
> 	'make ltpchecks' (this will take a while and will point out various
> 	missing syscalls and valgrind crashes!)
>
> FYI script they use [2]. They consider some test long running [3].
>
> Kind regards,
> Petr
>
> [1] https://www.mail-archive.com/valgrind-users@lists.sourceforge.net/msg07691.html
> [2] https://sourceware.org/git/?p=valgrind.git;a=blob;f=auxprogs/ltp-tester.sh;h=000cfaa7f336f8641f464d107a363af24f607614;hb=HEAD
> [3] https://sourceware.org/git/?p=valgrind.git;a=blob;f=auxprogs/ltp-error-patterns.txt;h=ee5048bf42b652258fb469a632fb2d16afb72c38;hb=HEAD
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
