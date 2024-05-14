Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB6C04FFE
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 18:37:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3D983CF293
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 20:37:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B82A23CAEB6
 for <ltp@lists.linux.it>; Tue, 14 May 2024 20:37:36 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2329C1000F67
 for <ltp@lists.linux.it>; Tue, 14 May 2024 20:37:36 +0200 (CEST)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-792b8d31702so376722585a.3
 for <ltp@lists.linux.it>; Tue, 14 May 2024 11:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715711855; x=1716316655; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fCoMnABaV05r93TH+/hKm5iM5YtOISiOr4Dx4AT8RM=;
 b=FzO4jZCNms50u/aPUhFtAZxF1wTeJdBDqMRfnQhPcYT2V/Zy7wx5XOVso7alSfJY3l
 RwIRl9x9uM/8fmkakc+TsXUy6bkQ3j3L++Ec4JM1Oq5AygvQ45RcabJBvoXYIFswBIWR
 52VLYoIPLwQmWRgfjhIdmu1FF34LjwEBeV+2aO2cLO/4F0B3XmczAI/bagkw69A0hZ2f
 N4eci2wX4tM4GMwb5MkiP3ZmnZitF/E/66MLOsM2SMYTrmIrsp13AIq+7PrRuWfrVvwt
 YuT9nSHAFaxvF7xBz78VuxS/ThbRARyexGOzeBQNMXsQnHlbbtqkTXejrTMxl48uWbUV
 Ruww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715711855; x=1716316655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fCoMnABaV05r93TH+/hKm5iM5YtOISiOr4Dx4AT8RM=;
 b=AanQEweChgesay3CWqaAbWoqa94OodGxZKPZhE0OAqcvnoZkRzFmSBzv4pzlcw52Aa
 Gs36LOS0og9vJfHCjo/bzV/mL9QAkQXy8MoZkAL0imd+jx5Kcgoxgsjslr2xN5eQb+97
 rwZqHRuubeC6BzvJD/h8s0WcphA0OWrgERjmqf2LhNFpDp15OwMWJSuxf61OrLkiP/pT
 eHE+90ARQsVhWTz7wsfc+M2cbdb8PZdMvEctAluDAln+IcHFI5la+fPUdSa27/uyRzPc
 MWCkCrkipJUn7glnNnLY6jUTAi7tk/q8cs+ishJeauJV1vaey4DCuDmGRBsPq/QphUo0
 1Eug==
X-Gm-Message-State: AOJu0Yy9FLJSi548E8+Edls1/mOl6RcUAC9ZhmY0u1zsIMl5bVz6L85/
 dABCiz9MdfmzpLlaF1onK1TIGpY8le7l75XJiG/CVXA1a4uSxjMohLwz/koJ4jZUIN5547Sn4Ic
 KV4BEw0pOVapuXJgks5bKjcOWHso=
X-Google-Smtp-Source: AGHT+IFl7czJ60q/qn/U2p2akXhaW2aAUOjhwfD/RbnWDXCw4Or51F73BFc5SguMgbAhFgbrvYIg2fi6G0YC6W2XMn4=
X-Received: by 2002:ae9:e206:0:b0:792:bae8:25d2 with SMTP id
 af79cd13be357-792c75efb4amr1642891985a.56.1715711854886; Tue, 14 May 2024
 11:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <CADJHv_v7BZORM+E6fMBD_TX_+uym7GuykqbpAaLqmCvqymOgCQ@mail.gmail.com>
