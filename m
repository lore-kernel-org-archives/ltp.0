Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8DCC87FCD
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 07:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753430014; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=bC4oZvRJvb3oin1fTk+MIo51SiWtlL3dpEat4HpPITA=;
 b=K6rL9qaye2OA1/PS9PPLNe+WCnPEto2NWP6ssaKYDA9joU7R4wbvEfk9XsEXPY2kME1pK
 up6YkS/BQatJjSSC4bwiKnanbGazptm5NUUoGdooIHwInNpJn9AONTd0TYsSTbyQXWBDE4r
 osg+h/50rMTTwfb4Bj2eJbHrYDNsi7w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6630E3CCE4C
	for <ltp@archiver.kernel.org>; Fri, 25 Jul 2025 09:53:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C6EA3C1E21
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 09:53:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 94CE8600A09
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 09:53:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753429989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7pmMRjtVnlUbU72RfxjapYM6b2rd81v8fmyYrnv1ZQc=;
 b=GIIoI9ODXUKCC6nM9TE/o8KZItOH633KYTvibuF7elrRQc1GvYfncXUaOtlVyH7HYZ2T+U
 b0qDGZ/LjaO6gqf9MsXZhD3/+GoCIJRYvY7xa69gkLF6+uY6eE5sh2MijsjKrwPvPxry9c
 SYOsBGc5DKVxvlzclkUXafEhmoBrhbc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-Kpl94MquOUm-xRqIAiLyAA-1; Fri, 25 Jul 2025 03:53:06 -0400
X-MC-Unique: Kpl94MquOUm-xRqIAiLyAA-1
X-Mimecast-MFC-AGG-ID: Kpl94MquOUm-xRqIAiLyAA_1753429986
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3138e65efe2so1637928a91.1
 for <ltp@lists.linux.it>; Fri, 25 Jul 2025 00:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753429986; x=1754034786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7pmMRjtVnlUbU72RfxjapYM6b2rd81v8fmyYrnv1ZQc=;
 b=VJ9xl3Ji1aRlDabDwQyVmhT3isepe0OnxpRgIyBhUDYtnrzdAWl4UnRuiFGPPiLprD
 vT/cGZsz7vAyCAs4erhJWujTIP3P+zoSufD3lqGWJSGjbDqj0o4f+63GN2JXdt6jbdaJ
 GOsNB4mJ/jEKc+2V97Ur7mKzCnS2O7juNH6A+hE1vGCyYauc6jGtJhiHypqZWDjwp3mR
 3o+SQjSZHjG7kg2zYqA/hMXdSu69+ZCt6Maz7mCM3lOvmDvO2SShYw9GUGiotdYloxyj
 HKiY/IsHR7ILDRX51NJuPtYGPuAoNnVfr1sGPLxdY+tZHDRmkR3G2J5iH+n7J5ajTGk1
 Oo/w==
X-Gm-Message-State: AOJu0YwtfDzRGuIlL7gqPLz4/rJhiGKe/qSAc7m654ZpN5RO4NFUKJun
 lYA/8zwjrFywa9auxWpQHPP1tQ8OfQ7D34vASjI05VOvbGaO/3XiUqI81Tc9wNB/jky4XAnrI52
 rvUGnyseuhdEOtd5B/ybCOjmJh87pcerxb4o2Emb0WAluo+0KAGSHZRgQXJ5SiqhZ/rjw0EhtBj
 Iu5axaMo1xdd7gIbJAFRFndpnkoTI=
X-Gm-Gg: ASbGncvIGMb7C7xpTkj3+d2UR5Yr5U4wKtHUYlVwK1CWwH+ZtXMflto40KJXkWZF8i9
 GkRtmx0qa6xjV2WKVh5I4yjgCYt2mob9t4F5a+cv7s9cgm251jzEH/4hXj8t+vNoBV01d6UyAKq
 Ha6xv+PL4jxdRr9yQ1lITnhw==
X-Received: by 2002:a17:90b:3b4a:b0:31e:761b:48f5 with SMTP id
 98e67ed59e1d1-31e77a027c3mr1225879a91.26.1753429985795; 
 Fri, 25 Jul 2025 00:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPN2qBA4AtWUrWcQJ3ZJYYlRUqHrJ/2WDDIKUFLVLInpNHzbGw/Wo1TWggAguBcV00d8sh96BCT2ImTHHBNZA=
