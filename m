Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE815C87FCF
	for <ltp@archiver.kernel.org>; Sun, 10 Aug 2025 03:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754797637; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7qPqvFobupiHLEICRXsn3JvNDl32HNP6n7B2av4rlR4=;
 b=ESt1KIP+HqqKlyk0wq6OcFob4MrAR+mOeLCPY+zPTuC+kJu30m0UFAW2K3TDWZdDj64bi
 9egCGZ9dLAH6lfVoGfoooETyWP7ptu9fUq7kfI6q6jVHcC6Q1B+QnSxyR7j38pE07Er6C0k
 sOXQfeI6odUpj5YrHAWyP/8ZhrV9hDQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6B143CA192
	for <ltp@archiver.kernel.org>; Sun, 10 Aug 2025 05:47:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 045B83C2CBD
 for <ltp@lists.linux.it>; Sun, 10 Aug 2025 05:46:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 013C11A0021A
 for <ltp@lists.linux.it>; Sun, 10 Aug 2025 05:46:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754797613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jcPnJ1dkGtca6TK2Eqi4HGFFwrfnXjLe7ocTPxA9D3s=;
 b=bXOQbWXWC+zQPtBro4FeAV70yTMYtXo4lo10W0YuQoGg3rmgJQ2qcZObECqiEmMHl/74za
 BaTUBvN9WtEGRgiZfyYeFZ8fS6D2ijYg3Xe6vseoguk7T5vNbZI+Sj2eT99ZiOyEJ8kB5o
 hh9opsd2pHJ7TZ/3QNIzV6YuVI0YX+U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-lNl7lSKEO_KDma6lifNSXQ-1; Sat, 09 Aug 2025 23:46:46 -0400
X-MC-Unique: lNl7lSKEO_KDma6lifNSXQ-1
X-Mimecast-MFC-AGG-ID: lNl7lSKEO_KDma6lifNSXQ_1754797606
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2407248a180so28978845ad.3
 for <ltp@lists.linux.it>; Sat, 09 Aug 2025 20:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754797605; x=1755402405;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jcPnJ1dkGtca6TK2Eqi4HGFFwrfnXjLe7ocTPxA9D3s=;
 b=fxsXOLq8hlAgi5lgaV020KzpeN8LlUKQBZQCXMiVRQrvRmcZBXJbBeVl/raGVioGoD
 Nf33Px76twKpu5dPxP1HsrX0aeajwKPuL6RijofhRU3J8LCGqnb9AOHFsHjxFgEWN937
 DsK8kf8mJRq7QwhvYtU6XJkmpvWwaHg2t/ox3D2R2DnlZLki54Vd9Ac8iAwWLcAavGac
 WvnTgQj8QGdP9pI5NioR4aRngR0bViE0rIzmXt3H3EQpi7N5Fk0WSFYtlDwZcYEPUqjw
 ttKkdZnolU1iM++RHiqbNkCV/923XikxSWUFUQNuduV8dH9KPQ2mUex8C8JeX8hcnkkL
 8INQ==
X-Gm-Message-State: AOJu0Yx3s6e6lm1HstZn8qBdABeFN2/2Gd4a6Pd9EcDaQOEBQeDVPoIS
 G5MACuZuN3+FE755qdGVTnwQu1PUVRBHPf3D2II5AaoVOkKqFKmkeTde8sAMvAYOeLqX7opwgFR
 z1zKGMitRY05OIp/HYzdJUqHBeB9DdY3KglMNjATltgaONew2yjI9cAXUyrk56ebRWp4URechEZ
 kazZ/4/ANbej+KDkZYVu/u68U7VQs=
X-Gm-Gg: ASbGncvBhRBC0ZcbqscDxTbVcNjH0SulL7JYtzZlsJQN7GWnjHk4k+neUBqi6KP6HZe
 IKdVY4HE6MmuUA6a/1qoKJU/YNI5liPnkHyz4hWrf4sJBTlUF2lWADtE9jyYqeQ5/x+1XLUBquJ
 yp5AfN0+szmtD2Ncr7YcHAuQ==
X-Received: by 2002:a17:902:ce91:b0:23f:f96d:7579 with SMTP id
 d9443c01a7336-242c2206d64mr116589065ad.37.1754797604772; 
 Sat, 09 Aug 2025 20:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd1p4OXN6Wo/8RvtGPN/pGVcaoz5J89127Dt1mV1JKv2ZWPllMVHI60X4pOmELsxuchwDKO8nsSxis4ZCY9Ek=
X-Received: by 2002:a17:902:ce91:b0:23f:f96d:7579 with SMTP id
 d9443c01a7336-242c2206d64mr116588835ad.37.1754797604426; Sat, 09 Aug 2025
 20:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <aJYBSmcQpbHUvOqW@stanley.mountain>
