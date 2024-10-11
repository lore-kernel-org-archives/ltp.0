Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21502CEDDBD
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 07:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728631621; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=anrKJvF9LJHKxzKgg/VjRR7GB4bUOgvu42X+fs4R/s8=;
 b=AZeJ3F/Y9wKgmXRRydrRMD60jduc9v/bovEaBfenMtvIhxzVG1hYSeSbeiIL9teuGxmAU
 1mYzjT7WWI4I2sobz0/KrT+pLfvyFbUcCRTAWDDIixuVUZv9EAGgXcZRGQglAKYPj2V+a5k
 7dQM1+qwjY6iDadLFhE5RBLquZvSPr0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35A023C568E
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 09:27:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 013203C0FB6
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 09:26:40 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6458827CCC1
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 09:26:40 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a995f56ea2dso274976466b.1
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 00:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728631600; x=1729236400; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixzPpHGWjbIzjOFkMBEXWyWKb+2xivwYlcVRcNyCgXI=;
 b=bVSiuyhj2qpBCXFBoWbFHq8xywpMsBqz5Gfw6jJHVea66bWtM2OFetr0VmbWqRgdM7
 nGmlBE8LSH0Vz9EG95nbxS9WYMwpEYOF6wdCtF4PaZNg1nu4IJIMsFINsBrnLCjItqWx
 GX1Uh3nw9ZqO3lPDp6fMCZx0P3OwYF95wLQZg+3iPL7LxTi4Pi6S1f4Cs7A/dZgmSqCa
 NpVk37fa7kiC9W0vpY5VTxG8Y/5+/b+E6vpjCbjE/13c2+3BPiUHLZ18caSCoZYEX6Nu
 PVSdDooJZ7Gb0VZIMZCfPPS482AWgZ+lzfVojrxtg7vP/8gCSjVe1MRvQSXgBnzuZViD
 Zk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728631600; x=1729236400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixzPpHGWjbIzjOFkMBEXWyWKb+2xivwYlcVRcNyCgXI=;
 b=XJCCsY86K8Wd2waxrTllBi0TYcOaRB21CIAC3so6Y5pOupFgOUe0eAKekG4NSfDhzY
 OnX5pGBZfi+hAPmYZ07x1RZQsApGvJ3JPInw+drmNaEC7kNrbrfAFHl25UR/WDRAckEm
 CG/MqQOr8uN2DbAGxyVQwpazFh9Ha7qips6Qv6Bv0HB10NBHEckuolU/vKIuKBUuoobV
 V7AjGyvm3PADHkkuuRVtov71Uz4wrOjDnmbEQeXlGZAE2bCF2ISQY1PKD32DepZiLMUR
 ftfhkhjyTHOpHGC/+TUcLSem1Y40IBCj9WVVsAAgA+5InfcmyOuWbSSGLIJrExO28Hj6
 Y47w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXHhRWQjyKPRSRZtX6Gu1ok59dQ4oW7g4G09IGzOBcQvcnfgL0YKPhAv55IguUAGkAgfg=@lists.linux.it
X-Gm-Message-State: AOJu0YyxHzV5YeYyeE93g8wNUrBxFTLAENwXRtFAO6bKOoYEqsAk8g17
 wszjCnnQkS+pxcfHy1eeZbGzKGIFslFckAoPcp2sOABEwZysrfmrYVZIhqRvIoI=
X-Google-Smtp-Source: AGHT+IG3U7R1UYejdbBGWZwBoWPi3Sa6YPNHz+0xXB49J0XrRx+Exmb/leRfmmCU4KpNQoPSnyi2fw==
X-Received: by 2002:a17:907:d2d4:b0:a99:76bc:d753 with SMTP id
 a640c23a62f3a-a99b958318amr136232166b.45.1728631599670; 
 Fri, 11 Oct 2024 00:26:39 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dc700sm179380366b.158.2024.10.11.00.26.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 00:26:39 -0700 (PDT)
Message-ID: <bdea0fbd-dbc4-4d02-818f-69bd3a91b014@suse.com>
Date: Fri, 11 Oct 2024 09:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20241009-ioctl_ficlone01_fix-v5-0-943238be9923@suse.com>
 <20241009-ioctl_ficlone01_fix-v5-1-943238be9923@suse.com>
 <ZwfUcY7ShiepjJ7J@yuki.lan> <ZwfV_f89AbQpQX-l@yuki.lan>
 <09db9e97-da63-43b2-835d-daab733a3e4a@suse.com> <ZwjNOmz1i8dpKmS8@rei.lan>
Content-Language: en-US
In-Reply-To: <ZwjNOmz1i8dpKmS8@rei.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Filter mkfs version in tst_fs
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Pushed thanks!

Andrea

On 10/11/24 09:01, Cyril Hrubis wrote:
> Hi!
>> If it's ok for you, I will push all patches with your patch included and
>> Reviewed-by tag in the last one.
> Yes please.
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
