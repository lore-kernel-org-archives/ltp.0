Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C77FC021B8
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 16:41:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F7C43C9D2C
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 17:41:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 798E43C29CB
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:41:00 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 312396000FE
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 17:40:59 +0100 (CET)
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2212a930001so81129005ad.0
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 08:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740588057; x=1741192857;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:dkim-signature:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J7Rw7KVZPKE3r5KctH8tYgGof4nhN6wZWZbteXF+Knc=;
 b=IBB3tb92woZeeHty+ak3upB6G1WvMdU/fdt6BiK8I3faSVOpQv63Wc+W18CAT7Fr6i
 zdgsQsdGck0ZP2RZ9HWFjd1OxgM3f66LxKjExoSGbsmEaCvwkLcnq/6f8uXkINUX0jRV
 YhHNjDXACvV71g784O8T5VCB78SEHdo9djsX/HRI0nXHl2uEOsSL8g/zP4Fux8XQgtb7
 roo+0CWTrEGsdLaJo0EIJ1iY5YTuXB6YZZ3ldIKI5AQARHFksmacuUEtFJkD5NSBC+JT
 H7qVra5EpmgbMgMe0Zx6LjdfLY+KWI5uqDUUlbz1wxsBU0itfFUWFZ+ptG2zLsygx5Od
 K6pA==
X-Gm-Message-State: AOJu0Yyuqow3EMIki9GrjcG28GZkfa/wOzv8vFJ7UO2sU0HZ05tLxSWj
 97qSpG5oJ4LKeYl9ufXggdvZ6kCfJUmsWY2p/CemInvqxBVHIGel1c7x1vG0
X-Gm-Gg: ASbGncstDd/CyfPo/uG1+UhuZIWii2pupSfZddEp9AGjmhhDSyw+LNxUZjDXS0h5Hva
 +rqJE+bqeHDSDCvQXL2TrBPMozlX0tTo6cSQaJAtzMYHftXZbzDmnhbpkca3T09lYM0tEM7/A7i
 SehIM7wOHygjtm7AD7MJawFtzLJPSEZKojJ+mA88+OVapsF9CY0R1je348A5uTKSeJ2aZ8m2uEb
 E3Q+TqekNC/VC8Kh0jYl1hFTGEpzJD4DZxyFJYhIfFyPN80UL7oEUOsFbvhz3i/vNCSIosJOl5T
 3rr9RlasneMyHBdfeS8V
X-Google-Smtp-Source: AGHT+IEKziN37vqHMw4waU6nwf9esktfF+Kz7TPFYAzl93UFLF8EbEAtn3BsnRFQs1nYYtaf3uTEKg==
X-Received: by 2002:a05:6a00:2445:b0:731:e974:f9c2 with SMTP id
 d2e1a72fcca58-73426af3a2dmr31345218b3a.0.1740588056916; 
 Wed, 26 Feb 2025 08:40:56 -0800 (PST)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a6fa24fsm3703576b3a.72.2025.02.26.08.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 08:40:56 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1740588053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7Rw7KVZPKE3r5KctH8tYgGof4nhN6wZWZbteXF+Knc=;
 b=lUB0fuf7k1qcf0U1vHswro7MHl3LlSFCXx/9fjCCgj4FwQkiJN7PU7j1kaXR4sxBQjW4eG
 T4wxbTlJx2SLa6IjpVYnb4XNmLL4VBZAvqJSdWsPLgpq8ysXeoyaIcJ+zVWtl66tNfLD7I
 +pbLixvqTxeujPpvRtpOpv9sAh7sKbw5+1cw+/sub7NwJP7Bo21lO+f5OmLdm40Iudeqb9
 DII/T38NLGZAZQou418c2vLKb1S//LQ0CGEcy92vHGt/63W/XJ5TwjWLlJLOjtZ/9yo14L
 bBakYxhkCaJlep/g8Ti2i/7NRkUgtTiflU9BAb86ejI1dfExEbJbJyhvcyMIJA==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Mime-Version: 1.0
Date: Wed, 26 Feb 2025 13:40:49 -0300
Message-Id: <D82IYV81YNX5.2CLR90X81HYPS@marliere.net>
To: "Cyril Hrubis" <chrubis@suse.cz>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
References: <20250224-conversions-pause-v3-0-5e3989d37f1d@suse.com>
 <20250224-conversions-pause-v3-3-5e3989d37f1d@suse.com>
 <D80X6ZHMZ1SX.1KAXYMYMDCHKO@suse.com> <Z788OcCPwPz17CDM@yuki.lan>
 <D82IOHFBAC1P.1DMBD7WPNMXUW@suse.com> <Z79CtMlApmlZxcav@yuki.lan>
In-Reply-To: <Z79CtMlApmlZxcav@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/5] syscalls/pause02: Delete duplicated test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed Feb 26, 2025 at 1:35 PM -03, Cyril Hrubis wrote:
> Hi!
>> > Will you also look into increasing the coverage for pause01.c as I
>> > described (make it loop over different signals)?
>> 
>> I gave it a shot here https://lore.kernel.org/all/20250224-conversions-pause-v3-2-5e3989d37f1d@suse.com/
>> 
>> Is that similar to what you had in mind?
>
> Looks like I missed that one, sorry, merged now, thanks.

BTW, there's one final modification needed, below.

Thank you,
-	Ricardo.


diff --git a/testcases/kernel/syscalls/pause/.gitignore b/testcases/kernel/syscalls/pause/.gitignore
index 8ea85563ca69..4923553440f1 100644
--- a/testcases/kernel/syscalls/pause/.gitignore
+++ b/testcases/kernel/syscalls/pause/.gitignore
@@ -1,2 +1,2 @@
 /pause01
-/pause03
+/pause02


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
