Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BE1C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:29:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E74B3CC8A3
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:29:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B58B3C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:29:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2B42200C6E
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:29:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669372179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qh9hwl+4nuL9uU8jtafGaSf95AQy8oBMVOOX8qu+w3E=;
 b=d3PMtHzqe39oZfggqsypgO3Zlte37EJW7nknhGUkk1rDsGkY7chGYZ4p4+AyNBzuzyk99b
 RgvkIvuuboCJjXD2J0ksg91sMrqxOuc3j/5Z7S9V8MJ6b8B+kLCsO0WRPMpRpNwQSkwn54
 u9Uih+7KdYs5qXjp2L+emmUtZlkKTQQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-27-xWfqMr1gNRmWOrSbUxVXfg-1; Fri, 25 Nov 2022 05:29:37 -0500
X-MC-Unique: xWfqMr1gNRmWOrSbUxVXfg-1
Received: by mail-wm1-f72.google.com with SMTP id
 8-20020a05600c228800b003d0376e42deso1642480wmf.4
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 02:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qh9hwl+4nuL9uU8jtafGaSf95AQy8oBMVOOX8qu+w3E=;
 b=bJgGUJSkEWmm5CsH8Ho8Fs8DNPTofTfh/e44/vbZlxiFCxP33eg5p5nbEJjdQwF8io
 Ied34Vw2qtzD28x9NOCrIsMOzuGDqqmxBUHXvKJxsNaQ2GqrAlOVcJClpkBDBuSW/an2
 fJCBJqrXIC5PRurhyEoDdP0kU+XO3xBKWhIM8cB5KgpmWtJ8Ei9+AYrSEOj2u36u/YkT
 Rwe3EHcet1yj7JHJdOOMDNgU+zQmLqFpFawPwDMZdbnXwwPhBm8tid99g6e/IeALS6xk
 u+WSOh9iS6UiWu838LrId2aRfU7GCBoBeb1nIci+qVPVMd1DfegdEI0kqIdcliMUJ6wu
 nVDA==
X-Gm-Message-State: ANoB5pnDR9sYahgGRdgu5Fqo9IGGDmIbnCgwDBXLZqLz8JWyh3LlKXj0
 n/L/qUOAeUcECATIIYfdi7YNSSqYS2wN4SmFTtjOpoPSqtBELH2SpLodbhQEmYrEYiJRud0yFgL
 BTB+9iOPLjWI=
X-Received: by 2002:adf:f504:0:b0:241:fcf8:be17 with SMTP id
 q4-20020adff504000000b00241fcf8be17mr4392300wro.629.1669372176550; 
 Fri, 25 Nov 2022 02:29:36 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5eGfNFOhempGoKJ8axQyKs+Mi1K7MOp1MmmL/m2rtn5N1bN/IDsYrEC9F6VeNyxmuXRTBbMw==
X-Received: by 2002:adf:f504:0:b0:241:fcf8:be17 with SMTP id
 q4-20020adff504000000b00241fcf8be17mr4392281wro.629.1669372176277; 
 Fri, 25 Nov 2022 02:29:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08?
 (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de.
 [2003:cb:c704:d800:887:cbec:f31f:a08])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a5d494c000000b00241b6d27ef1sm3320403wrs.104.2022.11.25.02.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 02:29:35 -0800 (PST)
Message-ID: <79125e1d-760f-432f-1814-502521347680@redhat.com>
Date: Fri, 25 Nov 2022 11:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Martin Doucha <mdoucha@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz> <Y4CTrrCb4jtQay9y@pevik>
 <da91a3a8-4609-c128-1c73-8b35dfb2b7c9@redhat.com>
 <af63ed9a-7108-fd19-fe2c-4b56be85d068@suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <af63ed9a-7108-fd19-fe2c-4b56be85d068@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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

On 25.11.22 11:25, Martin Doucha wrote:
> On 25. 11. 22 11:20, David Hildenbrand wrote:
>> See my other mail, it's the case on all instances that pass NULL (and I
>> don't really see the need to do this when working with NULL.
> 
> NULL may be defined as simple integer 0. When int is 32bit and pointers
> 64bit, this will cause trouble in variadic functions such as execlp().
> You do not need to remind us that LTP tests have lots of bugs, we know.

I can send a fixup patch for all these instances.

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
