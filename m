Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E8FCAC599
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758108812; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AXxwT31aMxnZQPBBftPHnP4dkBscJt9aFR4IL7kfMks=;
 b=Ukf0GY1mANoO4aBfhCrLDNXDSpOyr+hdjETjTRMHa10nMYS03i8yDUMcSwOZY+msIvk37
 TBmZqpbHmi357yDLQKa8IIqpvRxo06jJHJAXLc961ckleTgxWTErUJ18SCnPttybCAPtsox
 nQ9JCtbmMIBLeSt0uIg3m2Szz9y9Zro=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D3EC3CDC1D
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 13:33:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF11B3C8069
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 09:03:42 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EE085600A3D
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 09:03:41 +0200 (CEST)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b4c1fc383eeso4256074a12.1
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 00:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1758092620; x=1758697420; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5J1YBD35YzME4fUnRREYzYzV7J9Xh5Amzs6Qryaeq1c=;
 b=Gw6Iycq3vDLUh7+OmlXqHGIgWG/zf0gkZTRUHN+LLtx7DLtMOIbcK2qBJb5MTll26k
 PucvUvZYLzBaEwa2CvPHOVLQyRG0Qu4TtXDQ8ql2gzx/a/BS8/rewhVqjSSKdVYqTayd
 kucC6Rd4CAw2HGCxMwkfQmkDtq+rP0eunJ5UFMqvZzOa/hqxjXVai3fLG5dflnP38qMs
 FirJJCcAEDqD2G006Ms99RB6zLlhurw0Xsr/Fw5LvzM1srY9IKMo5NQgh67p+ohZUaTE
 fSK75Z0k3d7bsQmmXx+rV5zZlDLQWCq+0tvUlzzXJMYUeHOdEFHNbvtaa7X+PFhmoyOq
 2xmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758092620; x=1758697420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5J1YBD35YzME4fUnRREYzYzV7J9Xh5Amzs6Qryaeq1c=;
 b=uqHhpjCOVx40AtJzbiop83Hw7ZMx94tko5+mc7ytKvhkfEVdh3nmEy/S5Ku1vRp2cb
 8HVq5d9ZmM2WZIyCnC1vUcW9tXfgf903x96ux5bUzadFEGr+rao36OTzDtNCNpj0ep3O
 JNSVhGUiYOx7J5YOICYAZeGJq4myKubtpYBEuYqNdzZt+cfdpJblIyqgFEHaGtZ8K1/7
 EyOmV89oseCg0Kd1LouQBo8wckwxjExnp0iImOTLREM+uJlH9vxltfo6j3gstUMUg1Kz
 iwwoPtQdZ0y9fZu0I/3+1+DcrroBeDHavS1zlMyQUzB9C/dA0f8bpwYjju3YOamH4fUU
 uGDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJArPW/VP02glzeSfceSllHF1UJqKCTZOKZmVvtriW8l2RjqYaqi8N7YOmG2X2Eb+W9b0=@lists.linux.it
X-Gm-Message-State: AOJu0YxGTJ1XNSo6B7P8m2+AASdhXw3rqo2Y58lOEQBwb+wwAgWWmwFy
 rZsSqgUQYQHYFvEXzHDbD7mHHcaolCrtYJxWEPuIwqcL5LqYUgUqcyKB7c1CqPRq81w5BUl3QFK
 uJpkUf9dAIfO5IdqN8QvKiTV+ztWwCCGWOiVo4yFv
X-Gm-Gg: ASbGnct7PtaXsB8yJxPi8XFlXXK1J3zyVGlbCYEOnENbUuOQZlpq3szyLSse8z3OJp8
 SK4+T/2SXr9WtEvnfRdzD4o/GrYkg9OUHzCVhAJ10x0uDce06BeCAhhDFnYpXAIPLaw2NfdASYr
 3OnlDWUOxWW2rNB1gKJtbmPlwhPLj/3zbCrHPLxAuVo93UBarwZtQh59oUpDPlI0sF1cVMawVh+
 Ad2Tax7C+jbwm6RGue0FECCPbYoNuS9l4WR8sqmfUlfCsbvbdzODs9vkB5scxZnXXs=
X-Google-Smtp-Source: AGHT+IFHqqSb0iZeLJZY85eRucnrDK2myNCsnrye3aGyc3jn1Chr0LEkdru+rbzxnAqB29LvtQoRAz7rfDOuHcs9NJY=
X-Received: by 2002:a17:902:dac4:b0:248:f84f:fd3c with SMTP id
 d9443c01a7336-26812166d0cmr13573895ad.13.1758092619855; Wed, 17 Sep 2025
 00:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250910192057.1045711-2-kuniyu@google.com>
 <202509171359.658ddb38-lkp@intel.com>
