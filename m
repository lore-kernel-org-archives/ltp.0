Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72732C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786361113; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RguTVkKD6YNA59elASOEjxPErGaKJcOpVzSHRejafsE=;
 b=UvFupgz1g0V6tqj4/Z7qeYae8cBqWNXWlXDjZJkDLF+wOh+9LXOoTTlp/Gp8wXybGm4ox
 tiPWZ/rFFngdHnA1FEiL/SBben/IWhi0KQj4aETfnOHFxl+jvr0O+f/O2z4H6WwtvU0taM8
 eX/LZHHlo6jr5j0a7JgS+W+jLcicX+g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED6F33CC291
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 13:25:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DFB73CC174
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:24:51 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ABBD61400456
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:24:50 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so909898f8f.2
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 04:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786361090; x=1786965890; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ur4uVis8b+oWP/0+NX8L/epYJKXl9c9jU76j7/03VW8=;
 b=DS0qhCxwgrA3E5pjeqIw7JE1zQ0hMmZbPcZPen7NaJ2dff3ppL7hwZmgwj0H7TApeL
 vNgqSzvc/zhwUb9HJk/1KAOcDstwGpuWy3COvat57rP0pls3uZu3+aJ3ZzitPzOBbEJP
 tvqrQUqPLWHCoMkHvo/yhMFXsGhcTUsdAm3CScyhaSD+jLi1UO5S5IdYUsQUU0UIfGCR
 n7zZXrPWZ0I3UOAP7Fla2d99/Y3mCHHOx5ao3DZ3yZ0vc/hlax2/5e1S2HmxHuEw8p/c
 iMRKJ4GA3vwXXyZp03oCvG4sCOLMx1gADkCJRhAuKc7G5Bjq9NNB8mZH015JbVL0kZjI
 HxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786361090; x=1786965890;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ur4uVis8b+oWP/0+NX8L/epYJKXl9c9jU76j7/03VW8=;
 b=YDIOjUE7jwLna/1f1rzk6OzMC46++qbIE6MoPNQWaHJJdi2JE6tGvRSp1M0j38n48V
 tu1sHhdMJD6DGaDvFLVz/NeQUhpDUsbvql9QGoBFTf+jzNeEy55Pvioriv4piKEBuixF
 Wjch1q1PvUHXz48VlUnu1kpJa4Q96Tzs8UjRXp7HnUS3XnpQmePpnqK69MQltbRw1dWB
 wzaROMkcyFSRh2yjDKiqgHOGx7s58LHJKz3twKzMnoc7o+a153U0M2BvFDu+Z9w49hF+
 VqYXKMh26wtmTKFM59yq6t0+hbYSHvvwLsnWzrR02wYb6p+xGjsz5xqqaHWYnMKvbO2b
 cbGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqWD7IRuSR87bobr8ybweAn5ZzDY2A8/SSbJiRToWpxeit4Tp9pgnHITOqyVVlgffPasY8=@lists.linux.it
X-Gm-Message-State: AOJu0YxItO4Zj+CU90zY3RjrHrtgWq+7uVWkYDbZDDRBkaZ9M0hF05mn
 devbeb0Gqi/9j4nuEZdBFCIzVdYunYWghtY8iFhJNfi8hQvuORGDSgS3PN5fNiz6NbmGRTsBLHd
 vSpKa
X-Gm-Gg: AR+sD12gnz3IfrY+7QJkhIz3ypf89S5IfAGeigpkOGONYyaWcfRiYlfI21GveturJr9
 8S/dAV3vpjmUC7/6qqg9/vcAa9RZmU82FZIjI9bWqTg9vPGzBNJWt4XrnpkSLfgRg4kl6vaNSbU
 JFPnt4+X3lxjN0fVaUb4UwgNvXPBhDz04gjQYcPCxNZAS0ODj75vNCKI+oGEOTf8FOQn9nNxjSt
 yLvUFdWRaKxaPLcDK0JGeNnArqVb7gr6AXeNEmFWf0FCouiErW1aW2oAKBaCx81aunZls8W8dYQ
 PzCaZ2AH+ZWSvnxBJirBOiICWmQi1g+OIjASxfQie8JPIRhdJmdtN7tmy06IrzPmTsTYbqT4Y7+
 pnWSM70PUOXmlJITw2Ag9EbWjFY7xnEm4OR0pab5SvEP0v8G+cK1Os+YvIam2tuin/bNI/zOm8T
 AI9NczxCyiXFHwQ1HeWKBny/jwX0mhD8uyeFVbvNXDNqHw1dc1yzaXvg6NvioO+JmNgGV89ooAN
 7rm2LXL
X-Received: by 2002:a5d:5e89:0:b0:47f:5b52:5579 with SMTP id
 ffacd0b85a97d-480026c849emr30807755f8f.18.1786361089942; 
 Mon, 10 Aug 2026 04:24:49 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800214557esm31942985f8f.2.2026.08.10.04.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 04:24:49 -0700 (PDT)
Message-ID: <6a79b501.18b7d65e.302874.4926@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260810111521.GB918586@pevik>
Date: Mon, 10 Aug 2026 11:24:48 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] cve: reproducer for cve-2026-64600
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> > > > +			.min_kver = "4.16",
> > > It got introduced in 4.11. Is there a reason for testing from 4.16?
> > > Or is it just the copy paste error?
> 
> > 1e369b0e199bb ("xfs: remove experimental tag for reflinks") was merged
> > in 4.16
> 
> Well, 1e369b0e199bb just remove warning from dmesg that reflinks are
> experimental. Why to hide from users that kernels from 4.11 to 4.15 are
> vulnerable? Also, Darrick marked his fix as vulnerable from 4.11 (Commit has
> "Cc: stable@vger.kernel.org # v4.11" [1]), blog publish 4.11 [2], but LTP test
> says "Test requires 4.16" => potential user of 4.11 will think "ok I'm safe".
> IMHO perfect example of hiding kernel bug, specially due the fact that oldest
> fixed kernel is v5.15.212, which backported upstream fix 2f4acd0fcd86 as
> dc11be133efc, it was not backported to still supported LTS 5.10.x (EOL 31 Dec
> 2026) because it has conflicts.

We can use 4.11 then

> [5] https://lore.kernel.org/ltp/20260401094946.GA126168@pevik/

you will have hard time updating all tests then :) from what i see, we have
just a bunch of tests using the short SHA. Anyway, I had more than a few
reviews in the past asking to keep it short, so if we want to use the long one
in order to avoid hash collisions, we also need to officially ask for it.

I will update thepatch and merge, thanks 

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
