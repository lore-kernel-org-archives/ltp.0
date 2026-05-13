Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A62FCD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 07:57:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8C043DF9DB
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 09:57:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96CD23DB2CC
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:57:17 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D53E7200B1C
 for <ltp@lists.linux.it>; Wed, 13 May 2026 09:57:16 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-516389a9b70so756911cf.3
 for <ltp@lists.linux.it>; Wed, 13 May 2026 00:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778659036; x=1779263836; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EC3jD1Fm+vVOR/7lI4rig85AcWh/VgyJ2kbGp9L8qWM=;
 b=HiIhu/UhgR2CQCvpSd5J0WZMPGYu/ImnZdDE+02NnAjAercIj0f+iUC5j0lEb7IIws
 oEabD1prmwG72oH72U6NoHGJaXhOGtQp9zK+pKR95mw7vViAjXVEUsqZRf+I3mpw1Kt2
 PvQ6lFX88PVoqVgsTRX41m/FXH/v5fdt3GKRXKlC/GXhwyWsY5uqq0+eL2r9LoUkUwbE
 nPgyCP6vLPK5CGwBJ1u5FO748uajPPsdcO0NaO0O1YELt7JJrkjeFGkF0PJTX0zv5rLr
 GOsLvWquMUtWLFFViOUlJmo8OO4tG86IZySETKpC849yFfw/6BYiQJKm7ZT4P2TUNj+d
 riOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778659036; x=1779263836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EC3jD1Fm+vVOR/7lI4rig85AcWh/VgyJ2kbGp9L8qWM=;
 b=mjQUvUfd0XjCENmFEm9Q/vdrCYBZrB/RLy7JlqexCt6N8a3phY1jhKTzLHUzVLvXKu
 zIz7VlodIBv63/d25BcOfffKEK9Q9/F5mWkjJyRhBpFpdEOBwbqO+e4dNPCuHfc8aqp/
 T15JO8w0L5+uNjhvviRQrZ5EiMKA+FsABrxQFWdfwYJWQKPNZIj1Evp6YVHvC4IsGd7v
 XjsCWuxk43EG6sYMurQKzUGuDczDK71D+PYKm75wRuq/RWCoRSCT0nFNG8yYB8+CvzF5
 lT56wkQJ+yYH6cjPQJy1ol0pW5SEqycJ/faVkYjTstICf0GXQFT7FVV1ji+O/NHEJeR9
 XATA==
X-Gm-Message-State: AOJu0YxyA9EXsq71+/Ho/CYD+xpWiBTxIH7tJ40pC6Kjlc1Cl+xdBAMn
 u5OwH5vy1J+cgKKn6u+lvBDffDP9EjAY8H4cQSdj060nftCKvt/CQ+7E
X-Gm-Gg: Acq92OFOGeTyL8maoR8o0butj0NJ/UvQ+l23rTZR3c9W/eu+S9uA3nGmDVtP4gNwg2x
 ooMlwKF8lGYLf5+V3Hjq0t8ueeRGJhJSX4lLt8gjN3Mxp/7iuE3y2gDT+b7DMzC37DKHs0BTYNv
 XzSuX+DcH2LZJwMqvtIHtkqkIFcDBIsXu7Ys8/bioGC5I4WUGxDv9sk/p6Qk0WlWlvUFXO6CA6X
 3CslgSiKP/kIuUrCA3VlPhtLrxCYIs36loZ/hYWbCxe6gyPS2Vf9a+Bw/U9Gc68V3RmH51PKfA0
 Eg0iNrqg8JYrofc4kSdsjGQmauGo5R7/MWkEevjDps5R5MQClvTdSM98YMmIJAOyA2PXeQvNd9M
 RzO1hf7LHy1Qka1WFq5SRcG8kj1L1iWDdsHxPDAEZQETfBOWhEUmcKnzS1utlf5JBgt4vNNCN8o
 z/C6+efwyXrpznlkg/bDDEWQlrvyBj8PXxBYKj2Kb/H+GFp5IFeDVEdFfKrGbl77rtzKMRRWaky
 YSjxQ/udhSXZiu6fePcKeK+c5UQg894rSBsUOMxIEaL3HFRrec=
X-Received: by 2002:a05:622a:4d8e:b0:50d:71fe:85aa with SMTP id
 d75a77b69052e-5162f4a8997mr28432331cf.16.1778659035578; 
 Wed, 13 May 2026 00:57:15 -0700 (PDT)
