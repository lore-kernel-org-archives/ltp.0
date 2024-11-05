Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C394D1269F
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 12:43:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8AA0A3D21B3
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 13:43:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4D023D2193
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 13:43:02 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 784B311E5518
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 13:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730810578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hLuw4k+oELVUWrnCKqu/n9Sy991UoXDOT/Fnu6hJ4vo=;
 b=ixxxkLhd3GAbeARNk9TV0EEey1lBjIPqFjG4jK4UefYzTveeKK8lAcENshAVhQyT8WuGJo
 x7oA/ZX6JGVVJ09K3GScoyVScCGVtGzA/fuCqRHOfSJfUuBQWmcD12iCANYXrFIzJrCud9
 tu0GO1q8UIZVYTwHz83WEhVvqpRbc4I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-kgeuiO3nOXKyKZ2HpgyPnA-1; Tue, 05 Nov 2024 07:42:57 -0500
X-MC-Unique: kgeuiO3nOXKyKZ2HpgyPnA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2e76eabc7ddso6971835a91.3
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 04:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730810575; x=1731415375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hLuw4k+oELVUWrnCKqu/n9Sy991UoXDOT/Fnu6hJ4vo=;
 b=tv9zIcx9h691jcVCeijiicooYkB7d8e4fTap4r/N37dN7n/+hI6yOOT2AbXekbTVwy
 4Zo0ObBXOA9qoMN6WALkqy3cYkz7/GtidKDfqsEijtatx34daawNQMtGOOKfJRGEXGtk
 1NaM8JxpdfZK4apkOC6ni30Hle7jULreOfP2tkV6BTd/0qiNa1amrf8MpNU0omK5RZ7Z
 C0NttGKljwtz2G9ly6A0UEA1pSO0mhtZOq+4TO4lAesf3TqLG+6LX6PRsHO/ZfB4VROD
 T+ISnpdmbgS28gADroRVBs8syEuMuaBkUu2aAEdkDkvynbJwURPoDj/U2BGS7cwZZnlE
 lsvQ==
X-Gm-Message-State: AOJu0Yw4WHhCUVe2b1LQ9Av9qN84EQfdrRQ1+BajvVIrPsWBG4E2Ar5+
 75z1OBXoeNMWkgZjCIDcUOCaSeZMEW80+3sb9Ik5FVFcZaEvyzTk9tMJL1ykYMhMK2ADsFvi+AO
 fPTX4drgXyj/CeGVeZMqN8im5Y1/FD4VE8EUsfpm5mwE6IpwBLr8CjmJx0uftjd9mwvFvOMa7fQ
 68iea23+LNzPpwYxYC5SqJb4VWUv4/N/BMiA==
X-Received: by 2002:a17:90b:1f88:b0:2e2:8bce:3d16 with SMTP id
 98e67ed59e1d1-2e94c2e4cabmr22292947a91.19.1730810575155; 
 Tue, 05 Nov 2024 04:42:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu0mQCsfKk80E4U/YGM6nqrArr3STT/jWk+/12WI8RTVpVseTT3sZXBBhSSvqEK60A83Qxoo93LduLSoygMKw=
X-Received: by 2002:a17:90b:1f88:b0:2e2:8bce:3d16 with SMTP id
 98e67ed59e1d1-2e94c2e4cabmr22292915a91.19.1730810574651; Tue, 05 Nov 2024
 04:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20241105-landlock_network-v2-0-d58791487919@suse.com>
 <20241105-landlock_network-v2-1-d58791487919@suse.com>
 <CAEemH2fCcYOzMhFHhQKL_=sPK1Q_RZp6H+jWW-BGuJEc7Xv1Yg@mail.gmail.com>
In-Reply-To: <CAEemH2fCcYOzMhFHhQKL_=sPK1Q_RZp6H+jWW-BGuJEc7Xv1Yg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Nov 2024 20:42:41 +0800
Message-ID: <CAEemH2fTYRM_OC8szbFtByrdB_u9yGTKzMLhMKT077mmML00qg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/4] Fallback landlock network support
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

