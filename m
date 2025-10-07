Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93690CCA476
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759842984; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9+MUxTGMtfDNcF5UaM7YsYsUuVTLNF1+wXQji6Cz0Ss=;
 b=P86CCYxLvF32VPr8TgnwbwD72fel4KmgrmzG0vpZysXGmsQBnK2luUp9bUd8MwFhYxdFc
 9uznfv4MzbVR2/csV3PdjjSh/nBoRBc2R1blZuX4OI0HpfwtNYwozzYPY+9DzBS8otYcVAP
 54YuXV5YVFRkmKsf0HI+d61qmZKdk8w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B90733CE45A
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 15:16:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D5C53CC9D7
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 15:16:02 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E423F1A00113
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 15:16:01 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e52279279so42311145e9.3
 for <ltp@lists.linux.it>; Tue, 07 Oct 2025 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759842961; x=1760447761; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Md/pQteri9UdVsQQtWhr/ljUOPnMG/+sMkt+7A49HaE=;
 b=a+GA0isFbl9GBNzXrZLVD69Q88qn5LOQEun0JPh+wRXsdyeqzrtuhpOSQcCr3o3EYd
 nrxR9o7o1hU8j3T9qkIayuqMCnm01d9675iOOJuUv0DomCxI3d5LIMOZBy8oHHdQ1+ro
 cNGeeLoWhse0sdphZTrkfV9a9kfuuEYcLFrRsrXltfIruwwkJJjxPkCa9VgSzChRKyy6
 utUidwdMVg8qvU3rUnoZus7rm+rAPunoAQatKQGEIQ2wZYziiUloJ/OKMJDjkjnfHULA
 k+rtmvBxPpLMcGW35X5Ybx2LDXsjPmYnVc1GJfTtuTRfjeT6Lj0ysEaRx4RukILXpxS6
 QIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759842961; x=1760447761;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Md/pQteri9UdVsQQtWhr/ljUOPnMG/+sMkt+7A49HaE=;
 b=S76/4ANmOT6x1dqAKPV0csO71gDL8NeI8Dzpmu6IE6J1WC9gnqj3ZrZetBlWeln03a
 wsmUFg7MNWyKSmMhr6L1601Zz0sI9HGmHo6HHRqiJPJwV3TMnjA1hQf0bJ+7tlniOlVU
 orIo4OLe44ADiEjTaubOr2tIxMV1id77NaS1Z96tnVLqKaqtX6BfQjEEeDwZZmWlzbDH
 7W7vhOIAU0WAvubTzq6k9x8QpDe4FQt28z4OOv9SywKUe4JHud/19LHOI86/bFnrnfbr
 lz38x16kPueBkPJGODm+S+HjCAHaLeSO5C1GZV1f1nKvqJUCOPm4hCQqXAEqCi5SqmTG
 7ZMA==
X-Gm-Message-State: AOJu0Yz8ElW+n57sDGMIQ33CvXJ31PIbK7a613QKgK9z4y6jn5Jt8eo4
 AfoMYhTbQCeGjByDQDUZRLW+FMVoRrzyR95H+mN6HptbPPDhJnnkvekOTRgV3H9NCCQ=
X-Gm-Gg: ASbGncvI9vPgtCB1wuseYrjR368/RboZYXKpRw2MrXjQCEZe4gjlXPkky8qyvCcp5zW
 hxmdXU1NIEVVd8oYx21ZeNd6MnWWvqDV8jn7+ikgylW4utFe7y850XHbjg/sM6JSnCje2KquR80
 cGJ5Z9tOtAU3+XbH80XivKo1zrcH5ZZWMTIFIIoDq6UVpMSYe/UfoWNvXHxuCSpZC85jHVeTIYb
 Q8Y+voXNHzyOtdATwZB4S7P80rRw32hosEF5u8rOe+R0YmEN/vJnbnhqLdCR1Jr5xk/ioyL6zzI
 WcuCQkJJWA/iUTOPO6K/WjGVyYiUaUxZ+qqFRgv3meHK3Z5WWCOHVNyMoDYLKfaPifzZ6t+2J9q
 UWAZmsX3kvqIMnIwLQfDXWHi3hu38eb5vXf1I7JMxvJl9QBwVbB2woKfrq2cDzsMOpH5YJYUU8s
 wZNlThmGs/Rq/XiEhjWKVtMdoC6SaMcPHyJu+3z9+M
X-Google-Smtp-Source: AGHT+IEkdCt3FYnbl1okQos6pjQAJ4yXTArCIywvm6BPUDeZQpOfWdBhr5d2dgXqbs9jz0zNniWZvg==
X-Received: by 2002:a05:600c:1986:b0:46e:4287:a85e with SMTP id
 5b1f17b1804b1-46e71109f78mr95587035e9.13.1759842961175; 
 Tue, 07 Oct 2025 06:16:01 -0700 (PDT)
Received: from localhost
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa2cfa2dcsm18103855e9.0.2025.10.07.06.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 06:16:00 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 07 Oct 2025 15:16:00 +0200
Message-Id: <DDC49J0CRCSN.3K67TAS5U4VES@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.21.0
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-3-bf458fa66358@suse.com> <aOUHqfyqp8IVne7S@yuki.lan>
In-Reply-To: <aOUHqfyqp8IVne7S@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 03/10] setxattr01: add setxattrat variant
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Oct 7, 2025 at 2:29 PM CEST, Cyril Hrubis wrote:
> Can we please, in a subsequent patch, convert this part to our standard
> approach where we check for the availability in the test setup and
> expect the syscalls to be present if kernel is new enough?

What do you think it's the best way? Some of these tests have multiple
syscalls related to *xattrat and in this test in particular we are
testing 2 syscalls. Maybe the best way would be to check for HAVE_FUNC_*
declarations in this case, but then fallback function would fail anyway.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
