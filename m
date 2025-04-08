Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C52C369A5
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744128248; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : content-type : content-transfer-encoding :
 sender : from; bh=gMrKCp+8K7fNdYtp/w+/QKIBzPfhN0eOWTPI28Z/Tp0=;
 b=TzSTif4P70oTZV4PGuzthNMLiMoYT8LNfonrPFLVN+AHfdqK6GlikJd+HwzIxmFIjBucT
 0eXnbvctMq5LgNM1PJWNLPBPikCMLcIjLxjuirJcbpuGGH28A4IKOkgK9fYUu3lwkJ8B1yO
 5lgpf9uXl57GRjckvEPf4VHZnS4/+og=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2449B3CB3D1
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 18:04:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 27E823CB35A
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 18:03:46 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with UTF8SMTPS id 2DA45140075B
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 18:03:45 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so4522779f8f.3
 for <ltp@lists.linux.it>; Tue, 08 Apr 2025 09:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744128224; x=1744733024;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ovt8WiLl5CT2hf0ZhPrYhWsvQN7zLvOZ5ECWzMmN+Go=;
 b=UX7MWqluvuX+4wHTKVu9gm4hmnxg3L9K+a/H58uv/eDx5Wsi7bok9wmzlfKmV6uDn2
 hoUQw8Sz3bfdAjM1RCLo8G3GwPcuCGoY9X0r18wcZfV6hrMoA3Hzc/wH6WXVklkW35hI
 YX5Q858QCYyuEBK0Xgx9NQFE6XSlkaJltmRSFiHTMK+6DyvWWq7GOYh+g6IbsWekOXvd
 +317NaoRYl86pL4OBIBTzekZAuKNLEIea5gh6r/qvWtusEWJeMZZXL7eFje0njmS+XFI
 9GIslsxk3rRTr1LDS9Hd+yzUvKefhNgLuLYydMddimr2tIyD8l0E4amd67Iv/tKneTPJ
 +FaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJK5vHZl+BRcn7vSK0iyhLevBqUih607xlOGD3voOI6Wt6tNxVUEJWwereP73kcCT4uZY=@lists.linux.it
X-Gm-Message-State: AOJu0YyglCm320lj6xsjPMqnvMP5NspCpbOgfNrNIFTj61rlQ5ZAKCyo
 X7sy53Qe7b1eX4VMT0jMV7LV5RG73ZacAnPS+SYgpb7IcWhBU5FJmO1dSztxvUo=
X-Gm-Gg: ASbGncuE8eWY9ul6AaVhkWaVB0S+DZ9ozgvSLamamtuGDoWeCZJksqjU7l1mO/woydI
 QUsLCOjozNP1hj2kB/XJ/Ue+pIB951Q9+0krhdi9WHRgr1cAbvVLq5HIDdbPG3JMcoB7HWoo9YA
 Egi/ZoKkToCX7fFAuOqDnBNSWQ13GzsifA/hoKY1aisNFhtlJSQAVsWJU21YtKUiBqYIwd+OuiB
 OlMriSJHnOZQM04PPMOo01KgAlIq5XpwAf2dA8TksUY+Uq+zDShA/FrwDSVQSPmsevcLEDx96D1
 TS1LPYQ2A4nkBjUYwiqwKXQpLrEBRJ485osjcKofvzl5
X-Google-Smtp-Source: AGHT+IGkRZ8Q3teI773pqrusxbctWOM86ZLFJGbvPgTOJm2UHOUQXAJkPwsTJ6k3Dy24wlaFpYb/2w==
X-Received: by 2002:a5d:5f48:0:b0:38f:3e1c:211d with SMTP id
 ffacd0b85a97d-39cba9329b4mr15276688f8f.14.1744128224395; 
 Tue, 08 Apr 2025 09:03:44 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785bfe40sm102379935ad.72.2025.04.08.09.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 09:03:43 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 08 Apr 2025 13:03:41 -0300
