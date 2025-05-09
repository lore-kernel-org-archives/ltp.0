Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2080C3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746792045; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ajtHtl6yTPjdMk+zuwjoD2Jv3qsUZ+b2uHYWEfQM4AM=;
 b=PoC4GPd+vmG0JmOu8gfFHZdpQJMMldcfmJwo7MHMEYc8ZfKDUhP6O0GmyA6ZhUUqM6wxE
 49+aGpiYtuVLHIyLuV5P8926mJzAUmylRaf9vWn7TRNPcPHqi7boOWTZeRXtfhtpH2jYKAE
 nTmeoumePJeK3/LfBcx5Pc40TVjHoxc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 019DD3CC1FD
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 14:00:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23AC53CB1C2
 for <ltp@lists.linux.it>; Fri,  9 May 2025 14:00:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5B3E2200924
 for <ltp@lists.linux.it>; Fri,  9 May 2025 14:00:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746792020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=83Y6VWe6oRCTxuX1sM8MBXY1sd5FR2e3eeOBXPzWdWk=;
 b=Vn+Y8VBY8tfkBVYgdCNcj2zrtXEcfx5x84g+Hn5XAwARy/JZREUAyrge5Xb3FxVfu6wXju
 7jJ4WHWJr3mv/mcjN5/SMxGM++qCXxBxu0jpQo6s8JvBIvBdDnLZpNLPM8N4MjIlSNKOfT
 8ANzGx4zZiLQbDwmuY56agxlcf3H13Q=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-YcH1kUR2No6TKWOiM1rNlQ-1; Fri, 09 May 2025 08:00:18 -0400
X-MC-Unique: YcH1kUR2No6TKWOiM1rNlQ-1
X-Mimecast-MFC-AGG-ID: YcH1kUR2No6TKWOiM1rNlQ_1746792017
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22e50a45d73so21039645ad.3
 for <ltp@lists.linux.it>; Fri, 09 May 2025 05:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746792016; x=1747396816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=83Y6VWe6oRCTxuX1sM8MBXY1sd5FR2e3eeOBXPzWdWk=;
 b=Ag32KJqKFXwvJuReegUSpQrv3MjmTdYa3cpjw+zbsDEZXlqeTw0Vo1V/8WZ4ZEQglA
 ryzO2eoeKEgbERRtHhi0El1+LK/Uh5/DCInE6t/RhuMnD6HSJhpSZxWBhfiSOobyn9by
 AI0lMCiSh5kBhAoyIo66uyNjsAvptEhYkfglPpg9hrklMXrToNEwz67IoEDz4sX0/KrL
 U8iSnd/ky5yfoDzgLJynkllivoyhTK0hXhxfd/UopBK+p8W464DJwIY953+wuAmEpuv5
 6y3BtZkzw6rid/Gh1h9I5LjqZj76Yj5jqyWJV+tyNpSJAEXgSjd71M77wbby/3dM3G4M
 Jf7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6hVm0ip4p6iarfTi0AQbf2D0FHABiraygFL6GMOWvsDhJ7Wj7BVIWy/YItoxIR9CC7BY=@lists.linux.it
X-Gm-Message-State: AOJu0YxCvS+2K5hl+2rf2tHl/cLTC2hFq2aXo328tcvOMUNJt8phTxiL
 YNyHW38JYMbP6EqWNwdhILHH+NiKGSh4BrhoCBQNiZbPR3AAQUNvtsTKhcFm3P8hRVMKQVfBj+S
 GZwmwd3GRWxa8egif275LDALR1apmKNa3iNyBNyzOddXk9j67OpQ47GAqazQrkKG8UV2+qAJktn
 Asv449SBGlCUqFzg6pJAw+lzx+ijb4zdkIaQ==
X-Gm-Gg: ASbGnctrS6yGFvz7ChPSwa4qoHMZUxsT0ePe+qYDY1WM+1DYLAOw4mepPzudmVwdISq
 Wux5Eg1fu9j1Y3qE5u+J8G4Yt5iQSIeHpEOkaxmnLZRYLrp2OgrABeZCgJEL2+r4Mm0AB2w==
X-Received: by 2002:a17:902:e804:b0:21f:6fb9:9299 with SMTP id
 d9443c01a7336-22fc8b591aamr41871105ad.27.1746792015798; 
 Fri, 09 May 2025 05:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ1F3Wfthll9SPARHIBJRwBO6cCcUH7RhK3QZRUrWWr01xmvCc73SzRfF8gFvihkFDViO4VGOCQREWpvjj/2Q=
X-Received: by 2002:a17:902:e804:b0:21f:6fb9:9299 with SMTP id
 d9443c01a7336-22fc8b591aamr41870475ad.27.1746792015113; Fri, 09 May 2025
 05:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250507154543.22309-1-mdoucha@suse.cz>
 <20250507175328.GA182617@pevik>
 <CAEemH2d1Ae6r_7N2V2KBm0pb0wxedWMxwKkN4nnub19-P5YTEQ@mail.gmail.com>
 <1f0c4c30-6258-4ece-8bb2-881165f06317@suse.cz>
In-Reply-To: <1f0c4c30-6258-4ece-8bb2-881165f06317@suse.cz>
Date: Fri, 9 May 2025 20:00:02 +0800
X-Gm-Features: AX0GCFtQF0hxEuq7qMPBHQLgGOELSo5ikGBwyYTX93C_uk0nr9BgaiNPepdsA6U
Message-ID: <CAEemH2cHzcCBED=mMjr46yHrsoiSaxgnR1bbHvY8Bz7e8J54Uw@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rUWoajIxRsTDQfZAyWl5asqRD_PwCkZHevXcUqJsTe8_1746792017
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap_24-1: Change vm.max_map_count if needed
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Martin Doucha <mdoucha@suse.cz> wrote:

> On 09. 05. 25 6:03, Li Wang wrote:
> > There aremany ways toavoid OOM (e.g., overcommit_memory, oom_score_adj,
> > ulimit, etc.). However, the purpose of the mmap_24-1.c test is to
> > exhaust thevirtual
> > address space and trigger ENOMEM.
> >
> > Limiting vm.max_map_count may prevent OOM, but it changes the failure
> > cause to
> > hitting themap count limit, not actual address space exhaustion, which
> > might be away
> > from thetest's intent.
> >
> > Iguess using setrlimit(RLIMIT_AS, ...) is more appropriate here, as it
> > enforces address
> > space limits while preserving the original test goal.
>
> 64bit address space is so large that exhausting it requires 512+GB of
> page table structures alone (for the 48bit variant). And kernel will not
> return ENOMEM when it runs out of free memory for pagetable structures,
> it'll trigger OOM.

Indeed.

>
> The mmap_24-1 test started failing after the default vm.max_map_count
> increased in one of our tested product so this is the limit we want to

That suggests the issue is actually due to the process reaching the
vm.max_map_count limit, which results in ENOMEM errors in your
regularly tested product.

Give the fact, I agree with you patch, it addresses the root cause effectively.
But I recommend updating the code comments to reflect that the failure
comes from exceeding the maximum number of memory mappings,
not overall memory exhaustion.


> change here. But you could copy the test and change RLIMIT_AS there.
> That would also be a valid test case.
>
> --
> Martin Doucha   mdoucha@suse.cz
> SW Quality Engineer
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
