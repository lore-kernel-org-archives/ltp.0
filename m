Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E961CA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 03:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755834507; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7hL5DNztuNzHnBNGyTiASs8PCfKUqEXWSY+W7CkErXY=;
 b=kvMGnB0k7e2mx+mQMd7XrFGyFNHVLQUg+TdHffTEiVmBQj8PMRr+rDu1hiyHeHYJzAFaS
 rJfJNNVWMd8DaGEuQPgI4ScHdbkAi2i+5MEZMWpme2QnFmSUhB86b5uormRn+DJh0I2+ZUv
 k924zrV7xp4RCG8/n1ndR+yJPkBJ0X0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F303CCC4F
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 05:48:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 973553C2E97
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:48:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 725716002EC
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:48:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755834479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXCt71hON9Axf0jwB8Ch28E1UaGtCJ0kJ9d+tmDMpsY=;
 b=eUTz5gvRhCWuVf9bb6FYjVWJALqlkkuKd2kzRI7JvA3Cr789cgnpFY24l4UZmcNosh9fDJ
 15a3CnS3X4Td5OSZtoPL92btLAjYLaBWiKUXJ6ozk/d1QgcnqnOeW7G3mz674Rz3hHK7Oj
 wQ7q4Nbnsx5CtBZHkK96GDSNg0eHRbI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-mszKhzTHNnyiJ44AuYmFtQ-1; Thu, 21 Aug 2025 23:47:57 -0400
X-MC-Unique: mszKhzTHNnyiJ44AuYmFtQ-1
X-Mimecast-MFC-AGG-ID: mszKhzTHNnyiJ44AuYmFtQ_1755834476
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24640dae139so2256665ad.1
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 20:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755834475; x=1756439275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXCt71hON9Axf0jwB8Ch28E1UaGtCJ0kJ9d+tmDMpsY=;
 b=K3pOw2d3eoDecvDO0EnC0b2hJ0UH1OE56fMoWwXvx5fStatA6ttzF4MJFAZ+TsIU2C
 5eg1KLLrXUCB9WtfFBDkfMgS6AUw1pgnO6wqSVgn2qI7SyMo0AQ7gvvOUuCynHp3DI1G
 XbomhCOmGa+Tw4BOPOfmrHlLTjfx5lXT/MS/Mtx/mFmjduYc0gHfoMRhHrZ8fzly4jYv
 aVP2VnVF4qUGp3y/blTTEe22pgyxk3sgzVw3jr7ynWXBLzWJmNYvQ5LapxV8I8JVc1T4
 rYSSsQOCGzO9qP/ts4hG8w6TV2rykKoUXgqYIG7KQoOEkJo+X8G0JtFJjrvOateiJ3AU
 iUSQ==
X-Gm-Message-State: AOJu0YymJqI6/vf3rk8vcb292PxunjYT6TKwTA19X+E8iKZcEWnqD19/
 g/jm78zFJbXs2cLi+malnzQlCqnrqCnz7Sp/olkP6dvW/AXqz8VmSCQ6AZmZ7ImkO/ootQFB9sG
 paS70O9SceEY1eSjYjPE7e4eYhyQ/H5+AhBPZNacWj0BgwND7aG1N58eToFufquA3Q/M29WoA3a
 aBq0Bjk3chi5mfITOghpY8+atOIcBCeymVQz7Fh31a
X-Gm-Gg: ASbGnctpZjQt7Knyz+mRii2dgUGxcP5X/hrm/CjwzcHkWXwD03HKpr7Pjb44VYu4QaY
 KDoj9rpZ7qURsxWvLv/eF8Qa6V4WBEkmu3yXHGfnW0E3HrGaIw3Ki8Iy2ZA+9SUxpAb/ilgZZsQ
 x0GZIzwwhs9D/gqGshC61Yxw==
X-Received: by 2002:a17:903:2ac8:b0:234:986c:66bf with SMTP id
 d9443c01a7336-2462edd7d39mr16751485ad.11.1755834475271; 
 Thu, 21 Aug 2025 20:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgGh51A3zHqBuxk3+AEbq30kSQ0UWqoNO7TN/245Fe9Kcj76Dn+Bud+PUDYfrlaxFMexunqMYvV3Ek79IqZyc=
X-Received: by 2002:a17:903:2ac8:b0:234:986c:66bf with SMTP id
 d9443c01a7336-2462edd7d39mr16751365ad.11.1755834474884; Thu, 21 Aug 2025
 20:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250820002556.26865-1-wegao@suse.com>
 <20250822034215.28533-1-wegao@suse.com>
 <20250822034215.28533-3-wegao@suse.com>
In-Reply-To: <20250822034215.28533-3-wegao@suse.com>
Date: Fri, 22 Aug 2025 11:47:42 +0800
X-Gm-Features: Ac12FXyjDN862KeC7-TZNwaj9wRxlxA7qoHpD_a2A9zUY_bJOjCoF6JArYffnX4
Message-ID: <CAEemH2cZWrcOXfcbFJbjamJM1JAFShD+6=JkXCvsAgCUJZwVWg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rZ29ftnezhhvkbmQFWIB3g7aSJID-O-6DP2fC423Rtg_1755834476
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] fspick01.c: Check mount point was really
 remounted read only
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgMTE6NDLigK9BTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNv
bT4gd3JvdGU6Cgo+IEZpeGVzOiAjMTE3MQo+IFRoZSBmc3BpY2swMSB0ZXN0IGRvZXMgbm90IHRl
c3QgaWYgRlNDT05GSUdfQ01EX1JFQ09ORklHVVJFIHJlYWxseQo+IHJlY29uZmlndXJlcyB0aGUg
bW91bnQgcG9pbnQsIGUuZy4gaWYgdGhlIG1vdW50IHBvaW50IHdhcyByZWFsbHkKPiByZW1vdW50
ZWQgcmVhZCBvbmx5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNwaWNrL2ZzcGljazAxLmMgfCAg
MjMgKystCj4gIHZlcl9saW51eCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAx
OTEgLS0tLS0tLS0tLS0tLS0tLS0tLS0KPgoKSSBndWVzcyB0aGUgZGVsZXRpb24gb2YgdmVyX2xp
bnV4IHdhcyBhIGNhcmVsZXNzIG1pc3Rha2U/CgpPdGhlcndpc2UgbG9va3MgZ29vZC4KCgotLSAK
UmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