Message-Id: <D91DURHVD1PG.XSV2D1XPW2YA@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250408114432.220841-1-pvorel@suse.cz>
In-Reply-To: <20250408114432.220841-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] sphinx: Update to 7.2.6, python 3.12,
 ubuntu-24.04
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIEFwciA4LCAyMDI1IGF0IDg6NDQgQU0gLTAzLCBQZXRyIFZvcmVsIHdyb3RlOgo+IFVw
ZGF0ZSBzcGhpbnggdG8gNy4yLjYsIHB5dGhvbiAzLjEyLiBUaGlzIHJlcXVpcmVzIHRvIHVwZGF0
ZQo+IC5yZWFkdGhlZG9jcy55bWwgdG8gdXNlIHVidW50dS0yNC4wNCBbMV0sIGJlY2F1c2Uga2Vl
cCBpbiBzeW5jIHNwaGlueCBpbgo+IHJlYWR0aGVkb2NzIHdpdGggd2l0aCB0aGUgb25lIGZvciBs
b2NhbCBkZXZlbG9wbWVudCBhbmQgZ2l0aHViIENJLgo+IFJhaXNpbmcgcHl0aG9uIG1ha2VzIHNl
bnNlLCBhcyBkZXZlbG9wbWVudCBpcyB1c3VhbGx5IGRvbmUgb24gbmV3ZXIKPiBkaXN0cm9zLCB3
ZSB3ZXJlIHN0aWxsIHVzaW5nIG9sZCBweXRob24gMy42Lgo+Cj4gVGhpcyBmaXhlcyB0aGUgcHJv
YmxlbSBvbiBsb2NhbCBkZXZlbG9wbWVudCB0cnlpbmcgdG8gcnVuIG9sZGVyIHNwaGlueAo+IDUu
MyBvbiBweXRob24gMy4xMyByZXF1aXJlcyB0byB1c2UgaW1naGRyLCB3aGljaCB3YXMgcmVtb3Zl
ZCBmcm9tCj4gc3RhbmRhcmQgbGlicmFyeSAoYWx0ZXJuYXRpdmVseSB3ZSdkIG5lZWQgdG8gaW5z
dGFsbCBpdCBmcm9tIHBpcCB2aWEKPiBhZGRpbmcgc3RhbmRhcmQtaW1naGRyIGludG8gcmVxdWly
ZW1lbnRzLnR4dCkuCj4KPiBbMV0gaHR0cHM6Ly9hYm91dC5yZWFkdGhlZG9jcy5jb20vYmxvZy8y
MDI0LzA2L3VidW50dS0yNC0wNC8KPgo+IEZpeGVzOiBiOTAwYjc5MGU5ICgiZG9jOiBBZGQgc3Bo
aW54IHRvIHJlcXVpcmVtZW50cy50eHQiKQo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PgoKVGVzdGVkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2Uu
Y29tPgpSZXZpZXdlZC1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClRl
c3RlZCBvbiBUdW1ibGV3ZWVkLCBJIHdhcyBoYXZpbmcgdGhpcyBiZWZvcmU6CgokIG1ha2UKbWFr
ZSAtQyAvbW50L2V4dC9zcmMvbGludXgvbHRwL2ZpeGVzL21ha2VfZG9jL21ldGFkYXRhCm1ha2Vb
MV06IEVudGVyaW5nIGRpcmVjdG9yeSAnL21udC9leHQvc3JjL2xpbnV4L2x0cC9maXhlcy9tYWtl
X2RvYy9tZXRhZGF0YScKSE9TVENDIG1ldGFkYXRhL21ldGFwYXJzZQpIT1NUQ0MgbWV0YWRhdGEv
bWV0YXBhcnNlLXNoCi9tbnQvZXh0L3NyYy9saW51eC9sdHAvZml4ZXMvbWFrZV9kb2MvbWV0YWRh
dGEvcGFyc2Uuc2ggPiBsdHAuanNvbgptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL21udC9l
eHQvc3JjL2xpbnV4L2x0cC9maXhlcy9tYWtlX2RvYy9tZXRhZGF0YScKaWYgWyAtZCAudmVudiBd
OyB0aGVuIGlmIFsgIngiICE9ICJ4IiBdOyB0aGVuIC4gLnZlbnYvYmluL2FjdGl2YXRlLmZpc2g7
IGVsc2UgLiAudmVudi9iaW4vYWN0aXZhdGU7IGZpOyBmaTsKc3BoaW54LWJ1aWxkIC1iIGh0bWwg
LiBodG1sClJ1bm5pbmcgU3BoaW54IHY1LjMuMAoKRXh0ZW5zaW9uIGVycm9yOgpDb3VsZCBub3Qg
aW1wb3J0IGV4dGVuc2lvbiBzcGhpbnguYnVpbGRlcnMuZXB1YjMgKGV4Y2VwdGlvbjogTm8gbW9k
dWxlIG5hbWVkICdpbWdoZHInKQptYWtlOiAqKiogW01ha2VmaWxlOjI3OiBhbGxdIEVycm9yIDIK
ClRoYW5rIHlvdSwKLQlSaWNhcmRvLgoKCj4gLS0tCj4gSGksCj4KPiBmaXJzdCwgSSdtIHNvcnJ5
IGZvciBhIHJlZ3Jlc3Npb24uIEkgdGVzdGVkIGFsbCB0aGUgcHJldmlvdXMgdmVyc2lvbnMKPiBj
YXJlZnVsbHkgZXZlbiBsb2NhbGx5LCBidXQgaW4gdGhlIGVuZCB0aGUgZmluYWwgdmFyaWFudCBJ
IG9idmlvdXNseQo+IG9taXQgdG8gdGVzdC4KPgo+IFRlc3RlZDoKPiBodHRwczovL2FwcC5yZWFk
dGhlZG9jcy5vcmcvcHJvamVjdHMvbGludXgtdGVzdC1wcm9qZWN0L2J1aWxkcy8yNzc4NDU4OC8K
Pgo+IEFsdGVybmF0aXZlbHksIHdlIGNvdWxkIGtlZXAgb2xkIGRpc3Ryb3MgYW5kIGp1c3QgYWRk
IHN0YW5kYXJkLWltZ2hkcgo+ICh3aXRob3V0IHZlcnNpb24pIHRvIGRvYy9yZXF1aXJlbWVudHMu
dHh0LiBCdXQgc29vbmVyIG9yIGxhdGVyIHdlIHdpbGwKPiBuZWVkIHRvIHVwZ3JhZGUgdGh1cyBJ
J20gc2VuZGluZyB0aGlzIHZlcnNpb24uCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gIC5y
ZWFkdGhlZG9jcy55bWwgICAgIHwgNCArKy0tCj4gIGRvYy9yZXF1aXJlbWVudHMudHh0IHwgMiAr
LQo+ICAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS8ucmVhZHRoZWRvY3MueW1sIGIvLnJlYWR0aGVkb2NzLnltbAo+IGluZGV4
IDU0MzRlZjQ5ZDYuLjUxODI1ZGE3N2YgMTAwNjQ0Cj4gLS0tIGEvLnJlYWR0aGVkb2NzLnltbAo+
ICsrKyBiLy5yZWFkdGhlZG9jcy55bWwKPiBAQCAtMSw5ICsxLDkgQEAKPiAgdmVyc2lvbjogMgo+
Cj4gIGJ1aWxkOgo+IC0gIG9zOiAidWJ1bnR1LTIyLjA0Igo+ICsgIG9zOiAidWJ1bnR1LTI0LjA0
Igo+ICAgIHRvb2xzOgo+IC0gICAgcHl0aG9uOiAiMy42Igo+ICsgICAgcHl0aG9uOiAiMy4xMiIK
PiAgICBhcHRfcGFja2FnZXM6Cj4gICAgICAtIGF1dG9jb25mCj4gICAgICAtIGVuY2hhbnQtMgo+
IGRpZmYgLS1naXQgYS9kb2MvcmVxdWlyZW1lbnRzLnR4dCBiL2RvYy9yZXF1aXJlbWVudHMudHh0
Cj4gaW5kZXggNjMwMmVjZDlmMi4uMWI5YTk4NDU0NyAxMDA2NDQKPiAtLS0gYS9kb2MvcmVxdWly
ZW1lbnRzLnR4dAo+ICsrKyBiL2RvYy9yZXF1aXJlbWVudHMudHh0Cj4gQEAgLTEsNiArMSw2IEBA
Cj4gICMgVXNlIHRoZSBzYW1lIHNwaGlueCBhcyBvbiByZWFkdGhlZG9jcy5vcmcuIFdoZW4gdXBk
YXRlZCwgbWFrZSBzdXJlCj4gICMgc3BoaW54LXJ0ZC10aGVtZSBpcyBjb21wYXRpYmxlIHdpdGgg
c3BoaW54Lgo+IC1zcGhpbng9PTUuMy4wCj4gK3NwaGlueD09Ny4yLjYKPiAgc3BoaW54LXJ0ZC10
aGVtZT09Mi4wLjAKPgo+ICBsaW51eGRvYz09MjAyMzEwMjAKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
