Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E51CAC5AE
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758768333; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GINrkxhHScBFCw0F+c1liaBsBfTkdW0mJxXU3Ov0ptk=;
 b=T1WQvLXJl457TGYDpXdZ88xJRadZjH49Ide6wmrc3Sr9CL8Xy4Pl812HEToKp1EWTtfvx
 9rXOBysq4+/fvDc1uT24aDG0UGhngDrBkcUA+D9l+26wuXeoG9KecamA9wv17vx1Yk8FcVe
 YjONNXwvYaWXtA+ls8ctq/hFEdrypLk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC31E3CDC05
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 04:45:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEC163CC17A
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 04:45:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E11CB1A002C4
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 04:45:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758768309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BW2uz4nJ5W8kB29V3t+GVxP2uB3Sva0ZMmCf9m7m37Q=;
 b=ZXY76J7wwwC++WIhL7Vovn8gX8x64+kmSQAJgywrdpOOJqHwtIbTk9k3t/ZQJCQGY5NDo7
 KzlPYaBUgV9cyKkVk1DJr2rXsZdeYBjtmNTeoas7larwWkvp9w2dhlkph6Nbv3+Zu9eSGL
 GG48iUZVgEJ1Q4PgOS3vaciGyisAdsk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-GIKuJYvcO6OcbtBACngoXw-1; Wed, 24 Sep 2025 22:45:07 -0400
X-MC-Unique: GIKuJYvcO6OcbtBACngoXw-1
X-Mimecast-MFC-AGG-ID: GIKuJYvcO6OcbtBACngoXw_1758768307
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2697c4e7354so14838515ad.0
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 19:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758768306; x=1759373106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BW2uz4nJ5W8kB29V3t+GVxP2uB3Sva0ZMmCf9m7m37Q=;
 b=Jla0bmJN0O9g+nX2crUZ23RtwuzWd11SIlrlEm98vrj/wZVogStEAab3ZjylDR0m97
 3fBstlZw4oh5EMr+XsoTXTO3kR8j9k4Jx28xikuaTldYqbuPQYJLTxaZVqi6sifsl3dZ
 Y+fP0GtAS5hY3LS/s+kj2Uex8D+945yQMuVdzqWfq2382yYKSeppKVy61GX6LJhU2l/A
 olyixeiKS5SqZyQEh4EtZqiHIvTHZfeja+kAaqcHgpM7dcVFMhH8zRf9XmMlWB7TMpyc
 7+bofRxrhFzCF467mfmEP2+GSLmqyvorb7JkUSvg9yWO/Mq5IHEBtgCbreCkkGMlhUyn
 rl2Q==
X-Gm-Message-State: AOJu0YxBkdLrHvgG7D1dt1Yk6x1nw61Awmy7kRWFeByJ++rsEnnSrC6K
 fegT7aqc3Z8VMVZL4vZsGRPmDaGT8pE33TYVkgg0OImvgk/QNsyvr8ziMcgRGanTYnibXtz6E4I
 lCXVq5/xoGWL/M8iMiifCN0JBb2UmTizfzHwPzYQIPDOe99j6xXvXZE6GSndlmZ2AkCJEGyUuMv
 UK6gu1WBpI05l1Ny+dS6j+O8J2o79u/3gZEh4=
X-Gm-Gg: ASbGncsOIjVieLr53BL1rt660tVgJR+6SO6WEsM6Z0S11953xW+sDfrPcZgf5kxmUwP
 D0lvcQyRBjbW2/PGQ89s7DCbYZZOmUfFBHn+Wo69iZQ+XLKPIJ40wUY1mgJi5/dRqFJtPlA7xcw
 5/nYXXkyIbA7GAf7+CnGHciA==
X-Received: by 2002:a17:902:d585:b0:276:54f3:e6b with SMTP id
 d9443c01a7336-27ed72809fdmr10457935ad.27.1758768305991; 
 Wed, 24 Sep 2025 19:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwCyRcgDO82pCshKmGiz+MUO+75r0aXHbaBNxWuWt+J8ywHnrLFGVvcgfSiD7Kk8mNcYDaUFyGu7t6Cz0OC7c=
X-Received: by 2002:a17:902:d585:b0:276:54f3:e6b with SMTP id
 d9443c01a7336-27ed72809fdmr10457725ad.27.1758768305610; Wed, 24 Sep 2025
 19:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <aNOuYfhEU160i2gE@yuki.lan> <20250924202923.9202-1-akumar@suse.de>
In-Reply-To: <20250924202923.9202-1-akumar@suse.de>
Date: Thu, 25 Sep 2025 10:44:53 +0800
X-Gm-Features: AS18NWCP6j8l-zP9syyqQAEfyvhw2WZPLt4m9K5mUrEo47LMKRsdz1TIINKwWfM
Message-ID: <CAEemH2f8EjTe-uX1zm5h6L1kUFcxy72Br7bvBe5btr7i6PB1BQ@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jX7a-kl8ExT0qtYystIeYq5UU7JB8rCnExiFo5OG9zY_1758768307
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Introduce ioctl_pidfd_get_info_supported()
 function
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

