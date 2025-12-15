Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976DDD59D99
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765781888; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EN2VWsiGfUXdtH07eLrJ8h+5uGfR7vfzVU60bKUktq8=;
 b=alf13an6B3myKjFVTH5g1FAj8kWqXoctmrOEflycykrZJvyaNcrq6fST44cofxhuhB0jG
 6iYI0JS03JtuXqwWf6zB4OhaqUOfKTrv/P34onqM/O7qsxYQeyRmKcKlhpCa6SLUe1d6TDP
 ZCFFzPwYqz1EhRyK48eMc38Yk5wVy/U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFC553C0322
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 07:58:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96BA43CA1BC
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 07:57:44 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E6D861A00268
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 07:57:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765781861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NKQmuAYM0VmYs8GRiBr6CL6RqnM8FUoVv4nRQaxGdLk=;
 b=BB0OSzI5g18C0gctMtYuoCM6YxaAQxselUSrm8HUg36YZzwJ2FkDeJWlUVu2nHsaNsnzPQ
 mEbQztoufogWDoUaRInJaiF3z2LXPeihHhI7DvZ68GPcU16Y2ootcUdqT9+YPFpBgpOGEK
 zmQDNVKKffFjeI12nm+RKZ7p0LWP/y4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-xrQ7vf2CMcC-JAPu_2bl5Q-1; Mon, 15 Dec 2025 01:57:39 -0500
X-MC-Unique: xrQ7vf2CMcC-JAPu_2bl5Q-1
X-Mimecast-MFC-AGG-ID: xrQ7vf2CMcC-JAPu_2bl5Q_1765781858
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-bddf9ce4931so5544722a12.0
 for <ltp@lists.linux.it>; Sun, 14 Dec 2025 22:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765781858; x=1766386658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKQmuAYM0VmYs8GRiBr6CL6RqnM8FUoVv4nRQaxGdLk=;
 b=W9Nh9/pqvIqN4wQCuVAznKTJqjFBZ4k5e2+qFUc0lluAhXpwg2LmQS8i8IRtnfxytW
 GHqpUjM5124S7ZCfglI0vEnvMhq4a5gD89VXzvJUxmjdgXcfvsRsqusp+c2tg1g5SYa3
 VY61rr+H1GeyyrKBtPBABXUIigImvWR25rE+L75fQnmy4qwsfDMTZ3bcpPo/RTf+V9sD
 Fk6UpwQOdzeSSY3wyDitXsBxHJDa6qNTxp9FOiHNmc1aUP2VGd+ZV6X0Saqn3qvMILcm
 ILmbA95owUvZlPeSRrEmgOfeOzVvrv3aEUA1Z03OHr7V0fIWyGEDg+Bv9hylsMknqahh
 HVzA==
X-Gm-Message-State: AOJu0YxJdNnbEbcXhWI2ShPzH/OOcc7xYekLkAIFVP6SPziCYzQKrTxm
 NcBVvqUb6P+oFJAfCSiJCjk551iZU0LYOHLgVSzC35ONzkovpehYrNVZ4kmC09pA8mHLhcSQwAT
 vZsp8pEDShsbpblJfO4fMpuOeEA42JNzqfLhOUqmyo33fE6Bsy+oMV4dNClxaF7TkdyoikKenCd
 yTmOadC8HN0Q7iZHHjvFmh7pOoK7w=
X-Gm-Gg: AY/fxX7k3isrUrTTeyvoZ4OUuh4fb3cTKplAQiBNqIGuTUimQw3W6xJGURTByH272aA
 SAvQu3GEAcQgRh9TNATNHHtBvx4plydnOnyPrLIoaq0/oxcnl11IfJZyPT5DyouLoK3M2IAjNWv
 AMyoQD2saNjj54ffnYzP8kjI6UHkZws6HuNAvPM4+5WYZ73GyvxO8qbBcx/bGbJCWhhiI=
X-Received: by 2002:a05:7300:828d:b0:2ac:2c19:2a59 with SMTP id
 5a478bee46e88-2ac3012d690mr4894519eec.33.1765781857987; 
 Sun, 14 Dec 2025 22:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX2cUFEcXJXY1+DLaxPSLZOA/r17XkfBPmPO+D6vKZl1vefnuo/JEeyGl9Rhoozt4O7QvG6dZeGgW6l+Xp/vU=
X-Received: by 2002:a05:7300:828d:b0:2ac:2c19:2a59 with SMTP id
 5a478bee46e88-2ac3012d690mr4894514eec.33.1765781857533; Sun, 14 Dec 2025
 22:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20251209185557.20598-1-pvorel@suse.cz>
 <20251209185557.20598-2-pvorel@suse.cz>
