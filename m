Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73524C83F1A
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 06:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753340054; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=fvoTZfKI9CgM+TXXElN3aGL8WnhakBf8qlkOo6g8hpA=;
 b=Vhon8CWJoGxHqC7UnTpsEWS9OQNUFoTL/eYV4eqNj3rGqGtHaTfjbaARaNxi7jRC2pPLi
 Oa9GjL9+ty0LGHLPvyJtTj5NrcCBlJUlqIaIxp3O5SBNBEPt8a/PHY+Deip1RmYbwI1t493
 Lj1NHsC5WBupgV8z5LhBy2Kr29Az36Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A63D03CC8E8
	for <ltp@archiver.kernel.org>; Thu, 24 Jul 2025 08:54:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8913D3CB40F
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 08:53:53 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 19B2B600764
 for <ltp@lists.linux.it>; Thu, 24 Jul 2025 08:53:51 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso3849615e9.2
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753340030; x=1753944830; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dGjySAMEK6lGBtqZCWQmctmELESuJBa0zgUGxWLMMxs=;
 b=Ezxqu0R91uw3+gCRAUTmL01SoBeZy/Kq75/35Xy9UtZsMaoa8rHljqKTqIy1KuNsqX
 ZhHvOrJXHAH1aE30ny3WhPG3GLXkB/HBUznpUWleuTqcvlN9kTRPEVlYhWZhk5GLubeP
 6W0lSl2dw31JfNSGKKcs6gATccpf1Bi3XTI88CKefEFghTcW0mFQsm0jZyNajwCsTBxW
 NWqBIuYBEgD6oY/sYoP+jZZ2cgrMMAItZLRunBXDi77LxdIX8YGFnnrN2UKbIY8lH9rr
 kvWbT1xc/rEyYYInFntKBYXzM/h53Xr7IdmiXF/Ni1zEVF0b5oFMLgbhbGA9i4GjPGTX
 w+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753340030; x=1753944830;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dGjySAMEK6lGBtqZCWQmctmELESuJBa0zgUGxWLMMxs=;
 b=gccKbECGlmKaLLXkAlwa7+tD0jf9zL32SzzPuNoZO2MglhKsf1hrN9sieI5XmnR0x0
 6VqpvtZnkpPPkZJCaW+spTxBR0J9CllxvAwuFAF5rblI6tVJir/m3NmJmePWAK9I3vyV
 o7r8bhWGPoBUkK0ARoRGwacZv1xHszhSSlGD5wXaEF1ZTaYzYNsmFvkquZvca01Rm/zF
 Vaqt0Z8uNTb1++Qflw9yHyGqgnTPoBIS7EMAOfrAa+g1zJ5dyQPKWaCbLDHghiX590T5
 z/3eudRuPVrZrHTjXz6EI5lXsPakPaYvPcIbF6aKjmnvumCFCbc0GMZGKCJxSe9N53zp
 g4Fw==
X-Gm-Message-State: AOJu0Yz1ERdM5+rMLr46EGsHjj9LpEHpRFRG58N+rtShmnzIxEZve+cq
 0thi2EUKlVEap5KmxS/T7x8HM7uL3pxHJrSYtlx3lf/fEmd2iE94zvXb4UE7oU5WWZ0=
X-Gm-Gg: ASbGncusdBvtPYhLDd09zMMh+GOqqiIbbvD2HpC7hPlhgkHZ32wO2HucOJbZYfAVGcu
 wQt9awo/pgT4VkEXM+0fiXDaJy0JopKajtybxxO9V0Q+y0QF3caDmzEHuQXdANr0bI3iG6+YJnQ
 XpLfGlzeXLBaB1dzv8hAiznoG1davlwhto/x40ws03/rNVs/NevVqJY8n3QGR3847FaxaFPv3qz
 VXxez7Y+SCuupXv0sHAyii8inrli3KC0/Wh7GkkgQiYo1o0RtgOtq02ya2Bwxfi4Dv/axpgKO+x
 IIYT0/K7FbCyenifURtsax33lUCSqEzK3rMqRsqNPMrnZ9rQcli6HK2LEDRIMxoPOxgRXG3ICvA
 wRMklo8aNmi8Jg1iTdrz3FxTpxFhKs+rrveSxclA5+z/B+4KMRswcAzfuVI3rBzg66izp/PSwPt
 /zHg5c0YvF1rXIZOAXFn4V8ws0K7A9u1Zen+jj8FZE4cAWfNQlscuVNpt2kfB4/w==