T24gVGh1LCBTZXAgMjUsIDIwMjUgYXQgNDoyOeKAr0FNIEF2aW5lc2ggS3VtYXIgPGFrdW1hckBz
dXNlLmRlPiB3cm90ZToKCj4gQ2hlY2sgaWYgaW9jdGwoUElERkRfR0VUX0lORk8pIGlzIGltcGxl
bWVudGVkIG9yIG5vdAo+IGJlZm9yZSBwcm9jZWVkaW5nIGluIGlvY3RsX3BpZGZkMDUgdGVzdAo+
Cj4gU3VnZ2VzdGVkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiBTdWdnZXN0
ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6IEF2aW5l
c2ggS3VtYXIgPGFrdW1hckBzdXNlLmRlPgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2lvY3RsL2lvY3RsX3BpZGZkLmggfCAyOCArKysrKysrKysrKysrKysrKysrCj4gIC4uLi9r
ZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxfcGlkZmQwNS5jICAgICB8ICA5ICsrKysrLQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkLmgKPiBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxfcGlkZmQuaAo+IGluZGV4IDgx
MWY5NjljZC4uYjc4NWQ4MDQzIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvaW9jdGwvaW9jdGxfcGlkZmQuaAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW9jdGwvaW9jdGxfcGlkZmQuaAo+IEBAIC05LDYgKzksMzQgQEAKPiAgI2luY2x1ZGUgInRzdF90
ZXN0LmgiCj4gICNpbmNsdWRlICJsYXBpL3BpZGZkLmgiCj4KPiArc3RhdGljIGlubGluZSBib29s
IGlvY3RsX3BpZGZkX2dldF9pbmZvX3N1cHBvcnRlZCh2b2lkKQo+CgpUaGUgcmV0dXJuIHR5cGUg
c2hvdWxkIGJlIGludCwgYnV0IG5vdCBib29sLgoKCgo+ICt7Cj4gKyAgICAgICBwaWRfdCBwaWQ7
Cj4gKyAgICAgICBpbnQgcGlkZmQsIHJldDsKPiArICAgICAgIGludCBzdXBwb3J0ZWQgPSAwOwo+
ICsgICAgICAgc3RydWN0IHBpZGZkX2luZm8gaW5mbzsKPiArCj4gKyAgICAgICBpZiAodHN0X2t2
ZXJjbXAoNiwgMTMsIDApID49IDApCj4gKyAgICAgICAgICAgICAgIHJldHVybiAxOwo+ICsKPiAr
ICAgICAgIG1lbXNldCgmaW5mbywgMCwgc2l6ZW9mKHN0cnVjdCBwaWRmZF9pbmZvKSk7Cj4gKwo+
ICsgICAgICAgcGlkID0gU0FGRV9GT1JLKCk7Cj4gKyAgICAgICBpZiAoIXBpZCkKPiArICAgICAg
ICAgICAgICAgZXhpdCgxMDApOwo+ICsKPiArICAgICAgIHBpZGZkID0gU0FGRV9QSURGRF9PUEVO
KHBpZCwgMCk7Cj4gKwo+ICsgICAgICAgcmV0ID0gaW9jdGwocGlkZmQsIFBJREZEX0dFVF9JTkZP
LCAmaW5mbyk7Cj4gKyAgICAgICBTQUZFX1dBSVRQSUQocGlkLCBOVUxMLCAwKTsKPiArCj4gKyAg
ICAgICBpZiAocmV0ICE9IC0xKQo+ICsgICAgICAgICAgICAgICBzdXBwb3J0ZWQgPSAxOwo+ICsK
PiArICAgICAgIFNBRkVfQ0xPU0UocGlkZmQpOwo+ICsgICAgICAgcmV0dXJuIHN1cHBvcnRlZDsK
PiArfQo+ICsKPiAgc3RhdGljIGlubGluZSBpbnQgaW9jdGxfcGlkZmRfaW5mb19leGl0X3N1cHBv
cnRlZCh2b2lkKQo+ICB7Cj4gICAgICAgICBpbnQgcmV0Owo+IGRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkMDUuYwo+IGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9waWRmZDA1LmMKPiBpbmRleCBjMzc5NzE3YjMuLmQy
MGM2ZjA3NCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lv
Y3RsX3BpZGZkMDUuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9j
dGxfcGlkZmQwNS5jCj4gQEAgLTE0LDcgKzE0LDcgQEAKPiAgI2luY2x1ZGUgInRzdF90ZXN0Lmgi
Cj4gICNpbmNsdWRlICJsYXBpL3BpZGZkLmgiCj4gICNpbmNsdWRlICJsYXBpL3NjaGVkLmgiCj4g
LSNpbmNsdWRlICJsYXBpL2lvY3RsLmgiCj4gKyNpbmNsdWRlICJpb2N0bF9waWRmZC5oIgo+Cj4g
IHN0cnVjdCBwaWRmZF9pbmZvX2ludmFsaWQgewo+ICAgICAgICAgdWludDMyX3QgZHVtbXk7Cj4g
QEAgLTQ4LDggKzQ4LDE1IEBAIHN0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ICAgICAgICAgU0FGRV9D
TE9TRShwaWRmZCk7Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICt7Cj4gKyAg
ICAgICBpZiAoIWlvY3RsX3BpZGZkX2dldF9pbmZvX3N1cHBvcnRlZCgpKQo+ICsgICAgICAgICAg
ICAgICB0c3RfYnJrKFRDT05GLCAiaW9jdGwoUElERkRfR0VUX0lORk8pIGlzIG5vdCBpbXBsZW1l
bnRlZCIpOwo+ICt9Cj4gKwo+ICBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gICAg
ICAgICAudGVzdF9hbGwgPSBydW4sCj4gKyAgICAgICAuc2V0dXAgPSBzZXR1cCwKPiAgICAgICAg
IC5mb3Jrc19jaGlsZCA9IDEsCj4gICAgICAgICAuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1ZmZlcnMg
W10pIHsKPiAgICAgICAgICAgICAgICAgeyZhcmdzLCAuc2l6ZSA9IHNpemVvZigqYXJncyl9LAo+
IC0tCj4gMi41MS4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
