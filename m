Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AE1D31765
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 16:42:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 006AD3D298B
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 17:42:31 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED9993D297C
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 17:42:14 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 404D023E4DD
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 17:42:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730824932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cx1m4Aizyh3iLepNViQHsM1b4RN5/yi5KFX8sDG/nkc=;
 b=FHgQ7Z3w9m68iglzoDF8Q4AhJKdAGObOleKKxKN4KNYPzWP2/UQQaivhT6H2EMuHe5GvCb
 DYtsy+c6nu8SmaHtGZ294OtmGVvE+HNyJ/eslgATnJUEeCwkO0qrqkkWYpT7MtGif7w5e7
 77mSvamUOxDkQcFYpjeVwAR0GlPez5s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-I7O2u21rMXGJ2MZfeqf8QQ-1; Tue, 05 Nov 2024 11:42:11 -0500
X-MC-Unique: I7O2u21rMXGJ2MZfeqf8QQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso39025295e9.3
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 08:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730824930; x=1731429730;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cx1m4Aizyh3iLepNViQHsM1b4RN5/yi5KFX8sDG/nkc=;
 b=niaXYB1bFjnvRmlHnm/c0G+EIbDNplzDRkwvKqBP+V5DntA74BDWW8Fqs1RekgQgy3
 Fl3wH+0lmJC5FfDuz2qv5dD458bUpqYE448JXbXoxnUwxswMBtsBUaHSFwaMRBUVIFoh
 y4fx3MkCkgIWrY/lqWmb1ozBQG/2bGRhJXovg9qLAuYZ7zBRoB+93i6byuNsx/1ps3c/
 4fmgj0LEMN7xE33nkreqKrvz3La9oHPDdbdARlkdxJbGcbPc2a330fKN6femk4GmbgnU
 dv5h5HMqSEXDrt+dmK2lk2Vqh8cw2yhwplhBJ7kHqUNALKcyPEDzy89TVFA29hvq3MEg
 17Vg==
X-Gm-Message-State: AOJu0YxMIQmSkVRpb5pcCYcWDdfaa8NC7XMghA26oa3Q09p8+aX5Twn7
 ih77kOu3DKQB4qO0kM3UDhpI7Emti6chTihyePPYI7ktsJVdwt7mCuqpmjpT08EaLsvPbofCBkG
 l2UwyIxOJgFukksKJTvvzkcgZhWCxlpBpSGrWyrc1tI0GfFqR
X-Received: by 2002:a05:600c:1614:b0:431:44aa:ee2e with SMTP id
 5b1f17b1804b1-431aa7ff3acmr269247165e9.4.1730824930096; 
 Tue, 05 Nov 2024 08:42:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs2r/mh4+h+Q/L8saH0v5p1581c/EcnZzrP+mn5sr86FyvDFHftGqab6jFOrkFyf7O5Sjdpw==
X-Received: by 2002:a05:600c:1614:b0:431:44aa:ee2e with SMTP id
 5b1f17b1804b1-431aa7ff3acmr269247015e9.4.1730824929714; 
 Tue, 05 Nov 2024 08:42:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c73b:db00:b0d7:66ca:e3e9:6528?
 (p200300cbc73bdb00b0d766cae3e96528.dip0.t-ipconnect.de.
 [2003:cb:c73b:db00:b0d7:66ca:e3e9:6528])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7c08sm16681122f8f.17.2024.11.05.08.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2024 08:42:09 -0800 (PST)
Message-ID: <5667b9b5-c19e-4c00-8fa1-176ae7e1176d@redhat.com>
Date: Tue, 5 Nov 2024 17:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Avinesh Kumar <akumar@suse.de>
References: <20241104153404.21273-1-akumar@suse.de>
 <20241105104003.GA1573194@pevik>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241105104003.GA1573194@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] crypto/af_alg0[13]: update tests for additional
 possible errno case
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 05.11.24 11:40, Petr Vorel wrote:
> Hi Cyril, Jan, David,
> 
>> kernel behaviour wrt checking invalid algorithms has changed [1] [2]
>> updating the tests to address the additional errno case.
>> Related discussion on the mailing list [3]
> 
> Looking at 57ab2160c0 ("move_pages04: remove special-casing for kernels < 4.3") [4]
> recently reverting errnos for 4.3 d539a004dd ("move_pages04: fix zero page
> status code for kernels >= 4.3") [5] please double check this already merged
> change. I still believe it's a different case thus merging this is correct.
> Also Eric is suggesting this (I should have added Suggested-by: tag for him).
> 
> Maybe we need some rules to clarify when we are ok with different errno and when not.
> 

Right.

Regarding d539a004dd, we pretty much hid kernel bugs: behaving 
differently than expected+documented.

If the kernel starts reporting a different errno it might be a bug: user 
space might not be prepared to handle that. Or it might be expected, 
because nobody really cares about the exact error code.

So if a test starts failing, it's definitely concerning and needs a 
closer look.

> I also thought there would be some rule "don't hide kernel bugs", but I can't
> find it in the docs.

That rule makes sense to me.

-- 
Cheers,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
