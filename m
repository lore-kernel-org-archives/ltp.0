Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4AFCD6E4C
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 04:12:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7E783E59FE
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 06:11:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB0803E52CD
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 06:11:41 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8A5A32001DF
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 06:11:41 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-91550f68089so106044285a.2
 for <ltp@lists.linux.it>; Sun, 31 May 2026 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780287100; x=1780891900; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tn4KYc2MPIOSTTuwTjIdtlYUF82eifKyUq6HtdAT2gI=;
 b=V9ZbNm+AdN8qYert6knN6iDyL8Qa2qUjzMxNYR7IEypaAGNF7tHfc7heNNg1s3q/d5
 QMUwpIXt4Thi3gg3cJA2MS95wfqgGQIFfA7DPTO3+w455NEwQAHo4EWHksJZTgA0dUv8
 v2hRfrKrhtxuDC2pcYdOPzCi3S13rOXlpMwjWVYSRFZEQswvJ+ILY+qI78uV0gcL3cwC
 L2UbAq6v2LaoKiivIMt+WgqQOM6DQ5bJnFNXAzfTcmAlDknxG7atfXeZkrNS0K9PxZrB
 P4Oprkv2/FC9pwMko441A87Y/HC+haQQaoelDHw4pmqDn0LLjvHTuEOsH7/OHrHLFRTy
 74jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780287100; x=1780891900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tn4KYc2MPIOSTTuwTjIdtlYUF82eifKyUq6HtdAT2gI=;
 b=jSk32Me2eaCQT/VYjImCmU//4WqAZxVnyWPGgHzY2qVrJbOOgPXBDdoflrYeRPtgjz
 zcrV0+rUTxQ4YxpqjeRrw+zxLDti3Zzb055WzOtJF6ChKvtbmEkrdFTgsXOBOigmsa/4
 LaMojwoBVGnKlQE8cBwHji+CWNBxPJwGN1iB3li160BliE3bKY1P2OFOE4TCLY1NWzjl
 Y2W9YQwc0Aje5AJt6RViP+Uzyg2UhBru8SfzG9w6ZiL+jJJtiebNxSVGhRJOvOZ3FpYM
 phSxiLxvd8/QEe/8NfMAoJTLYLaYGN8LVS6zcqz+XsEgnS77hl0M3rEHXle1rdPfmZxB
 hx1A==
X-Gm-Message-State: AOJu0Ywbi20gAm9TJ2Oxsfwz1T+jlcpzoQimlBpflh0GsH1+gBTVyGGi
 M9yqh2b1VGbDhgsRYZdfvNSYw7dFgA5ivrt6n92Xv9VF2lqmeLxQBOer
X-Gm-Gg: Acq92OG9LirMQw9YMyaxzvhmPgZPRwEJDGRTrdH1VCiC1AFzCK1toBIylbeLqqG0JLf
 TzkmXqvIe17p696iTfE3ds/rwTBKJzL7mh/BBjoWrV2t4prfoeCien47EsC9ccnpGtvAbxalg9w
 BGpyk5IxtzfPpQCSoRLAJStoXwbVl51+Wv8Cward2mt5zS9TX1UqON/S7oog36iWIIMQw6BZpKq
 52yTdRkgwF6/ddy8TqE4FhRFyyqzTaMG7KVX4MWieDzbux0gXwWrD962VZAtAnQQ/da5eW0wk3Y
 okZBL713v94QxyDY4hBUpOHL3vPfGDnlohjNyNe1Q3tFJ4lbuLM9IkMXLKoWVNCMVu70SxYB2BW
 7mVoZKjfuSWrltYXscTu3uIHqqIeKGw6DRBNDiJ68CyXoU8H9maO9xmahqZB/X1ksvvlfzhovWx
 rRuouBclqGGEuzoevEJwihpTHju7JaUz4/T9iB7Z/piZEsx7BDoqJYWuM81Q5GBOLb38Svg2N9w
 T8fQEJYsE8vVC2G46edmzPvp5vgnuR1xMjoYMn9aWZK6TH5LB4=
X-Received: by 2002:a05:620a:45aa:b0:915:2023:fd2f with SMTP id
 af79cd13be357-9153da34832mr1413509385a.32.1780287100143; 
 Sun, 31 May 2026 21:11:40 -0700 (PDT)
