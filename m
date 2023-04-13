Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31F3C77B61
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 08:52:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B04F3CC4DC
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 10:52:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 483A03C6C4B
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 10:52:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 50FC660043A
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 10:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681375934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O9JZl17lXPwvTD76sknZtyNUWTiea94/g6kq7esRKqk=;
 b=FNkd3ylkAPgG4rln6HIMRHnYCfnBT8KSbTnfSfid5d1oWwcDmfRIB0V8ndUx4498WSRJoW
 0Vur54rzUF3fBfgUyeKsMEqP/62PLqR/Ude2KG08q+apwt12g/JORymnyosyo2RTkoaeJF
 l+4/cKFtX+emj1Xnv52rcsnipB/Jo5w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-tD-ZyyvPOIOHrvnAcJx1xw-1; Thu, 13 Apr 2023 04:52:13 -0400
X-MC-Unique: tD-ZyyvPOIOHrvnAcJx1xw-1
Received: by mail-wr1-f72.google.com with SMTP id
 r2-20020adfb1c2000000b002d92bb99383so2393964wra.23
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 01:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681375931; x=1683967931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O9JZl17lXPwvTD76sknZtyNUWTiea94/g6kq7esRKqk=;
 b=fGZqx+K/JJ/JxVuW97ufZez2268REDJFlloFGuGae4VTU5ri6mQ+dIGlXtFyw2p/wW
 2eW3w0ATTMI4iW61b0BFC35gO9q7tUw9gCu5dN0qW1zlTQfvCOK20tlUpWn76RT0VLAM
 OliMK8h64SR/8CisvYQN8fkKs/gLUYoJXjP4a/15aJ+tZxhKbDbRp4cBi9m50Z+NB6Nc
 XBDw2LYFi1L7YhwmtNQynGI9QzX0FlDqkvEKs1GhVrVbpdHkUKEgVIvKdf5/0EUlTvvD
 HQX8T8EbC1VtDUZmRECOLmW2ifnfnusMH3m64+YSRNsFGMGrr3IcegeT97aOxfu+LbHZ
 2Lew==
X-Gm-Message-State: AAQBX9e1VcK35T9M5t2uqDNYIND7kvjnD8HVD87k/+6svVz0MhvYvots
 Ch2P8mmNpUsjDwLgfuXqj+ovq/90kmbwZcDTgnkp6xlR/69fyAVNcLAgz+Y1YUVex1/t79+PWC7
 V91tFdsSpLjn5VZLEQRp5OBEMUvxvy1+tBjkITeaA
X-Received: by 2002:a5d:5405:0:b0:2f5:6430:356 with SMTP id
 g5-20020a5d5405000000b002f564300356mr236580wrv.7.1681375931588; 
 Thu, 13 Apr 2023 01:52:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350bziwM9HahxeOK6e2D9/082LetyWOdpJXF1Ms26y0uLyrZyD0Kuumf6ahJFiP+toVpYFGJUIe8W4/zXOOpiwIw=
X-Received: by 2002:a5d:5405:0:b0:2f5:6430:356 with SMTP id
 g5-20020a5d5405000000b002f564300356mr236576wrv.7.1681375931297; Thu, 13 Apr
 2023 01:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230403155258.309714-1-teo.coupriediaz@arm.com>
In-Reply-To: <20230403155258.309714-1-teo.coupriediaz@arm.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Apr 2023 16:52:00 +0800
Message-ID: <CAEemH2ejRNF2YQUCc1x2-csBU=+-vFRj73xPpWFfBgoziSPfrg@mail.gmail.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] ipc/msgstress03: Assume all forks will run
 concurently
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

T24gTW9uLCBBcHIgMywgMjAyMyBhdCAxMTo1M+KAr1BNIFRlbyBDb3VwcmllIERpYXogPHRlby5j
b3VwcmllZGlhekBhcm0uY29tPgp3cm90ZToKCj4gSXQgYXBwZWFycyB0aGF0IG1zZ3N0cmVzczAz
IGRvZXNuJ3QgYWNjb3VudCBmb3IgYWxsIFBJRHMgdGhhdCBpdHMgY2hpbGRyZW4KPiBjYW4gdXNl
LCBhcyBpdCBleHBlY3RzIHRoZSB0YXNrcyB3aWxsIHRlcm1pbmF0ZSBxdWlja2x5IGFuZCBub3Qg
cmVhY2gKPiB0aGUgUElEIGxpbWl0Lgo+IE9uIHNvbWUgc3lzdGVtcywgdGhpcyBhc3N1bXB0aW9u
IGNhbiBiZSBpbnZhbGlkIGFuZCB0aGUgUElEIGxpbWl0Cj4gd2lsbCBiZSBoaXQuCj4gQ2hhbmdl
IHRoZSBsaW1pdCB0byBhY2NvdW50IGZvciBhbGwgcG9zc2libGUgY2hpbGRyZW4gYXQgb25jZSwg
a25vd25pbmcKPiB0aGF0IGVhY2ggY2hpbGQgd2lsbCBmb3JrIGFzIHdlbGwuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBUZW8gQ291cHJpZSBEaWF6IDx0ZW8uY291cHJpZWRpYXpAYXJtLmNvbT4KPiAtLS0K
PiB2MjoKPiAgIC0gU2xpZ2h0bHkgY2hhbmdlIHRoZSBjb21wdXRhdGlvbiwga2luZCBvZiBzaW1p
bGFyIHRvIHdoYXQgaXMgZG9uZQo+ICAgICBpbiBtc2dzdHJlc3MwNCwgdG8gbWFrZSB0aGUgd2Fy
bmluZyBtYWtlIHNlbnNlIHdpdGggdGhlIGNoYW5nZS4KPiAgIC0gQWRkZWQgY29tbWVudCB0byBj
bGFyaWZ5Lgo+Cj4gTWF5YmUgdGhlIG1lc3NhZ2UgY291bGQgYmUgcmVwaHJhc2VkIGVudGlyZWx5
ID8gU29tZXRoaW5nIGFsb25nIHRoZSBsaW5lcwo+IG9mOiAiTWF4aW11bSBudW1iZXIgb2YgdXNl
ZCBwcm9jZXNzZXMgaGlnaGVyIHRoYW4gbGltaXQgWy4uLl0iCj4KClllcywgSSB0aGluayBzbywg
YXQgbGVhc3QgaXQgY2FuIGJlIHJld3JpdGVuIGJ5IG5ldyBBUEkuCkNvbnNpZGVyaW5nIGl0IGlz
IGEgbXNnIHN0cmVzc2Z1bCB0ZXN0LCBjaG9vc2UgYSBwcm9wZXIKcmFuZ2UvbGltaXQgb2YgcHJl
c3N1cmUgaXMgcXVpdGUgaW1wb3J0YW50LgoKQnR3LCBJIGhlbHAgbWVyZ2VkIHRoaXMgcGF0Y2gs
IHRoYW5rcyEhCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
