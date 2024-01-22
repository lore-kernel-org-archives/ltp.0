Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0400C47DD3
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:29:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F20693CE22B
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:29:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E9423CC785
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:29:14 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 403CC2009B7
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:29:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705908551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OGhEESSZS3JoMSjXiPGocT3FMKRcS1w+Lvg1ydBm/W4=;
 b=ghWZ6iRnxLBrH3x+W2sKOx1jP9hnZ5QzOkJhOn4t6n3FpuBJhrtexZHpU5TWE2at2A/tsW
 F6N1C/dHCkzW+lq2IvBbqsgilHGf3n8Qwup7bWfLN+RpGB8T1bONKbZO3QZPrI+0inPwbs
 VsL8moe9CCFHK2tzCLz2mLBqlKBOKdk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-R21eR_amMImFRvrg1dB_Kg-1; Mon, 22 Jan 2024 02:29:07 -0500
X-MC-Unique: R21eR_amMImFRvrg1dB_Kg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5ce53c43ea1so1656124a12.2
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 23:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705908547; x=1706513347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGhEESSZS3JoMSjXiPGocT3FMKRcS1w+Lvg1ydBm/W4=;
 b=v6DK1Su56PtrAe7ixEhUIRtAxbeiktoxAmZGvCpdTQC2rTm+7nIdx7J3hRXiOk0ZUw
 MF6IAwtVYwIO/rE83S/G7tS/liGpxJfaxp/Jgyz5EqlMgKGacHoMV1DYediPr7HzPBwc
 JjKH9QTLR+U34hSwy+JC/pDs3zQWkZpC+1STGIZ6RDc4kUxpBLUWh0gyZS2zpOW946H5
 F7zRhQx60lu6vVd/TAoQkonV41jTi+I3KQzH6zoUVVFPtPqmaCdAT4ijIiPil+6Oo7PJ
 99qojmWgx0B3gG6+oEIJzNhRefvNyvh7Q/qrpXAf9kZxaDk782lReicuc9aYN7ufrkWJ
 eqhA==
X-Gm-Message-State: AOJu0Yxyi/QlZRPEHE6G6C2pXTntggCHuOUs1Oiai0tmj7wRMJbY8I+L
 8IuDKy94X4fGyG5F2fVlCSJtjC/wDhMGR5oEhv+yIMddDq/0o44HYOKrX/2AGu0dYtonWIZ3+VO
 q7QyK/aoF8CgL3bfgxH2TGWcPsjz7JxeImTsRiavxq+K4rM91pb+I26gfb/0s5gP9Q1FJ2rRRxk
 iPQCNy2gX08oTh3S3KoI839sg=
X-Received: by 2002:a05:6a20:158f:b0:19a:2830:146d with SMTP id
 h15-20020a056a20158f00b0019a2830146dmr1547318pzj.85.1705908546949; 
 Sun, 21 Jan 2024 23:29:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF/x+WxMuptCd68brrIhvih3yD1jmVpD/VRSr2Jd3ayArfDnwOKabjjFSUuN122mcuesLZf+OGuQlWcx7Onus=
X-Received: by 2002:a05:6a20:158f:b0:19a:2830:146d with SMTP id
 h15-20020a056a20158f00b0019a2830146dmr1547314pzj.85.1705908546658; Sun, 21
 Jan 2024 23:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20240120043412.2544860-2-liwang@redhat.com>
 <20240120082725.2550695-1-liwang@redhat.com>
 <20240122071337.GB65606@pevik>
In-Reply-To: <20240122071337.GB65606@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 15:28:54 +0800
Message-ID: <CAEemH2eLMMNE1=UcNiw=XAD2HswV39bHerV8drZ+Pv8c_deAmA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] libswap: add Btrfs noCOW attribute setting for
 swap files
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