X-Google-Smtp-Source: AGHT+IFPv+2JWb+pUnCQUmkzP+ADzaM0JiKoBvIqi7wgyk+BHm9U01GAt4E8Udjwzz3F7+ONgNmKhA==
X-Received: by 2002:a05:600c:c0d2:20b0:442:dc6f:7a21 with SMTP id
 5b1f17b1804b1-4586a49249emr32126905e9.3.1753340030322; 
 Wed, 23 Jul 2025 23:53:50 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fc60585sm1185020f8f.5.2025.07.23.23.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 23:53:50 -0700 (PDT)
Message-ID: <e9f9ed86-5332-4fa7-98d1-f652949a056e@suse.com>
Date: Thu, 24 Jul 2025 08:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250723-xattr_bug_repr-v5-0-63183d865e97@suse.com>
 <20250723-xattr_bug_repr-v5-2-63183d865e97@suse.com>
 <20250723200336.GF162896@pevik>
Content-Language: en-US
In-Reply-To: <20250723200336.GF162896@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] Add listxattr04 reproducer
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

Merged with the suggestions below.

- Andrea

On 7/23/25 10:03 PM, Petr Vorel wrote:
> Hi Andrea,
>
> First, can you please before merge add
> listxattr04 to runtest/syscalls?
>
> With that you may add my RBT
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Thanks for the test.
>
> 3 very minor notes, up to you if you change it before merge.
>
>> +#include <pwd.h>
> I guess this is now not needed, right?
>
>> +#include <sys/acl.h>
>> +#include <sys/xattr.h>
>> +
>> +#define ACL_PERM        "u::rw-,u:root:rwx,g::r--,o::r--,m::rwx"
>> +#define TEST_FILE       "test.bin"
>> +
>> +static acl_t acl;
>> +
>> +static void verify_xattr(const int size)
>> +{
>> +	char buf[size];
>> +
>> +	memset(buf, 0, sizeof(buf));
>> +
>> +	if (listxattr(TEST_FILE, buf, size) == -1) {
>> +		if (errno != ERANGE)
>> +			tst_brk(TBROK | TERRNO, "listxattr() error");
>> +
>> +		tst_res(TFAIL, "listxattr() failed to read attributes length: ERANGE");
>> +		return;
>> +	}
>> +
>> +	tst_res(TPASS, "listxattr() correctly read attributes length");
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int size;
>> +
>> +	size = listxattr(TEST_FILE, NULL, 0);
>> +	if (size == -1)
>> +		tst_brk(TBROK | TERRNO, "listxattr() error");
>> +
>> +	verify_xattr(size);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	int res;
>> +	int selinux;
>> +	int smack;
>> +
>> +	selinux = tst_lsm_enabled("selinux");
>> +	smack = tst_lsm_enabled("smack");
>> +
>> +	if (!selinux && !smack)
> very nit: up to you, but I would avoid variables and just
>
> 	if (!tst_lsm_enabled("selinux") && !tst_lsm_enabled("smack"))
> 		tst_brk(TCONF, "There are no LSM(s) implementing xattr");
>
>> +		tst_brk(TCONF, "There are no LSM(s) implementing xattr");
>> +
>> +	SAFE_TOUCH(TEST_FILE, 0644, NULL);
>> +
>> +	acl = acl_from_text(ACL_PERM);
>> +	if (!acl)
>> +		tst_brk(TBROK | TERRNO, "acl_from_text() failed");
>> +
>> +	res = acl_set_file(TEST_FILE, ACL_TYPE_ACCESS, acl);
>> +	if (res == -1) {
>> +		if (errno == EOPNOTSUPP)
>> +			tst_brk(TCONF | TERRNO, "acl_set_file()");
>> +
>> +		tst_brk(TBROK | TERRNO, "acl_set_file(%s) failed", TEST_FILE);
>> +	}
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (acl)
>> +		acl_free(acl);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.needs_tmpdir = 1,
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "800d0b9b6a8b"},
>> +		{}
>> +	}
>> +};
>> +
>> +#else /* HAVE_SYS_XATTR_H && HAVE_LIBACL */
>> +	TST_TEST_TCONF("<sys/xattr.h> or <sys/acl.h> does not exist.");
> very very nit: please no dot in LTP messages.
>
> Kind regards,
> Petr
>
>> +#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
