Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B60606A319
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 21:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ERRLObh6;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gQczw/L5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792444127; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=6l8UiYKfR42SZCC267a59p661hLxLWGxyDBlHuYr2OA=;
 b=ERRLObh6d7eEHyx1l5df1cOEhNo+X3bxQmfOeQytbKBl+aVt9OexcPgDh+XIgkBdMnLce
 teoY9dALLilwhvAOCTiwosoZLT9Hjo1Pa9IK6GTYQUh+NlRezzkldyhUrjRc4whBTNrRno2
 6Usl6pP9ddGzpUngS9/Wr7qbSJJA6ng=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B6783EA671
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 23:08:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62CB73EA64B
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 23:08:28 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B4AC8600756
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 23:08:27 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1416851f8f.0
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792444107; x=1793048907; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=md42vjPsR+7lvygSulUxva+PR79C7dwwmDkUvDcHC8s=;
 b=gQczw/L5/Clde10V15KSgaHIiTPkCTNO4XbhTHy0nXgR4Rk3CfRwBeYgo8pIap+9To
 QW95RX9hNz96D4kagAwYSBBTkdMYvGFPiW9i4IUnn2z/25uv3VOkw9ooJNdJIogHh5M4
 iRfdKWTawOF2q7rd5ljYoddJ88Ndlm4SOW6SJ21S7Ve9QKgUY3fW/30ZciUYmmmIW5L6
 ECH39oBbOfY8o3s2suXmPZFRYNzP26J4Cwq1Ni/ydmV1DyZKR9TJDY7JSlN8QvBhNHoV
 1SpJqlBCFugt/3jAbzbFlXJTcxNLwLN0EbXL9ETAROpU4nFk/WIh44bEotI15hEoGxBD
 0SRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792444107; x=1793048907;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=md42vjPsR+7lvygSulUxva+PR79C7dwwmDkUvDcHC8s=;
 b=F/SoJA7Shgdw4nHdSer4caANfX0FLm12GCGdXlUMRCSPi22HcB5hvX09+umtzL4ne/
 zQMt6lMFfYfytAYNKfN+TD2iIaGelwNq8664aGvvqbZGLAYJJe1zR/MSjmlTe5jtl+BH
 EezfyMPo8FC5/qbRs/fHO8vAPkNarGKJ8x0UaNQDVR5g2Otudo2+KacfnpSNMuv6ZC22
 I5SbRQ3iBpnxg1dbqANshm8k9B6i8t5hwk2aV7zNsjjMheeS4MBv7KjPUO7O52bqVGO5
 QYc7uj7BqHbcuvzniOqoL0ofOVTJIinAkN5i+La+t9JtQCTnVELNokcYoPsQ77pPbqDq
 zUTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxotfpPuqwj5pHbDBUpKKEQXm5e3M5aPkJq7GqhkPsb0lRI4KKHo7GZk2/2R2jNmqscAsI=@lists.linux.it
X-Gm-Message-State: AFq9FYKXuSSsbDMMjbXiR8Y9postryTkGb9f/13iGg+7oIjllWDGrtoj
 3FIJp1JzJzXdzqFWnuniOxb3yDVvLIbhiVlY18ENDL0gTRUxuJg2BeMBaK9+gdSrNQU=
X-Gm-Gg: AYBFou1jCHL50XiO8lm4+MTymX8yn3SjJ3iQLUtjtlUTxYDHnAriQW5W9jXJzJWAo0V
 Z8FeG2HP8hAnZC66pXcqjw6TdtkH1LVQEmenxO0ZUm60XQQAmaocng9jxqBKd6r2kJkoDPgipQ9
 6fsAFH25rwf9cLX9I1uL6UiWvozh4pP6K+Okw7AwQdP1+MkESkKYr0ki6ODcYtjbgwpO7xxx4qp
 5nqxfrDaRJ5CT/qMtRK7as1Zn0Q0DMU5G6YVf30SiiNDWKtdHuBmuyHAVREnN04/UiKUsnwdEF5
 dvfR5hDYDlgP6tZFDURQSxh5RJ4HCsQ24D4eaul9QsCAFt+RultX62X1wCanIO7j7coUCm5qVwq
 1gEJdK3shR1vq1vrdcMo5sG9aPLYV6bZDhJUZ/3hubI1UcBsK8Rzf5WeiqvkBQ0GmFDR/U5gGBq
 mqRLGoSqde6YkZYQwL7gGApzi391zuGfJVrHSKt+rDnr4O871540BTLOAJlbouzR32JBHEyqj4V
 waoWw==
X-Received: by 2002:a05:6000:2402:b0:48d:e61d:68da with SMTP id
 ffacd0b85a97d-48e07bc4e77mr18335137f8f.20.1792444107010; 
 Mon, 19 Oct 2026 14:08:27 -0700 (PDT)
Received: from [192.168.1.109] ([176.114.240.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d82456asm1471784f8f.42.2026.10.19.14.08.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:08:26 -0700 (PDT)
Message-ID: <49034ca7-baa3-40bc-801b-ee1e91908b9c@suse.com>
Date: Mon, 19 Oct 2026 23:08:25 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it
References: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
Content-Language: en-US
In-Reply-To: <89fe77f22e26d912865c8b8266b150ba7459bfae.1792413314.git.jstancek@redhat.com>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nextafter01: Check exact results and convert to
 new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> +/*\
> + * Verify that nextafter() returns the next representable double in the
nit:
:manpage:`nextafter(3)`

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
