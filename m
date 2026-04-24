Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B80FED3CA
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777036588; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Up7RcTvlm9TdxuOAyHjH9zo0ya4343sQeONeUrhHk3g=;
 b=kMDQ7RyQcN+9EIecOXNbMdBY8/p46Ka7y7W31x6qZLsphSGgWg8094KtVUUBs9/3H+opj
 OcJYvwQ/HFTTWHTfS5/r1/OXmVh5RPhxufNkQV4O8o8T4VVOxDYp3IYb5NJyOZrqTyqEjad
 qofchA9HIQc+Pv3rG7xy8gJOOyueVn8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B8923E28D0
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 15:16:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD4D33E257E
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 15:16:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 79D951A00A3E
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 15:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777036561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FuJ+tt3bXietxkeSEqob4r3PBxpXus+WOR80/gX3YpI=;
 b=b48NUfgRHHfVRvb4lBmE3DT9Ko4G3YubPmnRDlmmMot5ntTnHpuFfhEvOzYFqYOEOeWyvi
 zaVrlo2X3DmGA7Ssj+scncVPRmCy52Csofi++A17yw+aeKKRW/58c+mYA46+fN+Zii1ni+
 0FTOSSWkL5FDKbWeW7Mylk0smveSoo8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-DcrkryGUOK6XcVY4TfDfJw-1; Fri, 24 Apr 2026 09:15:59 -0400
X-MC-Unique: DcrkryGUOK6XcVY4TfDfJw-1
X-Mimecast-MFC-AGG-ID: DcrkryGUOK6XcVY4TfDfJw_1777036558
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43fe4674d3eso7201412f8f.1
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 06:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777036558; x=1777641358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FuJ+tt3bXietxkeSEqob4r3PBxpXus+WOR80/gX3YpI=;
 b=XcEokyjfOAd7ik3G3rRT+S2d6Zr9Trp7Kcz6TTEQQ4gsuRZQnvMkIAjj1cSJHxg/9T
 bqKjiFEQjgAb/1YUa87oGaNgAlxEFyWlyCn17hI3LZ+SIz0kyJ8+UknxH0P1Jn9v0EJg
 ocw/utEeW4zqj75is2E6CSDUfiKNFVULxIZvHxVxY3xMgqbpYIytR9saWrqG4YAIfo/q
 0ZFRvVTZMs6F6afaEi2SiTgi8IlttxvzmQuBWYdYewnmag7qe0U6zICWSLTAsnyfvyRu
 z+/j1CLMD/P5um21YLfqIMyDEZsVs4rZYfk9VYOqWcy7+0d1d35oXdXjxNYv5L6kN4UE
 JhEg==
X-Gm-Message-State: AOJu0Yxo97W49nKj9KFW2PSY0sF+4VDaEBiOLjrGWaBWZ4vXiIjzi172
 tLEtSMQw2JTAO4CP/sdMC7bwqEgt0W8k5ON2740hugLOG3meRlM3hHd31/Rga8Q3nQFMgIDm9Di
 4xVF77usc+CJKN8nHYB/lc+utFiAFv7dVFJGkbv2kPxfVCLls01p88dJNwB7+kR6DKj08RPmH6U
 hDY+gt0bD1Sj1yO6YnOsh2ryg+Ldk=
X-Gm-Gg: AeBDievoTE1BVy8GRHcC8MdTtt6mjaDoWIX9IEkxu9URe9OTZAc5EsrOUeGgXXi/uMI
 KFCgZKxSvoJ3IKt6F1lOsRkFpgyXRx8BVH1ow7WI5QL94YWIZwdqaSGCX8w+B7Eo+mwVnf9rj/U
 YyyGrnd/uPnjiaEy3XCgu6kOHJlwHibbFPjth//KpGqq7gAlaAdGkVeaLqjf/mJI7jHS7kkrAKT
 4g6dAK8dXBKODw=
X-Received: by 2002:a05:6000:22ca:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-43fe3dfd65fmr46991046f8f.31.1777036558100; 
 Fri, 24 Apr 2026 06:15:58 -0700 (PDT)
X-Received: by 2002:a05:6000:22ca:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-43fe3dfd65fmr46990970f8f.31.1777036557617; Fri, 24 Apr 2026
 06:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260424101508.505501-1-pvorel@suse.cz>