In-Reply-To: <aJYBSmcQpbHUvOqW@stanley.mountain>
Date: Sun, 10 Aug 2025 11:46:32 +0800
X-Gm-Features: Ac12FXy-wYhrOB7X9IJfVh1xzdIrYlF3yyFCx8YnFd1U2oN6hOMMLMXmTS4dKko
Message-ID: <CAEemH2cBH+usbwMsHnDW=QM-qDKOCg2wp063O=1gtrRdqNFpug@mail.gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IU8tljlAXIU3WOxVnMItIdKAqQAfPdmEU6sC6Z5XuBE_1754797606
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] shmctl03.c is broken for 32bit compat mode
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
Cc: Theodore Grey <theodore.grey@linaro.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgRGFuLAoKT24gRnJpLCBBdWcgOCwgMjAyNSBhdCA5OjUz4oCvUE0gRGFuIENhcnBlbnRlciA8
ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPgp3cm90ZToKCj4gSW4gMzJiaXQgY29tcGF0IG1vZGUg
dGhlIHNobWN0bDAzLmMgdGVzdCB3aWxsIGFsd2F5cyBmYWlsOgo+Cj4gc2htY3RsMDMuYzozMzog
VEZBSUw6IC9wcm9jL3N5cy9rZXJuZWwvc2htbWF4ICE9IDIxNDc0ODM2NDcgZ290IDQyOTQ5Njcy
OTUKPiBzaG1jdGwwMy5jOjM0OiBUUEFTUzogL3Byb2Mvc3lzL2tlcm5lbC9zaG1tbmkgPSA0MDk2
Cj4gc2htY3RsMDMuYzozNTogVEZBSUw6IC9wcm9jL3N5cy9rZXJuZWwvc2htYWxsICE9IDQyNzgx
OTAwNzkgZ290IDQyOTQ5NjcyOTUKPgo+IFRoZSB0ZXN0IGJhc2ljYWxseSBkb2VzIHRoaXM6Cj4g
Ly8gPT09ID09PSA9PT0KPiAjZGVmaW5lIF9HTlVfU09VUkNFCj4gI2luY2x1ZGUgPHN5cy9zaG0u
aD4KPiAjaW5jbHVkZSA8c3RkaW8uaD4KPgo+IGludCBtYWluKHZvaWQpCj4gewo+ICAgICAgICAg
c3RydWN0IHNobWluZm8gaW5mbzsKPgo+ICAgICAgICAgc2htY3RsKDAsIElQQ19JTkZPLCAoc3Ry
dWN0IHNobWlkX2RzICopJmluZm8pOwo+Cj4gICAgICAgICBwcmludGYoInNobW1heCA9ICVsdVxu
IiwgaW5mby5zaG1tYXgpOwo+ICAgICAgICAgcHJpbnRmKCJzaG1tbmkgPSAlbHVcbiIsIGluZm8u
c2htbW5pKTsKPiAgICAgICAgIHByaW50Zigic2htYWxsID0gJWx1XG4iLCBpbmZvLnNobWFsbCk7
Cj4KPiAgICAgICAgIHJldHVybiAwOwo+IH0KPiAvLyA9PT0gPT09ID09PQo+Cj4gSXQgY29tcGFy
ZXMgdGhhdCBvdXRwdXQgd2l0aCB3aGF0IHdlIHJlYWQgZnJvbSB0aGUgZmlsZS4gIFlvdSBjYW4g
cnVuCj4gImdjYyAtbTMyIHRlc3QuYyAmJiAuL2Eub3V0IiB0byBzZWUgdGhlIGlzc3VlLgo+Cj4g
SW4gdGhlIGZpcnN0IGxpbmUgc2htbWF4IGlzIG5vdCB0aGUgdmFsdWUgdGhhdCB3ZSByZWFkIGZy
b20gdGhlIGZpbGUKPiBiZWNhdXNlIGl0IHdhcyBjYXBwZWQgYXQgSU5UX01BWCBieSB0aGUga2Vy
bmVsIGluIGNvbW1pdCBhZjdjNjkzZjE0NjAKPiAoIkNhcCBzaG1tYXggYXQgSU5UX01BWCBpbiBj
b21wYXQgc2htaW5mbyIpLgo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE2
L3NvdXJjZS9pcGMvc2htLmMjTDEzNDcKPgo+IFdpdGggdGhlIGxhc3QgbGluZSB3ZSdyZSB0cnlp
bmcgdG8gc3RvcmUgYSB1NjQgdmFsdWUgaW50byBhIHUzMi4gIFdlJ3JlCj4gZ29pbmcgdG8gbG9z
ZSBzb21ldGhpbmcgc28gaXQncyBub3QgZ29pbmcgdG8gYmUgYWNjdXJhdGUuICBUaGUgZGlmZmVy
ZW5jZQo+IGlzIGhvdyBzY2FuZigpIHRydW5jYXRlcyBpdC4gIElmIHlvdSBoYXZlIDMyYml0IGxv
bmdzIHRoZW4gaXQgd2lsbCBnaXZlCj4geW91IHRoZSBmaXJzdCB1MzIgYnV0IGlmIHlvdSBhc3Np
Z24gYSB1NjQgdG8gYSB1MzIgbGlrZSB0aGUgcmVzdCBvZiB0aGUKPiBjb2RlIGRvZXMgdGhlbiB5
b3UnbGwgZ2V0IHRoZSBsYXN0IDMyIGJpdHMuCj4KPiBXaGF0J3MgdGhlIHJpZ2h0IHdheSB0byBn
byBhYm91dCBmaXhpbmcgdGhpcz8KPgoKTWF5YmUgd2UgY2FuIHNpbXBseSBzcGxpdCB0aGUgY29t
cGFyaXNvbiBwYXJ0IGludG8gdHdvOgoKICAjaWZkZWYgVFNUX0FCSTY0OiBnbyB3aXRoIHRoZSBv
cmlnaW5hbCB3YXkuCgogICNpZmRlZiBUU1RfQUJJMzI6CiAgICAgICdzaG1tYXgnIGV4cGVjdHMg
SU5UX01BWCBmcm9tIHNobWN0bCgwLCBJUENfSU5GTywgLi4uKSwgZXZlbiBpZiAnCi9wcm9jL3N5
cy9rZXJuZWwvc2htbWF4JyBpcyBoaWdoZXIuCiAgICAgICdzaG1hbGwnIGNvbXBhcmVzIHRoZSBs
b3dlciAzMiBiaXRzIG9mIHRoZSB2YWx1ZSAoZXhwZWN0X3NobWFsbCA9CnNobWFsbCAmIDB4RkZG
RkZGRkY7KQoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
