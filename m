Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA623C30658
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 13:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719927988; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=naE4wLbxru3NDh0QfCzHcYZCysQgQO233Lho5jF8Jkw=;
 b=UkxrMK822ZO98NeA8Y1kSzHCfVUvdqBEGyATzc6r9nPeGsSgzTl1Lll/mKDAblQRYsF48
 kLSFqeuNyo+3+BjXPLJv0NwPi9ektkJrnO4wcCPYThmwhCjX79KeqOuQR3fDAYC8LKb6j1E
 WdVagCMxyebRBFZ7/sLJXq1iPNaGhD4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36C1B3D3EDF
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 15:46:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D4BB3CCE0D
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:46:06 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 81EAB600A70
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 15:46:05 +0200 (CEST)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ec61eeed8eso52408471fa.0
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719927965; x=1720532765; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L6EyUFaTIKxjxWnPTvTTGOVED/y4wNLAcJKoQSNs6ZY=;
 b=JvUjUCteoKQSIqaENW4i3N3VDWbprn0g4cTA7tSxn3RpEvO7B02i4+0lFt8zU7hTxV
 xIqissgBLI1JxFYrMvwt6goxihcd9oL50iUm2oA7JZ4DMw2648nn0GlahfBtUqmjEqmY
 loLW6o6kqsFZ6m63fir37SlK+vrr7sgENvLhXdeP+eaYMa0qwcywRy2K7LV2TduuSCyL
 hYMRADmeZ34CJjDpQqk6XPqGYSSsjvD5zOMIG6MAnJ4o4MpNv2AqCgMZfSEMXmPrqnvy
 mTfLjzSc8yAuhQJp9VIivDtk8evqHOoyU1XddDUfZI1blBBZYPNsqLWH+t2xgVGrKkZs
 t6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927965; x=1720532765;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L6EyUFaTIKxjxWnPTvTTGOVED/y4wNLAcJKoQSNs6ZY=;
 b=LbGdmtRn6kckccOddHF+MQJ4HDjG82QfSzEwYPiCYVhA+TeOHSLNFtk1ZA+D0Gb1HY
 wdK0edjudksa0m7cA1IGbw/cfvbVmJA9iv4UjMM2Q7Ni4Hq2VWgF2LeS9g6aY5qgWQOg
 bTmBac5ngerJN/9CeemZlSGiHK1g4ghTk4R+3pQya83m4gcEQ/cgZpNJ/d4+C5QlyPpf
 UrPt2LnxzGOH13AzrdU7adNEyCCq6SC1F1ZJOVvEczfWJ40dv7k4bVXACavX9Fd6JOPE
 q5QUNhNiCxDHRlbm88W4pqsQJDF7WHsGeqSvrdO8NlgQ1AC3PAGqoxQhjagz/+QmulWY
 bLlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAHGhSbKQOyeDUKQ01a7B42g8Iziodn9D/FxfzrJS+iJCGGOAevnBwJ2C8D+kfMh5FV3XgAF5Wujlx0e5Z+MnYr1E=
X-Gm-Message-State: AOJu0Yyj2CCmKqtIqcWiBAqXi1c0249FjR4KsWr/4e88wNUyqAkWfrdn
 WhQzXcEY1dUDpzruqoKIk4vGADhcHd6/ihb2Bh8GNtovV3labogdXWYm5E/+pps=
X-Google-Smtp-Source: AGHT+IFZi/kgoI4q9y7G0oJH93j6fiGhm3CPZUNHXJg5ZbpCqBXc7npx5QZSo9GnN/fPi69ytRY5nQ==
X-Received: by 2002:a2e:9c58:0:b0:2ec:3180:d4f7 with SMTP id
 38308e7fff4ca-2ee5e375a38mr51241421fa.26.1719927964201; 
 Tue, 02 Jul 2024 06:46:04 -0700 (PDT)
