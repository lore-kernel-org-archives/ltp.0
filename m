Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60661C3ABD8
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747227328; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=d5b9LkQR6Rx2JFsS6DpmlxYEhHQ006SbnqgNb0FPkvs=;
 b=Gz+V1CZLvq1rtM2+M31Sf2eKXbWPYjHdJh2SctHCcvEFeGwd0kHrnTxCsvl8H0qNRGpyn
 0fYrYAHdaaOxBFkhH7fv2jWUxTcKmbexYTqKSFZWhwqeGY1h+oTNN6OQdm7QWJm5cK1CXZO
 2hp+MgZByDEcYWtFDWD0cStTrxA60MM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7B293CC3B7
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 14:55:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B71223C01FE
 for <ltp@lists.linux.it>; Wed, 14 May 2025 14:55:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B035C60007C
 for <ltp@lists.linux.it>; Wed, 14 May 2025 14:55:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747227303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKEUvUW+hGmdQWMqpLaJ9Z6rOCT3qH2dd+Fg4nHO6+Y=;
 b=BiGdMySxsMFFU8Hw2nFuJ0dbm69Pg2vWiTVxwa0mlBUclDHWX4G+HZPO1vWhCksMj1kN5V
 rTB+l3FKtctN87fDN6a7IDXAExRsZO4Jc1M9VnCUcOylU1LilEDBzqpOj5RQKb5M/g4FCI
 Zn0XDiTjXIbiqn8Ab/ERPGBfSMfa+go=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-WILKlK5NNzydGgtZOYh7AQ-1; Wed, 14 May 2025 08:55:01 -0400
X-MC-Unique: WILKlK5NNzydGgtZOYh7AQ-1
X-Mimecast-MFC-AGG-ID: WILKlK5NNzydGgtZOYh7AQ_1747227301
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b5d18cb7so2637033f8f.2
 for <ltp@lists.linux.it>; Wed, 14 May 2025 05:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747227300; x=1747832100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKEUvUW+hGmdQWMqpLaJ9Z6rOCT3qH2dd+Fg4nHO6+Y=;
 b=kIAh/dUt3pcoadi2u4hKhe2q2djOc71mlqcyDLUUKIMsP6XfBXj4r7AHXeNkB7vsC+
 zZGF/FLtMGltKPUDJ2+Hzw5aGvE3OeTx+MfJR6A+Zgyg3qpVQFR2C1xoDOoyUknDuoFQ
 4+igMC5mQI4JJ321E0aI6GuTRoFHTipKwnsnjCBOtMD1TazZBmlRhfdzQZohLy4oHPlq
 /nKxaHguur1jD7fBzlq9Ph/uKp+f5L+hugd42VYCKxq3uVUeD3Ue3o0KqSXxnzJKxIK/
 6Z+X0889nIpw60DfdLozubuLQn9hO6yNLpdglwyKPHehkLanh3YnKLMmAZzfpSoxX5l9
 vzMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvXCbu3b19mb3DuKNyBbKr0V98J1PBQMcFq+EDNWwaA5zQfwKhBHU/nZyQQW0VYbPry64=@lists.linux.it
X-Gm-Message-State: AOJu0YyPHiqLBykmSncv7CzlUlqaznUZZpF/RrD03vf0KicjSzgjaikb
 C3sYnvaboR7CDnKSVXnVaL5mFkJGRKbUxgqg+6ocf/U0MusMNVHNArlhD1MsZme/LRGrMQD/Dxn
 0R6cWyOx7Ee9l4dAypAKsjc8JrA8ruVlXwlpQwgJAdiampU56eLuBNvF1JVb1O2HAix2UkbuXJs
 RaL3kruU5HPNXhF8Qmz+9B7WA=
X-Gm-Gg: ASbGncuW+suR/43RuI0E5ei6I9lFvvaZV6R65tocHYUn0xrARDbQQ8LYZrubhVVsqgq
 xPbbV+b07Fv8Fct7PuURQDMQFsJQlNpfrKQHnToyprpmGrUoPcy0gky0Hz59n4JznASUP
X-Received: by 2002:a05:6000:40d9:b0:3a3:4f88:6276 with SMTP id
 ffacd0b85a97d-3a34f8863e8mr255669f8f.46.1747227300639; 
 Wed, 14 May 2025 05:55:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEonYd/jfVniwIkOZyQO7d1gr+qyxC0D4Bthut/5YgxgnXXv3cU4SZRyE0yzE/FKk7CPp3FWoEAiPREiKHeFvk=
X-Received: by 2002:a05:6000:40d9:b0:3a3:4f88:6276 with SMTP id
 ffacd0b85a97d-3a34f8863e8mr255650f8f.46.1747227300323; Wed, 14 May 2025
 05:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
 <aBt7ck35Dq8GIKHc@yuki.lan>
 <CAASaF6y+e6eKMONT2FdgsLJyhGzZPswQNqthQpneEqpte+-6pQ@mail.gmail.com>
 <aCNox5FGkPsLWGf2@MiWiFi-CR6608-srv>
 <CAASaF6yRO-_dX-ktapqAcWyqU-jwf2k8cJ9+Q7XAN7sqkngz8A@mail.gmail.com>
 <CAEemH2dWyGyHXngTSghnAUmyF+DS0GNvKatVR9CuTpMEZc-rPQ@mail.gmail.com>
 <CAASaF6xNg8AeQMRscHY_gsqQGxw=wPhYiwquuHVKLSgZEYDoFA@mail.gmail.com>
 <CAEemH2fFUdjmqsNvFBk5mRjn+2xm62HJZx48Qug4jMdVBJNnsA@mail.gmail.com>
 <CAASaF6zONvCb8p_ATDTS2Ma1rs=ZvHA03i3=xqLHbKH2ZOCPWw@mail.gmail.com>
 <CAEemH2c7KTkJUh40D=Hn55u5_E8g-+p2XR+Fc5WehekxhFSA2Q@mail.gmail.com>
