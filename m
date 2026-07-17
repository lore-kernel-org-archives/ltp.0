Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B1BC44514
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 07:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784274359; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=1yMEGiO02KxnnHoVNaruLEcx+SkrwoHtbbjx1wAJMWM=;
 b=kf8lTM0+jPNIthUSH3wxgZOCGImC5rwJL7En6knXeTtdqyBE5MB54LholTQl1YUkGpD7n
 V0zQu0PO+W7kUGUf9F3Yv8tS8+oJg3sAXcbnN6p4tKKI8zi6OIEAu/v9akHfUFnuK11l8wi
 18kM8N0RCqSME/WTovpAxHgcA4zJ410=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ACF73E5662
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 09:45:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6BBC3C9911
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:45:39 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4EB406002D2
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 09:45:39 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso25897375e9.1
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 00:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784274339; x=1784879139; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ohmDJwvletIduzJgmNQmyZex2dhJiiCA1qdDBFB+gLE=;
 b=Q6jM4g7K3C+iNwG8r+hXojDGf0DSqI41NApQUFpxRsljVe+J09PN4a1q4rz7NbMuvP
 vr6/BxzPfGn4QjaS0BQZsQBvod2bq4T17du+zn/5QbIrSiz0gQMrIRmuH7QwEVQFXYh/
 cPYnKjydfMi7q8D0ErS2/sJ7fuSUXSzS/FWCVXWtMd0kzHl0x2uNDm2z1FhaUSHX1QAI
 i3lhmO9MZPAYtka0FUUMVJCBblJtdmtFwyJjEJXOoAOris7NydBbZBhgERDVqfXbRKRq
 bi111ewZVgshLyLdfusFFspSHa8ClM/6kzefS/EbVNQr+VIiCAGSoZP3GLeeSi0ZzEeo
 fAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784274339; x=1784879139;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ohmDJwvletIduzJgmNQmyZex2dhJiiCA1qdDBFB+gLE=;
 b=UdWscZwUwyati8U0xkJFhk2Tk3Ynop6to8hxNyYup7ERjvO+mda7F+4KqsCarYqyNE
 GReznkmg0XDZ7LHgdvJgtl0VuLGkSOy9YP+3PKsOUiZXdMgEcdcR/DlAFBdSTpsWY0p1
 6d3jAg7lQJFznTfu1J+A5BMAcLTzz/cqiN0W6UmyduIoFS5R2jyVr3wdNKfLNIt1mg0H
 ONkU0FihICOKDuI+nz+RH0rGIiWDkDOu72G5Z2U9G31DrqxQdDWRADJ0Iu0A1pvqBfke
 yoCyRJiChHOaPY1rNt6h1j8UKPa68hIPVGdddXHp1RGRJ5V7b9JpoZbym1uuKGnpmH71
 H1sg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSh11GOko/wv+CPk59zKixj6FOUx1k2LUCNMi6twgQ2OFwLW01hTmVEuC19gWTdDfdfGg=@lists.linux.it
X-Gm-Message-State: AOJu0YzcuFFJ8Q7t3wDzWL9rEjC+8IIqS5i7K77WwMBEFYvozLB/yFE0
 gx8pJXdYpdJTgk2apGMrTrf9RKpybhRleQUN3SfIwxnU8xeCtPmfqmAw9CdkfftQHmM=
X-Gm-Gg: AfdE7cmUnnyqDQhUWa8fpkuU5pZSIGbldTeuIhIPX0IdkotWnCVZIGQaXope76NU61h
 j/dcRLFbhltoswFdPEvRRRfYhRdh5UJqnLPv/1n8RNaerXUPdvXvk/IQwdNiFXJwRQFRceD/NW6
 rRrbtGskKasad0nmBGCfTERt/+9dn+KaFHm2kWP/XWmK6JcMy9FqHaUGJqzaPP21RSiheSH9YVf
 Ewsmw6tWuxreaANTDD+7wRt8efmbbDA+pIImFhb1FnENqU5sadSssFxo26RBN22s7YDRs7a1Am1
 3I0liPtKjdxsHedHYs4PggZK498YPWzMyiF24bLCvG4m+b1GOzzg3urLfIceS+hLevw1ckTfCeE
 LZ3wFG81fooawxuGxQyDVEfw98Z937EMozWkTMi4HTqljlKvgikD9ymAltCqWxqCKUKRyDCvOKY
 YC2Jf2M7M0m0KViiwEMS/aGJhfGg==
X-Received: by 2002:a05:600c:4f09:b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-4954a40bc1emr14136845e9.30.1784274338506; 
 Fri, 17 Jul 2026 00:45:38 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495499f3f99sm27264315e9.0.2026.07.17.00.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 00:45:38 -0700 (PDT)
Message-ID: <6a59dda2.ff5210e6.1a2a26.c868@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <alnbk-wNqcenHl2S@linux.dev>
Date: Fri, 17 Jul 2026 07:45:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugepages: ensure CONFIG_COMPACTION is defined
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Writing 1 to /proc/sys/vm/compact_memory only triggers proactive
> memory compaction. It's a best-effort hint that makes a hugepage
> reservation more likely to succeed by defragmenting memory
> beforehand, but the reservation itself does not depend on it.
> 
> The kernel can (and often will) still satisfy the request without
> any explicit compaction step. So treating a missing compact_memory
> (i.e. CONFIG_COMPACTION=n) as a hard TCONF is too strict: it skips
> tests that could otherwise run perfectly fine.
> 
> Given that, I don't think we should tst_brk(TCONF) here at all.
> My suggetion is not to use SAFE_* macros:
> 
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -47,7 +47,7 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>         }
>  
>         SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
> -       SAFE_FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
> +       FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
>         if (hp->policy == TST_NEEDS) {
>                 tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
>                 goto set_hugepages;
> 
> 
> -- 
> Regards,
> Li Wang

thanks for the patch, indeed I was not sure about the approach and I
think this might work. I will wait for other people to send a final
patch fixing this issue. it sounds resonable to me to follow your
approach.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
