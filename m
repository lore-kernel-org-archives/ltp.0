Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59686C87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 08:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754988053; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ET0JX7xZoF9s5gXeAsZH6s128zYTtaCchWA+Suy1jXY=;
 b=ro9ttDv429oF+oV/3vX2ffTJN7E1tblmDdHYJbKN+G62cvbNV9+aj+mpcl09N/f8OBAvX
 qFVieKcAGl/iKXIMQkDcpzOB3zGLGF8qxHigw0YSC7FV7I7ivEsYnw17DGSRcCIwR7Z/bnh
 J2WMx9MzoIpXmwnlIVKzDwZMwhxx3mQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FF1E3CB322
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 10:40:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 194CE3C052E
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 10:40:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CB5786007A9
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 10:40:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754988027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WT5VH2ips7oRD9VIlyKygI/+mnPlH26CPohibHpxD/k=;
 b=g7bmtwyhszzh164qaA+Yfq/8JJzjjmdl218MPQCu2AbhLaLhX1hvsAu/7rtWLF6VnZ196a
 jQykXEosMVTCQRLHmqQR1qkhx0uyfBZ9WWe73fhSsh3Y2xs3qpY5osjaIJyJzxQMNqx67D
 G0aQ0ffIPqjvNC9flbk2D6kdkTwf+4Y=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-KfRMa8xGMkC5dqKDoyr9Lg-1; Tue, 12 Aug 2025 04:40:25 -0400
X-MC-Unique: KfRMa8xGMkC5dqKDoyr9Lg-1
X-Mimecast-MFC-AGG-ID: KfRMa8xGMkC5dqKDoyr9Lg_1754988024
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b42a11d7427so3156197a12.3
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 01:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754988024; x=1755592824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WT5VH2ips7oRD9VIlyKygI/+mnPlH26CPohibHpxD/k=;
 b=b+gjWx5TZ9+XfWptjXbzHL2pYVZ3fBD1hG64E6hg9JH5sTWbk4liAWzryB3hTYEYbV
 SRHBQ20jxQYoTIPGVWNTzRjHJBtKYqLd5OB0BZCt6nb41uEY7EtQHJ8DZtRg8dx/Wst9
 50k6p1rJhHxgfhRQRT3VwbNsZt/81uuAnSbMkGXI+Ims+k70iXsM8L6ooWbhtKsUSgOg
 vZiSpToRlZfAIScjzVuaiF3ma5ABIYa3DrIk2gTghUDx49Qe86TuSqx5/csUMb0P7FzG
 ryEEORRTxhv1JHVCHs7pTNWgyMu86PvGVa9ndEGj0HWUemYBqAI+Mgto/+80qo6Em8o5
 MMcA==
X-Gm-Message-State: AOJu0YxTpElIcxcUQhZJ5GwQVwY+79H+kNRSdTOZOOtAsdJI/0bzjT13
 bOoioIngr/cbUyoawniOlpG9wwZmDa20p6SkNfs9uyuFv7UwK3Ubp0Y2C1tRTRAs8ra1yceqUIo
 S4m0FpnmvXGnKJae7zDXpxbyiVKbAv5VYZr8zq7+lcmYgDj7FoqZG8J1Ouf/iDZedoBpwk4VZJO
 xApv8j/9a+t+gJ9Yip1HoA0BV6H66rFcNCkxFk+A==
X-Gm-Gg: ASbGnctcKaalruic70nwvV0qgAWzPdA1nEQnODu4Fl9HBVJcoDeUnnCh2LogGHeNv1Q
 or4I1XdFWMZRmCgoMAPpHbzndUcBePJ4vFMTNU/idfbdagncJQHhWDdpuNG1DkEdX7bwAM4du7N
 uPXH0qP/cLxMH3XcMMbOUmIA==
