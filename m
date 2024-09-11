Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F53FEE01F3
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 06:17:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD61E3C1C1E
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 08:17:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B6DF3C1BB0
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:17:13 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4FCCC1A04322
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 08:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726035430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Na1kTbG7CYjKXq9i//Zfx40yUWuj20FVbSS+FSTE0IA=;
 b=BKu3gKZUmACdLK0tKD7iLKsztz5d371JnzRgRYrYUCjMDeWpgxboTaNDAR6Lp2VF+FM9aj
 d0/tgoE76OoubzX1SDsLjGUhIltV5SvWZ0AjzjmMJZptzqySqUHK5dgnYHrUU0pHvOwl9D
 4JSb8ElBbvuR3wIOPPTgkgEUuH9BkYY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-R5lJWrytMn-HoWDT1Cyo_g-1; Wed, 11 Sep 2024 02:17:09 -0400
X-MC-Unique: R5lJWrytMn-HoWDT1Cyo_g-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-7d817394b39so3142772a12.1
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 23:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035427; x=1726640227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Na1kTbG7CYjKXq9i//Zfx40yUWuj20FVbSS+FSTE0IA=;
 b=PmN6zBK4urHH3svclXstUgfn2neEq3IPyVlsS9JHklz219AiO+9D/mTI0ZSxMlC0Ji
 T3k3HNvxj+/uiN/cjSP7r6Fkd8d66w7OUWDHJW3okdqTI1M9v0dQcuRfa6oDZAHj7Vo1
 Wx2TcrcnIOXeUo4APj6cFLs6PzBIF7Ht2GbLmeqq5nVfcPVVu7eYgsetvNadqd6TMc8B
 NkXFPZtxE7OjW0bTp2E+Ut1CrfiYNYoNO9fq4Gav7WRPNkksJOcKGiRGxCryscXkaNpz
 gimc/EvGI2cq6YErTGJ+QrjgamOXF1CtLSMoohI7U70eAgNKLsBkeepWtLX47k43CegI
 yABQ==
X-Gm-Message-State: AOJu0YzGnRnU7imwR7WNMRViTAf7vem3otJZc5tIYlSF9iL/aTJkBgRP
 y7QTcvAgGvoFfCCPg3fFDQMz1Vp1Vils0qbPseW//9xwq63Y+JUfdc+YOKz8iFcMGFim+kwLOlb
 vg/h/Ouhj8Kmqj56tZ0PR1qaOYOxWIyCXdjuM3/SsXrcYKOgKtHnDt/SEU69cSytshTmTjipJYT
 +UlFzD5NvNUkdjytD73K2xVZybviIoqrVLYrAo
X-Received: by 2002:a05:6a20:d528:b0:1cf:2ef7:b396 with SMTP id
 adf61e73a8af0-1cf5e0320eemr4701216637.6.1726035427372; 
 Tue, 10 Sep 2024 23:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUyruQAyCX/ShHbNyQtiKrcIoMDiscXV5D5jAg7T9a7csGv+ABAJ5MyeL+OIvIZCNiIz61AoU6AZ4MhJK1Ah8=
X-Received: by 2002:a05:6a20:d528:b0:1cf:2ef7:b396 with SMTP id
 adf61e73a8af0-1cf5e0320eemr4701195637.6.1726035426916; Tue, 10 Sep 2024
 23:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240909-landlock_whitelist-v1-1-60c54aa9526d@suse.com>
In-Reply-To: <20240909-landlock_whitelist-v1-1-60c54aa9526d@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Sep 2024 14:16:55 +0800
Message-ID: <CAEemH2fLVESjVK2VzE_hpYKtrAiLbEDykfDa0gyomrRzCyVDkw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Add landlock syscalls to whitelist in statistics
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

T24gVHVlLCBTZXAgMTAsIDIwMjQgYXQgMTozNeKAr0FNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBMYW5kbG9jayBzeXNjYWxscyBhcmUgY3VycmVu
dGx5IHRlc3RlZCBpbiB0aGUgbGFuZGxvY2sgdGVzdGluZyBzdWl0ZSBhbmQKPiB0aGVyZSdzIG5v
IHJlYXNvbiB0byBjb25zaWRlciB0aGVtIHVudGVzdGVkLCBzbyB0aGV5IGNhbiBiZSBhZGRlZCB0
byB0aGUKPiBzdGF0aXN0aWNzIHdoaXRlbGlzdC4KPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBD
ZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KClJldmlld2VkLWJ5OiBMaSBX
YW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tLQo+ICBkb2MvY29uZi5weSB8IDMgKysrCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kb2MvY29uZi5w
eSBiL2RvYy9jb25mLnB5Cj4gaW5kZXggYzAzNDYzODhlLi43YTNlOWVjOWYgMTAwNjQ0Cj4gLS0t
IGEvZG9jL2NvbmYucHkKPiArKysgYi9kb2MvY29uZi5weQo+IEBAIC05MCw2ICs5MCw5IEBAIGRl
ZiBnZW5lcmF0ZV9zeXNjYWxsc19zdGF0cyhfKToKPiAgICAgICAgICAnc2VjY29tcCcsCj4gICAg
ICAgICAgJ3NlbXRpbWVkb3AnLAo+ICAgICAgICAgICdzZXRob3N0bmFtZScsCj4gKyAgICAgICAg
J2xhbmRsb2NrX2NyZWF0ZV9ydWxlc2V0JywKPiArICAgICAgICAnbGFuZGxvY2tfYWRkX3J1bGUn
LAo+ICsgICAgICAgICdsYW5kbG9ja19yZXN0cmljdF9zZWxmJywKPiAgICAgIF0KPgo+ICAgICAg
IyBwb3B1bGF0ZSB3aXRoIG5vdCBpbXBsZW1lbnRlZCwgcmVzZXJ2ZWQsIHVubWFpbnRhaW5lZCBz
eXNjYWxscwo+IGRlZmluZWQKPgo+IC0tLQo+IGJhc2UtY29tbWl0OiBkNjBiZGNjN2M3YWM0YmU2
NjI0MzAyYjkwOWU0ZDM4MzY3NjUyZGRhCj4gY2hhbmdlLWlkOiAyMDI0MDkwOS1sYW5kbG9ja193
aGl0ZWxpc3QtMWY5Yzk5NWExZWQ0Cj4KPiBCZXN0IHJlZ2FyZHMsCj4gLS0KPiBBbmRyZWEgQ2Vy
dmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Cj4KPiAtLQo+IE1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
