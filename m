Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0874CE6C5E5
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 01:24:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 092233DDA03
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 02:24:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 034543DD942
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 02:23:52 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=xiubli@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4BFDA611E1D
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 02:23:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733189030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C2/PC1ZypqZswVys9659RV2tZzXp19PZ6Avu/KkJe0k=;
 b=AncE1MJxszjrWjtJF9+JEnUmMcvEyY5ouMv6hSirNjXW5gzLhJM6e/1Y7ZEljHmf2RctlM
 GBqYITV6vCx6kqttMwt4RIbl4GKLkZHwy86o1M7rOhZrY14f8NAgo2rOcs+Nkz0WSefNxp
 i4+i6XXMG40TKDyq1H+xwHNIzi5lwV8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-wTLrIuj4M5GlW6JmWgKUng-1; Mon, 02 Dec 2024 20:23:48 -0500
X-MC-Unique: wTLrIuj4M5GlW6JmWgKUng-1
X-Mimecast-MFC-AGG-ID: wTLrIuj4M5GlW6JmWgKUng
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-215576aca41so20650225ad.0
 for <ltp@lists.linux.it>; Mon, 02 Dec 2024 17:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733189028; x=1733793828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C2/PC1ZypqZswVys9659RV2tZzXp19PZ6Avu/KkJe0k=;
 b=JyUMYdXh/D4iLCO979sFZtnBBoexNS/th0PC/RFaAtBbmKqb3bgtbv08xaxtaYqoyu
 JuZ9w/VmBxfyflbJ9NYaxIo6l0juwiZZpZC6rX8ZY3ST3UvVh+vJ7FAMKgKCV6kQXcqR
 e8I93Xuay7hytzyMIk57qT5j/WuXLXTT6dqvT1X9OsNB93Swib+mVllWEMRwBGF0G2Gx
 FPoKV5wMZFJIqzRMZkEywjkct8rotQUSsnb+D60ay+FX7rJpsw4zam+FgYUg4nicdtHD
 qJbEWv61yQV0YuDstzc+wrDS724N1FCNz9fSPw3OPg7NQQx8CXyc3iYvtD6eJE8lRpSk
 vErA==
X-Gm-Message-State: AOJu0Yxfo/p7eynkPOQ5nwjpnwtq42PFquk4aJCQn9055BM2RaZ61ChJ
 O7TAgwHnIZ5Nx9SKbMDJwMxVFYjGkxgnuuWwAdEXZOpc9fXFaUZywbXJrSzx4trQ11zyVvddOCj
 w5jrciYq11uvY+v9tFXnpZNDnBmpYnwReDnhPcQeBlEUrIGpY
X-Gm-Gg: ASbGnctSklorqbwgxPDsxDUcxO/OfmbB2q8O1xTJp0GPn/a3M+sMhzq2fs6k6DAPyhc
 EkABH0AgfV6u1my1dnzlS/SPowryoRO7AyxlKMtv17eISQCvxFgO/kaO/sNhEhQzfbB8yy8kFvT
 inUp0qK0TEjc1iNzl9YwbHQRcj6x/Gy8HBMI+PS3tDE8/qs+RWEhz8+GUHcQPYap0RjgvL1Genu
 HW1eKI5202kbe5E5E1N0C4VpfMLJA7rn8hle4A2BRmCY59JKDw=
X-Received: by 2002:a17:902:cec7:b0:215:a3e4:d26b with SMTP id
 d9443c01a7336-215a3e4dc89mr65627875ad.0.1733189027856; 
 Mon, 02 Dec 2024 17:23:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcnlTkOEYdvVSwQb5f9BrlBHCoY4NdIqDAtzR19zkNXnGj7T2eKbjQ4ASSxLtdeMBsVBvjVg==
X-Received: by 2002:a17:902:cec7:b0:215:a3e4:d26b with SMTP id
 d9443c01a7336-215a3e4dc89mr65627645ad.0.1733189027600; 
 Mon, 02 Dec 2024 17:23:47 -0800 (PST)
Received: from [10.72.112.98] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215b0887f58sm8629995ad.208.2024.12.02.17.23.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 17:23:46 -0800 (PST)
Message-ID: <2779c1f7-28fd-415f-a016-da3aa077659b@redhat.com>
Date: Tue, 3 Dec 2024 09:23:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20241119101357.951813-1-xiubli@redhat.com>
 <Z0mXHSnqmstCIMrF@yuki.lan> <a32c6381-8779-4dc5-878b-a46bff6454d6@redhat.com>
 <Z02PZRGzw5qM3z0w@yuki.lan>
From: Xiubo Li <xiubli@redhat.com>
In-Reply-To: <Z02PZRGzw5qM3z0w@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jSW_oJM9jDhx0x5RTnHROLw7Oi8UFie-GPUGfq61gf8_1733189028
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: correct the build steps for
 open_posix_testsuite
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


On 12/2/24 18:43, Cyril Hrubis wrote:
> Hi!
>> Wait.
>>
>> I check it again. I think we should do it under
>> 'testcases/open_posix_testsuite/' too ? For me it doesn't work only do
>> this just before 'cd testcase/...'
> Ah it's a bit more complicated that I remmebered. There are two ways how
> to compile the open posix testsuite.
>
> The top level configure script configures the open posix testsuite, but
> you have to pass the --with-open-posix-testsuite flag to it.
>
> Or you can run the open posix configure from the open posix directory.
>
Yeah, this looks better.

Does it make sense to fix the doc about this ? If so I will send the V3.

Thanks

- Xiubo


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
