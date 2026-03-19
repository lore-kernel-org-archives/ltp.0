Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D41D1088E72
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773892504; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GRdkPvkrdkKoaxA7//fbJQSgT7TPdTyMZjFP3XhlTGQ=;
 b=nODR8tqezLrs5Mj422qBNS99uAyHPk6b1BngWh16xaJ8rpJpwzIS4Fh7dCYIN+v8f+ioL
 ec1dHNeZ7adF6E2mEcRFazLFNcMJfU4EK0PjQzO6NbnQdTvR02vgA+IG+UE3IJW7Tt+8xv/
 /Rt8BgQtMeqfdmFNq80gpZbIVuYdYsU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 436613CAFD3
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 04:55:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 229EE3CAFD3
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 04:54:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA53B1400DA9
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 04:54:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773892478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wrtwcwgALKKM4jvOqC0QV88p9JiiRCnTmuX5r+xqSfk=;
 b=Cnl3vAjK4M2mNV5rjqdiD1gf40eVzuSoSgucTmRy90yfDVJPhd9foO7mDk6zPl8lzQfZQo
 N77j3loB1nwLjwwpe2HGLPMlw4MOFSLD2P5PLt5eGZuEREbrBgrAnCm7gtap+CX/z2yFmF
 aEhMWxKT+kyN5NwGeWyfj37ZzdfgKv4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-8tP17xyxP8-3FQdY3i7www-1; Wed, 18 Mar 2026 23:54:36 -0400
X-MC-Unique: 8tP17xyxP8-3FQdY3i7www-1
X-Mimecast-MFC-AGG-ID: 8tP17xyxP8-3FQdY3i7www_1773892476
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8297d261a67so328086b3a.0
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 20:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773892476; x=1774497276;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wrtwcwgALKKM4jvOqC0QV88p9JiiRCnTmuX5r+xqSfk=;
 b=fnJbBF88/lhRkYOg83Baor7J7KOtuN2j00Yw906r6NRdUdUuTYaEBSv7eMXB0wbbaz
 /pyNHypfnDvgppBmB2UPjbu/TzGYuOgROiPuQOAhJuMt0aWsxx/MPouPQQ39HEmHF2Rz
 NGLBNIJWdjKa8GpN/etPUUzztU9vqrbXgTyEUBGw3C+ppQJ8BuiUAurzeYdrcSHtksg1
 YRaxh39Hake3N44r1LFRXp7owf+kCJ/QU/hizDmjE/LgrxusWgK40PN9hJ2oW8ZwiBLF
 /Hgyalr3zq9ZK926fKbb0gFTlYndaMFZ8CDGqOYqngxDcuxRzsLBD2hxVq8aX64XXyiL
 tHkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtXPM3tHxW6E1VbD9beX1X8GpSARruTn87GWbrxp4h2trCY2DUUKP7bFxIBk9ihhFlyXQ=@lists.linux.it
X-Gm-Message-State: AOJu0YyribmzeBr0Q7TwX7gD10N45FuecvQfKoHw11k6T5q1HlhWRbHu
 ocj6DExHpnU5wF1/cMyjE+ljGcZluctAOOAawd3svlAcMESEhAN6wJGGm8rI52F3Lbn17Gj+ZT1
 bg2bMSqW6Z1OY7unfzsAu1gtyKUloXLelbSnQtZyJOnRd0vJm+aGk
X-Gm-Gg: ATEYQzzFKH6p+q2DqVh1tQhfJ+LLFyWze4/G/L/h+pD02QwHhzx7sK2EFSlBkgDf7vV
 4ZdiAzDxpYMAZGaGzIfb1e3YyHRSWHCROV6KPRMj9n82XRUV5PS8vRmdvJHQkxYpnaDwZWJ+Z+B
 hKeDKzWEEiBUUNYuHOU4BvNq5dUtLRn/V+xHEzbzuZytKmay9fdtSPOyFtFkyo/CGMX3IHCqJB/
 3wXHWgj5yTCFm9z4cweCJjFzsAPlTe8UWBsEDFO01jWv6sHd0yxu6gg+oSpm4le/FC/iDqq8zuK
 HD8jgfJ9AeIA3/VgfjMi0fyfjLMcbD7iuXiGxZU6D9K4ec1qhDWmUKBZAa6J4Ln4eflHkzmL7zF
 yPutP+f3mmdcyj8wnWA==
X-Received: by 2002:a05:6a00:811:b0:829:9f46:280d with SMTP id
 d2e1a72fcca58-82a6ac11434mr5429781b3a.1.1773892475766; 
 Wed, 18 Mar 2026 20:54:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:811:b0:829:9f46:280d with SMTP id
 d2e1a72fcca58-82a6ac11434mr5429760b3a.1.1773892475217; 
 Wed, 18 Mar 2026 20:54:35 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6b541cafsm4476836b3a.12.2026.03.18.20.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 20:54:34 -0700 (PDT)
Date: Thu, 19 Mar 2026 11:54:32 +0800
To: Chris Wailes <chriswailes@google.com>
Message-ID: <abtzeEghSKbrVf38@redhat.com>
References: <CAKfqHepUCKimv1xXxsAWw3bZRg=6VWBh7yyWOi=zuNaM5d9Eww@mail.gmail.com>
 <DEZNCTGEXSY9.1RY75URI3UEQW@suse.com>
 <CAKfqHeptLHymCgRyyUZ64UXoexoPEFsNHxSLa=aME9=U+dBywA@mail.gmail.com>
 <7d12c14f-4654-4248-b478-f57d721aba9a@suse.com>
 <CAEemH2fxanCLLMaMZRporvMXxdg0LKjO07_4suHgcFYxGQGCPQ@mail.gmail.com>
 <CAKfqHert2XNHQ12ai3r7joZYwTcV2DkbW7jFu7HqB07ZncQr+w@mail.gmail.com>
 <CAKfqHeonbt5n6d4GoWbmcqfAXpBdCsUNH0wbdzd1N65_+KHWiw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKfqHeonbt5n6d4GoWbmcqfAXpBdCsUNH0wbdzd1N65_+KHWiw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z0KIi59xhVzziySclKuDJQXSFLPLMbh0WIiFeTIgJy8_1773892476
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Update clone3 wrapper signature
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
Cc: chrubis@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBXb3VsZCBpdCBiZSBiZXR0ZXIvZWFzaWVyIGZvciBtZSB0byBzdWJtaXQgdGhpcyB0aHJvdWdo
IEdpdEh1Yj8KClRoZSBwYXRjaCBnZW5lcmFsbHkgbG9va3MgZ29vZC4KCldlIHByZWZlciB0byBy
ZXZpZXcgcGF0Y2ggaW4gbWFpbGluZyBsaXN0LiBDb3VsZCB5b3UgdHJ5IHRvIHJlc2VuZAppdCB2
aWEgdGhlIGZvbGxvd2luZyBjb21tYW5kcz8KCsKgIyBzdWRvIGRuZiBpbnN0YWxsIGdpdC1lbWFp
bAoKIC4uLiBkbyBzb21lIGxvY2FsIGNvbmZpZ3VyZSAuLi4KCsKgIyBnaXQgZm9ybWF0LXBhdGNo
IC0xCsKgIyBnaXQgc2VuZC1lbWFpbCAwMDAxLXh4IC0tdG8gbHRwQGxpc3RzLmxpbnV4Lml0Cgot
LSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