X-Received: by 2002:a17:90b:3b4a:b0:31e:761b:48f5 with SMTP id
 98e67ed59e1d1-31e77a027c3mr1225842a91.26.1753429985390; Fri, 25 Jul 2025
 00:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250724170003.479248-1-pvorel@suse.cz>
In-Reply-To: <20250724170003.479248-1-pvorel@suse.cz>
Date: Fri, 25 Jul 2025 15:52:53 +0800
X-Gm-Features: Ac12FXzRUYETX0KY_DH0D0VsRYPg_V4VnpBEyRe3BYL8sFftF3mye5Y6xy9AyVE
Message-ID: <CAEemH2c7U5AAwyK43n4tkot1T11RHj=4pm+m_ORL_P3xe2TWvQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jIDVm0nYifS-N5tu18E8RlMU23gYw-AF-tgPTXywg9E_1753429986
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] fsconfig03: Quit on first error
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdWwgMjUsIDIwMjUgYXQgMTowMOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gVGVzdCBydW5zIGluIGxvb3AgNTAwMHgsIGlmIGl0IGZhaWxzLCBpdCBw
b2xsdXRlcyBvdXRwdXQgYSBsb3QuCj4KPiBDdXJyZW50bHkgYmNhY2hlZnMgZmFpbHMgNDg4M3g6
Cj4gZnNjb25maWcwMy5jOjUzOiBURkFJTDogZnNjb25maWcoKSBwYXNzZWQgdW5leHBlY3RlZGx5
Cj4KPiBTa2lwIHdpdGggZ290byB0byBrZWVwIGNoZWNrIGZvciBhIHRhaW50IGZsYWdzLgo+Cj4g
U2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5
OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tLQo+IEhpIGFsbCwKPgo+IG9yIGRvIHdl
IHdhbnQgdG8gcXVpdCBhZnRlciBtb3JlIGVycm9ycywgZS5nLiAxMHg/Cj4KCk1heWJlIG5vdCBu
ZWVkZWQsIG9uY2UgZmFpbHVyZSBpbiB0aGUgbG9vcHMgc2hvdWxkIGJlIGNsZWFybHkgdmlzaWJs
ZS4KCgoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mc2NvbmZpZy9mc2NvbmZpZzAzLmMgfCAzICsrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
c2NvbmZpZy9mc2NvbmZpZzAzLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNjb25m
aWcvZnNjb25maWcwMy5jCj4gaW5kZXggYWRkNTQ3NjllMC4uOTg1Mjc4OTg2YSAxMDA2NDQKPiAt
LS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzY29uZmlnL2ZzY29uZmlnMDMuYwo+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNjb25maWcvZnNjb25maWcwMy5jCj4gQEAg
LTUxLDE1ICs1MSwxOCBAQCBzdGF0aWMgdm9pZCBydW4odm9pZCkKPgo+ICAgICAgICAgICAgICAg
ICBpZiAoIVRTVF9SRVQpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfcmVzKFRGQUlM
LCAiZnNjb25maWcoKSBwYXNzZWQgdW5leHBlY3RlZGx5Iik7Cj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBjbGVhbnVwOwo+ICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKFRTVF9SRVQg
IT0gLTEpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LIHwgVFRFUlJO
TywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJJbnZhbGlkIGZzY29uZmlnKCkg
cmV0dXJuIHZhbHVlICVsZCIsCj4gVFNUX1JFVCk7Cj4gICAgICAgICAgICAgICAgIH0gZWxzZSBp
ZiAoVFNUX0VSUiAhPSBFSU5WQUwpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfcmVz
KFRGQUlMIHwgVFRFUlJOTywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmc2Nv
bmZpZygpIGZhaWxlZCB3aXRoIHVuZXhwZWN0ZWQgZXJyb3IiKTsKPiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGNsZWFudXA7Cj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPgo+
ICtjbGVhbnVwOgo+ICAgICAgICAgaWYgKGZkICE9IC0xKQo+ICAgICAgICAgICAgICAgICBTQUZF
X0NMT1NFKGZkKTsKPgo+IC0tCj4gMi41MC4xCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
