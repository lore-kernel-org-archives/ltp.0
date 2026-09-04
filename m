Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0A5C61DD3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 06:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788503167; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=6iAafFeIGVVKvFUlDgPbcOVZeuMtSMfyBXNSnX0QTQU=;
 b=CFN944y/e4OlnyDWP942AoF3cSdFMg7ZoaCXYxTMTX/AVh3/FmG19UWK3eMVVznRNnS7H
 TfsYTVA5vkxmpylMOB4cByecKZpeqs7TkaB+Xp3GZXmO7rRu6dGfUD6tHOdBhoKrTVKipZN
 /BAlh5opegP4FHujlFnAqrb1foGnczY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7113B3E9360
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:26:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 671293CBEA2
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 08:25:47 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B05C51000F28
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 08:25:46 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so7010225e9.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 23:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788503146; x=1789107946; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N+V9I9hZOKE79ZcextEMDKao64fGBBvijmq7UqIhO3Q=;
 b=bSETRudZQBrq6O54Rd+lWhVYiiqSWE6RhR7s5E2UXwBEvMK8w5S34mR0t77pJAF3yH
 /JY+2xEgn6RWcaxyDuMJZ1TCnsvNycx8i+C6VPSCCwUOJtmOIWLZgFhBzDNBOwSCyWTW
 D6ElDEiUB4Bnuow6Y3VwPuPBRxvsFTpwgvHQjdLAKhsZjc6UcfpEzkrAPpDOE0omIRT/
 N9Uh+uOz8XVly+PleYwgeLzg537/ypTZtd0wFWutEer05ozFlLrRKlSToJRDLO1jWRsV
 RbpB8sdKNDn6dqOXD/7GEWer0QYFhEuFeAPOcpDIgPBigi5TKP/IPZr4kV3tuMWdf4dS
 12hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788503146; x=1789107946;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N+V9I9hZOKE79ZcextEMDKao64fGBBvijmq7UqIhO3Q=;
 b=J4FFku6f9TNmVK36YmPdpGGGX68KW2q3PJiTx5q+QcEW0jsv8f8s/fxZR0eCA0J+DV
 9XsndcZ7H6pMr0ya6OUMl6av+8QiV3KA858DIAms5Au8zAnSew65tzDFqEjgrqI8YNZX
 Pjej2mN+mReV7yaTUkdD7TkKty5ZqJFa6Idl8bSVwdQwCLIeCNB5Mz+JW4AZKuePmgUj
 1Hxpu8OVy221BjtK1ZRD3u1IJBPVA6OhK3aWd6kuuraKWZty3B8reWwSVj4erqYja2U8
 70TjaphrcpMF14uzHCEP2gY2j+38jNmSWrxBOf20Y9sstGoxBYC02pzB7Q75/g2+ISOe
 09TQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByBlRaaH3VHra5VWF6/JHnbY8kaNNQmrOS+Nbu3Y8up8wSxbPs2AJ+F4MK2X+Af4/k1vBQ=@lists.linux.it
X-Gm-Message-State: AFuF++nJ8lAZ98o37oWYgAVhO6Tow/hq7OR1g6Ms1uW1ifDd+9E+TZdT
 Y2iKfuJUpgw0BSXDCagP7GQR2ji3VkRIICidPtD5PDwbQRdaYnBsuvG7gNmjJcTDHW4rwc5mFkF
 XzYt+Wzf4kQ==
X-Gm-Gg: AYBFou07YgTHohPKKmTGBj6gtjeM0E87L3GDl3Ab1lwbelqD21Qn91pJwTaDyUbrTLf
 ZeHyYwiY8LZDO2PIdLz+CVuwpP1YLk7iiyZKua+i/urnY0m1reM8NH94RmONiS/9h3aR/ctaGjJ
 ZizAWVik1+3A3pfBcAOZ36KwFjdZ6JQDkfLbquRCw30v9DmRufXMOMIyqYFUu7HfikMaKCArnuT
 k1sMgPWgOcGoNM6PjAWO6fjyNbKbHCqHpZdo6Bpg5d36V0bu3A+R/vmSo7S7xLm3N5niheFrNzp
 A2fBTPwmmmUP8J0I43IXPIYhDd+YKgWEMDo5HR2wxnaYjfzXvq7tcrQOlyvsJ6ZPoXtREhWW3oB
 xbWr8g5Aw+uSOjYXqT9O4DmJ60wRXu/BhhuyDSMkX64caFvmBVdWw7y0a4SQ79O0YfiQMkn9pEc
 1sIeqhPqVFS1i3iylwIQhwLgxqYhyTaLmgYHeETUpSh0VfQtDS+7ucmwrkD9k7JyBKtyfOHhjsj
 x1w4gnQOh0j
X-Received: by 2002:a05:600c:34c9:b0:49c:f729:d757 with SMTP id
 5b1f17b1804b1-49cf824f757mr45419425e9.11.1788503145947; 
 Thu, 03 Sep 2026 23:25:45 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm3987166f8f.8.2026.09.03.23.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 23:25:45 -0700 (PDT)
Message-ID: <6a9a6469.3d30ac2e.110181.4b84@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <apo-YSqDGDNbrzcc@linux.dev>
Date: Fri, 04 Sep 2026 06:25:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] coredump01: New core_pattern specifiers test
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

> > +	TST_EXP_PASS(access(dump, F_OK), "core.%%e.%%p.%%s expanded to core.coredump01.%d.%d",
> > +		     pid, SIGABRT);
> 
> Generally this checks is really nice, but it'd be better to
> add more checks for the core dump file?
> 
> e.g. file size > 0, ELF magic valid, and type == ET_CORE.

this is already done, but we can introduce ELF type check (read below).

> 
> FYI:
> 
> +static int verify_core_dump(const char *path, long long expected_size)
> +{
> +       int fd;
> +       struct stat st;
> +       unsigned char magic[SELFMAG];
> +       Elf64_Ehdr ehdr;

Ehdr is not portable on 32 bit systems breaking our testing, so I
wouldn't use it in this case. We need Elf32_Half which is in both
32bit and 64bit.

> +
> +       if (access(path, F_OK) != 0) {
> +               tst_res(TFAIL, "Core dump file %s does not exist", path);
> +               return -1;
> +       }
> +       tst_res(TPASS, "Core dump file %s exists", path);
> +
> +       SAFE_STAT(path, &st);
> +       TST_EXP_EXPR(st.st_size > 0, "core file size = %ld bytes", st.st_size);
> +
> +       if (expected_size > 0 && st.st_size != expected_size) {
> +               tst_res(TFAIL, "Core dump size mismatch: expected %lld bytes, got %ld",
> +                       expected_size, st.st_size);
> +               return -1;
> +       }
> +
> +       fd = SAFE_OPEN(path, O_RDONLY, 0);
> +       SAFE_READ(0, fd, magic, SELFMAG);
> +       SAFE_CLOSE(fd);
> +
> +       TST_EXP_EXPR(!memcmp(magic, ELFMAG, 4),
> +                       "core file has valid ELF magic");
> +
> +       fd = SAFE_OPEN(path, O_RDONLY, 0);
> +       SAFE_READ(0, fd, &ehdr, sizeof(ehdr));
> +       SAFE_READ(0, fd, &ehdr, sizeof(ehdr));

double read? I guess it's an error

I will send a new version with some of the proposed checks

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
