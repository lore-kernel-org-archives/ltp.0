Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53B3CD8CAA
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781017416; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hylQpi3Exxb7pav7jgmv+FvumUO063PivjDAQbj6P/I=;
 b=AC15pMiMzyaoxhli7gza1rJ+4wZXXdg2QaI6u+A58wI5kdVbxCXCXhtzPyDW2QJ0HLDK1
 wJXBdSZvqZQ5R/O7XutNcBUvn2VrJshGOfxZ8HpQLEXM5ilvxu9L9e4v51mHZ9i/GVGtnow
 Asetl8VXcdPctW4/r1JOkcrcOPGHD00=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354C73E6F33
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 17:03:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FD983E1A5B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 17:03:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 787E6600847
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 17:03:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781017393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FHGqPeG4Gag8OeYMHHZa1xIvZULPc3ccWkSCvMqQeSM=;
 b=EA9aNlp4TE3+n1rxWSiU8nKvPlmBek+AB2kFU+4xhjch6v0AqDGybUNRT6ZsfNN/Pp4VFe
 P4hZYmySEg7ifl6hH+LbLNE6BX0rPSmL5+RfciRYHtSue3CQh/QRf9qfIGOnqcC4fvHyUJ
 3QuwyGsWoUU3PsQXgxC51WlVL6yaxNY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-2RaLSGQhNoCpKREQRZVQEA-1; Tue, 09 Jun 2026 11:03:12 -0400
X-MC-Unique: 2RaLSGQhNoCpKREQRZVQEA-1
X-Mimecast-MFC-AGG-ID: 2RaLSGQhNoCpKREQRZVQEA_1781017391
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46011aa5000so2477834f8f.3
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 08:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017391; x=1781622191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FHGqPeG4Gag8OeYMHHZa1xIvZULPc3ccWkSCvMqQeSM=;
 b=H3Q5izd4lyryvqQmkJVdXpjqkLYgljzhuVkT4UEz8OEB0hQoDkp4FUhvO6CgzfIWs/
 ggZgQ++txjAwpnIpTe2CePttjcsnBYlW1WyGQqdF5iTUOVzPGOuAcZxsmJ5JL2/ADjOu
 z/WF5hVVuFQ2j83Ot3uorme1zBvo4Q7fifTewN9K7Tt//Av4wWkGV5PSoDPUfTVPeui+
 vTByrmbW0BRsZ167cqCA/f0R682X7lTooc6AvXlGQdbXTllHWnEsvP4kwN1YacZrophS
 9pF44Mpr/yIMPtp3YI5eFV6iSo/2CvKCfNJNwkXTNdFzrdu7LRKlSb/PDfIEQAy7ThFT
 2nNA==
X-Gm-Message-State: AOJu0YxbUHM3NSoNTY+vNbCUqGFKnbXemSVFYj9KCFw6xSZkDSb2VnwL
 pr54xHVhCfRxxT517Jz78NeEFSXSGIJGMNpmAltMxCCqkBLnIhM/JxVaUXffbr+YMN6toFcgxPg
 ygRkZZ1Zp6bDaWBBgqJ1Fp+CPrXJo8zynBqROMOYUGsMAOPwNgW95e0Y76zsVeBGUPBkWraOphh
 nwjnUM+wqQSFsfvdCd8h0CBdDyPP4=
X-Gm-Gg: Acq92OFuRhiPJKBiEcg0htl6t7tOypv6qUnXqWETMzyHQfui/v0/ItQezTRVr8ouO0m
 hZfYVOwQBnsEpnxs/AT4PEkNKopk3p7JqOOQW0W/2ogmp0zezcOgBTo93JRbWbmW8rQhKAveKJZ
 0SjPc+RulPnMqsHIvzCdQTL9MJXycWdhdx9GbEYWhdjGMO/f7KgU40SQ/imcLnmqEh3aFqLLAt9
 PDtkj/MD1z7t/k=