In-Reply-To: <CAEemH2c7KTkJUh40D=Hn55u5_E8g-+p2XR+Fc5WehekxhFSA2Q@mail.gmail.com>
Date: Wed, 14 May 2025 14:54:43 +0200
X-Gm-Features: AX0GCFt8FPqKjlx9tbr7c_Ral-6MYnhz6w6fRFg6um42Od57tfEnLT58NnjfKjc
Message-ID: <CAASaF6whf1X=ZWFoqOvE519QfdbGrvLiF=em6Qk_2pEkZaJyHA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iC8wZaqiFY9-UuM8htcTkwYFzr_IIc5tDWT0mB_L7Fk_1747227301
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMTQsIDIwMjUgYXQgMjo0NOKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPiB3cm90ZToK
Pgo+ID4gPiA+IEknbGwgaGF2ZSBhIGNsb3NlciBsb29rIGFuZCB0cnkgbWFudWFsbHkuIEF0IGZp
cnN0IGdsYW5jZSBhdCB0ZXN0LCBJCj4gPiA+ID4gc3VzcGVjdCBjb21waWxlcgo+ID4gPiA+IGRv
aW5nIHNvbWV0aGluZyBjbGV2ZXIgZm9yOgo+ID4gPiA+ICAgICAgICAgICAgICAgICBmb3IgKDs7
KQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICooY2hhciAqKW1hbGxvYyhwYWdlX3Np
emUpID0gJ0InOwo+ID4gPgo+ID4gPiBQcm9iYWJseSwgIC1PMiBpcyB0aGUgZGVmYXVsdCBpbiBM
VFAgY29tcGlsaW5nLgo+ID4gPgo+ID4gPiBPciwgeW91IGNvdWxkIGFsc28gdHJ5IGRpc2FibGlu
ZyBLU00gd2hlbiB0ZXN0aW5nIG1tYXAyMi5jIHRvIHNlZSBpZiBpdCBoZWxwcy4KPiA+Cj4gPiBJ
biBjYXNlIG9mIG15IFZNLCBpdCBsb29rcyBsaWtlIGl0J3MgYWJsZSB0byBzd2FwIGZhc3RlciB0
aGFuIHdoYXQncwo+ID4gbmVlZGVkIHRvIGRyb3AgdGhlIGFsbG9jYXRpb24uCj4gPiBXaXRoIHRo
aXMgSSBnZXQgUEFTUyByaWdodCBhd2F5Ogo+ID4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDIyLmMKPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9tbWFwL21tYXAyMi5jCj4gPiBpbmRleCAwZTU4OWRmYWIuLjU2ZmU0MTJkMSAxMDA2NDQK
PiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjIuYwo+ID4gKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMi5jCj4gPiBAQCAtMzIsNiAr
MzIsNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X21tYXAodm9pZCkKPiA+Cj4gPiAgICAgICAgIGNnX2No
aWxkID0gdHN0X2NnX2dyb3VwX21rKHRzdF9jZywgImNoaWxkIik7Cj4gPiAgICAgICAgIFNBRkVf
Q0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5tYXgiLCAiJWQiLCBNRU1fTElNSVQpOwo+ID4gKyAg
ICAgICBTQUZFX0NHX1BSSU5URih0c3RfY2csICJtZW1vcnkuc3dhcC5tYXgiLCAiJWQiLCAxKTsK
Pgo+IFdoeSBub3Qgc2V0IGl0IHRvIDAgdG8gZGlzYWJsZSBpdCBjb21wbGV0ZWx5PwoKWWVzLCBJ
IHJlYWxpemVkIHRoYXQgd2hlbiBJIHdhcyBwcmVwYXJpbmcgdGhlIHBhdGNoIDotKS4KCj4KPiBJ
IGd1ZXNzIHdlIG5lZWQgdG8gZG8gaXQgc2VwYXJhdGVseSBmb3IgYm90aCBDZ3JvdXAgdjEgYW5k
IHYyLgo+ICAgLSBDZ3JvdXAtdjE6IHNldCBpdCB0byBNRU1fTElNSVQuCj4gICAtIENncm91cC12
Mjogc2V0IGl0IHRvIDAuCj4gRllJOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9q
ZWN0L2x0cC9ibG9iL21hc3Rlci90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDMuYyNMMzMK
ClRoYW5rcyBmb3IgcG9pbnRlciwgSSdsbCBhZGQgaXQgYWxzbyBmb3IgY2dyb3VwIHYxLgoKPgo+
IEFueXdheSwgdGVzdGluZyB3aWxsIGJlIG11Y2ggZmFzdGVyIHdpdGggdGhpcyBwYXRjaC4KPgo+
IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5nCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
