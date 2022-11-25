Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107AAC4321E
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:40:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CB5D3CC884
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:40:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D5993C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:40:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A95F600C82
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669372843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YYc+p0T5E0PgfDvjZeiNmwnsHwl4S21JkFxYDGTjGOU=;
 b=cH8CNaLmrLRJybxY50GHKplm99bxsKh7Is7eY7kinimpmJTGuMegiyOCqcgi3ocJwA1LQq
 AeM2aswm0mi3yAlHJH+sfeWkYURaK1f0Z3S05zqSeN15ThKiqMo/+fIuqwCJSwQrahJ428
 iTYFgDfwB0VhSMcZCaFCUPBQr3kvrYo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-RlexSpviOhuZzb5FYSiXxg-1; Fri, 25 Nov 2022 05:40:42 -0500
X-MC-Unique: RlexSpviOhuZzb5FYSiXxg-1
Received: by mail-wm1-f71.google.com with SMTP id
 v188-20020a1cacc5000000b003cf76c4ae66so4005732wme.7
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 02:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YYc+p0T5E0PgfDvjZeiNmwnsHwl4S21JkFxYDGTjGOU=;
 b=48FSP9Tz7niRV2g13aGdyVlIbWnMtxNNW68udTvTzT1HqiFj7k+/BYFgaOHXVPWoyJ
 GF7Q9Jg1cpngnSH9MA4o4SzcVFnzTSMugdBjHickmHx6V7da66nV7N3I/vS8pK4zt1V1
 HD4lkY7ydc37+fronvGsS3CWHKlLdUv+taim/x0uRsfwGrO++R+VweeGat/Zn1UNZXyX
 3cvkI+oIs1LCPNI1bUUjoK5iUbgKes0SzC3zxgqWwH1ij1DvD21vBJpmQyHxNBzpunK9
 CIF3Y4Kv3FiggnQ+y6Cfx3klj2moqyObnynN9XztBVwyCqXbAhq0ABfFvMixT6xDfZuc
 2o6Q==
X-Gm-Message-State: ANoB5pkotG4FPKm4jKnv/7QPcf59N8bszd/o+Gf6lNizHdTBt3ZLEomy
 vb3gc5svyBFQtxBr7g6GTAWab0cv7pSh2n+yuDg2kLSWDIysWM2Xj4NBP+1TkVEteA84nn0f2QK
 h9lVirUsBJrg=
X-Received: by 2002:a05:600c:21c8:b0:3c6:d9f0:9534 with SMTP id
 x8-20020a05600c21c800b003c6d9f09534mr12980734wmj.101.1669372841142; 
 Fri, 25 Nov 2022 02:40:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6HGxwrm4uKQDR+XuOiwfTKgAB5aSdERypbnmqnbqjBTBmjrWJUAhfBzoJxtKmvQfNaQybrwQ==
X-Received: by 2002:a05:600c:21c8:b0:3c6:d9f0:9534 with SMTP id
 x8-20020a05600c21c800b003c6d9f09534mr12980713wmj.101.1669372840849; 
 Fri, 25 Nov 2022 02:40:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08?
 (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de.
 [2003:cb:c704:d800:887:cbec:f31f:a08])
 by smtp.gmail.com with ESMTPSA id
 bg3-20020a05600c3c8300b003c71358a42dsm11831015wmb.18.2022.11.25.02.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 02:40:40 -0800 (PST)
Message-ID: <b93b851d-f99a-f16f-be95-8f8be31ee4f3@redhat.com>
Date: Fri, 25 Nov 2022 11:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Petr Vorel <pvorel@suse.cz>, Martin Doucha <mdoucha@suse.cz>
References: <20221123103547.54246-1-david@redhat.com>
 <30abc28c-be3c-0f9e-0c2e-6614fdd30e0c@suse.cz> <Y4CbVZ3MKmjG9x96@pevik>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4CbVZ3MKmjG9x96@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

On 25.11.22 11:39, Petr Vorel wrote:
> Hi Martin, David,
> 
>> On 23. 11. 22 11:35, David Hildenbrand wrote:
>>> +	uffdio_api.api = UFFD_API;
>>> +	uffdio_api.features = UFFD_FEATURE_MINOR_SHMEM;
>>> +	TEST(ioctl(uffd, UFFDIO_API, &uffdio_api));
>>> +	if (TST_RET < 0) {
> 
>> One more thing, checking just the ioctl() return value here is not enough.
>> You need to check that uffdio_api.features still includes the
>> UFFD_FEATURE_MINOR_SHMEM flag after the call. PPC64 does not seem to support
>> it on kernel 5.14 and the ioctl() still succeeds there.
> Very good catch, thanks!
> 
> David, please send official patch (speedups merging). Thanks a lot!

Interesting, thanks for testing! Will fix that as well and send a 
combined patch.

-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