Received: from [10.232.133.69] ([88.128.88.9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb0e94da7csm248985ad.50.2024.07.02.06.45.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 06:46:03 -0700 (PDT)
Message-ID: <00697ef1-ea3c-48b6-8910-67fc5058c9ce@suse.com>
Date: Tue, 2 Jul 2024 15:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Andrea Cervesato <acervesato@suse.de>
References: <20240702094745.96521-1-liwang@redhat.com>
 <20240702.Auya5Chaipho@digikod.net>
 <CAEemH2foX0KqS7OemqGbt0xj5iSbtzpcnTxvBAaJzr9JPKx71g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2foX0KqS7OemqGbt0xj5iSbtzpcnTxvBAaJzr9JPKx71g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] landlock: fix minimal required size for
 landlock_ruleset_attr copying
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it,
 paul@paul-moore.com, gnoack@google.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNy8yLzI0IDE1OjM0LCBMaSBXYW5nIHdyb3RlOgo+Cj4KPiBPbiBUdWUsIEp1bCAyLCAyMDI0
IGF0IDk6MDDigK9QTSBNaWNrYcOrbCBTYWxhw7xuIDxtaWNAZGlnaWtvZC5uZXQ+IHdyb3RlOgo+
Cj4gICAgIE9uIFR1ZSwgSnVsIDAyLCAyMDI0IGF0IDA1OjQ3OjQ1UE0gKzA4MDAsIExpIFdhbmcg
d3JvdGU6Cj4gICAgID4gQXMga2VybmVsIGNvbW1pdCBmZmY2OWZiMDNkZGUgKCJsYW5kbG9jazog
U3VwcG9ydCBuZXR3b3JrIHJ1bGVzCj4gICAgIHdpdGggVENQIGJpbmQgYW5kIGNvbm5lY3QiKQo+
ICAgICA+IGludHJvZHVjaW5nIGEgbmV3IGZpZWxkICdoYW5kbGVkX2FjY2Vzc19uZXQnIGluIHRo
ZSBzdHJ1Y3R1cmUKPiAgICAgbGFuZGxvY2tfcnVsZXNldF9hdHRyLAo+ICAgICA+IGJ1dCBpbiB0
aGUgbGFuZGxvY2tfY3JlYXRlX3J1bGVzZXQoKSBpdCBzdGlsbCB1c2VzIHRoZSBmaXJzdAo+ICAg
ICBmaWVsZCAnaGFuZGxlZF9hY2Nlc3NfZnMnCj4gICAgID4gdG8gY2FsY3VsYXRlIG1pbmltYWwg
c2l6ZSwgc28gdGhhdCBtYWRlIGRlY3JlYXNlIDEgaXMgdXNlbGVzcyBpbgo+ICAgICBMVFAgbGFu
ZGxvY2swMS5jIHRvCj4gICAgID4gdGVzdCB0aGUgdG9vLXNtYWxsLXNpemUuCj4gICAgID4KPiAg
ICAgPiBUZXN0IGNvZGU6Cj4gICAgID7CoCDCoCBydWxlX3NtYWxsX3NpemUgPSBzaXplb2Yoc3Ry
dWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0cikgLSAxOwo+ICAgICA+wqAgwqAgdHN0X3N5c2NhbGwo
X19OUl9sYW5kbG9ja19jcmVhdGVfcnVsZXNldCwgLi4uLAo+ICAgICBydWxlX3NtYWxsX3NpemUs
IDApCj4gICAgID4KPiAgICAgPiBSZXN1bHQ6Cj4gICAgID7CoCDCoGxhbmRsb2NrMDEuYzo0OTog
VEZBSUw6IFNpemUgaXMgdG9vIHNtYWxsIGV4cGVjdGVkIEVJTlZBTDoKPiAgICAgRU5PTVNHICg0
MikKPgo+ICAgICBJbnRlcmVzdGluZywgdGhpcyBsb29rcyBsaWtlIGEgYnVnIGluIHRoZXNlIExU
UCB0ZXN0cy4KPgo+Cj4gWWVzLCBBbmRyZWEgZHJhZnRlZCBhIHNlcmllcyBvZiBsYW5kbG9jayB0
ZXN0cyBmb3IgTFRQLgo+Cj4gRllJIC0gCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
cm9qZWN0L2x0cC9saXN0Lz9zZXJpZXM9JnN1Ym1pdHRlcj0mc3RhdGU9JnE9bGFuZGxvY2smYXJj
aGl2ZT0mZGVsZWdhdGU9IAo+IDxodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3Qv
bHRwL2xpc3QvP3Nlcmllcz0mc3VibWl0dGVyPSZzdGF0ZT0mcT1sYW5kbG9jayZhcmNoaXZlPSZk
ZWxlZ2F0ZT0+Cj4KPgo+ICAgICA+Cj4gICAgID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+Cj4gICAgID4gQ2M6IE1pY2thw6tsIFNhbGHDvG4gPG1pY0BkaWdpa29k
Lm5ldD4KPiAgICAgPiBDYzogS29uc3RhbnRpbiBNZXNraGlkemUgPGtvbnN0YW50aW4ubWVza2hp
ZHplQGh1YXdlaS5jb20+Cj4gICAgID4gQ2M6IFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5j
b20+Cj4gICAgID4gLS0tCj4gICAgID4KPiAgICAgPiBOb3RlczoKPiAgICAgPsKgIMKgIMKgSGkg
TWlja2FlbCwKPiAgICAgPsKgIMKgIMKgIMKgIEknbSBub3QgcXVpdGUgc3VyZSBpZiB0aGF0IGlz
IG9uIHB1cnBvc2UgdG8gdXNlIHRoZSBmaXJzdAo+ICAgICBmaWVsZCBvciBrZXJuZWwKPiAgICAg
PsKgIMKgIMKgIMKgIGJ1ZywgY2FuIHlvdSB0YWtlIGEgbG9vaz8KPgo+ICAgICBIaSBMaSwKPgo+
ICAgICBZZXMgdGhpcyBpcyBvbiBwdXJwb3NlLsKgIFRoZSBoYW5kbGVkX2FjY2Vzc19mcyBtaW5p
bWFsIHNpemUgY2hlY2sKPiAgICAgc2hvdWxkCj4gICAgIG5ldmVyIGNoYW5nZSBmb3IgYmFja3dh
cmQgY29tcGF0aWJpbGl0eSByZWFzb24uwqAgVXNlciBzcGFjZSBidWlsdCB3aXRoCj4gICAgIG9s
ZCBoZWFkZXJzIG11c3Qgc3RpbGwgd29yayB3aXRoIG5ldyBrZXJuZWxzLsKgIFRoaXMgaXMgdGVz
dGVkIHdpdGggdGhlCj4gICAgICJpbmNvbnNpc3RlbnRfYXR0ciIgdGVzdCBpbgo+ICAgICB0b29s
cy90ZXN0aW5nL3NlbGZ0ZXN0cy9sYW5kbG9jay9iYXNlX3Rlc3QuYwo+Cj4KPiBUaGFua3MgZm9y
IHRoZSBjb25maXJtYXRpb24sIHZlcnkgaGVscGZ1bC4KPgo+IEBBbmRyZWEgQ2VydmVzYXRvIDxt
YWlsdG86YWNlcnZlc2F0b0BzdXNlLmRlPiwgc2VlbXMgd2UgaGF2ZSB0byBhZGp1c3QgCj4gdGhl
IHRlc3QgdG8gdXNlIGEgcmVhbCBzbWFsbAo+IHJ1bGUgc2l6ZSB3aGljaCBpcyBhdCBsZWFzdCBz
bWFsbCB0aGFuIHNpemVvZihfX3U2NCkuCj4KU3VyZSwgdGhhbmtzIGZvciBjaGVja2luZy4KPgo+
IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoKQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
