Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE0BC624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788518270; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=j1VJTMFoWvO0DSgl7FLBcFFk5PADZafG44h0fYdZS538TVODt+HM1F+FsqzRC5CSm7RIZ
 EqPlUPN5k0gfNNXXE+uqsneJRcnpFUoWngWc6CnwWBOJ4MRUZmxr8oku8oklHADMRIhcw3B
 WjpHHWgOYeXAwTNCdf98glfzz0g+5oE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED03A3E9787
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:37:49 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 995D33E939B
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:37:29 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB5E71401222
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:37:28 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so8883395e9.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788518248; x=1789123048; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=NCsK6NN4LSUVLIpNbxNFON0VQkrbrG8Pz2AeEZ+yYns/ThVofV/coCH6AXjzn+3bnu
 j9wKe/mg0mV7L/fyWNBsHfA6l6wWRh69kxNJdMUKziGEefYCs9QcOwDY/nvD7XdZiPUi
 u7jC4fEGEvfRXsFRc2Qczo4c8+IpnnUerUEkwxmktC8aozkCwKU6UxvpwBg9BNf7+jZy
 LWNKB+u9l6mzqpDU+Gf3o3JSnbfVDwfHy16BNUosb9Zmw4L7TcGrE6hrXBVflwdomLq3
 q9yffrRWAhSXyZrYhgvUA9QxfOTh+F8zzbatBVBiDoSCgC9I0sZNOh9DVPJjl4Ra0CdA
 lCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518248; x=1789123048;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=rXJcvvRmeNWowe2kbfI5eFgkRFUtoQte8OZjBkpqnj+J/jjyFE00gGNHynYUSD/fCv
 oi/8ziPiebJ9v39hVmaNdyK8vsggx7dxTzK7KMnk07ET3zzJUpDJvKEZ2LnQcNer4azt
 znwLqDSpFiNeaCj3suiVVI5iKOsWA20Xpm+tQhVsL62XYOB4wxgMK64VWZ7+6PTPaOOA
 m5VNsrKuecevBnnXu57zwJKGmRn/QUNN+/gIvlMFTckD5DJ33lOrjdpqdrOKAGadPdU/
 QjqZdO8+TCDfj6cIDBOOxUejBE0+BvW9+gppQzARDO7iAmP2r+Z38YTtm4lbMHY83tae
 xPmA==
X-Gm-Message-State: AFuF++mWQfgik4pWVHo+QPbhl7mhratFgi/p9ZZE0eCppLucXclB+A7T
 7un2nC75Pn6/HxO7xqx4/zPluA59wtG/eud9KhJVp6EUmsnrKQuj+eGjyUcd+FgHq7s=
X-Gm-Gg: AYBFou0nyYuI8L0QukprVhPwHdkQ4o0hoYbfRxbeGfwftVAWRuRP0lFCrAlq7jP246k
 sL0ZSOcaDFdzlCcNAOnm9pqpWiTBOCz1oHUUrS7x0DwfNuLQVcK11CBjHQD9cHZMeZTiqEgu076
 EK58LAOkO2iMHtXjqv/SXPh/RhhavKsby/ourJaPz61UfgJa6gQGsXCCqnn5wbgonqeVEqva3P1
 HV17CLRZy2A0wymEryLPcMMGIUHBczc00lUh1zOVs6CaqfAMezJQrTTvRSYkGdnE4JaOUxRuZxs
 G/zk5fdqI7VkB2Plq3QAqCVVl7DjPDOfUVWJSJbFMklJsjF3NFeBlxJxMyCf7z9v5gLETRnXYgL
 D4jeh/IsnSiR1hARwi9MyXPqueR3ROiOmRASrvRQ55YA9Y8a7aNOFM3UUv+gurjL+LvxMbrpkzF
 lKEQUb94IjD1KzX2gpx/+VzcZSFnciB8PdfWflvKxDRt47YBZlutci6OpUOQfGEE9PxYfo/r1to
 vZMB6cdRGBl
X-Received: by 2002:a05:600c:3ba5:b0:49c:dada:f581 with SMTP id
 5b1f17b1804b1-49cf7f39c8bmr62886615e9.0.1788518248114; 
 Fri, 04 Sep 2026 03:37:28 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfbe5b252sm32050965e9.3.2026.09.04.03.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:37:27 -0700 (PDT)
Message-ID: <6a9a9f67.75b1e5fb.176848.720b@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260831020028.19193-2-wegao@suse.com>
Date: Fri, 04 Sep 2026 10:37:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13 1/3] lib/tst_uid: Remove spurious TERRNO from
 tst_get_free_gid success path
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