In-Reply-To: <202509171359.658ddb38-lkp@intel.com>
Date: Wed, 17 Sep 2025 00:03:28 -0700
X-Gm-Features: AS18NWCDLFhRi5V-YAZb1sP659_dYtJBp3pw_GvlN50RKdZinoKi4N8ZdQCAG4E
Message-ID: <CAAVpQUBZT4dX9hU8h6s8ew5BYX9C6yBPaRODP4zM3F-=BB4Dtw@mail.gmail.com>
To: kernel test robot <oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 17 Sep 2025 13:32:53 +0200
Subject: Re: [LTP] [PATCH v8 bpf-next/net 1/6] tcp: Save lock_sock() for
 memcg in inet_csk_accept().
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
From: Kuniyuki Iwashima via ltp <ltp@lists.linux.it>
Reply-To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mina Almasry <almasrymina@google.com>, lkp@intel.com,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, ltp@lists.linux.it,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBTZXAgMTYsIDIwMjUgYXQgMTE6MzfigK9QTSBrZXJuZWwgdGVzdCByb2JvdAo8b2xp
dmVyLnNhbmdAaW50ZWwuY29tPiB3cm90ZToKPgo+Cj4gSGVsbG8sCj4KPiBrZXJuZWwgdGVzdCBy
b2JvdCBub3RpY2VkICJCVUc6S0FTQU46c2xhYi1vdXQtb2YtYm91bmRzX2luX19pbmV0X2FjY2Vw
dCIgb246Cj4KPiBjb21taXQ6IGQ0NjVhYTA5OTQyODI1ZDkzYTM3N2MzNzE1YzQ2NGU4ZjY4Mjdm
MTMgKCJbUEFUQ0ggdjggYnBmLW5leHQvbmV0IDEvNl0gdGNwOiBTYXZlIGxvY2tfc29jaygpIGZv
ciBtZW1jZyBpbiBpbmV0X2Nza19hY2NlcHQoKS4iKQo+IHVybDogaHR0cHM6Ly9naXRodWIuY29t
L2ludGVsLWxhYi1sa3AvbGludXgvY29tbWl0cy9LdW5peXVraS1Jd2FzaGltYS90Y3AtU2F2ZS1s
b2NrX3NvY2stZm9yLW1lbWNnLWluLWluZXRfY3NrX2FjY2VwdC8yMDI1MDkxMS0wMzIzMTIKPiBi
YXNlOiBodHRwczovL2dpdC5rZXJuZWwub3JnL2NnaXQvbGludXgva2VybmVsL2dpdC9icGYvYnBm
LW5leHQuZ2l0IG5ldAo+IHBhdGNoIGxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI1MDkxMDE5MjA1Ny4xMDQ1NzExLTIta3VuaXl1QGdvb2dsZS5jb20vCj4gcGF0Y2ggc3ViamVj
dDogW1BBVENIIHY4IGJwZi1uZXh0L25ldCAxLzZdIHRjcDogU2F2ZSBsb2NrX3NvY2soKSBmb3Ig
bWVtY2cgaW4gaW5ldF9jc2tfYWNjZXB0KCkuCj4KPiBpbiB0ZXN0Y2FzZTogbHRwCj4gdmVyc2lv
bjogbHRwLXg4Nl82NC1jNjY2MGEzZTAtMV8yMDI1MDkxMwo+IHdpdGggZm9sbG93aW5nIHBhcmFt
ZXRlcnM6Cj4KPiAgICAgICAgIHRlc3Q6IG5ldC5mZWF0dXJlcwo+Cj4KPgo+IGNvbmZpZzogeDg2
XzY0LXJoZWwtOS40LWx0cAo+IGNvbXBpbGVyOiBnY2MtMTQKPiB0ZXN0IG1hY2hpbmU6IDggdGhy
ZWFkcyAxIHNvY2tldHMgSW50ZWwoUikgQ29yZShUTSkgaTctNDc5MFQgQ1BVIEAgMi43MEdIeiAo
SGFzd2VsbCkgd2l0aCAxNkcgbWVtb3J5Cj4KPiAocGxlYXNlIHJlZmVyIHRvIGF0dGFjaGVkIGRt
ZXNnL2ttc2cgZm9yIGVudGlyZSBsb2cvYmFja3RyYWNlKQo+Cj4KPiBJZiB5b3UgZml4IHRoZSBp
c3N1ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldyB2ZXJz
aW9uIG9mCj4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFn
cwo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5j
b20+Cj4gfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWxrcC8yMDI1MDkxNzEz
NTkuNjU4ZGRiMzgtbGtwQGludGVsLmNvbQo+Cj4KPiBUaGUga2VybmVsIGNvbmZpZyBhbmQgbWF0
ZXJpYWxzIHRvIHJlcHJvZHVjZSBhcmUgYXZhaWxhYmxlIGF0Ogo+IGh0dHBzOi8vZG93bmxvYWQu
MDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDI1MDkxNy8yMDI1MDkxNzEzNTkuNjU4ZGRiMzgtbGtw
QGludGVsLmNvbQo+Cj4KPiB3ZSBzYXcgYSBsb3Qgb2YgIkJVRzpLQVNBTjpzbGFiLW91dC1vZi1i
b3VuZHNfaW5fX2luZXRfYWNjZXB0IiBpc3N1ZSBpbiBkbWVzZwo+IHVwbG9hZGVkIHRvIGFib3Zl
IGxpbmssIGJlbG93IGlzIGp1c3Qgb25lIGV4YW1wbGU6Cj4KPgo+IFsgIDQ2OC45ODQyOTFdW1Qz
MDE4MF0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Cj4gWyAgNDY4Ljk5Mjc1M11bVDMwMTgwXSBCVUc6IEtBU0FOOiBzbGFi
LW91dC1vZi1ib3VuZHMgaW4gX19pbmV0X2FjY2VwdCsweDVjNi8weDY0MAoKT2ggSSBtaXN1c2Vk
IHNrX2lzX21wdGNwKCkgd2hpY2ggYXNzdW1lcyB0aGF0IHNrX2lzX3RjcCgpCmlzIGFsd2F5cyB0
cnVlIGFuZCBzaG91bGQgbm90IGJlIHVzZWQgaWYgc2tfaXNfdGNwKCkgaXMgZmFsc2UgZm9yClND
VFAsIHNvIHNrX2lzX21wdGNwKCkgdGVzdCB3YXMgdW5uZWNlc3NhcnkKCkknbGwgcmVtb3ZlIGl0
LCB0aGFua3MhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
