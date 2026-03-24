Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E46F54AAA
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774357567; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=VyFzpmkhVkFV0DHo0qq+G86QGICebKWB1xx0WQ4pACc=;
 b=Ks8fRK719akv1LYo7e8N7CIxcqcMrNVupUtP7jyPklms9ECRbmC6SixuBoMgwzpnKi5LK
 5e/ORIWYn8ioYIRjloTjGnrEbv2JI6hK1ixLbWfi4HA1d9eIF06XHD12pFRzI+F5lEfjRWy
 1LVLtOmc5/N12bkf5bjYWhkS0YNWBqo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF6103E553B
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 14:06:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A6723DADA3
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:05:45 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA968200AF0
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:05:44 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso58635745e9.0
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774357544; x=1774962344; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mHsniOkVbAcBgduXcp8ljUoM8jMEnjilqBTMR0OzUJY=;
 b=FGyKoAchtp9n2tHbcu2QhpETLNCeq2XRvM+oDo9lbF9U/3e1FTlorRNmx9Xg1rdzeW
 ioq1395h5unuN8rR+wOMw/uLYg0WgockuvxU/53czGGUv3waytRxHhNH8zUvVLO/h4QC
 yLTZRUxhx+xD7u0uuToCm37h6gs6PcLccrCfH63pmSYwegr+7ThPcnqa81kpuWgsBisn
 /7st3Tx5EbcLatBnoqyCh+2GHW5Pgcs/UJVhE9FtgwMoBUZ5VMs3PdwyD/y4BQn2+anQ
 FY8qI2cWaN5SE7VT+ppcifGlEbQuICLBBkKQvMEOlAdRtMvo6DV0w1g04SLOQnM+Ya4b
 UqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357544; x=1774962344;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHsniOkVbAcBgduXcp8ljUoM8jMEnjilqBTMR0OzUJY=;
 b=IUTlV3tZkzoQFqSGdjugbll73SowaJkyCWodjULeQvgkPIL3T5LW4l0U1uG1zzIlLj
 cQmhORb3hV7Ss25EtMiXDCGzPzX3/W59LQjN8wvdXLZa/i38mK0ueV3pS6cuSDrPP+Js
 861ASZe+rQqpneWXModdUKvTvoTnQDlB3SA4ge+/V9RBvnH2EAVvyzCQf18G/ZdJZLw5
 mf0/Dj+SgOZynO2e4P+PxgZWALB0ofiKxxml8mXhNUeZu2AdBDTlG/gmeiYHfcAag/uT
 nAjVYqi19cPSUDY7Fj1CnJBgNDitt9gV9B4Lfer/mZMOQcxYUwYJQdKRvUPdawyDZQfM
 wlcQ==
X-Gm-Message-State: AOJu0YyJSiDW4cKpZnUmXYLbKKZ1TT0/5lQeZeCFSZ6kWh1Pl8krXiKQ
 9D/NsQrvIuS3sVZjYDA4y8AHq6wFEu3uEWPCSY3LpXUG9KiPg5/GsLUzKim159vDC84=
X-Gm-Gg: ATEYQzwPtCNpCc4njASRYIzEjBEH84GPUTb7M9M1r3zcQXbbnVQ1qWbIhv0Rsk/Mj6b
 eSxyWwuzVNPTsps4LWardsvqflRgrvRyYhEvCxf7SlR+JmXJKUBb0SJVn1P9zJZDpA9tPN69POP
 mPxa5Y/qQUAHOGW61MJg8CvWGq9cefbsRW9xIAq5lrGAKvepYMgZ93QsQAEW97zk4W67P+tdIr5
 pQBZgoN2h4U+BvIJb3MhdvWOJjoHWyPYFdFibYlUGPQe70SOfuQjpIk1XCcItC4obZn6d5z0EEb
 qJIyN0vzNHvCl4Mp4pDow1UWZMmDkKn/YPNid3TjQv/I+ZlU3UdRHyZl68gwfCZYJwFaF5SZFd2
 hDHMNoqac+Q5sLqeQYP9Y0sMK20AIWezaJOnf1tdZHE7e08r4LqsX5yWqTdbi55Hrip/PBEB5ac
 SU8dQp7bADRjeIHmoFd/KRwx5idJF6pKyhGrVGulfX
X-Received: by 2002:a05:600c:4e13:b0:486:fbc4:8fe2 with SMTP id
 5b1f17b1804b1-4870f22485fmr48756805e9.15.1774357543619; 
 Tue, 24 Mar 2026 06:05:43 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116ac0a8sm92389145e9.6.2026.03.24.06.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 06:05:43 -0700 (PDT)
Message-ID: <69c28c27.050a0220.1f29e8.ce4b@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260323140851.197426-2-piotr.kubaj@intel.com>
Date: Tue, 24 Mar 2026 13:05:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> +				ptr = endptr;
> +				tst_res(TDEBUG, "interrupts[%d]: %ld", i, interrupts[i]);

`interrupts` is uint64_t*, so we should use %ul instead.

> +static void run(void)
> +{
> +	for (int i = 0; i < tz_counter; i++) {
> +		if (x86_pkg_temp_tz[i])
> +			test_zone(i);
> +	}
> +	read_interrupts(interrupt_later, nproc);
> +
> +	for (int i = 0; i < nproc; i++) {
> +		if (interrupt_later[i] < interrupt_init[i])
> +			tst_res(TFAIL, "CPU %d interrupt counter: %ld (previous: %ld)",
> +				i, interrupt_later[i], interrupt_init[i]);

We always consider TFAIL when counter decreases, but we never consider when
it increases. Is there a reason for that?

> +	}
> +
> +	if (temp <= temp_high)
> +		tst_res(TFAIL, "Zone temperature is not rising as expected");
> +	else
> +		tst_res(TPASS, "x86 package thermal interrupt triggered");
> +}

I also have other questions in here. Why are we considering only the
last zone temperature? Is there a reason for it, or we should save all
temperature for all zones and eventually verify temperature increased
specifically for each one of them?

Because in a single socket system (I guess) we have one single
temperature for all the zones, but on i.e. dual socket server, this
test would verify that only the last zone has increased temperature
above the higher level. And this is wrong, according to the goal of
this test. We want to verify that kernel is correctly working for all 
systems, correctly increasing the thermal counter for each thermal
zone. If this is correct, `temp` and `temp_high` should be an array,
where each item is associated to a zone, and it should be processed
only at the end for TPASS/TFAIL.


Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
