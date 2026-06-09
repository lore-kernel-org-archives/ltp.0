Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050DFCD8CAC
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780992733; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Y868cQqoz+qJV+BSBKlARzCx6eK2XPjkaK44JPcAvTk=;
 b=XaOlYGaC0x4g3ZU6IM8IpksOR1zjoK5YgP7OJnZeUq31LeWAYmFZXO/McjyBlZFdNtgNy
 SbqPGD/XsP9HKykAfJnj+a6Z4cMKgMg6UQdCw9jeAv3NXwBU0m7J51babUb6vTyisaYKlXq
 WAdmZ/rNiLoK0ztjefLU7Z6fvheJs5s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 504313E4E68
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 10:12:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F4853C9EB3
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:11:52 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6E4E760026B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 10:11:51 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4905529b933so56378315e9.0
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780992711; x=1781597511; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=92LTYC1QSMyo1xmCTt7ENNBMRO5Ccfyun5KYnSETcog=;
 b=Wd1aUrGoSexPSfnTSSsYo1NCqB86X+e+dBzHdcjbm8T9byRGgi6wXZTmddmTW2iJoe
 xOkbxC8bUed42Rq/rRaceI3UjUQyi2AWBXUl2x4STBc9/UqAQu/epr78j5WNiRW+YPZd
 mmBJuXjEZoa9qMOc0B+RtXR5qPUBRnVgj7B0XXmXTzu+Bh1O0NZK6ezl/r7LE1+6kWba
 2+7+WrXauM6KVJOlOc/Jf1uTHwYTpAI66NwJo76eZ3YljjOSK4H/RtAXrTiXWmuV4aOx
 z+n1zoBN8MIDgv88XVBPtMSu2DHhCcydbO+3UyDldVa/X7nnmMaYgwxqu4ZS5fac8FaA
 2qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780992711; x=1781597511;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=92LTYC1QSMyo1xmCTt7ENNBMRO5Ccfyun5KYnSETcog=;
 b=rV7e1joBZvGVUylOLqd0C9iKTcQ0TEHg6P296sv9lwJxuvZW+p+6zlR+D82ks3OR3w
 aTW5RTREhMQQ1VTFLUtY+n4CXi9AM46aaR/VldRRCZTBYuT1s3e0CSJKZoiQvGTTfz20
 XkePGet1FHlINSoiqsiX0AWmRyaZwDd+0PJhiL+BH15D2ndpeWcVQMT8cCyS77XPeauc
 JUzxtSTXrc7vkwuAdRmggAub4jLAF6R2g/5dABUWL8DHNCJGoxFmt5BkpPERoj1Jq3Ns
 ySe4mUTscmp9isVm7AXpvTrPZyCoPTzSfQ+fVVwQrAjnRtXI0itZS5SUv/WpXbWg1/EN
 4EpA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BQd5snd/DlX7FUFxufmQl2iMbNZMnZR9P/d1bcwMBFqmg1CUsqoWByCwNUU0XwUC1uZM=@lists.linux.it
X-Gm-Message-State: AOJu0Ywe2L6bnnO5g8YnMMPbZaZD48fVHrZ+ZbMnm/SF6Tw/APoK1Vzw
 sYOJlV7IvqxWVB7dmHsgPO6hcxIBPJx8F5xew9AuYnlYGIpsY3YLXi8+BQ6U3pLFcfBeX5j+syV
 c0L3+0KWQVw==
X-Gm-Gg: Acq92OGp+BXrgZFy8mla7EhY7VLBGcq4yHn9JDH2mPfVagJcDtNCEtwWtjlUF1t/x6j
 /OEG7NvIiTJj4ELmP92Zft7KRLo/SoAHEeA31KDckRQy4LcjssBk7Zn/g0khXNa1m6FVuVsCxBG
 zH5TdCMYor8pf9LmtGQT1xdbHKZUE9w84wKMg4QlaRbSbEgAxrVVmWzis+b6L7yZ6Tcyy4vYXKE
 bou9FoAxIxW9cB++fhYu2NKEPZkUDd8ghSatK/CqlAq9ncCjLb4Z4+gnHEVMKpi6Ym2rcJ4zoYM
 Klxlw29v8JDCyuFaXAOyBGX0G6gY8yEWEM2gF/UK43sqRgmXaHz4i4OF32R9zSp4blf/S0mf+68
 LI1Tc+YQ2TFh0bHiWjkS3GWK6dxwmzsqozDEQv06EIfOrkP3Zny4QLb265sNs2Cjh9CL0hN2UIN
 Bpfy49A4dqGhSQKnHqcaUKHuOyT+mB6Xj18Bsm3xqXEnUSkwfSruJEbqR1dLGABo5FFtmM0BmJg
 00XQIlkluLUim2ZsmOaOHU1Dy1Ae6j4GuV9OkGG8hVyJQ==
X-Received: by 2002:a05:600c:a00b:b0:490:b58b:a8cc with SMTP id
 5b1f17b1804b1-490c25d208bmr298906015e9.29.1780992710731; 
 Tue, 09 Jun 2026 01:11:50 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3fd663sm531362855e9.10.2026.06.09.01.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:11:50 -0700 (PDT)
Message-ID: <6a27cac6.62b8b855.1795d9.163e@mx.google.com>
To: panzhe <panzhe@kylinos.cn>
In-Reply-To: <20260604072637.147497-1-panzhe@kylinos.cn>
Date: Tue, 09 Jun 2026 08:11:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] gethostname02: Accept EOVERFLOW on alpha
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

Hi Panzhe,

> Hi Cyril,
> 
> Thanks for your review.
> 
> The ENAMETOOLONG note in man describes the mainstream glibc implementation based on uname(2), but alpha has its own arch-specific implementation calling raw gethostname syscall and returning EOVERFLOW.
> Alpha glibc source:
> https://codebrowser.dev/glibc/glibc/sysdeps/unix/sysv/linux/alpha/gethostname.c.html
> 
> POSIX does not specify required errno here, this is existing upstream glibc behavior. I suggest accepting both errnos to resolve alpha test failures.
> 
> 
> Regards,
> panzhe
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

for context, it was useful to add the following patch to the discussion:
https://patchwork.ozlabs.org/project/glibc/patch/20260604092410.185621-1-panzhe@kylinos.cn/

For me it's ok, but we need to see this patch being merged to glibc, before
updating LTP upstream. Please ping us when this will be official.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