Received: from
 runnervmeorf1.lcg2avo1p2berav5sjxbnkio3f.bx.internal.cloudapp.net
 ([172.214.44.215]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148fd8bfe0sm140394261cf.0.2026.05.13.00.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 00:57:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: lepillai@linux.ibm.com
Date: Wed, 13 May 2026 07:57:14 +0000
Message-ID: <20260513075714.3992-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513064818.1596754-1-lepillai@linux.ibm.com>
References: <20260513064818.1596754-1-lepillai@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Patch:V2:creat07():Added new_behavior flag to detect
 kernel version > 6.11 : Tests that creat() succeeds (write to executed file
 allowed) Removed the old skip logic that did TCONF on kernel >= 6.11 Added
 one static variable exp_errno to store expected result: -1 means creat()
 should succeed ETXTBSY means it should fail with that errno setup() now
 sets exp_errno from kernel version Simplified verify_creat(): if expected
 is success, call creat(), close fd, print TPASS if expected is failure,
 use TST_EXP_FAIL2() for ETXTBSY Removed extra verbose kernel-info messages
 Removed exec of external child binary and replaced it with an in-process
 forked child using TST_CHECKPOINT_WAKE() + pause() Removed .resource_files
 from test
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

SGkgTGVrc2htaSwKCk9uIFdlZCwgMTMgTWF5IDIwMjYsIGxla3NobWktY3BpbGxhaSB3cm90ZToK
PiBQYXRjaDpWMjpjcmVhdDA3KCk6QWRkZWQgbmV3X2JlaGF2aW9yIGZsYWcgdG8gZGV0ZWN0IGtl
cm5lbCB2ZXJzaW9uID4gNi4xMS4uLgoKVGhlIGNvbW1pdCBzdWJqZWN0IG11c3QgYmUgYSBzaW5n
bGUgY29uY2lzZSBsaW5lICg8PTcyIGNoYXJzKSBpbiBpbXBlcmF0aXZlCmZvcm0gd2l0aG91dCBh
ICJQYXRjaDpWMjoiIHByZWZpeC4gVGhlIGJvZHkgbXVzdCBleHBsYWluIFdIWSB0aGUgb2xkIFRD
T05GCmFwcHJvYWNoIHdhcyB3cm9uZywgbm90IGp1c3QgbGlzdCB3aGF0IHdhcyBjaGFuZ2VkLgoK
PiAtICAgICAgIGlmIChwaWQgPT0gMCkgewo+IC0gICAgICAgICAgICAgICBTQUZFX0VYRUNMKFRF
U1RfQVBQLCBURVNUX0FQUCwgTlVMTCk7Cj4gLSAgICAgICAgICAgICAgIGV4aXQoMSk7Cj4gKyAg
ICAgICBpZiAoIXBpZCkgewo+ICsgICAgICAgICAgICAgICBUU1RfQ0hFQ0tQT0lOVF9XQUtFKDAp
Owo+ICsgICAgICAgICAgICAgICBwYXVzZSgpOwo+ICsgICAgICAgICAgICAgICBleGl0KDApOwo+
ICAgICAgICAgfQoKUmVtb3ZpbmcgU0FGRV9FWEVDTCBicmVha3MgdGhlIEVUWFRCU1kgcGF0aDog
Y3JlYXQoKSBvbmx5IHJldHVybnMgRVRYVEJTWQp3aGVuIHRoZSB0YXJnZXQgZmlsZSBpcyBiZWlu
ZyBleGVjdXRlZCBieSBhbm90aGVyIHByb2Nlc3MuIFNpbmNlIHRoZSBuZXcKY2hpbGQgbmV2ZXIg
ZXhlYydzIGNyZWF0MDdfY2hpbGQsIGNyZWF0KFRFU1RfQVBQLCBPX1dST05MWSkgd2lsbCBuZXZl
cgpyZXR1cm4gRVRYVEJTWSBvbiBrZXJuZWxzIDwgNi4xMSDigJQgdGhhdCB0ZXN0IGJyYW5jaCB3
aWxsIGFsd2F5cyBmYWlsLgpSZXN0b3JlIHRoZSBleGVjIG9mIHRoZSBjaGlsZCBiaW5hcnkgKG9y
IGZpbmQgYW5vdGhlciB3YXkgdG8gaG9sZCB0aGUKaW5vZGUgYnVzeSBkdXJpbmcgZXhlY3V0aW9u
KS4KCj4gIC8qXAo+ICAgKiBDaGVjayB0aGF0IDptYW5wYWdlOmBjcmVhdCgyKWAgc2V0cyBFVFhU
QlNZIGNvcnJlY3RseS4KPiAgICovCgpVcGRhdGUgdGhlIGRvYyBjb21tZW50IHRvIGRlc2NyaWJl
IGJvdGggYmVoYXZpb3JzOiBFVFhUQlNZIG9uIGtlcm5lbCA8IDYuMTEKYW5kIHN1Y2Nlc3Mgb24g
a2VybmVsID49IDYuMTEuCgpQcmUtZXhpc3RpbmcgaXNzdWVzIG5vdGljZWQgaW4gdGhlIHN1cnJv
dW5kaW5nIGNvZGUgKG5vdCBpbnRyb2R1Y2VkIGJ5CnRoaXMgcGF0Y2gpOgoKLSB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2NyZWF0L2NyZWF0MDdfY2hpbGQuYyDigJQgb3JwaGFuZWQ6IHN0aWxs
CiAgY29tcGlsZWQgYnkgdGhlIHdpbGRjYXJkIE1ha2VmaWxlIGFuZCBsaXN0ZWQgaW4gLmdpdGln
bm9yZSwgYnV0IG5vCiAgbG9uZ2VyIGV4ZWMnZCBhbmQgcmVtb3ZlZCBmcm9tIC5yZXNvdXJjZV9m
aWxlcy4gRWl0aGVyIGRlbGV0ZSBpdCBvcgogIHJlc3RvcmUgdGhlIFNBRkVfRVhFQ0wgY2FsbC4K
Ci0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4g
VGhlIGZ1bGwgcmV2aWV3IGNhbiBiZQpmb3VuZCBhdDogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4
LXRlc3QtcHJvamVjdC9sdHAtYWdlbnQvYWN0aW9ucy9ydW5zLzI1Nzg1Nzk5MDc0CgpUaGUgYWdl
bnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBp
dHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZp
ZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4K
ClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