In-Reply-To: <CADJHv_v7BZORM+E6fMBD_TX_+uym7GuykqbpAaLqmCvqymOgCQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 14 May 2024 12:37:23 -0600
Message-ID: <CAOQ4uxhxeihXm_AsztvZ4v3bw=y8aQWpGvhEO1ONOXNM03pwdw@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP/fanotify01 corner case
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMTQsIDIwMjQgYXQgMToyMeKAr0FNIE11cnBoeSBaaG91IDxqZW5jY2Uua2Vy
bmVsQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSBBbWlyLAo+Cj4gV2hlbiBUTVBESVIgaXMgb24g
TkZTLCBmYW5vdGlmeTAxIGdldCBFTk9ERVYgd2hlbiB0ZXN0aW5nIGlmIGl0IHN1cHBvcnRzIHJl
cG9ydGluZyBldmVudHMgd2l0aCBmaWQgZnJvbSBtdWx0aSBmcyBpbiBzZXR1cCgpOgo+Cj4+ICAg
ICAgICAgaWYgKGZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRlZF9vbl9mcyhGQU5fUkVQT1JUX0ZJRCwg
RkFOX01BUktfTU9VTlQsIEZBTl9PUEVOLCAiLiIpKSB7Cj4+ICAgICAgICAgICAgICAgICBpbm9k
ZV9tYXJrX2ZpZF94ZGV2ID0gZXJybm87Cj4+ICAgICAgICAgICAgICAgICB0c3RfcmVzKFRJTkZP
LCAiVE1QRElSIGRvZXMgbm90IHN1cHBvcnQgcmVwb3J0aW5nIGV2ZW50cyB3aXRoIGZpZCBmcm9t
IG11bHRpIGZzIik7Cj4+ICAgICAgICAgfQo+Cj4KPiBsYXRlciBpbiB0ZXN0X2Zhbm90aWZ5KCks
IGZkX25vdGlmeSBmaXJzdGx5IGdldHMgYWRkZWQgYSBtYXJrIGZvciB0aGUgZnMgbW91bnRlZCB3
aXRoaW4gdGhlIE5GUyBUTVBESVIsCj4KPiBhbmQgdGhlbiBhdCB0aGUgZW5kIG9mIHRlc3RfZmFu
b3RpZnkoKSwgYWRkZWQgYW5vdGhlciBtYXJrIGZvciB0aGUgVE1QRElSIHdoaWNoIGlzIE5GUyBp
biB0aGlzIGNhc2UsIGFuZCBjaGVjayBvbiB0aGUgZXJybm86Cj4KPj4gICAgICAgICByZXQgPSBy
ZXBvcnRfZmlkID8gaW5vZGVfbWFya19maWRfeGRldiA6IDA7Cj4+ICAgICAgICAgVFNUX0VYUF9G
RF9PUl9GQUlMKGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCBGQU5fTUFSS19BREQsIEZBTl9DTE9T
RV9XUklURSwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBVF9G
RENXRCwgIi4iKSwgcmV0KTsKPgo+Cj4KPiBJdCB3b3JrZWQgZmluZSB0aWxsCj4KPj4gY29tbWl0
IDMwYWQxOTM4MzI2YmY5MzAzY2EzODA5MDMzOWQ5NDg5NzVhNjI2ZjUKPj4gQXV0aG9yOiBBbWly
IEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgo+PiBEYXRlOiAgIFRodSBOb3YgMzAgMTg6
NTY6MTkgMjAyMyArMDIwMAo+Pgo+PiAgICAgZmFub3RpZnk6IGFsbG93ICJ3ZWFrIiBmc2lkIHdo
ZW4gd2F0Y2hpbmcgYSBzaW5nbGUgZmlsZXN5c3RlbQo+Cj4KPiBBZnRlciB0aGlzIGNvbW1pdCB3
YXMgbWVyZ2VkLCB0aGUgZmlyc3QgY2hlY2sgZ290IEVOT0RFViBhbmQgdGhlIHNlY29uZCBjaGVj
ayBnb3QgRVhERVYuCj4KPiBUaGUgYm90aCB2YWx1ZXMgbWFrZSBzZW5zZSBpbiB0aGVpciBzaXR1
YXRpb24sIGJ1dCBpdCBzZWVtcyBsaWtlIHVzaW5nIG9uZSB2YWx1ZSBhcyBleHBlY3RlZCB2YWx1
ZSBmb3IgYW5vdGhlciBzZWVtcyBub3QgYWNjdXJhdGUgaGVyZSBmb3IgbWUuIEkgZG9uJ3Qga25v
dyBtdWNoIGhlcmUsIHlvdXIgaGVscCBpcyBtdWNoIGFwcHJlY2lhdGVkLgoKWW91ciBhbmFseXNp
cyBpcyBleGFjdCBhbmQgY29ycmVjdC4KClRoZSBjb21taXQgYWJvdmUgY2F1c2VkIGEgYmVoYXZp
b3IgY2hhbmdlIGluIHRoYXQgY2FzZSBtb3ZpbmcgZnJvbSBvbmUKZXJyb3IgdGhhdCBtYWtlcyBz
ZW5zZSB0byBhbm90aGVyIGVycm9yIHRoYXQgbWFrZXMgc2Vuc2UgYW5kIHRoZSB0ZXN0CnNob3Vs
ZCBjb3BlIHdpdGggdGhhdC4KClRoZSBlYXNpZXN0IHdvdWxkIGJlIHRvIG9wZW4gY29kZSBUU1Rf
RVhQX0ZEX09SX0ZBSUwoKQpoZWxwZXIgYW5kIGNoZWNrIGZvciBlaXRoZXIKZXJybm8gPT0gaW5v
ZGVfbWFya19maWRfeGRldiB8fCBlcnJubyA9PSBFWERFVi4Kbm90IHN1cmUgaWYgdGhlcmUgaXMg
YW4gTFRQIGhlbHBlciBmb3IgdGhpcyBwYXR0ZXJuLgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
