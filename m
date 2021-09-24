Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291AEC433F5
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 20:26:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AF3B611C8
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 20:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2AF3B611C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5E553C8F4E
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 22:26:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A5003C17A1
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 22:26:04 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 04CB2200A01
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 22:26:03 +0200 (CEST)
Received: by mail-qv1-xf2a.google.com with SMTP id r18so7036203qvy.8
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=yAqHELrri+EViAt1B8IvIJdzFLiqirPG5aEWb2h2u+Q=;
 b=no2LLpGh/WFx+nig+G+EJ9Af2FzPpt6QQ9Ueay3ey+M47dtv+7qb9QTdCyO3H7Wtq7
 E6sTxLmgm5mIT0IJN/kuDmLd2BiwcgrkOrQoLs0DX272dIVIzxMeji9EPCoJCnD2kmNw
 q9f2sw4eVfsZ9nYagiM7TtXIr5eF+fIxMV3LVP6NKCHh7aET3SM/qB9gZC/35zDTFsBc
 qPuAXtu84TIy8bDZARd02Xik28XQb5Hn33Yy3pCSOr8f52Ekw+QejYOoBR7r1N0YJYVD
 DesTbW/rXzecY0LAQmp3io23n5GNwPdN3np4PkxQX0nbPXuGPW/i6jfZ2NalPfcAVAq8
 HI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=yAqHELrri+EViAt1B8IvIJdzFLiqirPG5aEWb2h2u+Q=;
 b=Xvu4zu170kYHL1s+KzrgdNY9XWH8vuK87cseOJ+trI7e5PSFJA7od7rgd5ZF4mTf0i
 2PtNgc5Gb/JyNDYjufEEsf8jFMzu4uLP3puzh5tC9RQA27k4DTXuB6CvJA/DRJDhP//i
 E1Tz2KNpLqt8D44WFyZ5m9hry0YGkXBP9ReKZamJZEwW6GcML1F2t2gF5o3zmzjAEicJ
 Qc0xC/VnhDxmlgAq0WzlF2sl8weNjR+nDLkTupJzXc9vDCyStQC+Jjx5VNYQc/cbPGRU
 mEunvzjnDpaPGSdt0CbdENAdltKKbM3KntKQ2mlPmo+F76/Kr/EmBy7ldrow1ozuvBWh
 dtcQ==
X-Gm-Message-State: AOAM530A5eTkho1XVjT+KUfUi83dAyc2+baM7bRLvL4u3bklbQVnhs5X
 GW2nW1PVklRG/R5hoEue0J/ozw==
X-Google-Smtp-Source: ABdhPJxN9yxvPSxGDnrWRtTcemvIWPdPXzIER0XZ3TRFBXO3eZf9MRH/dQIGul3Uknhp4SBhbBG/vw==
X-Received: by 2002:ad4:5aa4:: with SMTP id u4mr4158345qvg.62.1632515162859;
 Fri, 24 Sep 2021 13:26:02 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id d13sm6068181qtm.32.2021.09.24.13.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Sep 2021 13:26:02 -0700 (PDT)
Date: Fri, 24 Sep 2021 16:26:01 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20210924202601.GB4029248@maple.netwinder.org>
References: <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki>
 <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki>
 <20210924014900.GA3975163@maple.netwinder.org>
 <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
 <20210924151130.GA4029248@maple.netwinder.org>
 <YU4YOI4yPufWP9uC@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YU4YOI4yPufWP9uC@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Cc: LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Sep 24, 2021 at 08:26:00PM +0200, Cyril Hrubis wrote:

>That is strange, for me the tmpfs starts to return ENOSPC when the
>system is getting low on memory.

I've repeated the tests, now with kernel 4.19.198 instead of 5.10.y.

1) LTP 20210524
   In the case of tmpfs, it got as far as mntpoint/file4 size 70310993,
   before returning ENOSPC. It seems it wrote about 134MB in total,
   which roughly matches the amount of free memory on my system.
   --> PASS

2) Latest commit 443cbc1039f5 ("hugeshmat04: try to find unmapped range for test")
   tst_test.c:903: TINFO: Limiting tmpfs size to 512MB
   OOM during tmpfs after mntpoint/file6 size 90739786
   Note the total written to tmpfs adds up to approx 225MB, which does
   not make sense -- this would be all memory except kernel itself.
   --> FAIL

3) Revert commit 7338156ac ("increase the fallocate and defallocate size")
    Exactly the same behaviour as case 2)
    --> FAIL

4) Remove .dev_min_size from fallocate05.c
    tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
    Otherwise exactly the same behaviour as case 3)
    --> FAIL

5) Apply Li's patchset (with v2 of the 3rd patch)
    Exactly the same behaviour as 4)
    --> FAIL

>Also if that one fails as well it's likely that something is wrong at
>your side.

Well, this is certainly possible, although there are no intentional 
changes in the kernel (esp filesystems). Only drivers for flash, 
architecture support, etc. One possible option would be to try testing a 
generic ARM kernel under qemu, to see if we can reproduce it there.

Note however that case 1) worked, while the others fail. So evidently 
the way that userspace "tickles" the kernel matters. I also previously 
used much older LTP 20200120 and did not have the problem either.

Thanks again for your time,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
