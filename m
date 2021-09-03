Return-Path: <SRS0=V1t1=NZ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E1DC433EF
	for <ltp@archiver.kernel.org>; Fri,  3 Sep 2021 22:35:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49A26101A
	for <ltp@archiver.kernel.org>; Fri,  3 Sep 2021 22:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A49A26101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 569193C9589
	for <ltp@archiver.kernel.org>; Sat,  4 Sep 2021 00:35:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E59C3C2836
 for <ltp@lists.linux.it>; Sat,  4 Sep 2021 00:34:51 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26D3A201109
 for <ltp@lists.linux.it>; Sat,  4 Sep 2021 00:34:51 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id v10so692543wrd.4
 for <ltp@lists.linux.it>; Fri, 03 Sep 2021 15:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to;
 bh=K1hovczy328QSBUpaVYie2BiKQL1tjJkRYXDJSyTNDk=;
 b=AXo/CQXu44EBeW5QQ1K/a2tzJ/kYCCJOUc4VECNxcDVe9Iz+qxDtPVmCyuyJ/qx2fm
 AarEIcp/V7CvBl73T5w4lzC89sRDheKp16DLRPhXIlBfdWe7oFdsEChincrrfEUBB7sG
 h2M9bLpMxI14KI/aIbckyfseUNiIKituLUE3Ch5G60UQxBCsDwi6CBLeczXmMSCuAa1T
 LrVULCzWsL+PtcAfwy+oJCCvzyZQzR3H5chtLtectichegQ+Im1QSN4K92ThoFYRPGd7
 Gb1sf9Arq+3B16Dg/nPXmo+/ERp2dti4L7XEMTnd7Bh0DeUqiWW7ksQmf6FHTh5jeDZ1
 jxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=K1hovczy328QSBUpaVYie2BiKQL1tjJkRYXDJSyTNDk=;
 b=kezvyorQjroGNAHC0dY7U2Jk61H7v0kKEDrsexd10fJJlzlOrbWlfK0cMgHf7EyYiu
 narx6Z9gfqqYgB/uuhQ/lP6Lea/1Wx7SoSwymzakVH++rhDecntBdJGjsQ4/L0UTaWC5
 4WzUV4LwzytB+icXfmRny0FUbSM0TXGu0SoGvYuAGA0S/NsOT8fPaR8CpMmnlwVBXx/F
 tW1VAWO+mxGn4gG77rUqTNAe7AOZ9+BVm4He8EG9gBUXY4rHnLpaMoFW/qc2tGL4rzad
 2lMANAmk3kuPfv5fH7aPRhC+hM/e9r6FEED5+jjfbA77iZpzcWnUWS9jimmxxF3b6tcF
 7w+A==
X-Gm-Message-State: AOAM530SKaozKnM1z2V8rPWX9B3zhFQ3wOktjw2NhT+52cnO34IppWb7
 tf+YGA/0gKqhW5jphewlv7lgNd9eEFV6pA==
X-Google-Smtp-Source: ABdhPJwr7c10O7OLroVZsAah7M2KXDYs0BqYV1HDHL00Krkos9YAz5WL/LI7Ojzi68sOdknm30SaqQ==
X-Received: by 2002:adf:c148:: with SMTP id w8mr1187665wre.317.1630708490694; 
 Fri, 03 Sep 2021 15:34:50 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id g1sm637261wmk.2.2021.09.03.15.34.49
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Sep 2021 15:34:50 -0700 (PDT)
Date: Sat, 4 Sep 2021 00:34:47 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Message-ID: <YTKjB5iDSECjZCSn@pevik>
References: <20210903214811.61727-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210903214811.61727-1-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/2] sched/process.c: Always use pointer to
 stderr
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210903223447.bDLtpY7MjPOuuUu3waYs5ljVOvZXgrfgLkex_nRau84@z>

Hi,

compilation tested:
https://github.com/pevik/ltp/actions/runs/1199503613

Runtime tested only on glibc (I'll test musl as well).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
