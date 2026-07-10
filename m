Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3DCC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783687322; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=iHiu6Bz2YP6Px7lyLWy0auzst63qX+NmiiDbXuC8fVw=;
 b=PqsZGVMRrQ+x9GOBJLGOcMvoCBzkXNxx2NGPfoBWnH9rXj14blYzkwv5e1So9djhj5DUE
 KAPgQOFYgEyOSMx03r4cNFJXem7k3C9iWwG885+yL+kHBBvqzF7z+HnXq8bU5mGxKD0HrfA
 BJ37iJFTCLk0atQ7v1MZfav0DXX3bFA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B98FB3E5B98
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 14:42:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01D1D3E275E
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:41:42 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79427600294
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:41:41 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so7877175e9.1
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783687301; x=1784292101; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=09ZiIPgx8hwUBPh8Vn3bs8W79s7AANaI6Rfq1BXaUtY=;
 b=EvO5RFLTFcQAxDwy3WPDtdXmptQXY4rskledGHSkviKnEf6vma5Fmy1EZsFxahcmJT
 cawCXhuQtoA/NCW5ZPl6HW62PLrkvycEjzWRzx57N61Ojx0qVE2Mw8L0+q/LPy6iqvK2
 V8VoD44mYGutJRi86jcf+UYhkBoXxwUYxc+/uyk3ExmexYCcWQ/X7L99lhEnOOAt8pit
 hv7QX6pJV7bnRsALI+flf4Wzp+/3jD9Uijx4SbfKiObNxCy/qt5FmwXuan15RzpXwjGx
 ae7ILw+VdzPQzN1MM9zQcHcXqRMv0z1BMzPCxZ5Ffy73AfBXt7K+yTpMvDxM9ppP6IOm
 VqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783687301; x=1784292101;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=09ZiIPgx8hwUBPh8Vn3bs8W79s7AANaI6Rfq1BXaUtY=;
 b=T+rJu5W4MmAbH70JeTAGkN/ZztFmyq2mH1Yb3ntbqNHec4nQEU2tflnfpDUoMoyQ8x
 9f+KeZNUeVtYQhmYTEMuxPrEuoYJ1jDb56sl48mEqTpE/qS6HU5qj2IpR84qF3V0QNku
 KI0bhQ/SkQFP2CU8s65H/PPlUgWsWpLdDQOBSaj6LVmiI8xylLLKpzcloZBi3EDqskL8
 nucwMKkZbWNmGsjiOSQ0VcZtdikPNR/clcpGo50zsq3trSi9gWN7X3vzrkDKr1gZ32F7
 iLTJPZR1Q3PzOr3cN1FhfVucDze0H14fTOOCOugQWpNRx5wFFkG3rBXQf2BYY6wAPhOQ
 Hikg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJoA8XvTVnwjhfuN2lAj8Yu3Rgp86cU7/6xXhiOVgzlOI9vlifHGFIgIANsYggB2Zp3Pw=@lists.linux.it
X-Gm-Message-State: AOJu0Ywa6e3Yx4JHR6WcqWFwURri28O7H9pMFXeFY3LOK3Wp5Y8Eo/t3
 pWiMThnpEsid9MttMD0QABgu2W52n7oAqm76tByjfnLjnn5LLcxoopm3HN2T5qgHMKE=
X-Gm-Gg: AfdE7ckEBwMKuN4XzNvYJIK5t8mTbtTzki7SZi3CdvKl3qXRBjJB1j/T5XkVw7++dn1
 YUH9c8eUZPQBo/kkwz0TakEPkYBLWgkbgQ1BYhvYuMtMsxNbVkR2P0xKNs2HPr2N+ltpDgPfIN6
 FOejLE1VqeYmqdQ480kQ8hDbitNtVcZGy5nFhghw+jfUPsFa9o6TqXgrVj/hjlkM5y5WFRNM+s4
 FajtYlkn5Mr6zwjHHWPTv5AkhMvFNpv1gbzcp3RP95bys4YxQaiWJU8K74owI+Cn9yhsUspKaIQ
 TWjO2d8VlOF8twXzOaFYrzYmVMRjiAjxfl7UZKqgpGy7HJtfhbreU8MJvXnQVhVra/dklkcE9+7
 eyBFPHsOeq/DnawoR16Hy5ve/mb7J4GsW2LE2jGFHaLb7tqsvjD3/bPDwk/7ahjQap2BLU/Dm+w
 KkqJpQjYhMbPi3SJpZQ/9Z9faCmaGODntMhrnw
X-Received: by 2002:a05:600c:8b64:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-493e68396a3mr113793445e9.10.1783687300772; 
 Fri, 10 Jul 2026 05:41:40 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ea082sm144907465e9.11.2026.07.10.05.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 05:41:40 -0700 (PDT)
Message-ID: <6a50e884.3829c3bf.f96e.d908@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <alDlHzYiak61OLRZ@rei>
Date: Fri, 10 Jul 2026 12:41:38 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per
 signal
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

Hi Cyril,

> Hi!
> Alternative we may change the core pattern for the duration of the test.
> Does this patch fixes the issue for you?
> 
> diff --git a/testcases/kernel/syscalls/kill/kill11.c b/testcases/kernel/syscalls/kill/kill11.c
> index 3cf62feae..191587368 100644
> --- a/testcases/kernel/syscalls/kill/kill11.c
> +++ b/testcases/kernel/syscalls/kill/kill11.c
> @@ -126,7 +126,12 @@ static void setup(void)
>  static struct tst_test test = {
>         .needs_tmpdir = 1,
>         .forks_child = 1,
> +       .needs_root = 1,

I don't know if it's a good idea to switch to privileged user, since
we would remove the test from parallel execution.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