Received: from
 runnervm3jyl0.dy0dcyvzke5e5dxxzu5nqqj3qb.cx.internal.cloudapp.net
 ([172.172.119.99]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-915325fd899sm896654885a.30.2026.05.31.21.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 21:11:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: AnonymeMeow <anonymemeow@gmail.com>
Date: Mon,  1 Jun 2026 04:11:39 +0000
Message-ID: <20260601041139.4107-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531234116.36480-1-anonymemeow@gmail.com>
References: <20260531234116.36480-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify13: fix test failure when running iterations
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

SGkgQW5vbnltZU1lb3csCgpUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4gT25lIGlzc3VlIGJlbG93
LgoKPiBmYW5vdGlmeTEzOiBmaXggdGVzdCBmYWlsdXJlIHdoZW4gcnVubmluZyBpdGVyYXRpb25z
Cj4KPiBUaGUgRkFOX0RFTEVURV9TRUxGIHRlc3QgY2FzZSByZW1vdmVzIHRlc3QgZmlsZXMsIGNh
dXNpbmcgbGF0ZXIKPiBpdGVyYXRpb25zIHRvIGNyYXNoLiBSZWNyZWF0ZSB0aGUgcmVtb3ZlZCBm
aWxlcyBhZnRlciB0aGUgdGVzdCB0bwo+IHJlc3RvcmUgdGhlIGV4cGVjdGVkIGluaXRpYWwgc3Rh
dGUuIEFuZCBhZGp1c3QgdGhlIG92ZXJsYXlmcyBtb3VudAo+IHRpbWluZyB0byBhdm9pZCBjcmVh
dGluZyBmaWxlcyBkaXJlY3RseSBpbiB0aGUgZmlsZXN5c3RlbSB1bmRlcm5lYXRoCj4gdGhlIGFs
cmVhZHkgbW91bnRlZCBvdmVybGF5ZnMuCgpUaGUgY29tbWl0IGJvZHkgZGVzY3JpYmVzIHR3byBv
ZiB0aGUgdGhyZWUgbWVhbmluZ2Z1bCBjaGFuZ2VzIGluIHRoaXMKcGF0Y2ggYnV0IG9taXRzIHRo
ZSBkb19jbGVhbnVwKCkgZml4ZXMsIHdoaWNoIGFyZSBhIHNpZ25pZmljYW50IHBhcnQKb2YgdGhl
IGZpeC4KCkluIGRvX2NsZWFudXAoKSwgdGhlIHBhdGNoOgogIDEuIE1vdmVzIFNBRkVfVU1PVU5U
KE9WTF9NTlQpIGJlZm9yZSB0aGUgYmluZF9tb3VudGVkIGJsb2NrIChvbGQKICAgICBvcmRlcmlu
ZyBjb3VsZCBsZWF2ZSB0aGUgb3ZlcmxheSBtb3VudGVkIHdoZW4gY2xlYXJpbmcgdGhlIGJpbmQK
ICAgICBtb3VudCBpbiBzb21lIG1vdW50IHN0YWNraW5nIHNjZW5hcmlvcykuCiAgMi4gQWRkcyBk
ZWxldGVfb2JqZWN0cygpIGJlZm9yZSB1bm1vdW50aW5nIE1PVU5UX1BBVEggKGVuc3VyZXMgdGVz
dAogICAgIGZpbGVzIGFyZSByZW1vdmVkIGZyb20gT1ZMX0xPV0VSL09WTF9VUFBFUiBzbyBhIHBl
cnNpc3RlbnQKICAgICBkZXZpY2UgZG9lcyBub3QgY2Fycnkgc3RhbGUgc3RhdGUgaW50byB0aGUg
bmV4dCBpdGVyYXRpb24pLgoKVGhlc2UgYXJlIHJlYWwgY29ycmVjdG5lc3MgZml4ZXMgdGhhdCBi
ZWxvbmcgaW4gdGhlIGNvbW1pdCBkZXNjcmlwdGlvbi4KClBsZWFzZSBleHBhbmQgdGhlIGJvZHkg
dG8gY292ZXIgYWxsIHRocmVlIGNoYW5nZXMuCgotLS0KClRoZSBjb2RlIGNoYW5nZXMgdGhlbXNl
bHZlcyBsb29rIGNvcnJlY3Q6CgogICogVGhlIG5ldyBtYWNyb3MgVFNUX1ZBUklBTlRfT1ZMX0xP
V0VSID0gKHRzdF92YXJpYW50ICYgMSkgYW5kCiAgICBUU1RfVkFSSUFOVF9PVkxfV0FUQ0ggPSAo
dHN0X3ZhcmlhbnQgPiAyKSBmYWl0aGZ1bGx5IHJlcGxhY2UgdGhlCiAgICBvcGVuLWNvZGVkIGV4
cHJlc3Npb25zIGFuZCBpbXByb3ZlIHJlYWRhYmlsaXR5LgoKICAqIE1vdmluZyBUU1RfTU9VTlRf
T1ZFUkxBWSgpIGFmdGVyIGNyZWF0ZV9vYmplY3RzKCkgaXMgdGhlIHJpZ2h0CiAgICBmaXg6IG9i
amVjdHMgYXJlIG5vdyBjcmVhdGVkIGluIE9WTF9MT1dFUiBiZWZvcmUgdGhlIG92ZXJsYXkgaXMK
ICAgIHN0YWNrZWQgb24gdG9wLCBhdm9pZGluZyB1bmRlZmluZWQgYmVoYXZpb3VyIHdoZW4gbW9k
aWZ5aW5nIGEKICAgIGxvd2VyIGRpcmVjdG9yeSB3aGlsZSBvdmVybGF5IGlzIGFscmVhZHkgbW91
bnRlZC4KCiAgKiBjbGVhbl91cHBlcl9kaXIoKSBjb3JyZWN0bHkgdXNlcyBTQUZFX1VOTElOSygp
IGZvciBhbGwgb2JqZWN0cwogICAgKGluY2x1ZGluZyB0aGUgZGlyZWN0b3J5KS4gQWZ0ZXIgU0FG
RV9STURJUigpIG9uIGEgbG93ZXItb25seQogICAgZGlyZWN0b3J5IHRocm91Z2ggb3ZlcmxheWZz
LCB0aGUga2VybmVsIHdyaXRlcyBhIGNoYXItZGV2aWNlCiAgICB3aGl0ZW91dCAoMDowKSB0byBP
VkxfVVBQRVIgYXQgdGhhdCBwYXRoIOKAlCBub3QgYW4gb3BhcXVlCiAgICBkaXJlY3Rvcnkg4oCU
IHNvIFNBRkVfVU5MSU5LKCkgc3VjY2VlZHMuIFRoZSBmdW5jdGlvbiBpcyBvbmx5CiAgICByZWFj
aGFibGUgdmlhIHZhcmlhbnQgMyAodmFyaWFudCAxJ3MgRkFOX0RFTEVURV9TRUxGIHBhdGggaXMK
ICAgIGFsd2F5cyBUQ09ORidkIGJ5IHRoZSAiYmFzZSBmcyBjYW5ub3QgYmUgd2F0Y2hlZCBmb3Ig
ZGVsZXRlIHNlbGYKICAgIGV2ZW50cyIgZ3VhcmQpLCBzbyB0aGlzIGFzc3VtcHRpb24gYWx3YXlz
IGhvbGRzLgoKICAqIFRoZSBuZXcgZG9fY2xlYW51cCgpIG9yZGVyaW5nIOKAlCBvdmxfYmluZCDi
hpIgT1ZMX01OVCDihpIgYmluZCDigJQgaXMKICAgIGNvcnJlY3QuIEZvciB2YXJpYW50IDMgYWZ0
ZXIgY2xlYW5fdXBwZXJfZGlyKCkgdGhlIG1vdW50cyBhcmUKICAgIHJlLXN0YWNrZWQgaWRlbnRp
Y2FsbHkgdG8gdGhlIHBvc3Qtc2V0dXAgc3RhdGUsIHNvIGNsZWFudXAKICAgIHVud2luZHMgdGhl
bSBpbiB0aGUgcmlnaHQgb3JkZXIuCgpWZXJkaWN0OiBOZWVkcyByZXZpc2lvbiAoY29tbWl0IG1l
c3NhZ2Ugb25seSkuCgpMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
