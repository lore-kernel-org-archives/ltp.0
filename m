Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB09CA0FED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 04:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757045079; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ABwoOrXAK+8W9zMdS2x0PxMBoAKUQmLh/Dt1sv8+7VY=;
 b=Rcp1Y0cPjgAN78ByVz/m6FkJpWwOFmtG76WT5ZXnYV4JZvYUY2AesjgImQ04fenoxg77h
 Dlb9mS9k3zjVQnTU/KurCGyyDqz2iZagQ6k1+ckXYHYc5BH+3rV6EKaG1C8XmEiDvlhHMEL
 fK9LFG5/vNw1aSYae8Zfrl5Qwcjs9Hk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 663D23CD4E5
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 06:04:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEFD33CCEE5
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 06:04:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A00DF1400C44
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 06:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757045056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6/aK2PRnXGZajmGGO8dMAt2cKL1Ivrbmn9voq1xRdNs=;
 b=Zk/DVNudixStL4In3u1k1xYbINRh+gjuY03ctDbpDnLYDr+IbTo913+eecGK3dzgt3ck2S
 D0vTESrJl7Yt7UdognyhNZofbWNGUIO6bQxaoRpwkLoOeJmwQ97jwLzlcV2IHKz8zfS+sY
 UKzDaqEOeHICOPnXOerPJxbsmHfDHME=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Bb5icfJzPzafWT3_V6PWBw-1; Fri, 05 Sep 2025 00:04:14 -0400
X-MC-Unique: Bb5icfJzPzafWT3_V6PWBw-1
X-Mimecast-MFC-AGG-ID: Bb5icfJzPzafWT3_V6PWBw_1757045053
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-24c99bd543aso28032095ad.3
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 21:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757045053; x=1757649853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6/aK2PRnXGZajmGGO8dMAt2cKL1Ivrbmn9voq1xRdNs=;
 b=H7BiSjoA7B+UJWxeF/Hd6sT/iTyaugqwxihvLQIOTABonVpbjS6lpGdZPO7BZh53Q5
 YBUouA7IHlEw9j6Ps4l38Es11QV5H0yY2H6PF1k+lsauffhPStYh/fZp9GAbMLgvlQiv
 2VciGsnC1yWBH8v/8ykMmR0zllGYcPLgXyurQZzS3IV1rx60JN5USKtIQ49UuroH+5Dz
 x7p1uwMUb4kjkEWsB9lBrJatWf2cZgmyY9Ko0yhyjtARcaHlV4Ad70eClIdBGyZq4Avu
 Pq/PRyxRu9pHJigVw4bCeJ82H67e0PeC0PpBmK7d/Iy8pNlzbrPy+Uo7XC+ny09Oy55+
 tIkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk0M1Lcdzy3dHJ4hxxPw0C4mKx3Hx33sCzh7dbolnuzJ2WdmXkwm9KINmJ4AYzWcC6GRc=@lists.linux.it
X-Gm-Message-State: AOJu0YwA6/5MNekoyRvUxf8ZSS4iTHbCx4CEywywPOWYqf2ZTS0gUy35
 o24BWq2l0rscLX461nztiNNUtzJRbKECPK8MW4gkgF1YcInLMJvT870b+FPD107qApV8VPi9R/o
 cYNIYs/5FjoVpGcYCl9ewW3gTspAhxiw9ghCqZQvmblQY6oQxNph+gvl4xnWKctR/q7htgGEjhN
 I1242GkPivk9U711NTkezzFC+K8jg=
X-Gm-Gg: ASbGnctNMvPoaE3WKCCnNE9aJf2YQaUKSbKT4c3L1K54G6k91ZkDQWkfAhUg7/BFQL5
 C35ZjY9bN7c7bolwoTG46qZ4IJn6+FmR0OMgEtdbtdiVnO3tT3uIsxGtoHksGgb8s26WoXa4utt
 xRL1A1Onc1F/b9EGYNI1snLA==
