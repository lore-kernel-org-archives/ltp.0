Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F70C3271E
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 03:50:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E49253D3897
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 05:50:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5BD63D073A
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 05:50:13 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5BB5602A1E
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 05:50:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720669811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aDgkUctyFnAw+9Yw+YuocORJF4RcaXgHtJghko4suIA=;
 b=dt7FCRN3lCqZjg3P80I42IPBpWKsC8nXoLahXWH+OewIGbz/EmcSlU0tNOTc/XL7CcnIUd
 rl1fRYL64Y/Rt/qi7I2llZCNUkb7lVIrewbKMhAci2Q6s+XOwp9Use5AkhLP9NCYBFPtmJ
 jtitgiBJ3NxxjNoUK3zluPe5oERRydc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-sp3saeCHPoSoQpQ-MAF1mQ-1; Wed, 10 Jul 2024 23:50:09 -0400
X-MC-Unique: sp3saeCHPoSoQpQ-MAF1mQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c9d510f670so442667a91.0
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 20:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720669808; x=1721274608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aDgkUctyFnAw+9Yw+YuocORJF4RcaXgHtJghko4suIA=;
 b=DhII+cwAKlZpBSVkFfb1oDaWjXsIGr0HJBF3oMDfFXdDHNHN1IBbzIXnxpD1NzOucp
 e561LZpFdvYEpo2j+BL9jvAngEK3CnNJYt+RjvLO//iygFg4yUVBo7Z0SFCTILegIKmP
 9mIg8AcmtLFcLlNAEnnMkpVNvFV9iIocKAL/1d4Zn9DNAeUjk/t4Nsd+6U6cFURkxpO+
 0SVbOWETOTyQoqXImOrLMHYnwSgahaXkg19xhn9nqMn7CtuIaF11FFB4MaZRSGmvQfZ8
 U1KrLiQkZvXOOo5ekPMlWO2/HShczV7rZD9xC2iZH6hZuSmAQZQi939NpV3WLW3WuEsb
 8VDQ==
X-Gm-Message-State: AOJu0YwjEBBBLddWiEm+gJWxdDgdmWgOIdaz+3/Zq4F/ypH6RnJClxJi
 afTHxy8dv5B8Ge4yTQZv7zF2/bLnMz5roKuMh9Z4FJM52qL/ezaqZGOXT1xzQvfOefao86fKM1I
 M2ZSNi1VkuiuPZCCuLiS/PAaCB/pg4kTFgL02bgjj1xbGZLrFC/Xak72wZVw/2tOjKQdw8Lc8Fd
 QPuKUIkBPlKS3WF8v22OvYnaU=
X-Received: by 2002:a17:90a:ac0e:b0:2c8:a8f:c97 with SMTP id
 98e67ed59e1d1-2ca35d3b18bmr5673317a91.37.1720669807760; 
 Wed, 10 Jul 2024 20:50:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeOX/SNQ3LLlF4fJ6nRynHJQFSeRhXSvo5HczYcKLAz2DQZ/pfYqAcHXScthPGGsj2JAV3d/m4WqS7HuLUGZY=
X-Received: by 2002:a17:90a:ac0e:b0:2c8:a8f:c97 with SMTP id
 98e67ed59e1d1-2ca35d3b18bmr5673311a91.37.1720669807357; Wed, 10 Jul 2024
 20:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
 <20240710-landlock-v2-8-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-8-ff79db017d57@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Jul 2024 11:49:55 +0800
Message-ID: <CAEemH2frcvzLUq7UmDFh_EA0cQLkAGOeWen6b3nrYSHF7XNXBg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 08/11] Add CAP_MKNOD fallback in
 lapi/capability.h
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

UmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKT24gVGh1LCBKdWwgMTEs
IDIwMjQgYXQgMjowNOKAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9A
c3VzZS5jb20+Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2Vy
dmVzYXRvQHN1c2UuY29tPgo+IC0tLQo+ICBpbmNsdWRlL2xhcGkvY2FwYWJpbGl0eS5oIHwgMTIg
KysrKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2NhcGFiaWxpdHkuaCBiL2luY2x1
ZGUvbGFwaS9jYXBhYmlsaXR5LmgKPiBpbmRleCAyYjU5Mzc5N2MuLjBmMzE3ZDZkNyAxMDA2NDQK
PiAtLS0gYS9pbmNsdWRlL2xhcGkvY2FwYWJpbGl0eS5oCj4gKysrIGIvaW5jbHVkZS9sYXBpL2Nh
cGFiaWxpdHkuaAo+IEBAIC00NCwxNCArNDQsMTggQEAKPiAgIyBkZWZpbmUgQ0FQX1NZU19USU1F
ICAgICAgICAgMjUKPiAgI2VuZGlmCj4KPiAtI2lmbmRlZiBDQVBfQVVESVRfUkVBRAo+IC0jIGRl
ZmluZSBDQVBfQVVESVRfUkVBRCAgICAgICAzNwo+IC0jZW5kaWYKPiAtCj4gICNpZm5kZWYgQ0FQ
X1NZU19SRVNPVVJDRQo+ICAjIGRlZmluZSBDQVBfU1lTX1JFU09VUkNFICAgICAyNAo+ICAjZW5k
aWYKPgo+ICsjaWZuZGVmIENBUF9NS05PRAo+ICsjIGRlZmluZSBDQVBfTUtOT0QgICAgICAgICAg
ICAyNwo+ICsjZW5kaWYKPiArCj4gKyNpZm5kZWYgQ0FQX0FVRElUX1JFQUQKPiArIyBkZWZpbmUg
Q0FQX0FVRElUX1JFQUQgICAgICAgMzcKPiArI2VuZGlmCj4gKwo+ICAjaWZuZGVmIENBUF9CUEYK
PiAgIyBkZWZpbmUgQ0FQX0JQRiAgICAgICAgICAgICAgMzkKPiAgI2VuZGlmCj4KPiAtLQo+IDIu
NDMuMAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
