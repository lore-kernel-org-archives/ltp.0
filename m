Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D57C07C79
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1713789610; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/PVMnbrM/O0DrYLDo4HIaUxHcvzNWpj9xTt1ajIyKVs=;
 b=G61LVjopNn5QJc2xYYzqNJcaLGj/Vc6NkkvVM+vmyGIywG9E8pvt5bmvZqzn5W1I8xkRr
 p62hC80FYL3zO7iREOt3TD8LEExURN8BJazwE2XoPTdn8iJ1rxAtpP+d3c9uewgSE8eWh3o
 eAMKP8iAB4VlzQJcude6EwT16ySB6uM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBB2A3CFF2A
	for <ltp@archiver.kernel.org>; Mon, 22 Apr 2024 14:40:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 409293C006F
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 14:39:48 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 565A6200C73
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 14:39:47 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41a7ae25d53so4017135e9.1
 for <ltp@lists.linux.it>; Mon, 22 Apr 2024 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1713789587; x=1714394387; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HqTcA0CsRAO/OA6cV57CQcGlAgfwqnerbB1zuqnX+9A=;
 b=KUItJJn4V9Zo6lwWvMl+KnLcI+MTln+uKKTOksBr1Fza0BMAqKubdHxes7LWO1XxA8
 fPOJV+0WIh9LzMUjcpiqjZNjfG5sMCp1ojNroOJj2srPZaw2yx4Jt8/uRntzx2xpyj6f
 fem8bxoLRnUdpN+9wp5by389iz1C5Htvc1EjKq8D3gnRJFkrrqGVYUIVwTv1adgwIBzu
 WofPOcCspzdYPtjUyslBmod0anifw3SWrHdjccA3CJFpp5sabMQ0els4yDJ9+QSIs/au
 CnI2xaBHslWwq1tUH7IZx3f2+L4ZnFi+9Np8sHG+eHNZ9+saEsd5tZivwl89wlctbF+8
 wSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713789587; x=1714394387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqTcA0CsRAO/OA6cV57CQcGlAgfwqnerbB1zuqnX+9A=;
 b=GElXbLe6KfvHuCYhc2Q5BzNlwMZMrTZ3Boq7IufFEgOkBnKqr09MCcYlxQ4mRFZb+L
 Ux7aB+rrD45S6gv8kmIjXBn7pysqaZ/3UXfCYITz0boPLCbAn07hte+O8K6ZHjvXKHf6
 NpZP/wJ2i5M3xlKosrf9FvVQREMDDw7OU7M3KZpzvglECCJmABOFKevz9uILpkriDQAZ
 /gTYqs7lFef9HqOcR7xPJJ2JSRHrb/mZywiSg7m9+5DQ/sbO3m4ryeCqvepfWRIsS//r
 FsWnoU8d1zGkQdly4vqbaWw81ceiFmX3Ec+EODAlmBRTR+73SkO+hY9OB7ce6W5Y8GBr
 aLrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLnYHz+QwXaWleBquQJi5xxx/lQv7kCKYAkdigs9sKe9HWJNRVzcSe78XNEJKi9HTfBD8xtvxLyT6X+gGzWgfFwZU=
X-Gm-Message-State: AOJu0YwhSd7JM/AA/LiiGbAvbJAmu776oF5187hw0rLtDXkMdYx8MVpk
 +WSOQrKaF7J29Jd2HNntZ09HRusAby/IWm0j7bJgQypoB+BKMxCJg58YiAsCOw==
X-Google-Smtp-Source: AGHT+IGOPCigKaEhBzn/GhhSZBQyY/iSCMUGYnEPtyOOJgOnlYtzhaP5viGinMEdTE3t+uvRGv+iNw==
X-Received: by 2002:a05:600c:3c95:b0:419:f126:a46d with SMTP id
 bg21-20020a05600c3c9500b00419f126a46dmr4528938wmb.30.1713789586748; 
 Mon, 22 Apr 2024 05:39:46 -0700 (PDT)
Received: from wegao.133.226.142 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a05600c458e00b00417e5b71188sm16586328wmo.34.2024.04.22.05.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 05:39:46 -0700 (PDT)
Date: Mon, 22 Apr 2024 08:39:41 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZiZajWz20Gm9Iwjl@wegao.133.226.142>
References: <20240418071422.10221-1-wegao@suse.com> <ZiFLikOzOFDwfR2d@yuki>
 <cef1a016-f47c-4785-adea-c9eb9cd88f4c@suse.com>
 <ZiItA8Rm0hFzTSAd@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZiItA8Rm0hFzTSAd@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapping01.c: Add sleeps in the loop that
 dirties the memory
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Vlastimil Babka <vbabka@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Apr 19, 2024 at 10:36:19AM +0200, Cyril Hrubis wrote:
> Hi!
> > Yeah I proposed you can try to reduce the sleep time/frequency to basically
> > to lowest value (with some margin) that resolves the issue reliably in your
> > testing. That 10ms per MB was just a possible starting point.
> 
> The usuall practice we do in LTP is to measure the minimal value
> required for the test to pass and then double that for the final value.
> But even with that I suppose that the value should be less than 10s.
> 
> Wei can you please try to measure how long are the shortest sleeps we
> need in order to make the test pass?
>

Run 500 times on same build for each measurement.

1) No any sleep, 17 case will failed
https://openqa.suse.de/tests/14111469#next_previous

2) sleep 1ms, no failed case happen
https://openqa.suse.de/tests/14110476#next_previous

3) sleep 0.5ms, 1 failed case happen 
https://openqa.suse.de/tests/14110476#next_previous

So currently 1ms is good candidate. I will sent second patch.


> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
