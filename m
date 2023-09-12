Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017EECA0EC3
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 08:32:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 440A13CE7EF
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 10:32:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5414A3CB335
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 10:31:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EE40D6008BD
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 10:31:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694507512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aNYnbADE0cMG5nEbowx69+mfnkfLRi2r6kuW5Vth/Vo=;
 b=EbYMooQTqKyJMT5mmWmjcl7sKjwpFBe5dcpUTWFzTtFJ3U9oF229WAWEo1aFNbNXGW5RH+
 LPhL3y4zBAfgpWKq7Lb164FpESqmDxPiqfWyTStsBiUrlgvZKP4wU/38x1oMn9n3mP0PAV
 t/c9Tfd5kJxJ3y/6zx6j2my3xrnSrjM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-TrP4JLfxP_W4fQMYqKg8Ig-1; Tue, 12 Sep 2023 04:31:50 -0400
X-MC-Unique: TrP4JLfxP_W4fQMYqKg8Ig-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5029253c6f9so5661970e87.0
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 01:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694507508; x=1695112308;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aNYnbADE0cMG5nEbowx69+mfnkfLRi2r6kuW5Vth/Vo=;
 b=SqQTuGTTB83o3kS6jLwoSsWbuT42khQ+Dh28kUu1YA28hHz9lED0WIcyk2bU8uQxaV
 r6CDucM4lNEg1J/9KqaTd4rsd6QYhV9VabqzLRmHz8dDxyu2c8YsJIV0iwa16HE4s7GS
 j7zGLWKoK8wc/HG+iBoXOd9+81+c+Kn98Hh6Oeip7+4JMdML/T9JF6Mubr7hVnUP9tJo
 xqAFKvvz2RQVs3j0VGl87HdJa/VdltKuq5ZuiZ0gek1YyrSNZ2t8+a1LHne1s4sF9Mtj
 es+NoxH34VcIQC+XTbGsxjSmYKFchVWj871h93QxlDrMVz1eRKFLhIl//yHyh094mM7c
 sF4g==
X-Gm-Message-State: AOJu0YxCF2CJxw6DNb2akWM+2WT6H0Zqplghv7Oaxi5XsqbdEAxcUdNk
 51HPul1bwSNK9o318ZRAklI2eupOExw6kUMYl5v8hndhPV3F8RIMJ8TISxfh0rQdn3qq7TX22s7
 Z8/RLsfvAmy6CdBPcVcNswvw6lIg=
X-Received: by 2002:a05:6512:308e:b0:4ff:8f71:9713 with SMTP id
 z14-20020a056512308e00b004ff8f719713mr11875044lfd.42.1694507508694; 
 Tue, 12 Sep 2023 01:31:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOH+5ph9NB77CMCmI7+1OIeeNkR/QkxeIGa3/mPnowIpXSAB7qYYB1rT08wmAU/DmpMq2pY1qZCAgBQC11GVo=
X-Received: by 2002:a05:6512:308e:b0:4ff:8f71:9713 with SMTP id
 z14-20020a056512308e00b004ff8f719713mr11875027lfd.42.1694507508326; Tue, 12
 Sep 2023 01:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CADm5pWf=W7vAiLFt4Gx4qGC1qd6WgryUY299yBoFABdKHzec4w@mail.gmail.com>
In-Reply-To: <CADm5pWf=W7vAiLFt4Gx4qGC1qd6WgryUY299yBoFABdKHzec4w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Sep 2023 16:31:36 +0800
Message-ID: <CAEemH2dY3_hUkT_8FQnJomseMnaE67MWzzEHWndN-uByGYjxRw@mail.gmail.com>
To: Shizhao Chen <shichen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] numa01.sh: unset default cpuset awareness before
 verify physcpubind
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNzozMuKAr1BNIFNoaXpoYW8gQ2hlbiA8c2hpY2hlbkBy
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gc3lzdGVtcyB3aXRoIGNwdSBpc29sYXRpb24gY29uZmln
dXJlZCAoYSB2ZXJ5IGNvbW1vbiB0ZWNobmlxdWUgdXNlZCBpbgo+IHRoZQo+IHJlYWwgdGltZSBr
ZXJuZWwpLCAkcnVuX29uX2NwdSBtYXkgaGFwcGVuIHRvIGJlIGFuIGlzb2xhdGVkIGNvcmUgYW5k
IGhlbmNlCj4gdW5hY2Nlc3NpYmxlIHRvIG51bWFjdGwuCj4KPiBVbnNldCBkZWZhdWx0IGNwdXNl
dCBhd2FyZW5lc3Mgd2l0aCAtLWFsbCwgc28gbnVtYWN0bCBjYW4gdXNlIGFsbCBwb3NzaWJsZQo+
IENQVXMvbm9kZXMgZm9yIGZvbGxvd2luZyBwaHlzY3B1YmluZCBzZXR0aW5ncy4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFNoaXpoYW8gQ2hlbiA8c2hpY2hlbkByZWRoYXQuY29tPgo+CgpSZXZpZXdlZC1i
eTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwv
bnVtYS9udW1hMDEuc2ggfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbnVtYS9udW1h
MDEuc2gKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvbnVtYS9udW1hMDEuc2gKPiBpbmRleCAzNjc4MTNj
ZTkuLjAxODFjZDhmNSAxMDA3NTUKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL251bWEvbnVtYTAx
LnNoCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9udW1hL251bWEwMS5zaAo+IEBAIC0xODMsNyAr
MTgzLDcgQEAgdGVzdDQoKQo+ICAgICAgbm9fb2ZfY3B1cz0kKHRzdF9uY3B1cykKPiAgICAgICMg
bm90IHN1cmUgd2hldGhlciBjcHUncyBjYW4ndCBiZSBpbiBvZGQgbnVtYmVyCj4gICAgICBydW5f
b25fY3B1PSQoKCQoKG5vX29mX2NwdXMrMSkpLzIpKQo+IC0gICAgbnVtYWN0bCAtLXBoeXNjcHVi
aW5kPSRydW5fb25fY3B1IHN1cHBvcnRfbnVtYSBwYXVzZSAmICNqdXN0Cj4gd2FpdHMgZm9yIHNp
Z2ludAo+ICsgICAgbnVtYWN0bCAtLWFsbCAtLXBoeXNjcHViaW5kPSRydW5fb25fY3B1IHN1cHBv
cnRfbnVtYSBwYXVzZSAmCj4gI2p1c3Qgd2FpdHMgZm9yIHNpZ2ludAo+ICAgICAgcGlkPSQhCj4g
ICAgICB2YXI9YGF3ayAneyBwcmludCAkMiB9JyAvcHJvYy8kcGlkL3N0YXRgCj4gICAgICB3aGls
ZSBbICR2YXIgPSAnKG51bWFjdGwpJyBdOyBkbwo+IC0tCj4gMi40MS4wCj4KPgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
