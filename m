Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777F9C48260
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:50:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA2343CE261
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:50:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 488903CE227
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:50:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E8FFD60096C
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:50:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705909837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RdGhTeiujE496SBsoJtwqTbexJ8mRbBf1UQxhbPEksU=;
 b=bZCzPGQ9z0y69JXYaBB2IRHIQKloMgU+8qFpQ2BwscSlmwBbAwkPioKxN7+x1WJmom+t+m
 6+mPV+QWLFaf60Z2V61tp98dpI+vr2VpWG0Ym79kLzPD1sgSJStbr03AHmgQix2SsAzdUJ
 W0TdUE6iilrCNc3y1u4cP7SNvdoqhEM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-L7kgMBkSOtW7Rg2mWpxpZA-1; Mon, 22 Jan 2024 02:50:35 -0500
X-MC-Unique: L7kgMBkSOtW7Rg2mWpxpZA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28bb7083fb5so1599278a91.2
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 23:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705909834; x=1706514634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RdGhTeiujE496SBsoJtwqTbexJ8mRbBf1UQxhbPEksU=;
 b=wWzLQveoCH3PSXYwLQZ0/5xFD6H92obYwI7E9GMQdsJbbpp+LX7hC8ESAacrNB5I6w
 RbgxYTVGXAuRLfMhTptPscEYCLksz3I72Xzl4awEK6er1FeUc4Q2NC/3bnlclM75Asto
 3LI5jdsMY6k9yQjXRcp8BRNVRhNaWVHISO9qIx+NNRwQ7WCWbUXRobUISVBusgBT5uTF
 vwtyQmhhYTIzE+7UDvf1jIPD7nCyN+irMwv3MjYMBeTtkSlWtNDcBcNpzZxxXCpQr6ne
 X3u3F4RenqP83b4lowYqgG3kI6VEWyH0yit4zU/w4EUhZMa2C8lzOkc0maNQlYxXhmq4
 cmeQ==
X-Gm-Message-State: AOJu0YyHTg2xCZdJYTFrLRvJNaloprBv6/fdSfQrtkoIHRxIPHkvYKlq
 alwjH7POC37ec0f/6xr8+E/5ZGSMmAK/j6QsJMxrnWiBl2MCpWsW6Mby7FupIRkI0hLO498VI5P
 BVORfuLwD3AdMoRoezX38H+FICbp03WY7vd2x7yhoVHde9BZQhRIbXOhY+ob37RgBcmYxUXIq+d
 HBfH5wTXb8mzvPFreL4np5aqmPL+eZK06YQ+5o
X-Received: by 2002:a17:90a:130b:b0:28f:ef16:673 with SMTP id
 h11-20020a17090a130b00b0028fef160673mr859307pja.73.1705909833963; 
 Sun, 21 Jan 2024 23:50:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7Z32F3VsDrCu1qR0Lg4jvK8NP7OWHDTjUbxGEf5p8vdOXhJdBZC1osPdEjKEWUvCRq8BgJGlNnzy0hQzYkZ0=
X-Received: by 2002:a17:90a:130b:b0:28f:ef16:673 with SMTP id
 h11-20020a17090a130b00b0028fef160673mr859302pja.73.1705909833621; Sun, 21 Jan
 2024 23:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20240119144322.41928-1-pvorel@suse.cz>
 <CAEemH2ceuoj+a2PK2pNStXYnsBcXM+g8JWkdd3Jj077xi+nm3A@mail.gmail.com>
 <20240122062627.GB58756@pevik>
In-Reply-To: <20240122062627.GB58756@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 15:50:21 +0800
Message-ID: <CAEemH2epxiFvRCaXaGgbJ2uW36qrbJJ_zAYyUOwnS2Z7uqtpDg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] swapon01: Test on all filesystems
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

