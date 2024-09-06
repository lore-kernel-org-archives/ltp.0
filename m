Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACE9CE7AFD
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 10:19:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D183B3C26AD
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 12:19:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDBD83C0352
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 12:19:32 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5540614002B8
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 12:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725617969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xbXxqEXq8uvF3n45w7OU3ccyxi6XRES9vU1SDOCIiZk=;
 b=EUGtj90nTHiDJ7zPsdmK+azPTcLFD8/C/njZU643douxtQFc3BRXJfi9Zck/fymlnsoeje
 PoTHr1C4eqCgy7SKplBlMzOTZikkWcQKhj2cefs7fBntpdxEwbjM5EHiqOsUJhWRyNx4i/
 8y9wGRaxnsJrOSJMeGFWXaN/e7xWMvw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-CvrAOCmVMbuXBOLpx1N1Wg-1; Fri, 06 Sep 2024 06:19:28 -0400
X-MC-Unique: CvrAOCmVMbuXBOLpx1N1Wg-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-718d873b1e8so597993b3a.3
 for <ltp@lists.linux.it>; Fri, 06 Sep 2024 03:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617966; x=1726222766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbXxqEXq8uvF3n45w7OU3ccyxi6XRES9vU1SDOCIiZk=;
 b=qlDJUzl0PCamahvwQB3i+ssfkwua8g+nsYb339Crxf7LimlGM7cEEb2w1h6Kbyz1Q1
 UETngLjHPVMN1DkXgnbTlj+kpmPFCaiBAPRtKnTIBy+4ugrISv2S6Dkg2MAlN9spI0wU
 4n/28U0tZEzZSK6uGSieiwwPX/4HIHNFe8q5ci1n9xPo6D7SKWwygO3egFXcuy2DJ4n/
 ysJkYnQfMBC2xZn4H0Qh3+dRJ8JLMn4wHoBWXaSpOuAsNXPXUFyvclkhPYEpvspN951n
 p61OB8Kj3SWBaNBcNZUmbRK2dTSLd/zdAMdOD2tzqbtF0db4TGKMmIP1xxidElyrlgU6
 Rw/w==
X-Gm-Message-State: AOJu0Yygj4fLwr6uaVzJEEOkf+wTXAddk8jFlwK3TpTU0PEhvHNcz0d7
 ydltdZYEFLMBRiU9C5Q3nCU95oF1caNw5/ueXsWVnKTEdd0IVv6fU7E1l5adQKTb3yFTegy+6gU
 qNBxfTktAUSDFk1l6tMpwWj/iWYc1JKFcxdY7cOOMVt9YtOG25gWLMZTiHf6bO/MeiwFimP13rY
 x8g/4nVpbGUTONf2Eiq7gniarQpVU6mZEbCPxP
X-Received: by 2002:a05:6a20:db0c:b0:1c4:8291:e94e with SMTP id
 adf61e73a8af0-1cf1d1ef82dmr1916207637.45.1725617965802; 
 Fri, 06 Sep 2024 03:19:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9PgtEra441bEAugqY8Bkh7TLzXPAZAlrumq1L4KrGqk+nmfODDnitsiFrbLe+KPAZcL0hkW4dl1QdS+u32Ew=
X-Received: by 2002:a05:6a20:db0c:b0:1c4:8291:e94e with SMTP id
 adf61e73a8af0-1cf1d1ef82dmr1916186637.45.1725617965362; Fri, 06 Sep 2024
 03:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
 <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
 <ZtrRCVxNKuu5ZdHN@yuki.lan>
In-Reply-To: <ZtrRCVxNKuu5ZdHN@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Sep 2024 18:19:12 +0800
Message-ID: <CAEemH2d0h9t5iad82YSHu_yZto5ZXQ2TBF9Xs0Oq5jBrjTY5tg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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

