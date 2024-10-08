Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2349CEF177
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728395857; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=suJ/2f7I/eSCxYLHbs0sdsphn1bvfilfT5q66WIg4gg=;
 b=h37n92JCh8MywPTXjZq3yhqmLkC8DiXkxWPDEtmkQyoPdEfzD23yvdZ7DtuNlndT+MC9V
 DZ/Su8BSxUD6QjNO6D8VecxNxnU8NLtyM4CmQjpGdwdsQ+/fHJUkT2e1p2orBJCHLVta9JM
 sUOvwHs4f/CUOr2Fas0wxMRRTXwMgIc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 484323C1C20
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 15:57:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 132C03C1881
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:57:16 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 69CA7208E08
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 15:57:16 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c5bca6603aso7105680a12.1
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728395836; x=1729000636; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NSEhP514N4jVfrlSKTKyOwKC2hjv6CNOAVj7QnNEIPw=;
 b=ICD4RD26dQoBM3vX2i6I1u5luu0BoBAtPlTsU/wUqGQkcZGJjOaH5UfOXMUOV3al3x
 wniEtT+NneSSTSKtgDuKShW+lvOqSLQeI+SAcnZ2XbV4rDpdgN/ajvR2XiosZoDa0te0
 QiRsg+LpUpGQqJVvR+SWbNnBjYxFN9OzR6trQbvXbsnAlJ629tQ12x4jQ0YM8ZNXDRuM
 BJv62cPA1s+4dstta60ipkNJsxeecb7J59buQqJnV1LQ1Oqz6ewTc489KCn6i1+588/K
 JDmGBunIPnKY513aFbViHYVFc2Af7LLkHMDU2fKFLH+OlgrAcsCN1ixXThf4/sfVXR7C
 SNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728395836; x=1729000636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NSEhP514N4jVfrlSKTKyOwKC2hjv6CNOAVj7QnNEIPw=;
 b=MX+X2K/2qTm8pp9qjyaCDGNy594YDv8EmH0+aw663QJlx3FUDqfmy8m4qMFa1B9hi/
 3rUTL3PJpnpElLh77BVQwCIqEoc6oXO/M1qQpBDa2cme+FiRMSCvrh++4FEUjm3V825d
 R5hbpQvtz6dT9y2UpWOvWmnAktsaKHvbGQyVVaECEHUm+IYj9LGmB+PU8dxr5f85l5z+
 oqnITWxb9/HzAmllQ/Yb9WQJimJ8wOs60t79vLwQeRYSWvxKmJAHAwxh8VPMoIopFtdO
 DikaUlypH3AFn17kq12NIoL7oA178a1gvk9WJhyrWx/PE0nWWsntcB+VWhcuVG+a0pM9
 xnFw==
X-Gm-Message-State: AOJu0YzmxkkupRc8chJwFp6c91nnlcatMIv0XN6YvdRJs/1sIdPf0GwZ
 hONfmLb6C4LPTnZreeQZw9QpQ1x7drW35UGpD5jkWgWTcysxnymcnet5uw5/j8E=
X-Google-Smtp-Source: AGHT+IEEl0CyQGKFigo3YRhGX75eJUgNOJdsdjC3CF9yk2n35l2mcvr842Dv87HV7sEFl3u4eP0gvg==
X-Received: by 2002:a05:6402:1d54:b0:5c8:81bd:ac90 with SMTP id
 4fb4d7f45d1cf-5c8d2e75d91mr14833417a12.27.1728395835681; 
 Tue, 08 Oct 2024 06:57:15 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c8e05f3b80sm4305614a12.90.2024.10.08.06.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 06:57:15 -0700 (PDT)
Message-ID: <7a3a91f7-473e-4d25-ad5f-1b3b1ff4450f@suse.com>
Date: Tue, 8 Oct 2024 15:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
 <20241008-listmount_statmount-v5-11-66f4e1a9e7db@suse.com>
 <ZwUfe1rysrK2MfDi@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZwUfe1rysrK2MfDi@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 11/16] Add statmount05 test
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

Hi,

On 10/8/24 14:03, Cyril Hrubis wrote:
> Hi!
>> +static void test_mount_root(void)
>> +{
>> +	tst_res(TINFO, "Testing STATMOUNT_MNT_ROOT");
>> +
>> +	char *last_root;
>> +
>> +	memset(st_mount, 0, SM_SIZE);
>> +
>> +	TST_EXP_PASS(statmount(root_id, STATMOUNT_MNT_ROOT, st_mount,
>> +		SM_SIZE, 0));
>> +
>> +	if (!TST_PASS)
>> +		return;
>> +
>> +	last_root = strrchr(mnt_root, '/');
> Wouldn't last_root = strrchr(DIRA, '/') produce the same result?
>
> I'm just wondering why MNT_ROOT is relative and MNT_POINT is absolute
> here.
Because STATMOUNT_MNT_ROOT returns the root folder and 
STATMOUNT_MNT_POINT returns the mount point folder, relative to the root 
folder.
>> +	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_ROOT);
>> +	TST_EXP_EQ_STR(st_mount->str + st_mount->mnt_root, last_root);
>> +}
> Otherwise:
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