T24gVHVlLCBOb3YgNSwgMjAyNCBhdCA4OjMx4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPiBIaSBBbmRyZWEsCj4KPiBPbiBUdWUsIE5vdiA1LCAyMDI0IGF0IDU6Mzbi
gK9QTSBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuZGU+Cj4gd3JvdGU6
Cj4KPj4gRnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4K
Pj4KPj4gTGFuZGxvY2sgbmV0d29yayBzdXBwb3J0IGhhcyBiZWVuIGFkZGVkIGluIHRoZSBBQkkg
djQsIGFkZGluZyBmZWF0dXJlcwo+PiBmb3IgYmluZCgpIGFuZCBjb25uZWN0KCkgc3lzY2FsbHMu
IEl0IGFsc28gZGVmaW5lZCBvbmUgbW9yZSBtZW1iZXIgaW4KPj4gdGhlIGxhbmRsb2NrX3J1bGVz
ZXRfYXR0ciBzdHJ1Y3QsIGJyZWFraW5nIG91ciBMVFAgZmFsbGJhY2tzLCB1c2VkIHRvCj4+IGJ1
aWxkIGxhbmRsb2NrIHRlc3Rpbmcgc3VpdGUuIEZvciB0aGlzIHJlYXNvbiwgd2UgaW50cm9kdWNl
Cj4+IHRzdF9sYW5kbG9ja19ydWxlc2V0X2F0dHJfYWJpWzE0XSBzdHJ1Y3Qocykgd2hpY2ggZmFs
bGJhY2sgQUJJIHYxIGFuZCB2NAo+PiBydWxlc2V0X2F0dHIgZGVmaW5pdGlvbnMuCj4+Cj4+IFNp
Z25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+
Cj4+IC0tLQo+PiAgY29uZmlndXJlLmFjICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMyArKy0KPj4gIGluY2x1ZGUvbGFwaS9jYXBhYmlsaXR5LmggICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDQgKysrKwo+PiAgaW5jbHVkZS9sYXBpL2xhbmRsb2NrLmggICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAyOAo+PiArKysrKysrKysrKystLS0tLS0tLS0tCj4+ICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDEuYyAgICB8IDE1ICsr
KystLS0tLS0tLQo+PiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9j
azAyLmMgICAgfCAgOCArKystLS0tCj4+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRs
b2NrL2xhbmRsb2NrMDMuYyAgICB8ICA2ICsrLS0tCj4+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2xhbmRsb2NrL2xhbmRsb2NrMDQuYyAgICB8ICA2ICsrLS0tCj4+ICB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDUuYyAgICB8IDEwICsrKystLS0tCj4+ICB0
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDYuYyAgICB8IDE0ICsr
KystLS0tLS0tCj4+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2Nr
MDcuYyAgICB8ICA2ICsrLS0tCj4+ICAuLi4va2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRs
b2NrX2NvbW1vbi5oICAgICB8IDEyICsrKystLS0tLS0KPj4gIDExIGZpbGVzIGNoYW5nZWQsIDUz
IGluc2VydGlvbnMoKyksIDU5IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvY29uZmln
dXJlLmFjIGIvY29uZmlndXJlLmFjCj4+IGluZGV4Cj4+IGQzMjc5NzRlZmE3MWYyNjNkN2Y3ZjVh
ZWM5ZDJjNTgzMWQ1M2RkMGUuLmUyZTRmZDE4ZGFhNTRkYmYyMDM0ZmE5YmNjNGYyMzgzYjUzMzky
ZjQKPj4gMTAwNjQ0Cj4+IC0tLSBhL2NvbmZpZ3VyZS5hYwo+PiArKysgYi9jb25maWd1cmUuYWMK
Pj4gQEAgLTM0LDYgKzM0LDggQEAgbTRfaWZuZGVmKFtQS0dfQ0hFQ0tfRVhJU1RTXSwKPj4gIEFD
X1BSRUZJWF9ERUZBVUxUKC9vcHQvbHRwKQo+Pgo+PiAgQUNfQ0hFQ0tfREVDTFMoW0lGTEFfTkVU
X05TX1BJRF0sLCxbI2luY2x1ZGUgPGxpbnV4L2lmX2xpbmsuaD5dKQo+PiArQUNfQ0hFQ0tfREVD
TFMoW0xBTkRMT0NLX1JVTEVfUEFUSF9CRU5FQVRIXSwsLFsjaW5jbHVkZQo+PiA8bGludXgvbGFu
ZGxvY2suaD5dKQo+PiArQUNfQ0hFQ0tfREVDTFMoW0xBTkRMT0NLX1JVTEVfTkVUX1BPUlRdLCws
WyNpbmNsdWRlIDxsaW51eC9sYW5kbG9jay5oPl0pCj4+ICBBQ19DSEVDS19ERUNMUyhbTUFEVl9N
RVJHRUFCTEVdLCwsWyNpbmNsdWRlIDxzeXMvbW1hbi5oPl0pCj4+ICBBQ19DSEVDS19ERUNMUyhb
TkZUQV9DSEFJTl9JRCwgTkZUQV9WRVJESUNUX0NIQUlOX0lEXSwsLFsjaW5jbHVkZQo+PiA8bGlu
dXgvbmV0ZmlsdGVyL25mX3RhYmxlcy5oPl0pCj4+ICBBQ19DSEVDS19ERUNMUyhbUFJfQ0FQQlNF
VF9EUk9QLCBQUl9DQVBCU0VUX1JFQURdLCwsWyNpbmNsdWRlCj4+IDxzeXMvcHJjdGwuaD5dKQo+
PiBAQCAtMTcyLDcgKzE3NCw2IEBAIEFDX0NIRUNLX01FTUJFUlMoW3N0cnVjdCB1dHNuYW1lLmRv
bWFpbm5hbWVdLCwsWwo+PiAgXSkKPj4KPj4gIEFDX0NIRUNLX1RZUEVTKFtlbnVtIGtjbXBfdHlw
ZV0sLCxbI2luY2x1ZGUgPGxpbnV4L2tjbXAuaD5dKQo+PiAtQUNfQ0hFQ0tfVFlQRVMoW2VudW0g
bGFuZGxvY2tfcnVsZV90eXBlXSwsLFsjaW5jbHVkZSA8bGludXgvbGFuZGxvY2suaD5dKQo+PiAg
QUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBhY2N0X3YzXSwsLFsjaW5jbHVkZSA8c3lzL2FjY3QuaD5d
KQo+PiAgQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBhZl9hbGdfaXYsIHN0cnVjdCBzb2NrYWRkcl9h
bGddLCwsWyMgaW5jbHVkZQo+PiA8bGludXgvaWZfYWxnLmg+XSkKPj4gIEFDX0NIRUNLX1RZUEVT
KFtzdHJ1Y3QgZmFub3RpZnlfZXZlbnRfaW5mb19maWQsIHN0cnVjdAo+PiBmYW5vdGlmeV9ldmVu
dF9pbmZvX2Vycm9yLAo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2NhcGFiaWxpdHkuaCBi
L2luY2x1ZGUvbGFwaS9jYXBhYmlsaXR5LmgKPj4gaW5kZXgKPj4gMGYzMTdkNmQ3NzBlODZiMzk5
ZjBmZWQyZGUwNGMxZGNlNjcyM2VhZS4uMTRkMmQzYzEyYzA1MTAwNjg3NWYxZjg2NGVjNThhODhh
Mzg3MGVjMAo+PiAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9sYXBpL2NhcGFiaWxpdHkuaAo+PiAr
KysgYi9pbmNsdWRlL2xhcGkvY2FwYWJpbGl0eS5oCj4+IEBAIC0yMCw2ICsyMCwxMCBAQAo+PiAg
IyBlbmRpZgo+PiAgI2VuZGlmCj4+Cj4+ICsjaWZuZGVmIENBUF9ORVRfQklORF9TRVJWSUNFCj4+
ICsjIGRlZmluZSBDQVBfTkVUX0JJTkRfU0VSVklDRSAxMAo+PiArI2VuZGlmCj4+ICsKPj4gICNp
Zm5kZWYgQ0FQX05FVF9SQVcKPj4gICMgZGVmaW5lIENBUF9ORVRfUkFXICAgICAgICAgIDEzCj4+
ICAjZW5kaWYKPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9sYW5kbG9jay5oIGIvaW5jbHVk
ZS9sYXBpL2xhbmRsb2NrLmgKPj4gaW5kZXgKPj4gMjExZDE3MWViZWNkOTJkNzUyMjQzNjlkYzdm
MWQ1YzU5MDNjOWNlNy4uYjNjOGM1NDhlNjYxNjgwNTQxY2RmNmU0YThmYjY4YTNmNTAyOWZlYwo+
PiAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9sYXBpL2xhbmRsb2NrLmgKPj4gKysrIGIvaW5jbHVk
ZS9sYXBpL2xhbmRsb2NrLmgKPj4gQEAgLTcsNiArNyw3IEBACj4+ICAjZGVmaW5lIExBUElfTEFO
RExPQ0tfSF9fCj4+Cj4+ICAjaW5jbHVkZSAiY29uZmlnLmgiCj4+ICsjaW5jbHVkZSA8c3RkaW50
Lmg+Cj4+Cj4+ICAjaWZkZWYgSEFWRV9MSU5VWF9MQU5ETE9DS19ICj4+ICAjIGluY2x1ZGUgPGxp
bnV4L2xhbmRsb2NrLmg+Cj4+IEBAIC0xNCwxMyArMTUsMTYgQEAKPj4KPj4gICNpbmNsdWRlICJs
YXBpL3N5c2NhbGxzLmgiCj4+Cj4+IC0jaWZuZGVmIEhBVkVfU1RSVUNUX0xBTkRMT0NLX1JVTEVT
RVRfQVRUUgo+PiAtc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0cgo+PiArc3RydWN0IHRzdF9s
YW5kbG9ja19ydWxlc2V0X2F0dHJfYWJpMQo+PiArewo+PiArICAgICAgIHVpbnQ2NF90IGhhbmRs
ZWRfYWNjZXNzX2ZzOwo+PiArfTsKPj4gKwo+PiArc3RydWN0IHRzdF9sYW5kbG9ja19ydWxlc2V0
X2F0dHJfYWJpNAo+Pgo+Cj4gT2ssIGhlcmUgeW91IGFjaGlldmUgdHdvIEFCSSB2ZXJzaW9ucyBm
b3IgbGFuZGxvY2tfcnVsZXNldF9hdHRyLAo+IGJ1dCB3aXRoIG1haW5saW5lIGtlcm5lbCBpbnRy
b2R1Y2luZ1sxXSBhIG5ldyBmaWVsZCAnc2NvcGVkJyB3aGF0IHdpbGwKPiB5b3UgZG8gbmV4dCwg
YWRkIG9uZSBtb3JlIEFCSSB2ZXJzaW9uIDUgaWYgbmVlZGVkPyBXaGF0IGlmIHRoZSBtYWlubGlu
ZQo+IGtlcm5lbCBhZGRzIG1vcmUgbmV3IGZpZWxkcyBpbiB0aGUgZnV0dXJlPwo+Cj4gYW5kIHdo
eSBfYWJpMSBhbmQgX2FiaTQsIGJ1dCBub3QgX2FiaTI/Cj4KPiBbMV0gY29tbWl0IDIxZDUyZTI5
NSAoImxhbmRsb2NrOiBBZGQgYWJzdHJhY3QgVU5JWCBzb2NrZXQgc2NvcGluZyIpCj4KCk9yLCBh
bm90aGVyIHdheSBpcyBqdXN0IHRvIGRlZmluZSB0aGUgbGF0ZXN0IEFCSSB2ZXJzaW9uIGluIGxh
cGkvbGFuZGxvY2suaCwKYnV0IG9ubHkgZGVmaW5lIHRoZSB0ZXN0ZWQgQUJJIHZlcnNpb24gaW4g
YSBzaW5nbGUgdGVzdCwgZS5nLgpsYW5kbG9jazAxLmMgdXNlZCBsYW5kbG9ja19ydWxlc2V0X2F0
dHJfYWJpMSwgc28gdGhpcyB3b24ndCBtYWtlIHBlb3BsZQpjb25mdXNlZCB3aGVuIHJlYWRpbmcg
dGhlIHRlc3QgY29kZSwgdGhleSBrbm93cyB0aGUgbGFuZGxvY2swMSBpcyBvbmx5CnRlc3QgYWJp
MSBhbmQgZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IHRoaW5ncyBpbiAnbGFwaS9sYW5kbG9jay5o
JywgV0RZVD8KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
