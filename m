Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837A2CD98ED
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781783575; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=dUJHJUOeOmrrQUla6C/4ZxDReIE3qH9IeeEHyH68udJtdVdmvPORtInb64XAItsrWpWF+
 +GPqhqo62eANu8Md297U0Oc2AxZYYK6WKCby77CxD/utDE/Hllkodfl78+PLKHzgaF6zjNw
 zM/NKTatGrwqVCfY110IW8MdgTasXJY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F27F03E5877
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 13:52:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4E733E5874
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:52:32 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 28A1D1400E01
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 13:52:32 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso5025915e9.1
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 04:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781783551; x=1782388351; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Nl4uLukbV2/zJkKNu4sTyQoq++2QAmVrVjiiK1prBzpM/kvOQ6n+LwiOp4zeEIZK+G
 GoFkHOJbseUdh6dsRMAbGyDE+Lcge5uAONc5fv2YVCGNnQF8UgUvjejH2YhXmH0w/QhQ
 HdeTSkN/rQevcBAA6Hbae5Zz9taoVz0fVbuaRCY6xqfBNrSGONcIwG2z3lkbbbkJW1tt
 ammU3ETmNu02YnWqwDhn6lEkZzl4c0Cmd6PTxLqs/f0G/H6Rr7BkoFCt4txpPxKWaTdg
 yuM3VdZDtarrbxq3Xdd00sP+SsmIthQOC6qXm177FO3zkpeyCa6YTfXTY74x4GKNLw6V
 wN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781783551; x=1782388351;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Cki9w0YhK5qO08h6n0fQsiIKF1WTUcq5uHdPMWPVvirg7WscFmiy77a/IzbHzXQHuy
 SrCRpwixdocSdsJ9HqFF8F8++2u/vGOa3yWGjYxVyeprEehSAsZs/hPwOksijIbmx6Oj
 KrIzsWaQDCLp/YT/yRE3kNgK834YsIJu4UGFptNAC2N5YgnMeo4q016YrwKGbsW+GY9W
 ZoDxwVWR4keMIvcRX4JLSAIvFtGfBM1UYNR5K4HYxw+6k16cV80GB3pB6UtzW77USx8f
 3ngFiqJmqFJATrMxm8h8iIfQut+H+Xu3PUPqq9Yfx9Vu03NLObJrpQ7yJV150pqBDiNa
 jsmg==
X-Gm-Message-State: AOJu0YzdznMjxA5iQsoTWcR0bZeREnsQgvkKz81di+6ddDlVSAvDnx5f
 5k6Y4UeVvPjWunS+npCxiya5WGFdxMIwquME7TpLaX4aujTL2o+d0zvjGsWQB2rQhSk1mFBXENP
 zPiW8AbY=
X-Gm-Gg: AfdE7ckUPoHbvkD0f3JmY65AMhkMMgItZLGxUgQIdZMpdHw3PeVsl3W1g5AooJoB3cR
 RGGQOo+m0LpNRQUUlZNVqZtTP6+rIfUDlZZXPH1CncjpKq9zbYgeF0l880gAFiwZgYXOlUvDHgD
 MAaVArL/Khqeq+HeBORGKsUJubCq+OUVbZvjGqELSTVj8OGyf+OUyhV4N4D6ep34IR5GfgxB+e3
 DNHZRHcxzznd2Udg85LYub6WOElNSvmM7+ZLjiATxZOM0MHgNjH5sPM1VcnuzN39sDPoobl7AZv
 HBhLsY9qoERL5WHLwl4RnvEV5JBXByJ1U4U0Sxvzq84abgWXoBQ9yO9CAdqWhKqyenu/xKSl+bU
 M6ZaBIFzEYhwkn8Hc4EAKsAIjkxCM30xRtJu405fiOvAOmQwqoZzAnaQV7lM2LZ8n4CjGsQynjZ
 6GZPtaLGsSS1y/II2I4vjsoTGiXJ/URbx100OWTjwRsNSll8yelggORO3dygQS3Q==
X-Received: by 2002:a05:600c:1395:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-4923a8c402emr30684395e9.0.1781783551465; 
 Thu, 18 Jun 2026 04:52:31 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923a1d3fcdsm37391085e9.1.2026.06.18.04.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 04:52:31 -0700 (PDT)
Message-ID: <6a33dbff.73c26634.39f8a3.4a43@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260618114706.105296-1-avinesh.kumar@suse.com>
Date: Thu, 18 Jun 2026 11:52:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fw_load0[12]: Skip on Lockdown and Secure Boot
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
