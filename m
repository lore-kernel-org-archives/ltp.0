Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77103C02185
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 12:33:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D1973C7C31
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:33:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 528483C7C3E
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:33:38 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 83BC3144A1E8
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737117215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PoWdliKBSveX1gMRz1TnVM62B+g1tGDfNLJH6F/NxMg=;
 b=gtlNAtvosTDqFgG0LmxsWxFe2QoJw8dnGdrkueHt2Gm76bxPNrnuX8+1qwzyfCMbj/Mtbh
 l+nF9tsc+yZsf53mWXDEB8WTomo9196ypAHniVkimDSFc2g5spCYPR9Fqr7jfAkVZgcyLd
 djlSw0JXnU68G3grg06IT0tR1evZFyA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-Ce9espmMNTa8W3QBpq-7tg-1; Fri, 17 Jan 2025 07:33:33 -0500
X-MC-Unique: Ce9espmMNTa8W3QBpq-7tg-1
X-Mimecast-MFC-AGG-ID: Ce9espmMNTa8W3QBpq-7tg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so4079046a91.2
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 04:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737117211; x=1737722011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PoWdliKBSveX1gMRz1TnVM62B+g1tGDfNLJH6F/NxMg=;
 b=h0s7c7OfKf8vB+NGiPvPnawDvxxJayjPEEf6Xzxf4C88QEyc0YYtNPWcJcHpinDW5B
 6S53X+7a3bVyuqXR+vFd7mlb0eFJKfB8Uhb+pj5LUlgIliklhYR3tWQSsvhxWqa182uB
 2csBx5xLSHd9a+v6BOz7N5AtV7E4mxoX62Qrx1N8DBOA9lBE9anIt3+qXSlJow24xMGk
 Dy++OyFiL0qzyiJf+WYUIg7kUIncB1MzXtSlGzeb1GpKhuNO9feuUJJ1y+aBrDIUDk5N
 bj+r/YYVhDcx5GONhJQdz8RGCd/Jg87ECCzko8vjzqBshF4MWcvWKkGV4EySLKXG68o3
 ddiw==
X-Gm-Message-State: AOJu0YynYNybNlwENyAzlCvuEmY4TT4Ze+j6BzN8QGmsQyJ3TaCcbLGe
 B+eSAQYT7z1Xhp2JUb1Uonj7FFwnPVfZpJ42NR8hZn9V8Wk5n8NezVHc7YuuK1OL7mMAZxFt361
 91idWQ6PuZ6qL8I1EVNUQVAgaqlTdf60fTZrhJwB09rhQuo3CGgNT3v9iH+yDAQl1ianVmH1uXP
 lSILRwCnFq2oJgEduU5U8yZIZMSUITm92Tu/Iw
X-Gm-Gg: ASbGnctKPBp+I6jgj2eHXn0GnOa3gtWD38Y3bTSiARPQVR7xriEMAXXuengDNBiK5Je
 5rk2bIx13h7uYCw7kC3uli0ysOInW3TgEcrofdQo=
X-Received: by 2002:a17:90b:4d0b:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2f782c4b250mr3230552a91.5.1737117211198; 
 Fri, 17 Jan 2025 04:33:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8SbXlZea1xOft4x9+BPJEJ7fjLSYb5agt9UM1Eu0sW4vpQaoeG9+DlUpfv/sehDTnkb+m4exdlSA3ug1+Vpw=
X-Received: by 2002:a17:90b:4d0b:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2f782c4b250mr3230532a91.5.1737117210925; Fri, 17 Jan 2025
 04:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20250117122455.7989-1-chrubis@suse.cz>
