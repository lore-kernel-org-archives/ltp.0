Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96867C30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719925877; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=PKL2zkfi3qFRhgKcjPbnMDoQaFbwrq4Hdw5dDi8n/X8=;
 b=gxTh5x14rEaToZCIDyG7HP0eAWxrM0/wXeanAsUG9gzJdwr22pgu28NRLoeFD2b8/sZxL
 YK1ZdVXt/9MwT8JU9PwLSpjypzSPITsSqSCfG/AZeZTM7ac/2ub2RFXO2xo9h8IqM7PK88u
 6nfXF8mksDCLmpEdOD+ehGloCrOxquA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0570A3D3ED1
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:11:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03B403D0F60
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:10:55 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 88644200AEF
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:10:54 +0200 (CEST)
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ebec2f11b7so47304691fa.2
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719925854; x=1720530654; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N5S4KKpfKx/swgMSnQIyK11r0SRK6Yk81BAk7irGZfg=;
 b=Tb5Sf/dkjDRgHbbFUQC9L45vD0RkfH2hawzxspFEXu6ZlFtwWRY0Uwl7UBkIYjh2i1
 nQ38qIm53MNNf73K7OI+BUtVrftjg9vxoL41AfNNtxjRugrrbLrbPxBW77XXNXCCKGoo
 hYirEnI7ad54afgmBUEpwTX1nNtJGIpRm0RYCIili8qNF2bm4pXAzDMoQoBDh9epu+G7
 /+FiEjHSf2WIR8JDRJBn7wS0WrMxOTeUdmu5D3uWsefu06M2vA53rq6oblIJW+rO7IEm
 Q6RAUNaaCtX+tGIpPUwaUHBLcU+NTl5PP9LCw3zcZGOw+p54R4h9iyHjNF903A9cfSiy
 RajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719925854; x=1720530654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N5S4KKpfKx/swgMSnQIyK11r0SRK6Yk81BAk7irGZfg=;
 b=QXzYJqsEDE0TYrJsT1b/EODsQ1Yr2w6NSSt8RHXFggjcj0dxpeFtitVv2zrGH/IooF
 LejwrSk5gdzRbjROnz7LWxu2cDUuBVHH1c4neTL6vxFDfDcYovITxDoUpAliNehD4pUi
 D5o2/2POmwo7EgeBYhvaNK9cwAGzvV/JeM6s1uDQnJNS+OUIM/B5XMbNYW/adK2rrlRb
 5YMyLTavyYdnxBPvIY7ifHphHeaw2mEt+lGZhikcnEKz9WLxA/+WnqsilhFmRMROAX61
 xOwogR033IHsEP9a2CygDTKo7iWIRu2/v+9ZgQ6e9wM2muKvFqEyFFCpciBRXpnEOmEP
 zUHA==
X-Gm-Message-State: AOJu0Yx+005nPleUelpM5xVlX2b4pmWhJzsBXnns1L6WaqXJRB4Cveap
 1kc896pUlAOGs0UHJXW9Xo2gpIVq1e+AqPZS1LL+30Yd/dDgY6mkjsenFmSZC2vIfMNFMux2MYP
 mun8=
X-Google-Smtp-Source: AGHT+IH15longLV8ZkZllZ5E4q6GeLnKs+MbjjN2ifGqPGKeJ7iBzlESnrLdSdPs0pnF96AN1/zrNg==
X-Received: by 2002:a05:651c:154c:b0:2ec:5dfc:a64e with SMTP id
 38308e7fff4ca-2ee5e2a8a4dmr76943731fa.0.1719925853289; 
 Tue, 02 Jul 2024 06:10:53 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15b890asm83652745ad.301.2024.07.02.06.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 06:10:52 -0700 (PDT)
Message-ID: <9b70179d-2bfa-47e3-8ae3-5cbb971bd5c3@suse.com>
Date: Tue, 2 Jul 2024 15:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240417144409.11411-1-andrea.cervesato@suse.de>
 <ZnllGpZEj6TOsWqB@yuki>
Content-Language: en-US
In-Reply-To: <ZnllGpZEj6TOsWqB@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Add stat04 test
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

Hi!

This test is basically a clone of the lstat03 test. I'm wondering if it 
makes sense to have both, when we already have that one.

Andrea

On 6/24/24 14:22, Cyril Hrubis wrote:
> Hi!
>> +/*\
>> + * [Description]
>> + *
>> + * This test checks that stat() executed on file provide the same information
>> + * of symlink linking to it.
>> + */
>> +
>> +#include <stdlib.h>
>> +#include "tst_test.h"
>> +
>> +static char *tmpdir;
>> +
>> +static void run(void)
>> +{
>> +	char *symname = "my_symlink0";
>> +
>> +	SAFE_SYMLINK(tmpdir, symname);
>> +
>> +	struct stat path;
>> +	struct stat link;
>> +
>> +	TST_EXP_PASS(stat(tmpdir, &path));
>> +	TST_EXP_PASS(stat(symname, &link));
>> +
>> +	TST_EXP_EQ_LI(path.st_dev, link.st_dev);
>> +	TST_EXP_EQ_LI(path.st_mode, link.st_mode);
>> +	TST_EXP_EQ_LI(path.st_nlink, link.st_nlink);
>> +	TST_EXP_EQ_LI(path.st_uid, link.st_uid);
>> +	TST_EXP_EQ_LI(path.st_gid, link.st_gid);
>> +	TST_EXP_EQ_LI(path.st_size, link.st_size);
>> +	TST_EXP_EQ_LI(path.st_atime, link.st_atime);
>> +	TST_EXP_EQ_LI(path.st_mtime, link.st_mtime);
>> +	TST_EXP_EQ_LI(path.st_ctime, link.st_ctime);
> Looking at these, most of the would be the same both for the link and
> the actual target. Maybe we should do some extra work in the test setup
> to make sure they differ. I would create a file in the temporary
> directory as a target for the symlink and use chown() to set a different
> owner and group, we can use utime() to change access and modification
> time to the beginning of the unix epoch. If we write a megabyte or so to
> the file the size should differ as well. If we link() the file it's
> nlink counter should increase. And I suppose that if we create either
> the file or the symlink on a mounted loop device, it will have different
> dev number as well.
>
> I think that the only part that is not changed easily is the creation
> time (also called birth time), the rest should be under our control.
>
>> +	SAFE_UNLINK(symname);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	tmpdir = tst_get_tmpdir();
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	free(tmpdir);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_tmpdir = 1,
>> +};
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
