Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5BFC54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785501483; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YXQLaNcjOFm5RvnLBUfclzf/bvFUrLD6n70Smv9i/Uc=;
 b=b5sJpVRn2jU8ekt/GhmG/NZWKNcMlkNLQefW2R4TNvW5eFaCExbR3xebSmtzNcgzHBmCm
 RNFdaz592y8hLECOuOD+I22PicvNanMFSm8uqi5ZABBFrwsajlXHX6mZH8JqP/eCL05qHZJ
 ks5mejaU6G/w0v+SdFMzfqmoOMJTJrE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CBD73E71E3
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:38:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B83E3E4AD2
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:37:43 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7DCA91000448
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:37:43 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so672255f8f.3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785501463; x=1786106263; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ET68Vc7VsNqMxoCc7ivG16Ptuhoc0L++LsWvNoV1b20=;
 b=Bl8A4lZRDbyfE8hr+zyIltOf1F+pxWFl6wirb0HCcsnyYA4wxY7plKtYwuv1tSi/Nd
 kV5Ndf78m+8+KAkvesEVp6YO/r7Xfql5ai9JHmzveJrYqV/A/S5OANTavU7z47KjJfWW
 4Z77a/+sO2BOKARwH1seNOLFfKPliP1VpkXzouHq4GT+ARz3eorvpgp6kgS4YVP5w9Tc
 SWEn23922JG1qXwrMFgqajK73JTNjZFCwqp6CoWeG6AtfrJ2rAZYtQfn7jO1TPJ9kSmT
 oSbsRl1UUQOpwyVmG5b27MJpOOyY2QwyIai04pb3O6EGuVVfIV//fGzimmLKBWmQfHEt
 MJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785501463; x=1786106263;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ET68Vc7VsNqMxoCc7ivG16Ptuhoc0L++LsWvNoV1b20=;
 b=hUi65ErwzV+Qp9oz+fWWDjm4CDUvcunx7+thnSzhtjMjf4UtL3gThx8Zjus6qERgYX
 iiFBKIfo9aF9NsS/njX3pVMIvvUjGHj3PqwygPZG+2MDVd9FGAJ+rPnAyiHxygJKXFWI
 wWAU0WW1p6DSNdj5ScWkAYn2kP3xLP7mPS2AO1XbBJAM8M4AVE1OoCHG7iUi4Iv93QM0
 rHtb72b1Ts3z0RyGdAiyvhCAuV7MEWp6raX6zuTK0AmSPO15k4WZ7e+0tHnv6F4TIaoF
 kxQ2PPGUpaBTfxUlt/6TsoiNp7I1dzLWxUTirGdFLHUsq3lPEkhnmoZ5tqjA8igndzZm
 AKTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoE4csniudlQPlfvYab7KPLyMjcIhRiP81oZFL6glqd3w1cl2P0gRh/ukDVbtCuAEiw8HQ=@lists.linux.it
X-Gm-Message-State: AOJu0YxKkY+2Rq7CRFRUd3PWN1mjVO47ZMu4F5pWBmkyQ3Zyn2orlrv0
 23JBTdiG9q0+YVKSQEMzQqe91TI9Hix3UAbehmCNeNIUQsirbSVQcFhqw4WMXetS+kU=
X-Gm-Gg: AR+sD12FgppvNUqsosCu1hi0h/ey9bKmWGFpMSuza5VI/aABa4lfwFn5w4RQLOraZK+
 6zTk9gdK7DqQHfT1PJ6Wm9rspMhX3GBo6QagXFXJ2KrgN6LfkM+8EW/+H+Betwe54QAA0cY54ER
 vzJiSYq6wfu5k5b+QmhzvAKKlAMqOIhj9BwLxFx5scaG4hBlp8kUGWHvnCGfvBhw7oQh7ejEKb8
 JkTY4C/bcJr2QbE/XUSNOwq5P+to3+JfpGKnrA1nPciwIYf+zXxUlh5XlD28Aq/B4VFfS+25vnJ
 crcGL2R/bXqhLEvEFuYGUNfyfxrKyQz+R1kZUiBTJfn/js6aSsFPnZh21b1PwV6IfC+Ceqnm4Xc
 tXvrRtZTuFp+S1mT6HbEqreZW21X/fhM77y0wVJJcj6d8syXioA1WEJBNUtco//tWl1ge+V2jo9
 ZCwRqA5gv9eCwoGvDzNt4VScQPgoAOUA+yXNIzylzvZaierm+547s3TCG/Ld8OKjqd46adnHFeV
 2pgvyxZpUNwrbjufhIIEMhLsfNoll6nvXZb8A==
X-Received: by 2002:a05:6000:4283:b0:47f:7129:e30 with SMTP id
 ffacd0b85a97d-47fd2ab9161mr4287162f8f.11.1785501462800; 
 Fri, 31 Jul 2026 05:37:42 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d0064sm4312611f8f.5.2026.07.31.05.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:37:42 -0700 (PDT)
Message-ID: <6a6c9716.b7086f8d.c2a23.334f@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260731122009.GA196217@pevik>
Date: Fri, 31 Jul 2026 12:37:41 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Rename function check_kver() => check_min_kver()
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> @Cyril @Andrea could you also please double check?

It's correct.

The legacy ETXTBSY behavior was fully restored in commit
3b832035387f (Revert "fs: don't block i_writecount during exec").

So we have a window where this is not valid anymore and we should
take this in consideration inside the test.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
