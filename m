Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960D8E9A048
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771501058; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rFldd2edhXj6irBsBoPXDZtSCxo4gNaCY5a/LWtM5gE=;
 b=pKlLKb0A69AhEVU7jDr6J5FbcuyRvkOftKsgWQrfV/arbJDF596L9CkVYTiJkwfo589s3
 0IXAnqFCpurc/K+x+ln7iEr250SzlipxN+vwwgzl6bumWfz0/6o7AfOgKX5NqBJ+JrfiU3J
 VCUck/k5dcrt8iKO+PH0XksZfIhIpBw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72B243D072A
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 12:37:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DD0D3C634E
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:37:13 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F3789600A0B
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:37:12 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43622089851so798699f8f.3
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 03:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771501032; x=1772105832; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyXKRau4Pj/ZC0vj0ErRofWEsr//FFsO2BROI2//fwc=;
 b=al2HM7h8XXMoaC62FbfElY0v4CNBxtOVwHkNRqf2nUzG2cIMAyT0DkMRfcbFCtkobP
 K5FMLhcD/2+11lr0HJ1+bOzfLURtSl5hVUg6fiidjyleIWpWP7rVJaoiryoVqG/SlFZE
 hGYqkt+J6bVARhXK+M0ojV/NUFxENpv4OAJ4meMldfdF895XNdPECRIqm8Vyh7nuS0gh
 d4lfCj3C9JAIu6mUCicrxESZJj+g0Exm+G1ErxHYdln9CdZUpdt9eZP/ciFxXYhN1ZCt
 +OFDn16AUfqU6B1cGWCIkLKYGG63f/otmLvJdOu4YM2gGjiubP6Pn0bFbWVKkOgvnfoX
 RgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771501032; x=1772105832;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LyXKRau4Pj/ZC0vj0ErRofWEsr//FFsO2BROI2//fwc=;
 b=kmTXMtJN0G5K+7VNE4v2ttzKr5S08EFFv7xk8Zn7lB5vvGdznKmf90yngkfNIZyvG0
 HGrtNYj+6B99dqV1sVBfaA8ZR9bE0rUlP3Hjt4kvtQ0KVkvXVgQvkVvBVCWmDwgFgVyu
 fwQfj95MZ+PcWdFZkt2ILOfgSL2kJAa4QvBzuionWJlsboNw6Y2+X46c7u1JEhttvcuu
 JHlClF8skluPPdy18gpsccvpojLoB6vdRc7aSu016SLIXNfGnFUCmrKCWEaO4WlEzPJK
 DJqJGAql0xp3PPHdTOFWoNxyExBquMx6Qleg9shi0qFnPsEbb76twtQljZVQzR51jwCC
 Ux3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbOqwlMW0jDafpJMO3gCXOJLh8HzkcA9G2DGHKODqUe3HAU29XagBO2UWYniYePVu9gIU=@lists.linux.it
X-Gm-Message-State: AOJu0Yzj7jGWXTDfKyfIGo5z8wt4FqcbqvOlGrXrDG5P0CX6Lguyn0UR
 +apiFRtBiCgeeMxfnUDg8CvHS8AjDCU93ufg/ltwip6eWukPcOJu0uRPSVsGideD5c+ggyppHQ4
 ZVpkmBxM=
X-Gm-Gg: AZuq6aJ9zynz36l27RSCWPwOlNKj6kE9cyTqLi4QgAv5jcPjynCXuCF+2TBiQK0Tmjc
 WNNG2Lpe3dKysmm3p3VOtunplOYutwb8tr4T0NLm+G0kFaHev9tOviPpiL0L7zdDtZU/HeExg14
 HGFGBUj3ePyaz4g/5n2DITW75mB3se73TeYMcyHWC0VnA5CfomcOTEXcSSwy4Hs2J8s1fQWCS2O
 HIoFPVECs6WBfPHy20bUOOKydZhQCwdUDaW/DnQbTBqKgTwlbCFDG+bJRLRuzT/Hc1062zEjLzI
 aEGN6fa4ZFmzRyMm9fdot95JEeTphYK2s757TyFxlHh0U73OwSTLz+MTFqkQiYbvAHuqkd4ZNCY
 T9pM+DQ8yZgRdbHiZspSzpIF1TOps8Mo33cFl7PeiPCHv544iSspa+5udszlIIFfM7N1J+DJxr+
 KJh1zK/1ojCPr7Zfk2bqJ0QicE
X-Received: by 2002:a05:6000:2384:b0:432:dfea:1fa8 with SMTP id
 ffacd0b85a97d-43958e500d6mr10052332f8f.45.1771501032335; 
 Thu, 19 Feb 2026 03:37:12 -0800 (PST)
Received: from localhost ([88.128.90.50]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad015bsm49610996f8f.38.2026.02.19.03.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 03:37:12 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 19 Feb 2026 12:37:11 +0100
Message-Id: <DGIWPEYYBBF8.YF81SUUGP6QA@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260218135026.159676-1-rbranco@suse.de>
 <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com> <aZby3eA2UvAnpWzd@yuki.lan>
In-Reply-To: <aZby3eA2UvAnpWzd@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Add test using UFFDIO_POISON
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

> Technically all memory is released when last reference to it is removed,
> which happens on process exit. So no mmaped() memory is not going to
> leak.
>

Yes, still, we should make sure that it's released at the end of the
test. Same for for malloc() memory allocation.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