X-Received: by 2002:a05:6000:11cb:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-46030609816mr24071407f8f.19.1781017390676; 
 Tue, 09 Jun 2026 08:03:10 -0700 (PDT)
X-Received: by 2002:a05:6000:11cb:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-46030609816mr24071352f8f.19.1781017390090; Tue, 09 Jun 2026
 08:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260609143237.1246776-1-chrubis@suse.cz>
In-Reply-To: <20260609143237.1246776-1-chrubis@suse.cz>
Date: Tue, 9 Jun 2026 17:02:53 +0200
X-Gm-Features: AVVi8CeSi7THfcqOSfp-GoJ_1fdyWoMZGJjPYVI5kgyUQxR2OeauK9-FOX0_eHI
Message-ID: <CAASaF6wcvPUD38N=9o+MSv6e0oFkURCiCB-s5o+ip-hVg-x4Ew@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -rmaRpIZCpRLEnyhkxMglx8bGoR_SnLpWabwBHTI5yM_1781017391
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_test: Add needs_cpu_vendor to struct tst_test
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gOSwgMjAyNiBhdCA0OjMy4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gVGhpcyBhZGRzIGEgZ2VuZXJpYyBpbXBsZW1lbnRhaXRvbiBvZiBu
ZWVkc19jcHVfdmVuZG9yIHRvIHRoZSB0c3RfdGVzdAo+IHN0cnVjdHVyZSB0aGF0IGlzIGJhc2Vk
IG9uIHBhcnNpbmcgL3Byb2MvY3B1aW5mby4gSXQgZG9lcyBub3QgbGlrZWx5Cj4gd29yayBmb3Ig
bm9uLXg4NiBDUFVzIHNpbmNlIHRoZSAvcHJvYy9jcHVpbmZvIGZvcm1hdCBpcyBkaWZmZXJlbnQs
IGJ1dAo+IHdlIGRvIG5vdCBjYXJlIGF0IHRoZSBtb21lbnQuIEZvciBhcm0gd2Ugd291bGQgaGF2
ZSB0byBsb29rIGF0IHRoZQo+IGltcGxlbWVudGVyIGZpZWxkIGluc3RlYWQsIHdlIHdpbGwgYWRk
IHRoYXQgaWYvb25jZSBuZWVkZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNo
cnViaXNAc3VzZS5jej4KPiBDQzogUGlvdHIgS3ViYWogPHBpb3RyLmt1YmFqQGludGVsLmNvbT4K
CkFja2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KCkknbSBjdXJpb3Mg
d2hhdCB0ZXN0IG5lZWRzIGl0LgoKPiAtLS0KPiAgaW5jbHVkZS90c3RfY3B1LmggICAgICAgICAg
ICAgICAgICB8ICA5ICsrKysrKysrKwo+ICBpbmNsdWRlL3RzdF90ZXN0LmggICAgICAgICAgICAg
ICAgIHwgIDUgKysrKysKPiAgbGliL25ld2xpYl90ZXN0cy8uZ2l0aWdub3JlICAgICAgICB8ICAx
ICsKPiAgbGliL25ld2xpYl90ZXN0cy90ZXN0X2NwdV92ZW5kb3IuYyB8IDE2ICsrKysrKysrKysr
KysrKysKPiAgbGliL3RzdF9jcHUuYyAgICAgICAgICAgICAgICAgICAgICB8IDE4ICsrKysrKysr
KysrKysrKysrKwo+ICBsaWIvdHN0X3Rlc3QuYyAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysr
KysKPiAgNiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBsaWIvbmV3bGliX3Rlc3RzL3Rlc3RfY3B1X3ZlbmRvci5jCj4KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS90c3RfY3B1LmggYi9pbmNsdWRlL3RzdF9jcHUuaAo+IGluZGV4IDA3MjQ5NzVmMC4u
MzEyMjJhM2UxIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X2NwdS5oCj4gKysrIGIvaW5jbHVk
ZS90c3RfY3B1LmgKPiBAQCAtMTAsNiArMTAsMTMgQEAgbG9uZyB0c3RfbmNwdXNfY29uZih2b2lk
KTsKPiAgbG9uZyB0c3RfbmNwdXNfbWF4KHZvaWQpOwo+ICBsb25nIHRzdF9uY3B1c19hdmFpbGFi
bGUodm9pZCk7Cj4KPiArLyoqCj4gKyAqIHRzdF9jcHVfdmVuZG9yKCkgLSBSZXR1cm5zIENQVSB2
ZW5kb3IuCj4gKyAqCj4gKyAqIFJldHVybjogQSBDUFUgdmVuZG9yIGUuZy4gIkdlbnVpbmVJbnRl
bCIgb3IgIkF1dGhlbnRpY0FNRCIuCj4gKyAqLwo+ICtjb25zdCBjaGFyICp0c3RfY3B1X3ZlbmRv
cih2b2lkKTsKPiArCj4gICNkZWZpbmUgVklSVF9BTlkgICAgICAgMCAgICAgICAvKiBjYXRjaC1h
bGwgYXJndW1lbnQgZm9yIHRzdF9pc192aXJ0KCkgKi8KPiAgI2RlZmluZSBWSVJUX1hFTiAgICAg
ICAxICAgICAgIC8qIHhlbiBkb20wL2RvbVUgKi8KPiAgI2RlZmluZSBWSVJUX0tWTSAgICAgICAy
ICAgICAgIC8qIG9ubHkgZGVmYXVsdCB2aXJ0dWFsIENQVSAqLwo+IEBAIC0yMSw0ICsyOCw2IEBA
IGxvbmcgdHN0X25jcHVzX2F2YWlsYWJsZSh2b2lkKTsKPgo+ICBpbnQgdHN0X2lzX3ZpcnQoaW50
IHZpcnRfdHlwZSk7Cj4KPiArCj4gKwo+ICAjZW5kaWYgLyogVFNUX0NQVV9IX18gKi8KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS90c3RfdGVzdC5oIGIvaW5jbHVkZS90c3RfdGVzdC5oCj4gaW5kZXgg
OWJjNjdjZjZhLi5jNjkzNjI0ODUgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90c3RfdGVzdC5oCj4g
KysrIGIvaW5jbHVkZS90c3RfdGVzdC5oCj4gQEAgLTM5MSw2ICszOTEsOSBAQCBzdHJ1Y3QgdHN0
X2ZzIHsKPiAgICoKPiAgICogQG1pbl9jcHVzOiBNaW5pbWFsIG51bWJlciBvZiBvbmxpbmUgQ1BV
cyB0aGUgdGVzdCBuZWVkcyB0byBydW4uCj4gICAqCj4gKyAqIEBuZWVkc19jcHVfdmVuZG9yOiBU
aGUgdGVzdCBuZWVkcyBhIHNwZWNpZmljIENQVSB2ZW5kb3IgZS5nLiAiR2VudWluZUludGVsIgo+
ICsgKiAgICAgICAgICAgICAgICAgICAgb3IgIkF1dGhlbnRpY0FNRCIuCj4gKyAqCj4gICAqIEBt
aW5fbWVtX2F2YWlsOiBNaW5pbWFsIGFtb3VudCBvZiBhdmFpbGFibGUgUkFNIG1lbW9yeSBpbiBt
ZWdhYnl0ZXMgcmVxdWlyZWQKPiAgICogICAgICAgICAgICAgICAgIGZvciB0aGUgdGVzdCB0byBy
dW4uCj4gICAqCj4gQEAgLTU4MSw2ICs1ODQsOCBAQCBzdHJ1Y3QgdHN0X2ZzIHsKPiAgICAgICAg
IGNvbnN0IGNoYXIgKmNvbnN0ICpza2lwX2ZpbGVzeXN0ZW1zOwo+Cj4gICAgICAgICB1bnNpZ25l
ZCBsb25nIG1pbl9jcHVzOwo+ICsgICAgICAgY29uc3QgY2hhciAqbmVlZHNfY3B1X3ZlbmRvcjsK
PiArCj4gICAgICAgICB1bnNpZ25lZCBsb25nIG1pbl9tZW1fYXZhaWw7Cj4gICAgICAgICB1bnNp
Z25lZCBsb25nIG1pbl9zd2FwX2F2YWlsOwo+Cj4gZGlmZiAtLWdpdCBhL2xpYi9uZXdsaWJfdGVz
dHMvLmdpdGlnbm9yZSBiL2xpYi9uZXdsaWJfdGVzdHMvLmdpdGlnbm9yZQo+IGluZGV4IDE1ODZl
MGFkNi4uYjg1MTYzODI0IDEwMDY0NAo+IC0tLSBhL2xpYi9uZXdsaWJfdGVzdHMvLmdpdGlnbm9y
ZQo+ICsrKyBiL2xpYi9uZXdsaWJfdGVzdHMvLmdpdGlnbm9yZQo+IEBAIC03MSwzICs3MSw0IEBA
IHRlc3RfYnJrX3BhcmVudAo+ICB0ZXN0X2Jya19wYXNzCj4gIHRlc3RfYnJrX3ZhcmlhbnQKPiAg
dGVzdF9mYWlsX3ZhcmlhbnQKPiArdGVzdF9jcHVfdmVuZG9yCj4gZGlmZiAtLWdpdCBhL2xpYi9u
ZXdsaWJfdGVzdHMvdGVzdF9jcHVfdmVuZG9yLmMgYi9saWIvbmV3bGliX3Rlc3RzL3Rlc3RfY3B1
X3ZlbmRvci5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLjEwYjQ3
M2I3ZQo+IC0tLSAvZGV2L251bGwKPiArKysgYi9saWIvbmV3bGliX3Rlc3RzL3Rlc3RfY3B1X3Zl
bmRvci5jCj4gQEAgLTAsMCArMSwxNiBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjYgQ3lyaWwgSHJ1
YmlzIDxjaHJ1YmlzQHN1c2UuY3o+Cj4gKyAqLwo+ICsKPiArI2luY2x1ZGUgInRzdF90ZXN0Lmgi
Cj4gKwo+ICtzdGF0aWMgdm9pZCBkb190ZXN0KHZvaWQpCj4gK3sKPiArICAgICAgIHRzdF9yZXMo
VFBBU1MsICJUZXN0IHBhc3NlZCEiKTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfdGVz
dCB0ZXN0ID0gewo+ICsgICAgICAgLnRlc3RfYWxsID0gZG9fdGVzdCwKPiArICAgICAgIC5uZWVk
c19jcHVfdmVuZG9yID0gIk5vbmV4aXN0ZW50IiwKPiArfTsKPiBkaWZmIC0tZ2l0IGEvbGliL3Rz
dF9jcHUuYyBiL2xpYi90c3RfY3B1LmMKPiBpbmRleCBmYWZmY2JhOTEuLjE3NzY2MWM4MiAxMDA2
NDQKPiAtLS0gYS9saWIvdHN0X2NwdS5jCj4gKysrIGIvbGliL3RzdF9jcHUuYwo+IEBAIC0yMyw2
ICsyMyw3IEBACj4gICNpbmNsdWRlIDx1bmlzdGQuaD4KPiAgI2luY2x1ZGUgInRlc3QuaCIKPiAg
I2luY2x1ZGUgInRzb19zYWZlX21hY3Jvcy5oIgo+ICsjaW5jbHVkZSAidHNvX3NhZmVfZmlsZV9v
cHMuaCIKPgo+ICBsb25nIHRzdF9uY3B1cyh2b2lkKQo+ICB7Cj4gQEAgLTk3LDMgKzk4LDIwIEBA
IGxvbmcgdHN0X25jcHVzX2F2YWlsYWJsZSh2b2lkKQo+ICAgICAgICAgcmV0dXJuIHRzdF9uY3B1
cygpOwo+ICAjZW5kaWYKPiAgfQo+ICsKPiArY29uc3QgY2hhciAqdHN0X2NwdV92ZW5kb3Iodm9p
ZCkKPiArewo+ICsgICAgICAgc3RhdGljIGNoYXIgY3B1X3ZlbmRvclsxNl07Cj4gKyAgICAgICBp
bnQgcmV0Owo+ICsKPiArICAgICAgIGlmIChjcHVfdmVuZG9yWzBdKQo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gY3B1X3ZlbmRvcjsKPiArCj4gKyAgICAgICByZXQgPSBGSUxFX0xJTkVTX1NDQU5G
KE5VTEwsICIvcHJvYy9jcHVpbmZvIiwgInZlbmRvcl9pZCA6ICUxNnNbXlxuXSIsIGNwdV92ZW5k
b3IpOwo+ICsgICAgICAgaWYgKHJldCkKPiArICAgICAgICAgICAgICAgc3RyY3B5KGNwdV92ZW5k
b3IsICJVbmtub3duIik7Cj4gKwo+ICsgICAgICAgdHN0X3Jlc20oVERFQlVHLCAiQ1BVIHZlbmRv
ciAnJXMnIiwgY3B1X3ZlbmRvcik7Cj4gKwo+ICsgICAgICAgcmV0dXJuIGNwdV92ZW5kb3I7Cj4g
K30KPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF90ZXN0LmMgYi9saWIvdHN0X3Rlc3QuYwo+IGluZGV4
IDBiZWJiMGEzZS4uNWY3MTU2NDAzIDEwMDY0NAo+IC0tLSBhL2xpYi90c3RfdGVzdC5jCj4gKysr
IGIvbGliL3RzdF90ZXN0LmMKPiBAQCAtMTQxNiw2ICsxNDE2LDExIEBAIHN0YXRpYyB2b2lkIGRv
X3NldHVwKGludCBhcmdjLCBjaGFyICphcmd2W10pCj4gICAgICAgICBpZiAodHN0X3Rlc3QtPnN1
cHBvcnRlZF9hcmNocyAmJiAhdHN0X2lzX29uX2FyY2godHN0X3Rlc3QtPnN1cHBvcnRlZF9hcmNo
cykpCj4gICAgICAgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJUaGlzIGFyY2ggJyVzJyBpcyBu
b3Qgc3VwcG9ydGVkIGZvciB0ZXN0ISIsIHRzdF9hcmNoLm5hbWUpOwo+Cj4gKyAgICAgICBpZiAo
dHN0X3Rlc3QtPm5lZWRzX2NwdV92ZW5kb3IgJiYgc3RyY21wKHRzdF90ZXN0LT5uZWVkc19jcHVf
dmVuZG9yLCB0c3RfY3B1X3ZlbmRvcigpKSkgewo+ICsgICAgICAgICAgICAgICB0c3RfYnJrKFRD
T05GLCAiVGVzdHMgbmVlZHMgJyVzJyBDUFUgdG8gY29udGludWUgaGF2ZSAnJXMnIiwKPiArICAg
ICAgICAgICAgICAgICAgICAgICB0c3RfdGVzdC0+bmVlZHNfY3B1X3ZlbmRvciwgdHN0X2NwdV92
ZW5kb3IoKSk7Cj4gKyAgICAgICB9Cj4gKwo+ICAgICAgICAgaWYgKHRzdF90ZXN0LT5zYW1wbGUp
Cj4gICAgICAgICAgICAgICAgIHRzdF90ZXN0ID0gdHN0X3RpbWVyX3Rlc3Rfc2V0dXAodHN0X3Rl
c3QpOwo+Cj4gLS0KPiAyLjUzLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