T24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgMjoyN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEN5cmlsLAo+Cj4gPiBIaSBQZXRyLCBDeXJpbCwKPgo+ID4g
T24gRnJpLCBKYW4gMTksIDIwMjQgYXQgMTA6NDPigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiA+ID4gVGVzdCBvbiBhbGwgZmlsZXN5c3RlbXMgdG8gaW5jcmVhc2Ug
Y292ZXJhZ2UuCj4gPiA+IFNraXAgZmlsZXN5c3RlbXMgd2hpY2ggZG9lcyBub3Qgc3VwcG9ydCBz
d2FwIChjdXJyZW50bHkgYmNhY2hlZnMsIGJ0cmZzCj4gPiA+IGFuZCB0bXBmcykuCj4KPiA+ID4g
VGVzdGVkIG9uIDUuMTAsIDYuNiBhbmQgNi43Lgo+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIg
Vm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+ID4gPiAtLS0KPiA+ID4gSGkgTGksIEN5cmlsLAo+Cj4g
PiA+IGZlZWwgZnJlZSB0byBwb3N0cG9uZSB0aGlzIGFmdGVyIHRoZSByZWxlYXNlLgo+ID4gPiBJ
ZiB3ZSBhcmUgZm9yIGFkZGluZyB0aGlzLCBJJ2xsIHJldGVzdCBvbiBNb25kYXkgb2xkZXIgZmls
ZXN5c3RlbXMuCj4KPiA+ID4gbWFuIHN3YXBvbig4KSBtZW50aW9uczoKPgo+ID4gPiAgICBCdHJm
cwo+ID4gPiAgICAgICAgU3dhcCBmaWxlcyBvbiBCdHJmcyBhcmUgc3VwcG9ydGVkIHNpbmNlIExp
bnV4IDUuMCBvbiBmaWxlcyB3aXRoCj4gPiA+IG5vY293Cj4gPiA+ICAgICAgICBhdHRyaWJ1dGUu
IFNlZSB0aGUgYnRyZnMoNSkgbWFudWFsIHBhZ2UgZm9yIG1vcmUgZGV0YWlscy4KPgo+ID4gPiA9
PiBDYW4gd2UgcGFzcyAibm9jb3ciIGp1c3QgdG8gYnRyZnM/IE9yIHNob3VsZCBpdCBiZSBhZGRl
ZCB0byBzaW5nbGUKPiA+ID4gdGVzdCwgd2hpY2ggdXNlcyBqdXN0IGJ0cmZzIHdpdGggbm9jb3c/
Cj4KPiA+ID4gICAgTkZTCj4gPiA+ICAgICAgICBTd2FwIG92ZXIgTkZTIG1heSBub3Qgd29yay4K
Pgo+ID4gPiA9PiBJIGd1ZXNzIHRoaXMgaXMgbm90IGltcG9ydGFudCBmb3IgdXMsIGFzIE5GUyBp
cyBub3QgcGFydCBvZgo+ID4gPiBmaWxlc3lzdGVtcyBpbiAuYWxsX2ZpbGVzeXN0ZW1zLCBidXQg
bWF5YmUgd2Ugc2hvdWxkIHN0aWxsIGFkZCBpdCB0bwo+IHRoZQo+ID4gPiB3aGl0ZWxpc3Q/Cj4K
PiA+ID4gS2luZCByZWdhcmRzLAo+ID4gPiBQZXRyCj4KPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMgfCAyMSArKysrKysrKysrKysrKystLS0tLS0KPiA+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Cj4g
PiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24w
MS5jCj4gPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+
ID4gPiBpbmRleCBlNTlmYjIwYTEuLmVmNGViZmRjZiAxMDA2NDQKPiA+ID4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiA+IEBAIC04LDYgKzgsNyBA
QAo+ID4gPiAgICogW0Rlc2NyaXB0aW9uXQo+ID4gPiAgICoKPiA+ID4gICAqIENoZWNrcyB0aGF0
IHN3YXBvbigpIHN1Y2NlZHMgd2l0aCBzd2FwZmlsZS4KPiA+ID4gKyAqIFRlc3Rpbmcgb24gYWxs
IGZpbGVzeXN0ZW1zIHdoaWNoIHN1cHBvcnQgc3dhcCBmaWxlLgo+ID4gPiAgICovCj4KPiA+ID4g
ICNpbmNsdWRlIDx1bmlzdGQuaD4KPiA+ID4gQEAgLTE3LDEzICsxOCwxNCBAQAo+ID4gPiAgI2lu
Y2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKPiA+ID4gICNpbmNsdWRlICJsaWJzd2FwLmgiCj4KPiA+
ID4gLSNkZWZpbmUgU1dBUF9GSUxFICJzd2FwZmlsZTAxIgo+ID4gPiArI2RlZmluZSBNTlRQT0lO
VCAgICAgICAibW50cG9pbnQiCj4gPiA+ICsjZGVmaW5lIFNXQVBfRklMRSAgICAgIE1OVFBPSU5U
Ii9zd2FwZmlsZTAxIgo+Cj4gPiA+ICBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQpCj4g
PiA+ICB7Cj4gPiA+ICAgICAgICAgVFNUX0VYUF9QQVNTKHRzdF9zeXNjYWxsKF9fTlJfc3dhcG9u
LCBTV0FQX0ZJTEUsIDApKTsKPgo+ID4gPiAtICAgICAgIGlmIChUU1RfUEFTUyAmJiB0c3Rfc3lz
Y2FsbChfX05SX3N3YXBvZmYsIFNXQVBfRklMRSkgIT0gMCkgewo+ID4gPiArICAgICAgIGlmICh0
c3Rfc3lzY2FsbChfX05SX3N3YXBvZmYsIFNXQVBfRklMRSkgIT0gMCkgewo+ID4gPiAgICAgICAg
ICAgICAgICAgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywKPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAiRmFpbGVkIHRvIHR1cm4gb2ZmIHN3YXBmaWxlLCBzeXN0ZW0KPiA+ID4g
cmVib290IHJlY29tbWVuZGVkIik7Cj4gPiA+ICAgICAgICAgfQo+ID4gPiBAQCAtMzEsMTMgKzMz
LDIwIEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9zd2Fwb24odm9pZCkKPgo+ID4gPiAgc3RhdGljIHZv
aWQgc2V0dXAodm9pZCkKPiA+ID4gIHsKPiA+ID4gLSAgICAgICBpc19zd2FwX3N1cHBvcnRlZChT
V0FQX0ZJTEUpOwo+ID4gPiAgICAgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAwKTsKPiA+
ID4gIH0KPgo+ID4gPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gPiAtICAg
ICAgIC5uZWVkc19yb290ID0gMSwKPiA+ID4gLSAgICAgICAubmVlZHNfdG1wZGlyID0gMSwKPiA+
ID4gKyAgICAgICAubW50cG9pbnQgPSBNTlRQT0lOVCwKPiA+ID4gKyAgICAgICAubW91bnRfZGV2
aWNlID0gMSwKPiA+ID4gKyAgICAgICAubmVlZHNfcm9vdCA9IDEsIC8qIGZvciBzd2Fwb24oKSAq
Lwo+ID4gPiArICAgICAgIC5hbGxfZmlsZXN5c3RlbXMgPSAxLAo+ID4gPiAgICAgICAgIC50ZXN0
X2FsbCA9IHZlcmlmeV9zd2Fwb24sCj4gPiA+IC0gICAgICAgLnNldHVwID0gc2V0dXAKPiA+ID4g
KyAgICAgICAuc2V0dXAgPSBzZXR1cCwKPiA+ID4gKyAgICAgICAuc2tpcF9maWxlc3lzdGVtcyA9
IChjb25zdCBjaGFyICpbXSkgewo+ID4gPiArICAgICAgICAgICAgICAgImJjYWNoZWZzIiwKPiA+
ID4gKyAgICAgICAgICAgICAgICJidHJmcyIsCj4gPiA+ICsgICAgICAgICAgICAgICAidG1wZnMi
LAo+ID4gPiArICAgICAgICAgICAgICAgTlVMTAo+ID4gPiArICAgICAgIH0sCj4KPgo+Cj4gPiBJ
TUhPLCBJIGhhdGUgdG8gYWRkIHRoZSBza2lwX2ZpbGVzeXN0ZW0gaW4gdGhpcyB0ZXN0LCBiZWNh
dXNlIGlmIHdlIGRvLAo+ID4gdGhlbiB3ZSBoYXZlIHRvIGFkZCB0byBhbGwgb2YgdGhlIHJlbGF0
ZWQgc3dhcCB0ZXN0cyB0aGF0LCBpdCBhZGQgbW9yZQo+ID4gdGVkaW91cyB3b3JrIHRvIHBlb3Bs
ZS4KPgo+IEZpcnN0IEkgdGhvdWdodCBpdCdkIGJlIG9rIHRvIGhhdmUganVzdCBzaW5nbGUgdGVz
dCB3aGljaCB1c2VzCj4gYWxsX2ZpbGVzeXN0ZW1zCj4gKGJldHRlciBvbmUgdGhhbiBub25lKSwg
YnV0IHN1cmUsIGhhdmluZyBhbGwgb2YgdGhlbSB3b3VsZCBiZSBiZXR0ZXIuCj4KPiA+IFNvLCBp
ZiB3ZSBkZWNpZGUgdG8gcG9zdHBvbmUgdGhpcyBwYXRjaCB0byByZWxlYXNlLCB3ZSBjYW4ganVz
dCByZWZhY3Rvcgo+ID4gdGhlIGlzX3N3YXBfc3VwcG9ydGVkKCkgZnVuY3Rpb24gdG8gbWFrZSB0
aGluZ3MgZWFzaWVyLiBJIHdpbGwgc2VuZCBhbgo+IFJGQwo+ID4gcGF0Y2ggdG8gc2hvdyBzb21l
dGhpbmcgaW4gbXkgbWluZCwgd2hhdCB3ZSBuZWVkIHRvIGRvIGxhdGVyIGlzIGp1c3QKPiA+IHRv
IGZpbmFsaXplIHRoZSBzd2FwX3N1cHBvcnRlZF9mc1tdIHN0cnVjdCBsaXN0Lgo+Cj4gU3VyZSwg
dGhpcyBpcyBub3QgY3JpdGljYWwsIGl0IGNhbiB3YWl0IGlmIHlvdSBoYXZlIGJldHRlciBzb2x1
dGlvbi4gVGhhbmtzCj4gZm9yIHNwZW5kaW5nIHRpbWUgb24gaXQuCj4KClllcywgYnV0IGl0IGlz
IHJlYWR5IHRoZXJlIDEvNCA6KS4KICBodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9s
dHAvMjAyNC1KYW51YXJ5LzAzNjgwNC5odG1sCgpUaGUgcmVzdCB3b3JrIGlzIGp1c3QgdG8gZmlu
YWxpemUgdGhlIHN3YXBfc3VwcG9ydGVkX2ZzIGxpc3QuCkFuZCwgSSBhZ3JlZSB0aGF0IGFsbCBv
ZiB0aGVzZSBjYW4gYmUgcG9zdHBvbmVkLiBCZWNhdXNlCnNvIGZhciBpdCB3b24ndCBiZSBhIGNy
aXRpY2FsL3VyZ2VudC1maXggZm9yIGEgbmV3IHJlbGVhc2UuCgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