In-Reply-To: <20260424101508.505501-1-pvorel@suse.cz>
Date: Fri, 24 Apr 2026 15:15:41 +0200
X-Gm-Features: AQROBzCrEtRKagc7J2v4XP2nIUjRqXo6YVRr2jozFX8XPrsrY1VJypE7AdZa2gg
Message-ID: <CAASaF6zE645N3kXGNis5h++Q2AF8RvJQ02wRZU9E8s0V6HjMsg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wdWZncx15M0KKR9HkRSU14a6YSAcbuqpXijE3inHoJI_1777036558
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ioctl_pidfd06: Update kernel version
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBcHIgMjQsIDIwMjYgYXQgMTI6MTXigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBLZXJuZWwgY29tbWl0IGFiODkwNjBmYmM5MmUgKCJwaWRmczogcmV0
dXJuIC1FUkVNT1RFIHdoZW4gUElERkRfR0VUX0lORk8KPiBpcyBjYWxsZWQgb24gYW5vdGhlciBu
cyIpIGZyb20gdjcuMCB3YXMgYmFja3BvcnRlZCBpbnRvIHN0YWJsZS9MVFMKPiBrZXJuZWxzIHY2
LjE4LjE0ICg3NDQ2MTI1YWZiNmQ5KSBhbmQgdjYuMTkuMTAgKDI5MjBhYmFmNTZjMDkpLgo+IFVw
ZGF0ZSBlcnJub3MgZm9yIHRoZXNlIHN0YWJsZS9MVFMga2VybmVscyAoZG8gbm90IHRyZWF0IG9s
ZGVyIGJlaGF2aW9yCj4gYXMgYW4gZXJyb3IpLgo+Cj4gRm9sbG93LXVwOiBmNjMwNDcxYTY1MjAg
KCJpb2N0bF9waWRmZDA2OiBTZWxlY3QgZXhwZWN0ZWQgZXJybm8gZm9yIFBJREZEX0dFVF9JTkZP
IGFjcm9zcyBwaWRucyIpCj4gUmVwb3J0ZWQtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+
IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0tLQo+IEFsdGVy
bmF0aXZlIGFwcHJvYWNoIGZvciBXZWkncyBmaXg6Cj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI2MDQwNjAyMzUzOC4xNDczOS0xLXdlZ2FvQHN1c2Uu
Y29tLwo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI2MDQwNjAyMzUzOC4xNDczOS0x
LXdlZ2FvQHN1c2UuY29tLwo+Cj4gQ2hhbmdlcyB2MS0+djI6Cj4gKiBDb3ZlciBhbHNvIDYuMTku
MC4udjYuMTkuOQo+ICogQWRkIEZvbGxvdy11cDogdGFnIChub3QgRml4bWU6IHRhZyksIGNvbW1p
dCB3YXMgY29ycmVjdCBhdCB0aGUgdGltZS4KPgo+IExpbmsgdG8gdjE6Cj4gaHR0cHM6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI2MDQyNDA2MDU0My40NjI0NzUt
MS1wdm9yZWxAc3VzZS5jei8KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA0MjQw
OTU5MDAuR0E1MDAxNThAcGV2aWsvVC8jdAo+Cj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW9jdGwvaW9jdGxfcGlkZmQwNi5jIHwgNyArKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkMDYuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvaW9jdGwvaW9jdGxfcGlkZmQwNi5jCj4gaW5kZXggMGYyNGQ0NzQxZi4uYmM5MGFhZmQx
NyAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3Bp
ZGZkMDYuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGxfcGlk
ZmQwNi5jCj4gQEAgLTU0LDcgKzU0LDEyIEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gICAg
ICAgICBpZiAoIWlvY3RsX3BpZGZkX2luZm9fZXhpdF9zdXBwb3J0ZWQoKSkKPiAgICAgICAgICAg
ICAgICAgdHN0X2JyayhUQ09ORiwgIlBJREZEX0lORk9fRVhJVCBpcyBub3Qgc3VwcG9ydGVkIGJ5
IGlvY3RsKCkiKTsKPgo+IC0gICAgICAgaWYgKHRzdF9rdmVyY21wKDcsIDAsIDApID49IDApCj4g
KyAgICAgICAvKgo+ICsgICAgICAgICogYWI4OTA2MGZiYzkyZSAoInBpZGZzOiByZXR1cm4gLUVS
RU1PVEUgd2hlbiBQSURGRF9HRVRfSU5GTyBpcyBjYWxsZWQgb24gYW5vdGhlciBucyIpCj4gKyAg
ICAgICAgKiBmcm9tIHY3LjAsIGJhY2twb3J0ZWQgdG8gdjYuMTguMTQgYW5kIHY2LjE5LjEwLgo+
ICsgICAgICAgICovCj4gKyAgICAgICBpZiAodHN0X2t2ZXJjbXAoNiwgMTksIDEwKSA+PSAwIHx8
Cj4gKyAgICAgICAgICAgKHRzdF9rdmVyY21wKDYsIDE4LCAxNCkgPj0gMCAmJiB0c3Rfa3ZlcmNt
cCg2LCAxOSwgMCkgPCAwKSkKPiAgICAgICAgICAgICAgICAgZXJyX25yID0gRVJFTU9URTsKCmxn
dG0gYXMgd2VsbCwKQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoK
PiAgfQo+Cj4gLS0KPiAyLjUzLjAKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