T24gRnJpLCBTZXAgNiwgMjAyNCBhdCA1OjU04oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IHRzdF90ZXN0LmM6MTg2MDogVElORk86IExUUCB2ZXJz
aW9uOiAyMDI0MDUyNAo+ID4gdHN0X3Rlc3QuYzoxODY0OiBUSU5GTzogVGVzdGVkIGtlcm5lbDog
Ni44LjAtMTAxMC1yYXNwaSAjMTEtVWJ1bnR1IFNNUAo+ID4gUFJFRU1QVF9EWU5BTUlDIFRodSBB
dWcgIDggMjM6MjI6NDEgVVRDIDIwMjQgYWFyY2g2NAo+ID4gdHN0X3Rlc3QuYzoxNzAzOiBUSU5G
TzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKPiA+IHNoZWxsX3Rlc3QwMS5jOjExOiBU
SU5GTzogQyB0ZXN0IGV4aXRzIG5vdwo+ID4gVXNhZ2U6IHRzdF9yZXNfIGZpbGVuYW1lIGxpbmVu
byBbVFBBU1N8VEZBSUx8VENPTkZ8VElORk98VERFQlVHXSAnQSBzaG9ydAo+ID4gZGVzY3JpcHRp
b24nCj4gPiB0c3RfdGVzdC5jOjE1MzU6IFRCUk9LOiBUZXN0IGhhdmVuJ3QgcmVwb3J0ZWQgcmVz
dWx0cyEKPiA+Cj4gPiBTdW1tYXJ5Ogo+ID4gcGFzc2VkICAgMAo+ID4gZmFpbGVkICAgMAo+ID4g
YnJva2VuICAgMQo+ID4gc2tpcHBlZCAgMAo+ID4gd2FybmluZ3MgMAo+ID4KPiA+Cj4gPiBIZXJl
IEkgZ290IHRlc3QgZmFpbHVyZXMgb24gbXkgUlBpNCAoYmFzaC01LjIuMjEpIHRoYXQgdGhlICRM
SU5FT04gY2FuJ3QKPiA+IGJlIHBhcnNlZCBjb3JyZWN0bHkuCj4KPiBBcmUgeW91IHN1cmUgdGhh
dCB0aGlzIGlzIGR1ZSB0byBiYXNoPyBNeSBndWVzcyBpcyB0aGF0IG9uIFJQaSB0aGUKPiBkZWZh
dWx0IHNoZWxsIGlzIGRhc2ggYmVjYXVzZSBpdCdzIGRlYmlhbiBiYXNlZC4KPgo+IEkgd2lsbCB0
cnkgdG8gcmVwcm9kdWNlLgo+Cj4gPiBUaGUgcmVhc29uIHByb2JhYmx5IGlzIHNvbWUgc2hlbGxz
IG9yIHNwZWNpZmljIHZlcnNpb25zIG1pZ2h0IG5vdCBoYW5kbGUKPiA+ICRMSU5FTk8gY29ycmVj
dGx5IHdpdGhpbiBhbGlhc2VzLCBlc3BlY2lhbGx5IHdoZW4gdGhlIGxpbmUgbnVtYmVyIG5lZWRz
Cj4gPiB0byBiZSBkeW5hbWljYWxseSBkZXRlcm1pbmVkLgo+ID4KPiA+IFNvIEkgc3VnZ2VzdCB1
c2luZyBhIGZ1bmN0aW9uIGluc3RlYWQgb2YgdGhlIGFsaWFzLgo+ID4KPiA+Cj4gPiAtLS0gYS90
ZXN0Y2FzZXMvbGliL3RzdF9lbnYuc2gKPiA+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5z
aAo+ID4gQEAgLTIxLDUgKzIxLDEyIEBAIHRzdF9icmtfKCkKPiA+ICAgICAgICAgZXNhYwo+ID4g
IH0KPiA+Cj4gPiAtYWxpYXMgdHN0X3Jlcz0idHN0X3Jlc18gJHRzdF9zY3JpcHRfbmFtZSBcJExJ
TkVOTyIKPiA+IC1hbGlhcyB0c3RfYnJrPSJ0c3RfYnJrXyAkdHN0X3NjcmlwdF9uYW1lIFwkTElO
RU5PIgo+ID4gK3RzdF9yZXMoKQo+ID4gK3sKPiA+ICsgICAgdHN0X3Jlc18gIiR0c3Rfc2NyaXB0
X25hbWUiICIkTElORU5PIiAiJEAiCj4gPiArfQo+ID4gKwo+ID4gK3RzdF9icmsoKQo+ID4gK3sK
PiA+ICsgICAgdHN0X2Jya18gIiR0c3Rfc2NyaXB0X25hbWUiICIkTElORU5PIiAiJEAiCj4gPiAr
fQo+Cj4gVGhhdCBhY3R1YWxseSBkb2VzIG5vdCB3b3JrIGJlY2F1c2UgdW5saWtlIHRoZSBhbGlh
cyB0aGUgJExJTkVOTyBpcwo+IGV4cGFuZGVkIGluIHRoZSB3cm9uZyBwbGFjZSBhbmQgdGhlIGxp
bmUgaXMgaW5jb3JyZWN0Lgo+Cj4gVGhlIHdob2xlIHJlYXNvbiBmb3IgdGhpcyB0byBiZSBhbGlh
cyBpcyB0aGF0IGl0J3MgZXhwYW5kZWQgb24gdGhlCj4gY29ycmVjdCBsaW5lIGluIHRoZSB0ZXN0
IHNvdXJjZS4KPgoKQWgsIHlvdSdyZSByaWdodCwgSSB3YXNuJ3QgYXdhcmUgb2YgdGhhdC4KCk1h
eWJlIHdlIGNhbiB1c2UgYSB0cmljayB3aXRoIGV2YWwgdG8gZGVsYXkgdGhlIGV4cGFuc2lvbgpv
ZiAkTElORU5PIHVudGlsIHRoZSBmdW5jdGlvbiBpcyBhY3R1YWxseSBjYWxsZWQ/CgplLmcuCgp0
c3RfcmVzKCkKewogICAgZXZhbCAidHN0X3Jlc18gXCIkdHN0X3NjcmlwdF9uYW1lXCIgXCRMSU5F
Tk8gXCJcJEBcIiIKfQoKdHN0X2JyaygpCnsKICAgIGV2YWwgInRzdF9icmtfIFwiJHRzdF9zY3Jp
cHRfbmFtZVwiIFwkTElORU5PIFwiXCRAXCIiCn0KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
