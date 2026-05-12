Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341F9CD4855
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 08:08:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 576D23CF2B9
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 10:08:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC59B3CC915
 for <ltp@lists.linux.it>; Tue, 12 May 2026 10:08:19 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7EF591A00933
 for <ltp@lists.linux.it>; Tue, 12 May 2026 10:08:18 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8d736211595so371104385a.0
 for <ltp@lists.linux.it>; Tue, 12 May 2026 01:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778573297; x=1779178097; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQwzvWevRFf2A9PoU0LFMA+H7l+9E2nW4uuM7AAkRzo=;
 b=dh/UxoevFJ/+cWezPO+E5lMHIj4UIazjiQ6kIgsBdmPZSYgTiaroZFmz1/Z7kaw4Mg
 zb9KZ1angRrdyzS6pOCBkjQl48JRiCO2N6lAu60Mwt4tU3upIbMg7zuoRbx4AybCOcNt
 38L+s4MuqWsrjNpK9zBmrMngBybtyGQeCj1LJWVpk/nR2S+OQ/ObqVvytyc9/GeePXya
 2bivzqxgzsVzvjnLcBuRT26NMYiXF/wJcTtFOwrDL8uMsaz8j56qColN4k+TWCBhoBKP
 Io/RvHAe7s8d0dZvcYKPwFdnEDAxrW+xzzUfZyljaBnA7Bz2D5eQducJ5VCo0d6M4d4e
 sEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778573297; x=1779178097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oQwzvWevRFf2A9PoU0LFMA+H7l+9E2nW4uuM7AAkRzo=;
 b=T9qDBsWWiWoWNCPMdZc54U3ROEp6m2MDLq2wMbiCM9o73r4Ph7F28qZiQkLBmOT5de
 9KpH1a9YLBvSbUNhh3ZAeWBso9Jfx/TD6EBwFD3kHT/RXsxVKStmImgMXMohVNzfYh7I
 Te2GkBsJ99N11GG4S5lruWoh9qIThTJwzNRGFT3loy4kO6vRquS1NpQX9d91ok/pKt7J
 l25oD3IMvINdxg+ENLbiLPO97IQaxGNVO8ZfOACduY1n6/aI7bslcw3MKFhQAvwf+FcB
 JJ/Y3oOWHeB7xeFsaDxGaOPClzK6lgmxjtasX+2e9mVmc8w2oh54aaPRjWMAVpCTZPlc
 a2nQ==
X-Gm-Message-State: AOJu0YyH3EpRoah7Fu4ceM/JHiWh7W5bxtOUW5qxpTnOLP855HRxkR1P
 wxtEEWCpSQQ6KxxLBA7J55WhnGfSmlL7xjsE6rlMtnBbVM2c/aPmPNLY
X-Gm-Gg: Acq92OHimn+hUrbvyuU21QEExf11z9FoVHZImoWWbhHv4bvOmoTxkBlKbgNS5HBjQYB
 GcYID71OiZZPWQL6vbrQDc4X+rJtNSr5RNa/bmnrryVn5wWpiw+8lz+1hbZ8i0aTAyfazj3p/sx
 TDaIKkfYO+IZ+hrJgqD/JOBZ90i+f+L8UMclRwDYBAmyOTwVYAB9FpSbEQMhtyO2yz1cT+cGScm
 uRe6A3fQYqLrRl5iRiVwAXEJnle+UPkIq2z6XrVNpZjhfMWgVOdxVW/XuMKsFG/PU3BxGsCOZdO
 WGzbTXUMF27BnlU/fefTCzVN5wMIGTkJSgJ/jGJLZZ0rKWTHQ0pH/v6UDBeEqEhfJTPbCRkXdlg
 5YZq5xNQlj+wCe/KIt+bIGiEz1UU4VET+sm1ONnCPgBPw32XZZlUITwhQsHbxXBZqTt56OgmjE7
 dgw5mQOe+/v9Qo/qxQBg83ckMJWHL1UZCH37oih43Fr6nj5T9V9O/ZsYvsp8OP3QV2s+Edtn4Wn
 e2jSQNutP/+1Oc1fnmUJgZXypk/tLS0lH3eZVs=
X-Received: by 2002:a05:620a:22bc:b0:90c:fc17:95f8 with SMTP id
 af79cd13be357-90cfc17a137mr178028185a.51.1778573297117; 
 Tue, 12 May 2026 01:08:17 -0700 (PDT)
Received: from
 runnervmeorf1.1vi0t330zhkepje5rbhct212od.ex.internal.cloudapp.net
 ([135.232.200.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-90d4a6a3859sm79769485a.23.2026.05.12.01.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 01:08:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue, 12 May 2026 08:08:15 +0000
Message-ID: <20260512080815.3976-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509082649.8533-1-wegao@suse.com>
References: <20260509082649.8533-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Allow 0 return value when detaching or joining
 joined thread
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

SGkgV2VpLAoKT24gU2F0LCAwOSBNYXkgMjAyNiAwODoyNjo0NyArMDAwMCwgV2VpIEdhbyB3cm90
ZToKPiBPcGVuUE9TSVg6IEFsbG93IDAgcmV0dXJuIHZhbHVlIHdoZW4gZGV0YWNoaW5nIG9yIGpv
aW5pbmcgam9pbmVkIHRocmVhZAoKPiBUaGVzZSBhcmUgY2F1c2VkIGJ5IGdsaWJjIGNvbW1pdCA1
ZGExNWIxNWFkYWI2NjFjODBlMzczYjZhZjg5YmUwYjVmYTViM2FkCj4gKCJucHRsOiBEbyBub3Qg
dXNlIHB0aHJlYWQgc2V0X3RpZF9hZGRyZXNzIGFzIHN0YXRlIHN5bmNocm9uaXphdGlvbiAoQlog
IzE5OTUxKSIpLgoKVGhlIG1vdGl2YXRpb24gaXMgY2xlYXIgYW5kIHRoZSBmaXggbG9va3MgY29y
cmVjdCDigJQgYWNjZXB0aW5nIDAgaW4gYWRkaXRpb24KdG8gRVNSQ0ggbWF0Y2hlcyB0aGUgbmV3
IGdsaWJjIGJlaGF2aW9yLgoKPiBUaGUgbmV3IGdsaWJjIGxvZ2ljIHJlbW92ZWQgdGhlIGV4cGxp
Y2l0IHZhbGlkYXRpb24gb2YgdGhyZWFkIGhhbmRsZXMgdGhhdAo+IHByZXZpb3VzbHkgcmV0dXJu
ZWQgRVNSQ0g6CgpUaGUgY29tbWl0IG1lc3NhZ2UgaXMgbWlzc2luZyBhIFNpZ25lZC1vZmYtYnk6
IHRhZy4gUGxlYXNlIGFkZDoKCiAgU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5j
b20+CgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0
Y2guIFRoZSBmdWxsIHJldmlldyBjYW4gYmUKZm91bmQgYXQ6IGh0dHBzOi8vZ2l0aHViLmNvbS9s
aW51eC10ZXN0LXByb2plY3QvbHRwLWFnZW50L2FjdGlvbnMvcnVucy8yNTcyMTY3MzA1MQoKVGhl
IGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0
ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUg
cmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlv
bnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