X-Received: by 2002:a17:903:2304:b0:24c:99bd:52bb with SMTP id
 d9443c01a7336-24c99bd54a9mr98436235ad.30.1757045052871; 
 Thu, 04 Sep 2025 21:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiQd+30BMmJpg+ZerM56Tt6/+Pqy24aWzoXUEDRUl44dyCSyCzvCrZZqDBbqG8I/3g2KBpVL2ccSCCd22xxsg=
X-Received: by 2002:a17:903:2304:b0:24c:99bd:52bb with SMTP id
 d9443c01a7336-24c99bd54a9mr98435785ad.30.1757045052117; Thu, 04 Sep 2025
 21:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
In-Reply-To: <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
Date: Fri, 5 Sep 2025 12:03:59 +0800
X-Gm-Features: Ac12FXx1mxQDYS1wVht_8jIXDKcWnMLWSfM-9yWMAcI_yjBoLKfTYIzC7Mh0gIM
Message-ID: <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KDKv5Ga7TdtfshtFP4kmp_q6YSumKjnWJ-i9zcvkKt4_1757045053
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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

T24gRnJpLCBTZXAgNSwgMjAyNSBhdCA4OjU04oCvQU0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+Cj4gT24gVGh1LCBTZXAgNCwgMjAyNSBhdCAxMToyOOKAr1BNIEN5cmls
IEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPgo+PiBIaSEKPj4gPiA+ID4gPiAgc3Rh
dGljIHZvaWQgZG9fc2V0dXAodm9pZCkKPj4gPiA+ID4gPiAgewo+PiA+ID4gPiA+ICsgICBpZiAo
IXRzdF9jaGVja19wcmVlbXB0X3J0KCkpCj4+ID4gPiA+ID4gKyAgICAgICAgICAgdHN0X2JyayhU
Q09ORiwgIlRlc3QgcmVxdWlyZXMgcmVhbC10aW1lIGtlcm5lbCIpOwo+PiA+ID4gPgo+PiA+ID4g
PiBJIHVuZGVyc3Rvb2QgQ3lyaWwgaXMgcmVhbGx5IHN1Z2dlc3RpbmcgdG8ga2VlcCBpdCBbMV0u
IEkgd291bGQgYWxzbwo+PiA+ID4gdm90ZSB0bwo+PiA+ID4gPiBrZWVwIGl0ICh3ZSBzdGlsbCBo
YXZlIHNvbWUgdGltZSB0byBzZWUgaWYgaXQgZ290IGZpeGVkIGJlZm9yZQo+PiByZWxlYXNlKS4K
Pj4gPiA+ID4KPj4gPiA+ID4gSSBrbm93IHdlIGhhZCB0aGlzIGRpc2N1c3Npb24gaW4gdGhlIHBh
c3QgKHNvbWUgb2YgeW91ciBjb2xsZWFndWUKPj4gPiA+IHN1Z2dlc3RpbmcgaXQKPj4gPiA+ID4g
c2hvdWxkIG5vdCBiZSBydW4gb24gbm9uLVJUIGtlcm5lbCksIHNvIEknbSBub3QgcHVzaGluZyBm
b3IgaXQuCj4+ID4gPgo+PiA+ID4gSSBzdGlsIGRvIG5vdCB1bmRlcnN0YW5kIHJlYXNvbnMgZm9y
IGRpc2FibGluZyB0aGUgdGVzdC4gVGhlIFBPU0lYCj4+ID4gPiByZWFsdGltZSBzY2hlZHVsbGlu
ZyBjbGFzc2VzIGhhdmUgdG8gd29yayBwcm9wZXJseSByZWdhcmRsZXNzIG9mIHRoZQo+PiA+ID4g
a2VybmVsIGZsYXZvci4gV2h5IHNob3VsZCB3ZSB0dXJuIHRoZSB0ZXN0IG9mZiBvbiBub24tcnQg
a2VybmVsIHRoZW4/Cj4+ID4gPgo+PiA+Cj4+ID4gTm8gc3BlY2lhbCByZWFzb25zLiBJIHN0aWxs
IGNhbiBzcG9yYWRpY2FsbHkgY2F0Y2ggdGhlIGZhaWx1cmUgb24gbm9uLVJUCj4+ID4ga2VybmVs
IHdpdGggZXZlbiBzbGVlcCAyIHNlY29uZHMuCj4+Cj4+IFRoYXQgaXMgdmVyeSBzdHJhbmdlLiBU
aGUgU0NIRURfRklGTyB0aHJlYWRzIHNob3VsZCBwcmVlbXB0eSBhbnkgbG93ZXIKPj4gcHJpbyB0
aHJlYWQgYXMgbG9uZyBhcyB0aGV5IGJlY29tZSBydW5hYmxlIGFuZCBzaG91bGQgc3RheSBydW5u
aW5nIHVudGlsCj4+IHRoZXkgZmluaXNoIG9yIHlpZWxkLiBUd28gc2Vjb25kcyBzaG91bGQgYmUg
bW9yZSB0aGFuIGVub3VnaCBmb3IgdGhhdCB0bwo+PiBoYXBwZW4uCj4+Cj4+ID4gVGh1cywgSSB0
b29rIHRoaXMgdmVyeSBleHRyZW1lIGFwcHJvYWNoLCBiZWNhdXNlIG9uIG5vbi1SVCBrZXJuZWws
IHNsZWVwCj4+ID4gbWF5IG5vdCBoYXZlIGEgcGFydGljdWxhcmx5IHBlcmZlY3QgZWZmZWN0LCBJ
IGd1ZXNzIHRoZSBzdG9jayBrZXJuZWwKPj4gd2l0aAo+PiA+IHNjaGVkX3NldHNjaGVkdWxlcigs
IFNDSEVEX0ZJRk8sICkgaXMgc3RpbGwgaGFzIHNjaGVkdWxpbmcgc2tldyB3aXRoCj4+ID4gd29y
a2xvYWQuCj4+Cj4+IERvZXMgdGhpcyBoYXBwZW4gb24gdmFuaWxsYSBMaW51eCBhcyB3ZWxsIG9y
IG9ubHkgb24gUmVkSGF0IGtlcm5lbHM/Cj4+Cj4KPiBZZXMsIGJvdGggdmFuaWxsYSBMaW51eCBh
bmQgQ2VudE9TIGtlcm5lbHMuCj4KPiBtb3JlIENJIHRlc3QgaGlzdG9yeSBmb3Igc2NoZWRfZm9v
dGJhbGw6Cj4KPiAgICBXaXRob3V0IGJhcnJpZXIgcGF0Y2g6Cj4gICAgICAgICAgICBGYWlscyBv
biBib3RoIFJUIGFuZCBub24tUlQgQ2VudE9TIFN0cmVhbSA5LzEwIGtlcm5lbHMKPiAgICAgICAg
ICAgIEZhaWxzIG9uIG5vbi1SVCBtYWlubGluZSB2Ni4xNy1yYzQga2VybmVscy4gKG5vdCBidWls
ZCB2Ni4xNwo+IFJUIGtlcm5lbCkKPgo+ICAgKF4gdGhhdCdzIHdoeSB3ZSBzdGFydGVkIHRvIGxv
b2sgaW50byB0aGUgZmFpbHVyZSBhbmQgc3VibWl0IHRoZSBjb21taXQKPiBlNTIzYmE4OGRkOWIp
Cj4KPiAgICBXaXRoIGJhcnJpZXIgcGF0Y2g6Cj4gICAgICAgICAgICBGYWlscyBvbiBib3RoIFJU
IGFuZCBub24tUlQgQ2VudE9TIGtlcm5lbHMsIGJ1dCB0aGUgZmluYWwgYmFsbAo+IHBvc2l0aW9u
IGlzIG5vdGljZWFibHkgbG93ZXIuCj4gICAgICAgICAgICBGYWlscyBvbiBub24tUlQgbWFpbmxp
bmUgdjYuMTctcmM0IGtlcm5lbHMuIChub3QgYnVpbGQgdjYuMTcKPiBSVCBrZXJuZWwpCj4KPiAg
ICBXaXRoIGJhcnJpZXIgcGF0Y2ggKyBraWNrb2ZmIGZsYWcgZW5oYW5jZW1lbnQ6Cj4gICAgICAg
ICAgICBGYWlscyBvbiB0aGUgbm9uLVJUIENlbnRPUyBTdHJlYW0gMTAga2VybmVsCj4gICAgICAg
ICAgICBGYWlscyBvbiBub24tUlQgbWFpbmxpbmUgdjYuMTctcmM0IGtlcm5lbC4gKG5vdCBidWls
ZCB2Ni4xNwo+IFJULWtlcm5lbCkKPiAgICAgICAgICAgIFBhc3NlZCBvbiBSVCBDZW50T1Mgc3Ry
ZWFtIGtlcm5lbAo+Cj4gKF4gaGVyZSBJIHN0YXJ0ZWQgdG8gc3VzcGVjdCB0aGUgU0NIRURfRklG
TyB0aHJlYWRzIGNhbiBub3QgcGVyZm9ybSB3ZWxsCj4gbGlrZSBSVC1rZXJuZWwpCj4KPgo+IFty
b290QGRlbGwtcGVyNzYyNS0wMSBzY2hlZF9mb290YmFsbF0jIHVuYW1lIC1yCj4gNi4xNy4wLXJj
NC5saXdhbmcKPgo+IFtyb290QGRlbGwtcGVyNzYyNS0wMSBzY2hlZF9mb290YmFsbF0jIC4vc2No
ZWRfZm9vdGJhbGwKPiB0c3RfdGVzdC5jOjIwMDQ6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTA1
MzAKPiB0c3RfdGVzdC5jOjIwMDc6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA2LjE3LjAtcmM0Lmxp
d2FuZyAjMSBTTVAKPiBQUkVFTVBUX0RZTkFNSUMgVGh1IFNlcCAgNCAyMDowNzoyMCBFRFQgMjAy
NSB4ODZfNjQKPiB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmln
Cj4gJy9saWIvbW9kdWxlcy82LjE3LjAtcmM0Lmxpd2FuZy9idWlsZC8uY29uZmlnJwo+IHRzdF9r
Y29uZmlnLmM6Njc2OiBUSU5GTzogQ09ORklHX0ZBVUxUX0lOSkVDVElPTiBrZXJuZWwgb3B0aW9u
IGRldGVjdGVkCj4gd2hpY2ggbWlnaHQgc2xvdyB0aGUgZXhlY3V0aW9uCj4gdHN0X3Rlc3QuYzox
ODI1OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDJtIDAwcwo+IHNjaGVk
X2Zvb3RiYWxsLmM6MTYyOiBUSU5GTzogcGxheWVyc19wZXJfdGVhbTogMzIgZ2FtZV9sZW5ndGg6
IDUKPiBzY2hlZF9mb290YmFsbC5jOjE3ODogVElORk86IFN0YXJ0aW5nIDMyIG9mZmVuc2UgdGhy
ZWFkcyBhdCBwcmlvcml0eSAxNQo+IHNjaGVkX2Zvb3RiYWxsLmM6MTg1OiBUSU5GTzogU3RhcnRp
bmcgMzIgZGVmZW5zZSB0aHJlYWRzIGF0IHByaW9yaXR5IDMwCj4gc2NoZWRfZm9vdGJhbGwuYzox
OTI6IFRJTkZPOiBTdGFydGluZyA2NCBjcmF6eS1mYW4gdGhyZWFkcyBhdCBwcmlvcml0eSA1MAo+
IHNjaGVkX2Zvb3RiYWxsLmM6MTE4OiBUSU5GTzogU3RhcnRpbmcgcmVmZXJlZSB0aHJlYWQKPiBz
Y2hlZF9mb290YmFsbC5jOjEyMTogVElORk86IFN0YXJ0aW5nIHRoZSBnYW1lICg1IHNlYykKPiBz
Y2hlZF9mb290YmFsbC5jOjE0NDogVElORk86IEZpbmFsIGJhbGwgcG9zaXRpb246IDIwMjA1Cj4g
c2NoZWRfZm9vdGJhbGwuYzoxNTA6IFRGQUlMOiBFeHBlY3Q6IGZpbmFsX2JhbGwgPT0gMAo+CgoK
Q2hlY2tpbmcgdGhlIGNvbmZpZ3VyYXRpb25zIG9mIHRoZSBzdG9jayBrZXJuZWwgYW5kIHRoZSBy
ZWFsLXRpbWUKa2VybmVsLCB0aGUgc3RvY2sga2VybmVsIHVzZXMgIkNPTkZJR19QUkVFTVBUX1ZP
TFVOVEFSWT15LCIKd2hpY2ggb25seSBwcm92aWRlcyB2b2x1bnRhcnkgcHJlZW1wdGlvbi4KClRo
aXMgcHJlZW1wdGlvbiBtb2RlbCBpcyBkZXNpZ25lZCB0byBzdHJpa2UgYSBiYWxhbmNlIGJldHdl
ZW4gdGhyb3VnaHB1dAphbmQgbGF0ZW5jeS4gSXQgb25seSBhbGxvd3MgdGhlIGtlcm5lbCB0byBi
ZSBwcmVlbXB0ZWQgYXQgc3BlY2lmaWMsIHdlbGwKZGVmaW5lZAoic2FmZSBwb2ludHMsIiBwb3Rl
bnRpYWxseSByZXN1bHRpbmcgaW4gbG9uZywgdW5ib3VuZGVkIGxhdGVuY2llcy4KCkhvd2V2ZXIs
IHRoZSBzY2hlZF9mb290YmFsbCB0ZXN0IHdhcyBtb3N0IGxpa2VseSBkZXNpZ25lZCB0byBtZWFz
dXJlIG9yCnN0cmVzcy10ZXN0IHRoZSBkZXRlcm1pbmlzdGljLCBsb3ctbGF0ZW5jeSBzY2hlZHVs
aW5nIGJlaGF2aW9yIHRoYXQgaXMKY2hhcmFjdGVyaXN0aWMgb2YgcmVhbC10aW1lIChSVCkga2Vy
bmVsLgoKU28sIEkgdGVuZCB0byBiZWxpZXZlIHRoZSB0ZXN0J3MgZmFpbHVyZSBvbiB0aGUgc3Rv
Y2sga2VybmVsIGlzIGFjY2VwdGFibGUuCkFuZCwgYnkgdGhlIHdheSwgd2hhdCBkb2VzIHRoZSBT
VVNFIGtlcm5lbCBjb25maWd1cmF0aW9uIGxvb2sgbGlrZT8KCgojIGdyZXAgQ09ORklHX1BSRUVN
UFQgL2Jvb3QvY29uZmlnLTYuMTIuMC01NS4yOS4xLmVsMTBfMC54ODZfNjQKQ09ORklHX1BSRUVN
UFRfQlVJTEQ9eQpDT05GSUdfUFJFRU1QVF9WT0xVTlRBUlk9eQojIENPTkZJR19QUkVFTVBUIGlz
IG5vdCBzZXQKIyBDT05GSUdfUFJFRU1QVF9SVCBpcyBub3Qgc2V0CkNPTkZJR19QUkVFTVBUX0NP
VU5UPXkKQ09ORklHX1BSRUVNUFRJT049eQpDT05GSUdfUFJFRU1QVF9EWU5BTUlDPXkKQ09ORklH
X1BSRUVNUFRfUkNVPXkKQ09ORklHX1BSRUVNUFRfTk9USUZJRVJTPXkKCiheIEkgYnVpbHQgbXkg
djYuMTctcmM0IHdpdGggdGhpcyBjb25maWcgdG9vKQoKCiMgZ3JlcCBDT05GSUdfUFJFRU1QVCAv
Ym9vdC9jb25maWctNi4xMi4wLTU1LjMxLjEuZWwxMF8wLng4Nl82NCtydApDT05GSUdfUFJFRU1Q
VF9CVUlMRD15CkNPTkZJR19QUkVFTVBUPXkKQ09ORklHX1BSRUVNUFRfUlQ9eQpDT05GSUdfUFJF
RU1QVF9DT1VOVD15CkNPTkZJR19QUkVFTVBUSU9OPXkKIyBDT05GSUdfUFJFRU1QVF9EWU5BTUlD
IGlzIG5vdCBzZXQKQ09ORklHX1BSRUVNUFRfUkNVPXkKQ09ORklHX1BSRUVNUFRfTk9USUZJRVJT
PXkKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