X-Received: by 2002:a17:90a:fc50:b0:321:c8e1:82e with SMTP id
 98e67ed59e1d1-321c8e10bf5mr270693a91.26.1754988023764; 
 Tue, 12 Aug 2025 01:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHAUGJqL/0HU2MiIlZ/5ohS7m9kLBtFxtrnfwHFQ7CMOsZROF8mdxbS1eWbCJWRUZyKrpMp3MUAE6sl+BswnM=
X-Received: by 2002:a17:90a:fc50:b0:321:c8e1:82e with SMTP id
 98e67ed59e1d1-321c8e10bf5mr270673a91.26.1754988023333; Tue, 12 Aug 2025
 01:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <aJYBSmcQpbHUvOqW@stanley.mountain>
 <CAEemH2cBH+usbwMsHnDW=QM-qDKOCg2wp063O=1gtrRdqNFpug@mail.gmail.com>
 <aJmj6kmNvgzbd1Zi@stanley.mountain>
In-Reply-To: <aJmj6kmNvgzbd1Zi@stanley.mountain>
Date: Tue, 12 Aug 2025 16:40:11 +0800
X-Gm-Features: Ac12FXwSqi_zI9GcaMHhlgBswDPJ_gBz5CmNBOiSCSGYkaREzo3NDXkYZkPNcXc
Message-ID: <CAEemH2eoW0LUq5ynrh9KFfHbMVqw+yJDBOEAo9g4QCS+SbEKmA@mail.gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cPzLMoyEMl8UcRKSad9KlT7KIIixuNVVQ8UtFmrS1cI_1754988024
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] shmctl03.c is broken for 32bit compat mode
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
Cc: Theodore Grey <theodore.grey@linaro.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgMTEsIDIwMjUgYXQgNDowNOKAr1BNIERhbiBDYXJwZW50ZXIgPGRhbi5jYXJw
ZW50ZXJAbGluYXJvLm9yZz4Kd3JvdGU6Cgo+IE9uIFN1biwgQXVnIDEwLCAyMDI1IGF0IDExOjQ2
OjMyQU0gKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gPiBIaSBEYW4sCj4gPgo+ID4gT24gRnJpLCBB
dWcgOCwgMjAyNSBhdCA5OjUz4oCvUE0gRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5h
cm8ub3JnPgo+ID4gd3JvdGU6Cj4gPgo+ID4gPiBJbiAzMmJpdCBjb21wYXQgbW9kZSB0aGUgc2ht
Y3RsMDMuYyB0ZXN0IHdpbGwgYWx3YXlzIGZhaWw6Cj4gPiA+Cj4gPiA+IHNobWN0bDAzLmM6MzM6
IFRGQUlMOiAvcHJvYy9zeXMva2VybmVsL3NobW1heCAhPSAyMTQ3NDgzNjQ3IGdvdAo+IDQyOTQ5
NjcyOTUKPiA+ID4gc2htY3RsMDMuYzozNDogVFBBU1M6IC9wcm9jL3N5cy9rZXJuZWwvc2htbW5p
ID0gNDA5Ngo+ID4gPiBzaG1jdGwwMy5jOjM1OiBURkFJTDogL3Byb2Mvc3lzL2tlcm5lbC9zaG1h
bGwgIT0gNDI3ODE5MDA3OSBnb3QKPiA0Mjk0OTY3Mjk1Cj4gPiA+Cj4gPiA+IFRoZSB0ZXN0IGJh
c2ljYWxseSBkb2VzIHRoaXM6Cj4gPiA+IC8vID09PSA9PT0gPT09Cj4gPiA+ICNkZWZpbmUgX0dO
VV9TT1VSQ0UKPiA+ID4gI2luY2x1ZGUgPHN5cy9zaG0uaD4KPiA+ID4gI2luY2x1ZGUgPHN0ZGlv
Lmg+Cj4gPiA+Cj4gPiA+IGludCBtYWluKHZvaWQpCj4gPiA+IHsKPiA+ID4gICAgICAgICBzdHJ1
Y3Qgc2htaW5mbyBpbmZvOwo+ID4gPgo+ID4gPiAgICAgICAgIHNobWN0bCgwLCBJUENfSU5GTywg
KHN0cnVjdCBzaG1pZF9kcyAqKSZpbmZvKTsKPiA+ID4KPiA+ID4gICAgICAgICBwcmludGYoInNo
bW1heCA9ICVsdVxuIiwgaW5mby5zaG1tYXgpOwo+ID4gPiAgICAgICAgIHByaW50Zigic2htbW5p
ID0gJWx1XG4iLCBpbmZvLnNobW1uaSk7Cj4gPiA+ICAgICAgICAgcHJpbnRmKCJzaG1hbGwgPSAl
bHVcbiIsIGluZm8uc2htYWxsKTsKPiA+ID4KPiA+ID4gICAgICAgICByZXR1cm4gMDsKPiA+ID4g
fQo+ID4gPiAvLyA9PT0gPT09ID09PQo+ID4gPgo+ID4gPiBJdCBjb21wYXJlcyB0aGF0IG91dHB1
dCB3aXRoIHdoYXQgd2UgcmVhZCBmcm9tIHRoZSBmaWxlLiAgWW91IGNhbiBydW4KPiA+ID4gImdj
YyAtbTMyIHRlc3QuYyAmJiAuL2Eub3V0IiB0byBzZWUgdGhlIGlzc3VlLgo+ID4gPgo+ID4gPiBJ
biB0aGUgZmlyc3QgbGluZSBzaG1tYXggaXMgbm90IHRoZSB2YWx1ZSB0aGF0IHdlIHJlYWQgZnJv
bSB0aGUgZmlsZQo+ID4gPiBiZWNhdXNlIGl0IHdhcyBjYXBwZWQgYXQgSU5UX01BWCBieSB0aGUg
a2VybmVsIGluIGNvbW1pdCBhZjdjNjkzZjE0NjAKPiA+ID4gKCJDYXAgc2htbWF4IGF0IElOVF9N
QVggaW4gY29tcGF0IHNobWluZm8iKS4KPiA+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvdjYuMTYvc291cmNlL2lwYy9zaG0uYyNMMTM0Nwo+ID4gPgo+ID4gPiBXaXRoIHRoZSBs
YXN0IGxpbmUgd2UncmUgdHJ5aW5nIHRvIHN0b3JlIGEgdTY0IHZhbHVlIGludG8gYSB1MzIuICBX
ZSdyZQo+ID4gPiBnb2luZyB0byBsb3NlIHNvbWV0aGluZyBzbyBpdCdzIG5vdCBnb2luZyB0byBi
ZSBhY2N1cmF0ZS4gIFRoZQo+IGRpZmZlcmVuY2UKPiA+ID4gaXMgaG93IHNjYW5mKCkgdHJ1bmNh
dGVzIGl0LiAgSWYgeW91IGhhdmUgMzJiaXQgbG9uZ3MgdGhlbiBpdCB3aWxsIGdpdmUKPiA+ID4g
eW91IHRoZSBmaXJzdCB1MzIgYnV0IGlmIHlvdSBhc3NpZ24gYSB1NjQgdG8gYSB1MzIgbGlrZSB0
aGUgcmVzdCBvZiB0aGUKPiA+ID4gY29kZSBkb2VzIHRoZW4geW91J2xsIGdldCB0aGUgbGFzdCAz
MiBiaXRzLgo+ID4gPgo+ID4gPiBXaGF0J3MgdGhlIHJpZ2h0IHdheSB0byBnbyBhYm91dCBmaXhp
bmcgdGhpcz8KPiA+ID4KPiA+Cj4gPiBNYXliZSB3ZSBjYW4gc2ltcGx5IHNwbGl0IHRoZSBjb21w
YXJpc29uIHBhcnQgaW50byB0d286Cj4gPgo+ID4gICAjaWZkZWYgVFNUX0FCSTY0OiBnbyB3aXRo
IHRoZSBvcmlnaW5hbCB3YXkuCj4gPgo+ID4gICAjaWZkZWYgVFNUX0FCSTMyOgo+Cj4gV2lsbCB0
aGlzIGFmZmVjdCByZWFsIDMyYml0IHN5c3RlbXM/ICBUaGUgcHJvYmxlbSBpcyBvbmx5IHdoZW4g
d2UncmUKPiBlbXVsYXRpbmcgYSAzMmJpdCBzeXN0ZW0gb24gYSA2NGJpdCBzeXN0ZW0gdXNpbmcg
dGhlIENPTVBBVCBjb2RlLgo+CgpZZXMsIHlvdSdyZSByaWdodC4KCkxvb2tpbmcgaW50byB0aGUg
a2VybmVsIGFuZCB0ZXN0IHJlbGF0ZWQgY29kZSwgdGhhdCBzZWVtcyB0aGUgdGVzdCB3aWxsIHBh
c3MKYXMgbG9uZyBhcyB0aGF0IC9wcm9jL3N5cy9rZXJuZWwve3NobW1heCxzaG1tbmksc2htYWxs
fSBlcXVhbHMgd2l0aCB0aGUKaW5mby57c2htbWF4LHNobW1uaSxzaG1hbGx9LgoKT24gYSBtb2Rl
cm4gbmF0aXZlIDMyYml0IHBsYXRmb3JtLCBpdCB3aWxsIHN0aWxsIGNob29zZSB0aGUgSVBDXzY0
IGJyYW5jaAphbmQgdGhlCmtlcm5lbCBjb3BpZXMgc2htaW5mbzY0IGZpZWxkcyBkaXJlY3RseS4g
U28gdGVzdCBzaG91bGQgcGFzcyBhcyB3ZWxsLgpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92Ni4xNi9zb3VyY2UvaXBjL3NobS5jI0w5MDYKCgoKPgo+ID4gICAgICAgJ3NobW1heCcg
ZXhwZWN0cyBJTlRfTUFYIGZyb20gc2htY3RsKDAsIElQQ19JTkZPLCAuLi4pLCBldmVuIGlmICcK
PiA+IC9wcm9jL3N5cy9rZXJuZWwvc2htbWF4JyBpcyBoaWdoZXIuCj4gPiAgICAgICAnc2htYWxs
JyBjb21wYXJlcyB0aGUgbG93ZXIgMzIgYml0cyBvZiB0aGUgdmFsdWUgKGV4cGVjdF9zaG1hbGwg
PQo+ID4gc2htYWxsICYgMHhGRkZGRkZGRjspCj4gPgo+Cj4gVG8gYmUgaG9uZXN0LCB0aGUgY29y
cmVjdCB0aGluZyB3aXRoIHJlZ2FyZHMgdG8gc2htYWxsIGlzIHRvIGNhcCBpdCBhdAo+IElOVF9N
QVggaW4gdGhlIGtlcm5lbCBhcyB3ZWxsLiAgSSBkaWRuJ3Qgd2FudCB0byBzdWdnZXN0IHRoaXMg
YmVjYXVzZSBpdAo+IHdhcyBGcmlkYXkgYWZ0ZXJub29uLiAgUmVwb3J0aW5nIHdoYXRldmVyIGlz
IGluIHRoZSBsb3cgMzJiaXRzIGlzIHNvcnQKPiBvZiByYW5kb20uICBCdXQgdGhhdCB3b3VsZCBt
YWtlIGl0IGV2ZW4gbW9yZSB0cmlja3kgdG8gaGFuZGxlIGluIExUUC4KPgoKT2theSwgeW91IGNh
biB0cnkgQ3lyaWwncyBzdWdnZXN0aW9uLCB3aGljaCBzb3VuZHMgbW9yZSByZWxpYWJsZS4KCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