In-Reply-To: <20251209185557.20598-2-pvorel@suse.cz>
Date: Mon, 15 Dec 2025 14:57:25 +0800
X-Gm-Features: AQt7F2pMXn2t2ejAftWAaM_ztd4Xa8AhnQ6et_bqJbaCD0ULw2kHhLWBykrjG10
Message-ID: <CAEemH2ej8-e_S4LgcKKkt08dUhyF0TreWp-QvXzQ1QGQYbywJg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V4SIwP-WYSTshqvujf72Afb-Gd_u5XLL-a1LO1fm_-o_1765781858
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/4] shell: Add tst_runas.c helper
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCgo+ICsrKyBiL3Rl
c3RjYXNlcy9saWIvdHN0X3J1bmFzLmMKPiBAQCAtMCwwICsxLDUwIEBACj4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4gKy8qCj4gKyAqIENvcHlyaWdodCAo
YykgMjAyNSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiArICovCj4gKwo+ICsjZGVmaW5l
IExUUF9VU1JfVUlEIDY1NTM0Cj4gKyNkZWZpbmUgTFRQX1VTUl9HSUQgNjU1MzQKPiArCj4gKyNk
ZWZpbmUgVFNUX05PX0RFRkFVTFRfTUFJTgo+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiArCj4g
K3N0YXRpYyB2b2lkIHByaW50X2hlbHAodm9pZCkKPiArewo+ICsgICAgICAgZnByaW50ZihzdGRl
cnIsICJVc2FnZTogJXMgY21kIFthcmdzXSAuLi5cbiIsIF9fRklMRV9fKTsKPiArICAgICAgIGZw
cmludGYoc3RkZXJyLCAiVXNhZ2U6ICVzIGNtZCBbLWhdIHByaW50IGhlbHBcblxuIiwgX19GSUxF
X18pOwo+ICsKPiArICAgICAgIGZwcmludGYoc3RkZXJyLCAiRW52aXJvbm1lbnQgVmFyaWFibGVz
XG4iKTsKPiArICAgICAgIGZwcmludGYoc3RkZXJyLCAiTFRQX1VTUl9VSUQ6IFVJRCBvZiAnbm9i
b2R5JyB1c2VyLCBkZWZhdWx0cyAlZFxuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBMVFBf
VVNSX1VJRCk7Cj4gKyAgICAgICBmcHJpbnRmKHN0ZGVyciwgIkxUUF9VU1JfR0lEOiBHSUQgb2Yg
J25vYm9keScgdXNlciwgZGVmYXVsdHMgJWRcbiIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
TFRQX1VTUl9HSUQpOwo+ICt9Cj4gKwo+ICtpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltd
KQo+ICt7Cj4gKyAgICAgICBpZiAoYXJnYyA8IDIgfHwgIXN0cmNtcChhcmd2WzFdLCAiLWgiKSkg
ewo+ICsgICAgICAgICAgICAgICBwcmludF9oZWxwKCk7Cj4gKyAgICAgICAgICAgICAgIHJldHVy
biAxOwo+ICsgICAgICAgfQo+ICsKPiArICAgICAgIHVuc2lnbmVkIHVpZCA9IExUUF9VU1JfVUlE
LCBnaWQgPSBMVFBfVVNSX0dJRDsKPiArCj4KCgoKPiArICAgICAgIGNoYXIgKnVpZF9lbnYgPSBn
ZXRlbnYoVFNUX1RPX1NUUl8oTFRQX1VTUl9VSUQpKTsKPiArICAgICAgIGNoYXIgKmdpZF9lbnYg
PSBnZXRlbnYoVFNUX1RPX1NUUl8oTFRQX1VTUl9HSUQpKTsKPgoKClNvIGZhciB0aGlzIGZvcm1h
dCBpcyBjb3JyZWN0LgoKQnV0IGFzIEkgcG9pbnRlZCBpbiB0aGUgbGFzdCB0aHJlYWQsIGhlcmUg
dXNpbmcgVFNUX1RPX1NUUl8gbWlnaHQgYmUgYQpwb3RlbnRpYWwKaXNzdWUgaWYgc29tZWRheSB3
ZSBtYWtlIGNoYW5nZXMgb24gdGhhdCB0byBiZWNvbWUgdHdvLWxldmVsIG1hY3JvLgpJdCBsaWtl
bHkgdG8gaW50ZXJwcmV0ZWQgYXMgIGdldGVudigiNjU1MzQiKTsKClNvIG9uIHRoZSBzYWZlIHNp
ZGUsIEnigJlkIHN0aWxsIHJlY29tbWVuZCB3cml0aW5nIGl0IGV4cGxpY2l0bHk6CgogICAgY2hh
ciAqdWlkX2VudiA9IGdldGVudigiTFRQX1VTUl9VSUQiKTsKICAgIGNoYXIgKmdpZF9lbnYgPSBn
ZXRlbnYoIkxUUF9VU1JfR0lEIik7CgoKVGhlIHJlc3Qgd2hvbGUgcGF0Y2ggc2V0IGxvb2tzIGdv
b2Q6CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
