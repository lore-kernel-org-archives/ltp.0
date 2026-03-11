Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E10112584D
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 15:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773242988; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=We461z7SJN6gYPaa6GHn1DlUYZIgP+JBZfPDIIsGtvQ=;
 b=EvbG3g914wppQyolxIvnC9NFwDu0EhPlnKGjk/JBcMvEVe+3wKyLWaJ7cKvLN6OdGvHDu
 qc5SUkK7hHNQxr+SR8lql56MJJXiXwZlWqlOHEVOqpaDh/dkIMS6H2TRSLJqg9Rvh1HzT7K
 vPAlegNwA4L1Er9ZdbfsYhrcBd0Rc10=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF03C3E52CD
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 16:29:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 668203C2CA3
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 16:29:25 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D2DA9600818
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 16:29:24 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso578455e9.0
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773242964; x=1773847764; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ONs1Fe4+l0gqfLk/qqlhXSlODFbMPvQmI7w6dbRkbKk=;
 b=M4MBVpEb0Ol3t9bvmw5uK+o+xRRW69lLHvyytxHPxmNh5JAh1wRzTVyNIUhUz7eWh3
 4uvUixxU9Z3db3q/z3uvsr4T7aavw5FfMmVTbacdG2QcYX8FZbSfHUMaGc+3+EDy1NWp
 rsoZ38vrZ3h48K35qr0sIYPhT9e3X21GWdZxCJi3H+EFoUTMyL93mjlXsJXJm7GdV6iY
 EQ01Vaj5B9W7Op84Mn/UwXZdAdOlfLgtznqBEHh7osdXMLa39zZ1SdVBMOEVGQq2tREU
 1JGfWZ65nVgFvHASVLeaIWJo/BPojSTFcb+CEYGvpmpVjpndld5yS0NLuwseNyXaG6DZ
 S9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773242964; x=1773847764;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONs1Fe4+l0gqfLk/qqlhXSlODFbMPvQmI7w6dbRkbKk=;
 b=D67/xMihRQ9YiH5ceq2SKj9UsQI6Xv5W3TFD14dKyNX/f/WGzXN2gGdI8DexkpdQJ+
 dqc5QgcykCPEexBMT2kNj8928twDF2F7qa5dc8+fIv3IajzK3B0paRxd+bN9VN2LOh33
 hVPDGr03v/odTxpQ4BsFllaoA7KQBq1+cmvyC5pjXBVS7BPPrMxJu2NPkfV+33zSpT33
 1iCCXN/wMIOSyhEkvs4kuvMfkcoThmeAkLRU0xuDmCBwke9b3f0P21FNsvfjcv81NiMG
 ufE9z2Va4bpz8LzpGuN3xTYbnVYthBMEcelBMjr1Iw8J5hIf/vU4z9y1bL11/W/zBbe/
 vAvA==
X-Gm-Message-State: AOJu0YwYhAz12gAiDMlWzei0W45XqSs4mHWRUJFt2WNWShw/JLfq7+4c
 EYlAu/nOrx26v1gwkXFLB4i2s4gYScrVZGwuPZwCXdCWNR8Ruh1VBLaPud/Z0NnpSTSq8v/uu7q
 47vvT
X-Gm-Gg: ATEYQzwsr55utejm+ukYyvukbb6ReyFK9VIi0atZdkI9bd5CevYEQCVJUmVmjvv/BMX
 c3YQXqRg0O0Xu+97EyWs3XPlHnOaqhVO2Hx1na5U2QvemKZHPHutOxGQLcNG0hLYFBS0IiA6/Zd
 b9nQKp6EQLFrTf7ptnQz9ChnEMsIxcgdSOIIf6fsk450iLbmDh9ZMgVQrrvxGH+4x4frVZrEzmg
 8gIksePw8tJH6KvVE8PlOqqGeA3iu+5q9nTE/UHGjVXBpQLKsnRD/Zk1QFm/PnzpZNiH1RLneu0
 exKBBgbyo6arirkBnyIkmBsMn7Iw2nTbffoJlttUBfY4/JhJi1dIVXcw904IosQCa/NQVnMBsqr
 cHq7qvKhgidsDGwS6nr5rpmUcm0nMeC+ijCGh7B6iHKPzhBxrHbC+y3swKhrLZKZFDixglUwzY5
 45JELhy09zAo1/uSt90DpUdZjTeSA68bNzk0gclILV
X-Received: by 2002:a05:600d:8497:10b0:485:482e:f6c6 with SMTP id
 5b1f17b1804b1-4854f523a8dmr963175e9.0.1773242963850; 
 Wed, 11 Mar 2026 08:29:23 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aba60esm175525065e9.5.2026.03.11.08.29.22
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 08:29:23 -0700 (PDT)
Message-ID: <69b18a53.050a0220.10e0b.7f53@mx.google.com>
To: ltp@lists.linux.it
In-Reply-To: <20250917-open_tree_attr-v3-0-d78d4150b662@suse.com>
Date: Wed, 11 Mar 2026 15:29:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] open_tree_attr syscall coverage
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, I forgot it after release.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