In-Reply-To: <20250117122455.7989-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 20:33:18 +0800
X-Gm-Features: AbW1kvajVPj-DB989XuAnpUVMDHCi8nEXV4OsFenPCFngsAUKKbmbXmdtei8G6g
Message-ID: <CAEemH2d0YTx3AN+p_r1yf9ZYSbuHJ82jPMhOiKQhaVzHGkddgw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rj7-mZYdCLn86EE929ErtMX-ApX6HAe9luKQcC3SFVw_1737117213
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] testcases/lib: Fix tst_ns_* helpers
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

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgODoyNeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gUmVwbGFjZXMgU0FGRV9DTE9ORSgpIHdpdGggdHN0X2Nsb25lKCkg
aW4gdGhlIHRzdF9uc18qIGhlbHBlcnMuCj4KPiBUaGUgcmVhc29uIGZvciB0aGUgcmVwbGFjZW1l
bnQgaXMgdGhhdCBTQUZFX0NMT05FKCkgdXNlcwo+IFRTVF9SRVRSWV9GVU5DKCkgd2hpY2ggY2Fs
bHMgdHN0X211bHRpcGx5X3RpbWVvdXQoKS4gVGhlIHByb2JsZW0gd2l0aAo+IHRoYXQgaXMgdGhh
dCB0aGUgdHN0X211bHRpcGx5X3RpbWVvdXQoKSBpcyBhIHRlc3QgbGlicmFyeSBmdW5jdGlvbiB0
aGF0Cj4gc3RhcnRlZCB0byBwcmludCBUSU5GTyBtZXNzYWdlcyByZWNlbnRseSBhbmQgdGhhdCB3
ZSByZWx5IG9uIHBhcnNpbmcgdGhlCj4gb3V0cHV0IGZyb20gdGhlIHRzdF9uc18qIGhlbHBlcnMu
Cj4KPiBUaGUgcmVhc29uIFNBRkVfQ0xPTkUoKSBzdGFydGVkIHRvIGNhbGwgVFNUX1JFVFJZX0ZV
TkMoKSBpcyB0aGF0IGluIHRoZQo+IGNhc2UgdGhhdCB3ZSBjcmVhdGUgbmV3IG5hbWVzcGFjZXMg
d2l0aCB0aGUgY2xvbmUgY2FsbCwgd2UgbWF5IGVuZCB1cAo+IGNyZWF0aW5nIHRoZW0gZmFzdGVy
IHRoYW4ga2VybmVsIGNhbiBjbGVhbiB0aGVtIHVwIHdoaWNoIGlzIGRlc2NyaWJlZCBpbjoKPgo+
IGNvbW1pdCA3ZDg4MjA4MWE1NjEzZjQ0YTEyZmM2YjFjNDQyNjdkNGRmMDg1N2E0Cj4gQXV0aG9y
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiBEYXRlOiAgIE1vbiBNYXIgMjggMjI6NDY6
NDMgMjAyMiArMDIwMAo+Cj4gICAgIGxpYjogUmV0cnkgc2FmZV9jbG9uZSgpIG9uIEVOT1NQQwo+
Cj4gVGhpcyBjb21iaW5lZCB3aXRoIHRoZSBuZXdseSBpbnRyb2R1Y2VkIGNoYW5nZXMgaW4gdGhl
IHRlc3QgbGlicmFyeSB0aGF0Cj4gY2hlY2sgZm9yIGtlcm5lbCBkZWJ1Z2dpbmcgb3B0aW9ucyB0
aGF0IG1heSBuZWVkIHRvIGFkanVzdCBkZWZhdWx0Cj4gdGltZW91dHM6Cj4KPiBjb21taXQgODkz
Y2EwYWJlN2U4Mjg1MWZmMGU1ZDkzYzA5YjEwOThmMmVmZjEyMQo+IEF1dGhvcjogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+Cj4gRGF0ZTogICBTdW4gRGVjIDIyIDE1OjIyOjQ5IDIwMjQgKzA4
MDAKPgo+ICAgICBsaWI6IG11bHRpcGx5IHRoZSB0aW1lb3V0IGlmIGRldGVjdCBzbG93IGtjb25m
aWdzCj4KPiB3aGljaCBhZGRzIHRzdF9oYXNfc2xvd19rY29uZmlnKCkgaW50byB0aGUgdHN0X211
bHRpcGx5X3RpbWVvdXQoKSBjYXVzZXMKPiB0aGUgVElORk8gbWVzc2FnZXMgdG8gYmUgcHJpbnRl
ZC4KPgo+IFRoZSByZWFzb24gd2h5IHdlIGNhbiBzYWZlbHkgcmVwbGFjZSB0aGUgU0FGRV9DTE9O
RSgpIHdpdGggdHN0X2Nsb25lKCkKPiBoZXJlIGlzIHRoYXQgd2UgYXJlIG5vdCBjcmVhdGluZyBu
ZXcgbmFtc3BhY2VzIGluIHRoZSB0c3RfbnNfKiBoZWxwZXJzLAo+IGJ1dCByYXRoZXIgdGhhbiB0
aGF0IGNsb25pbmcgYSBuZXcgcHJvY2VzcyB0byBiZSBleGVjdXRlZCBpbnNpZGUgb2YgdGhlCj4g
bmFtZXNwYWNlLCBoZW5jZSB3ZSBkbyBub3QgbmVlZCB0byByZXRyeSBvbiBFTk9TUEMuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPgoKUmV2aWV3ZWQt
Ynk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKTmljZSB3b3JrIQoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
