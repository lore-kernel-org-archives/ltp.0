Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CE2C30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719927044; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=7VQLEcjyzz8znNCUTdl/ShKceE495BOLVhyGroNUEAQ=;
 b=Y8m+mBiY3oSuIhARIzkrNXVXFijWLNGI8Yxhb4VC7r3siVpHNeu+cWR23rlQSdUe9RgVf
 A6nlqTN0Qwpkea/21RiEln4EJlGs6YQ7ao3m3Fp//5WGafH9jbs1NPdU3dm/4F042MdAD94
 drdHYFolvzct5os9ImNKxD6SU3Rv+ac=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5002B3D3EC8
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:30:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BD9D3D0F6E
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:30:22 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B1912600045
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:30:21 +0200 (CEST)
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52ce6c8db7bso6392020e87.1
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 06:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719927021; x=1720531821; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vyjtl8RAWxGYsOXAgTA3t4Tl38Bsk8ehrsLDwnClwVE=;
 b=SrAgkGdpuMKQerShkLT45s+wGeg22x5MfjhwNX6c0kds7mFQ4OAHYkWrnxlkhp4Yk0
 YcJBotMVg14kClpimnv5JiLbbemOgCD09iERbZ7gSc9BEpEPO3oC+liR1FLg0sEGjC6Z
 pxg8WSLAPBTpK00ULb2lBuDnf0Bzrnot/odqLtAAAWdrrxfS8BYeb7+lqZnOwW4sQDQL
 8D7LZAa1zVsrH1COJ4zgMehaZDOdh/PTvycZPe0fwXbYXTYbXdk75Y2P5sNhfaMr9Sv+
 XQiAsp0coVsVL3v8RqI0bHa1ErIvOYEQkHOuzICEHBrOytX1A3lchXQJ49k6Llfwy1p3
 Qpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927021; x=1720531821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vyjtl8RAWxGYsOXAgTA3t4Tl38Bsk8ehrsLDwnClwVE=;
 b=TuQLm2cKBtxqPpyn4nto68FWEOl2TY1VV4MMPgydhAIFaBaxKwOY/JcRFKCfsRnmni
 cWbFU/5h8O+GY9zmD8l+2yfeAl9xwtJr+gR/i5F29WFmr75ZXs3MDBeQA5Ob7wCkswEZ
 kUKHoCl9tZVkbQIKlNWSdEBc3NOTTTIdmbcxDJE2HscrOdZXweVAab88DPvchc8SJ9cb
 pnzxUll+ucVKKsUDWoPP2F2RZzVT2xxR+YBqoV47r/DqSiZ4e2OCv2uWhNUCKSeeysFP
 BJDT8uYy/m2crf7ros6I/Ql1w871v1xNoGqBzG3FbSWbtOexXwS+SYjeYZJe127C5jNf
 CmOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl2TxJq+HDQuyvrFy2Q7qMyfg6lNHpd5BRYpampC02j7b0j7qSdd272iWwFYx0I8QJ48fec/xO46EiHklWD3y4aac=
X-Gm-Message-State: AOJu0Yyl4lv80QWxPljkgrqu3VQuQNR2cDfReEXNxyye7WQwj8yH4eCR
 4TXWxrNhay5LldX9sdl8y8KXZGaRBgPe8FtIaYQQPvY74qB3YZSz0xGs7X4ArB488WcCM+ENhde
 p1Tw=
X-Google-Smtp-Source: AGHT+IFfSraSkSw1HUd3lQsA076FWDyrR4Yem8LB27SF3L0gd4wMN7Rgv4FDFM5hBKI29H0Cer80dw==
X-Received: by 2002:a2e:7309:0:b0:2eb:f31e:9e7b with SMTP id
 38308e7fff4ca-2ee5e35729amr54251361fa.14.1719927018448; 
 Tue, 02 Jul 2024 06:30:18 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.9])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708045a9f52sm8743368b3a.177.2024.07.02.06.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 06:30:17 -0700 (PDT)
Message-ID: <948a7035-130b-4e4d-ac88-e5b9e37cc54c@suse.com>
Date: Tue, 2 Jul 2024 15:30:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240417144409.11411-1-andrea.cervesato@suse.de>
 <ZnllGpZEj6TOsWqB@yuki> <9b70179d-2bfa-47e3-8ae3-5cbb971bd5c3@suse.com>
 <ZoP_-6z9LPTn8Yac@yuki>
Content-Language: en-US
In-Reply-To: <ZoP_-6z9LPTn8Yac@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Add stat04 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

yes I got lost in the code and missed the point. I think I need more sleep..
Thanks for the reply,

Andrea

On 7/2/24 15:26, Cyril Hrubis wrote:
> Hi!
>> This test is basically a clone of the lstat03 test. I'm wondering if it
>> makes sense to have both, when we already have that one.
> You are stil missing the point of this test, the end result we expect is
> different for stat() and lstat(). The point I'm trying to make is that
> we should:
>
> 1. Make sure that as many attributes are diffent for the symlink and the
>     symlink target for *both* stat() and lstat() tests, since if they are
>     not made different the test does results are not conclusive at all
>
> 2. For stat() you should get same result on the file and symlink since
>     stat actually follows the symlink then gets the data
>
> 3. For lstat() you should get different result on the file and symlink
>     since lstat() *does not* follow the symlink before it gets the data
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
