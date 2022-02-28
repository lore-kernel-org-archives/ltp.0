Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF47FC433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 12:50:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 952443CA24F
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 13:50:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1438F3C2DCA
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 13:50:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E382B200AEB
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 13:50:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646052642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oeot12NK7GfVFzBJEs1OaaCw1EskCTbbJb1ZR3KjDVw=;
 b=FAXlFvqxw3ZltoXF9f2SDaLeTqPtJQkbqjVBifsBTWs584Dgh5xiQ5/47hp0rr8R0LRfYI
 wBCr08ItO/sdkljHRbltlC0Zrih8pZVX6yVxbm+cKYDwrDmhyKCxFgTOXc05WXTd16kMD+
 55cTxh+UCSFcFTJFMXv3hnAXpTYktcE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-CkKrJNobOeW0KTjG7mXN8Q-1; Mon, 28 Feb 2022 07:50:40 -0500
X-MC-Unique: CkKrJNobOeW0KTjG7mXN8Q-1
Received: by mail-lj1-f197.google.com with SMTP id
 x7-20020a2e9c87000000b002463977afe4so5674337lji.21
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 04:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Oeot12NK7GfVFzBJEs1OaaCw1EskCTbbJb1ZR3KjDVw=;
 b=qWHUH2GYJflCCQbIcWRCl7cV6yJzTVCA6ngOVWLWEP2nRWmeEJgO0kvGE0pXA8MKSS
 IlKe0FzzHL1ZzLA/9KzGiqUa060j4HPZEfIGNq2VC+zfFdg1V33N63mLOX+2dqOppbdf
 o4ANaUysHM+0sGELD/cu85H0tb3COLJYsStmQi/UyaZxSMEJpN0xsnrD40k1M7aHMf3H
 7wFpHokAlLcH7wzfIZVw9uziiYt1HpYSpzqPURLp8RuyD3UXLc2pXtiuQ343Kz9gyGo1
 bazkZb+fJGwg09l0mYlmsffReL7GXv8xNnmPPV22ZWtfvrjWq1ieOdXnzYQnoAHkWv2y
 RUjA==
X-Gm-Message-State: AOAM5335HZW37rqcXqa6EZtRhYdMyY8BxI5iDUuKsLVGPtM1X5VgRXlX
 iot7DWaRSXcaYeQ1j4QIY4rEnNY+pKvcWL2DhcPQHtge/YFoXgL7RN2DZZM4QU6w+Wt6I0L0utP
 aYjJoRqkLsqge44NvN4qI4sIJJQQ=
X-Received: by 2002:a2e:a795:0:b0:246:468b:dcb3 with SMTP id
 c21-20020a2ea795000000b00246468bdcb3mr14390924ljf.49.1646052637989; 
 Mon, 28 Feb 2022 04:50:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1djKjjpFBGzw74BM8/mFHd5SeAv//RtQfS3Ac+qiTlwUt/AoYtaUSy4qpcNUQw0hngNaXluh7fDO8ipPwY/4=
X-Received: by 2002:a2e:a795:0:b0:246:468b:dcb3 with SMTP id
 c21-20020a2ea795000000b00246468bdcb3mr14390864ljf.49.1646052636724; Mon, 28
 Feb 2022 04:50:36 -0800 (PST)
MIME-Version: 1.0
References: <b32ed0e56099520bc3e75455e2472841aa0b3020.1645096642.git.jstancek@redhat.com>
 <YhY/V3diG4W0XrBC@yuki>
In-Reply-To: <YhY/V3diG4W0XrBC@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 28 Feb 2022 13:50:20 +0100
Message-ID: <CAASaF6yuSYu6Z6P4ROqUo0cej-9zsYmuHtrAJb99aAgrsJx73g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/perf_event_open03: skip test on slower
 systems
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Generally looks good. I guess that I will have to consider turning this
> into a generic functionality when I return to the runtime patchset, but
> for now this should be good to go.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Pushed with compiler workaround removed and string kept on single line.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
