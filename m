Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9CDEB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 09:16:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60893CC02D
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:16:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 278773C9978
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:15:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 61BFD10007F5
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 11:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688462149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5U7pdADQqk4YDs0fg36GIoVaf5PkL8h3Z+9GxZukm8=;
 b=O6a1ukACV4jtoH5Pu+1xAJo4ZyR2XmU+m4mP3yX1awnGmHU91yugZNTA4mpCgh7Jgj+Ta5
 o5YoBnQamsvfLeOWLHLIznSkLjU2G2UkdJN2bDeps/lS97dIpfj02SbtbK5X5bMIn/fSsh
 eytwg1jtFt9hTJFUdPXBRP+lQx9n1h0=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-BCnCL4EBNwGN5GUfYoCVlw-1; Tue, 04 Jul 2023 05:15:46 -0400
X-MC-Unique: BCnCL4EBNwGN5GUfYoCVlw-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-791b34626a3so683897241.0
 for <ltp@lists.linux.it>; Tue, 04 Jul 2023 02:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688462146; x=1691054146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/5U7pdADQqk4YDs0fg36GIoVaf5PkL8h3Z+9GxZukm8=;
 b=AeAIXqp6yU2jM/NaGD8V4xmYHMFEyxW0tPMHPDJtesNbPNMQd/MIYsSbRXn3TY3v3w
 crzHOhfpqemPemmxVXqVXzBkBP6PaBMJsdm4IoHcbs+Q2rIfkIu5olggz53Bp9mej0S0
 TGLGmhiabNZBjDYfhXk05dJWgZc8Y9WAx8AwD7BSFEl/C+2R+U3iDsLvRYlfHafMMA7a
 bnUpL17glEK7v0tbie202TpNkjSXZuBO/YLWHxPEih3q88gvCceUju1KrVh9juyTJFna
 8osBbIn+E9DwkWTkkUnx40onxUcso6eonPlFEhdLDmApSneQapmU87W4/vF4oMRlFOEg
 m5/g==
X-Gm-Message-State: ABy/qLYiYGKM5cuVDJ+y6G6oeHF1RESWFUTH0b7R/4Kvd+Oho0LBYlHo
 Jjj4bbx2e9DAzTyxo1oc+l5Q/+Rjg7iLBLg3LzKDUbrG2t/PXJ7tiGcu3tMz5PACY0wPbY83Wg1
 OGyM5NBx7OKOM9Wy1sl58iTIDXKU=
X-Received: by 2002:a67:de0c:0:b0:443:6457:112 with SMTP id
 q12-20020a67de0c000000b0044364570112mr5760712vsk.2.1688462146205; 
 Tue, 04 Jul 2023 02:15:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQsFYYwSSxe9fH/iTdNjT/wzxdkbqM31NrRlUb6iekpAJFCP4taTP8ozgZuau+iQNhzPLapi0gBX4raQ2xUVs=
X-Received: by 2002:a67:de0c:0:b0:443:6457:112 with SMTP id
 q12-20020a67de0c000000b0044364570112mr5760708vsk.2.1688462145990; Tue, 04 Jul
 2023 02:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230703194904.445661-1-pvorel@suse.cz>
 <20230703200735.GB446620@pevik>
In-Reply-To: <20230703200735.GB446620@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 4 Jul 2023 11:15:29 +0200
Message-ID: <CAASaF6ykX_2mbA961CCqzh-McXO+_aqvoAqTUOtiZiuo8o78aQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] mremap06: Add mremap() reproducer for
 7e7757876f25
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

T24gTW9uLCBKdWwgMywgMjAyMyBhdCAxMDowN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpLAo+Cj4gWyBkcm9wIGtlcm5lbCBkZXZlbG9wZXJzLCBhZGQgSmFu
LCBMaSBdCj4KPiA+IC0tLQo+ID4gQEN5cmlsOiBJIHBsYW4gdG8gYWRkIFNBRkVfRkFMTE9DQVRF
KCkgKDMgb3RoZXIgc291cmNlcyksCj4gPiBTQUZFX01QUk9URUNUKCkgKDcgb3RoZXIgc291cmNl
cykgYW5kIFNBRkVfTVJFTUFQKCkKPiA+ICgyIG90aGVyIHNvdXJjZXMpLCBidXQgYXMgYSBzZXBh
cmF0ZSBlZmZvcnQuCj4KPiBASmFuLCB5b3UgYWRkZWQgaW4gOTEyMGQ4YTIyICgic2FmZV9tYWNy
b3M6IHR1cm4gZnVuY3Rpb25zIHdpdGggb2ZmX3QgcGFyYW1ldGVyCj4gaW50byBzdGF0aWMgaW5s
aW5lIikgbm90ZSAiZm9sbG93aW5nIGZ1bmN0aW9ucyBhcmUgaW5saW5lIGJlY2F1c2UgdGhlIGJl
aGF2aW91cgo+IG1heSBkZXBlbmQgb24gLURfRklMRV9PRkZTRVRfQklUUz02NCAtRE9GRl9UPV9f
b2ZmNjRfdCBjb21waWxlIGZsYWdzIi4gSU1ITyB0aGUKPiBvbmx5IHNvdXJjZSB3aGljaCB1c2Vz
IFNBRkVfTU1BUCgpIGlzIHRlc3RjYXNlcy9rZXJuZWwvbWVtL21tYXBzdHJlc3MvbW1hcHN0cmVz
czAxLmMKCnNlbmRmaWxlMDQuYyBwb3RlbnRpYWxseSB0b28sIGl0J3MgYWxzbyBjb21waWxlZCB3
aXRoIDY0Yml0IG9mZnNldHMsCnRob3VnaCBvZmZzZXQgaXMgYWx3YXlzIDAKCj4gSSdtIGFza2lu
ZyBiZWNhdXNlIEkgd29uZGVyIGlmIFNBRkVfTVBST1RFQ1QoKSBhbmQgU0FGRV9NUkVNQVAoKSBz
aG91bGQgYmUgYWxzbwo+IHN0YXRpYyBpbmxpbmUsIElNSE8gaXQncyBub3QgbmVlZGVkLgoKRG9l
c24ndCBhcHBlYXIgdG8gYmUgbmVlZGVkIGhlcmUuCgo+Cj4gQGFsbDogU0FGRV9NUFJPVEVDVCgp
IHdvdWxkIGJlIG5lZWRlZCBhbHNvIG9uIHNvbWUgc3RpbGwgb2xkIEFQSSBzb3VyY2VzCj4gKHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lnbmFsL3NpZ25hbDA2LmMsCj4gdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tcHJvdGVjdC9tcHJvdGVjdDAyLmMsCj4gdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9tcHJvdGVjdC9tcHJvdGVjdDAzLmMpCj4gU2hvdWxkIEkgaWdub3JlIHRoYXQgYW5k
IGFkZCBpdCBqdXN0IHRvIG5ldyBBUEk/Cj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gPiBL
aW5kIHJlZ2FyZHMsCj4gPiBQZXRyCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