T24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgMzoxM+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IFRoZSBwYXRjaCBhaW1zIHRvIGVuc3VyZSBzd2Fw
IGZpbGVzIG9uIEJ0cmZzIGZpbGVzeXN0ZW1zIGFyZSBjcmVhdGVkCj4gPiB3aXRoIHRoZSBhcHBy
b3ByaWF0ZSBGU19OT0NPV19GTCBhdHRyaWJ1dGUsIHdoaWNoIGlzIG5lY2Vzc2FyeSB0bwo+ID4g
ZGlzYWJsZSBDb1cgKENvcHktb24tV3JpdGUpIGZvciBzd2FwIGZpbGVzLCBwZXJ0aGUgYnRyZnMo
NSkgbWFudWFsIHBhZ2UuCj4gPiBUaGlzIGNoYW5nZSBpcyBnYXRlZCBiZWhpbmQgYSBrZXJuZWwg
dmVyc2lvbiBjaGVjayB0byBlbnN1cmUKPiBjb21wYXRpYmlsaXR5Cj4gPiB3aXRoIHRoZSBzeXN0
ZW0ncyBjYXBhYmlsaXRpZXMuCj4KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0By
ZWRoYXQuY29tPgo+ID4gLS0tCj4KPiA+IE5vdGVzOgo+ID4gICAgIEhpIFBldHIsCj4KPiA+ICAg
ICAgIEkgaGF2ZW4ndCBnb3R0ZW4gYSBjaGFuY2UgdG8gdGVzdCB0aGlzIHBhdGNoIG9uIGFueSBC
dHJmcyBwbGF0Zm9ybSwKPiA+ICAgICAgIGJ1dCBvbmx5IGNvbXBpbGUgc3VjY2Vzc2Z1bGx5IHdp
dGhvdXQgZXJyb3Igb24gbXkgUkhFTDgvOSh4ZnMpLgo+ID4gICAgICAgQ2FuIHlvdSBoZWxwIHRl
c3QgYW5kIGd1YXJhbnRlZSBpdCB3b3JrcyBmb3IgeW91Pwo+Cj4gSSdtIG5vdCBhYmxlIHRvIGFw
cGx5IHRoaXMgdG8gdGhlIGN1cnJlbnQgbWFzdGVyLiBJIGFsc28gZ290IGEgYml0Cj4gY29uZnVz
ZWQgYnkKPiBudW1iZXIgb2YgcGF0Y2hlcyBmb3IgbGlic3dhcCAvIHN3YXBvbjAxLiBDb3VsZCB5
b3UgcGxlYXNlIHJlc2VuZCBhbGwgdGhlCj4gcGF0Y2hlcyBhZ2FpbiAoaW4gYSBzZXJpZXMpPyBP
ciBwdXNoIGJyYW5jaCB0byB5b3VyIGZvcmsgYW5kIHBvaW50IHRoZQo+IGxvY2F0aW9uPwo+ICh3
aGF0ZXZlciBpcyBlYXNpZXIgdG8geW91KQo+CgpTdXJlLCBsZXQncyBmb3JtYXQgdGhlbSBpbiBh
IHNldC4KClNvcnJ5IGZvciB0aGUgY29uZnVzaW9uLCBJIHdhcyBqdXN0IGRldmVsb3BpbmcgdGhl
bSBvbmUgYnkgb25lIGFuZCBzZW50CmRpcmVjdGx5LgoKCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBl
dHIKPgo+ID4gIGxpYnMvbGlibHRwc3dhcC9saWJzd2FwLmMgfCAzNSArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCsp
Cj4KPiA+IGRpZmYgLS1naXQgYS9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jIGIvbGlicy9saWJs
dHBzd2FwL2xpYnN3YXAuYwo+ID4gaW5kZXggNWY5NjIyYWNhLi44YjE4MGYyODggMTAwNjQ0Cj4g
PiAtLS0gYS9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4gPiArKysgYi9saWJzL2xpYmx0cHN3
YXAvbGlic3dhcC5jCj4gPiBAQCAtNCw2ICs0LDcgQEAKPiA+ICAgKiBBdXRob3I6IFN0YW5pc2xh
diBLaG9sbWFuc2tpa2ggPHN0YW5pc2xhdi5raG9sbWFuc2tpa2hAb3JhY2xlLmNvbT4KPiA+ICAg
Ki8KPgo+ID4gKyNpbmNsdWRlIDxsaW51eC9mcy5oPgo+ID4gICNpbmNsdWRlIDxlcnJuby5oPgo+
Cj4gPiAgI2RlZmluZSBUU1RfTk9fREVGQVVMVF9NQUlOCj4gPiBAQCAtMjMsMTEgKzI0LDM3IEBA
IHN0YXRpYyBjb25zdCBjaGFyICpjb25zdCBzd2FwX3N1cHBvcnRlZF9mc1tdID0gewo+ID4gICAg
ICAgTlVMTAo+ID4gIH07Cj4KPiA+ICtzdGF0aWMgdm9pZCBzZXRfbm9jb3dfYXR0cihjb25zdCBj
aGFyICpmaWxlbmFtZSkKPiA+ICt7Cj4gPiArICAgICBpbnQgZmQ7Cj4gPiArICAgICBpbnQgYXR0
cnM7Cj4gPiArCj4gPiArICAgICBmZCA9IFNBRkVfT1BFTihmaWxlbmFtZSwgT19SRE9OTFkpOwo+
ID4gKwo+ID4gKyAgICAgaWYgKGlvY3RsKGZkLCBGU19JT0NfR0VURkxBR1MsICZhdHRycykgPT0g
LTEpIHsKPiA+ICsgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCB8IFRFUlJOTywgIkVycm9yIGdl
dHRpbmcgYXR0cmlidXRlcyIpOwo+ID4gKyAgICAgICAgICAgICBjbG9zZShmZCk7Cj4gPiArICAg
ICAgICAgICAgIHJldHVybjsKPiA+ICsgICAgIH0KPiA+ICsKPiA+ICsgICAgIGF0dHJzIHw9IEZT
X05PQ09XX0ZMOwo+ID4gKwo+ID4gKyAgICAgaWYgKGlvY3RsKGZkLCBGU19JT0NfU0VURkxBR1Ms
ICZhdHRycykgPT0gLTEpCj4gPiArICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBURVJSTk8s
ICJFcnJvciBzZXR0aW5nIEZTX05PQ09XX0ZMCj4gYXR0cmlidXRlIik7Cj4gPiArICAgICBlbHNl
Cj4gPiArICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJGU19OT0NPV19GTCBhdHRyaWJ1dGUg
c2V0IG9uICVzXG4iLAo+IGZpbGVuYW1lKTsKPiA+ICsKPiA+ICsgICAgIGNsb3NlKGZkKTsKPiA+
ICt9Cj4gPiArCj4gPiAgLyoKPiA+ICAgKiBNYWtlIGEgc3dhcCBmaWxlCj4gPiAgICovCj4gPiAg
aW50IG1ha2Vfc3dhcGZpbGUoY29uc3QgY2hhciAqc3dhcGZpbGUsIGludCBzYWZlKQo+ID4gIHsK
PiA+ICsgICAgIGxvbmcgZnNfdHlwZSA9IHRzdF9mc190eXBlKHN3YXBmaWxlKTsKPiA+ICsgICAg
IGNvbnN0IGNoYXIgKmZzdHlwZSA9IHRzdF9mc190eXBlX25hbWUoZnNfdHlwZSk7Cj4gPiArCj4g
PiAgICAgICBpZiAoIXRzdF9mc19oYXNfZnJlZSgiLiIsIHN5c2NvbmYoX1NDX1BBR0VTSVpFKSAq
IDEwLCBUU1RfQllURVMpKQo+ID4gICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiSW5zdWZm
aWNpZW50IGRpc2sgc3BhY2UgdG8gY3JlYXRlIHN3YXAKPiBmaWxlIik7Cj4KPiA+IEBAIC0zNSw2
ICs2MiwxNCBAQCBpbnQgbWFrZV9zd2FwZmlsZShjb25zdCBjaGFyICpzd2FwZmlsZSwgaW50IHNh
ZmUpCj4gPiAgICAgICBpZiAodHN0X2ZpbGxfZmlsZShzd2FwZmlsZSwgMCwgc3lzY29uZihfU0Nf
UEFHRVNJWkUpLCAxMCkgIT0gMCkKPiA+ICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgIkZh
aWxlZCB0byBjcmVhdGUgc3dhcGZpbGUiKTsKPgo+ID4gKyAgICAgLyogQnRyZnMgZmlsZSBuZWVk
IHNldCAnbm9jb3cnIGF0dHJpYnV0ZSAqLwo+ID4gKyAgICAgaWYgKHN0cmNtcChmc3R5cGUsICJi
dHJmcyIpID09IDApIHsKPiA+ICsgICAgICAgICAgICAgaWYgKHRzdF9rdmVyY21wKDUsIDAsIDAp
ID4gMCkKPiA+ICsgICAgICAgICAgICAgICAgICAgICBzZXRfbm9jb3dfYXR0cihzd2FwZmlsZSk7
Cj4gPiArICAgICAgICAgICAgIGVsc2UKPiA+ICsgICAgICAgICAgICAgICAgICAgICB0c3RfYnJr
KFRDT05GLCAiU3dhcGZpbGUgb24gJXMgbm90IGltcGxlbWVudGVkIiwKPiBmc3R5cGUpOwo+ID4g
KyAgICAgfQo+ID4gKwo+ID4gICAgICAgLyogbWFrZSB0aGUgZmlsZSBzd2FwZmlsZSAqLwo+ID4g
ICAgICAgY29uc3QgY2hhciAqYXJndlsyICsgMV07Cj4gPiAgICAgICBhcmd2WzBdID0gIm1rc3dh
cCI7Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
