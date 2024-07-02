Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7A9C30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:54:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD6093D3EC4
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 11:54:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35D363D3EAD
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 11:54:42 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51F682081B6
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 11:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719914078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QxovMaYxD13vuYDdzcCT0nHSwCjr+Ja4FwUJEohz9oU=;
 b=QdhFV8+MwJ7QFUiutZ99W2CfqXTeCPSVUW0IwYiNoho4z5or/zfAATWKz/OMvge4m54oet
 7Fnn6zUwCfPyHpWfqkAocYrFDuPL0mazGJ7QR/WYFoN73hkCTR+OMDBOuCmeWhQQWxZt1r
 aArNj4rw1MD6ZEPSj5rOLmgeTov5Rgg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-P88wv1zWON6O6edEY-X60Q-1; Tue, 02 Jul 2024 05:54:32 -0400
X-MC-Unique: P88wv1zWON6O6edEY-X60Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7a8fa8013so3679690a91.2
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 02:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719914071; x=1720518871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QxovMaYxD13vuYDdzcCT0nHSwCjr+Ja4FwUJEohz9oU=;
 b=L32ZaS6mJcX+fJaSuImfgYA+zSyYXQU6BvslWguxCVAECOh4uW1DTrdJ3m208qmmz0
 gqpM7rseJxePmAZ5xsNCyklOUQU59Su5+ZNucDlfoM9bzUQZsqp4VofIcXArpmDuS2JJ
 JyEeByayzJqhFFlOvqHh62ZCuKDHkfmpfNfNT1SC/fGMOKKBdR4m0c0PFHMUMQvStqE7
 4hp4/sA/y7Nac3rhEiT5oKhutYzHOenuIKnM1ssRpK8J1LKFvJcj8ozwA2s3WYv741CH
 JcjNAUXrgYBAbqqAJUq/ao6iX+5HQRDzW7sWEydelYWWjrNHLQvNYZL21qevWrmMPPPj
 Ratw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOgoq2trKeTeTZzF3pzPIg71OiNqwLcU7B14KVfMfm39elyoQuuZbTDm0J5qthlfLGqYGGqAEGgdM5o7ngK3tTgJY=
X-Gm-Message-State: AOJu0Yz15HOSpW3we5zXv9inX6zXHxHX/7nNfJMqg7LTiIlBB+MbOHmO
 s6+PVxYnskB9/phe/42wYrX7S86Ag0lchGCcIEvZdNwAvij1nS6jgDyAkfh26TUapwHP9spdVW+
 ACYolBh97Bz6Bh2VaRxpNUtPRSso9/5YD9/V+hpE9FkxwuNhsq/4gmJ53AmW1mwmEhkKAgAFejx
 GPsHb3vtxY8RgnbNIMFgDDsQQ=
X-Received: by 2002:a17:90a:b112:b0:2c4:b32f:4fd2 with SMTP id
 98e67ed59e1d1-2c93d714e83mr6229940a91.29.1719914070948; 
 Tue, 02 Jul 2024 02:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk0G06NiARGPrqD2F5DvJGvPPuAbxNddLhj3o9HUrI4hj9UAc7nl4CNWAdmDnLD3mPSar6n6+r6WPxtB0v/Us=
X-Received: by 2002:a17:90a:b112:b0:2c4:b32f:4fd2 with SMTP id
 98e67ed59e1d1-2c93d714e83mr6229930a91.29.1719914070456; Tue, 02 Jul 2024
 02:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-5-58e9af649a72@suse.com>
 <CAEemH2esa-BzXw5nqQRiR+Gq05YpFKUMnZmxoix3tqCcwXTqbQ@mail.gmail.com>
 <CAEemH2ffXRAgdWm1UZhU6E7zhaHU7qX9w3Rgox2DzD=1FUA+rw@mail.gmail.com>
 <d6278557-4839-4c8b-8056-3e2b1201f60b@suse.com>
In-Reply-To: <d6278557-4839-4c8b-8056-3e2b1201f60b@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Jul 2024 17:54:17 +0800
Message-ID: <CAEemH2egCksmZ1+Y4j-DPV2eqWwK4mPokyr2QbMKV56BU3t+kg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 05/10] Add landlock01 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Andrea Cervesato <andrea.cervesato@suse.com> wrote:


> +static void setup(void)
>>> +{
>>> +       verify_landlock_is_enabled();
>>> +
>>> +       rule_size = sizeof(struct landlock_ruleset_attr);
>>> +
>>> +       rule_small_size = rule_size - 1;
>>>
>>
>> Here minus 1 is not enough, we have to decrease more than 8
>> otherwise it just returns ENOMSG.
>>
>>     landlock01.c:49: TFAIL: Size is too small expected EINVAL: ENOMSG (42)
>>
>>   rule_small_size = rule_size - 9;
>>
>> or, we use a small enough type:
>>
>>   rule_small_size = sizeof(int);
>>
>> my test kernel is 6.9.6-200.fc40.x86_64.
>>
>> I haven't figured out that's why, but maybe inside the
>> landlock_create_ruleset()
>> syscall compare the size unprecisely. Something like invoke the
>> copy_min_struct_from_user.
>>
>> 199         err = copy_min_struct_from_user(&ruleset_attr,
>> sizeof(ruleset_attr),
>> 200
>> offsetofend(typeof(ruleset_attr),
>> 201                                          handled_access_fs),
>> 202                                          attr, size);
>>
>> ...
>>
>> 32 #define offsetofend(TYPE, MEMBER) \
>>  33         (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>>
>> This needs more investigation...
>>
>
> I guess I found the reason, kernel commit fff69fb03dde1df introducing a new
> field 'handled_access_net' in the structure, but in the
> landlock_create_ruleset(),
> it still uses the first field 'handled_access_fs' to count min size, so
> that why
> decrease 1 is useless in your test.
>
> I will send out a RFC patch to LKML for that. Thanks!
>
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -198,7 +198,7 @@ SYSCALL_DEFINE3(landlock_create_ruleset,
>         /* Copies raw user space buffer. */
>         err = copy_min_struct_from_user(&ruleset_attr,
> sizeof(ruleset_attr),
>                                         offsetofend(typeof(ruleset_attr),
> -                                                   handled_access_fs),
> +                                                   handled_access_net),
>                                         attr, size);
>         if (err)
>                 return err;
>
>>
>
> --
> Regards,
> Li Wang
>
> First of all, thanks for the review. Super for the bug in the landlock
> code.
>
No problem, but that's maybe on purpose set only one field for
the structure's minimal size, if so, we have to adjust your testcase
to decrese 9.

Let's see what the author thinks about my proposal patch[1].

[1] https://lists.linux.it/pipermail/ltp/2024-July/039073.html


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
