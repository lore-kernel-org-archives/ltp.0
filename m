Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0107CD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 14:15:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21B33E52C9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 16:15:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25D5E3D01C8
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:15:31 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B4FF600700
 for <ltp@lists.linux.it>; Mon, 25 May 2026 16:15:31 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-3044857f09aso4676761eec.1
 for <ltp@lists.linux.it>; Mon, 25 May 2026 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779718530; x=1780323330; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tm2g6118LRu3peX1AhoHD2wYeeDJIwv7FZMn///MY88=;
 b=OH6GXwbTWRBT5CKyqt/a+rZGz6FHUwuLmoXZ70dClG/iaF2SdpXORvke2EEeE2fP1Y
 0uGIyVXwXRURWpylWQHQqWur8OsKNb9rGXc7WCfafw4l9q2GSy6PEdFA3Arfw3UIWQgD
 AjHpqD4ebknMB7MOfpg8PkIdSixGmeC5GtIBG7wDkOiVsn12zdd3z1s8F2FHbTFuiX1h
 zoE1tLF5yLR4UYPB7ACrT8MHoZtVnQI3c1tMLAAKO81ZM2glInYYKQRKML78wWkNxW+h
 XLNJXDXcVxR+XvXE8USEHntUhuk8yBriqIhJZT55YtC1ssUUkZiJHzNhnskGiuREUHTA
 NHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779718530; x=1780323330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tm2g6118LRu3peX1AhoHD2wYeeDJIwv7FZMn///MY88=;
 b=I6p6JITWfyj6pjPmMFGihLC31AkiPoNXgDj3citM95U7TkkbYa6bMIT9my/ULCX2VO
 2PigFDam0wzM4qFTvNAAYtF6GSfnsInPT5wnW32Wn5Mb1GdCFriKAAIOpFUrN1cO4eMG
 8ELDpxh68CDRz1S9A1eJKmcnZ1NNlAUZ7ohyrkYKw2MV6aWUeu/VJAJ4erejsDtIZ+9D
 GeoQUPHySqJvrim+xg3pOHOrRmX+jsdzelc8x53oUKqNVW9BhrueJhKmN8gGgZ2fjZdB
 QFDXvgsFKa35xZ7EsL0H3MnW0+r/pLVeIou0OS/AwgdLoLr8F5FPZhbFlOvMvx5Q0/Jk
 ca/A==
X-Gm-Message-State: AOJu0YwFO1sZTRN5FEgjaOZHylPBuDTW3gLHA4qVN+SWgoJkSURCR5Wz
 HyAK5MLih7U583F0o8PBBczv7qaBV1+MnMRMLa+NKvIPh/SzGVX+4tSI
X-Gm-Gg: Acq92OHZVRGxuL8WTFXKREahpNOLp+hdMR1MkDq1ICeu12kIfg8TSEsqEFafVCvRe8H
 TyqqA8NaSsdV2nRm/dclNRrLEQ12Vmj0bTtxVjEXgCpi/62ItXwDVQhX2LNyW3CrglZzQ0cyew+
 ILPqwrDWk/FUcipEgS9opePxcfnfvHijTNAyjpUHUuqzmTN31j1sdLN8bG4uJ3hVg33co4MRwug
 BwWY7oeKOCD7+xe5Q6Ng8HCjkgyISCmlm6OJsSBtZfgp0zL5mMENWMp+lUdSlW/m9D6yq3/DSxd
 wOBuU4x/qsqMY5yD3Wq9VuhNjfvhAS93Ue83xmXslHnFu2wf7YTf9e3PUWdl6iD5KgnejMfzeIv
 CDyxJGe8zQv4p8GFdbXq3pMwDnr5dvW7ifwLCXS717E6Wzl4+yrPtx7xw/YYIYIcW0KhvGRmnCZ
 qqsQzd5f8r+0cAwfOGhPgaLyDVZilORzwidSkXAUMjiAUtaGEj8IxWsc42aJ+jebptZqcy7fip9
 ZW+MQZKnKkmK7H8AyKJVEQb/KFxpFVsY74zVg==
X-Received: by 2002:a05:7301:ea7:b0:2d9:6373:ad24 with SMTP id
 5a478bee46e88-30449093ee2mr6160125eec.26.1779718529482; 
 Mon, 25 May 2026 07:15:29 -0700 (PDT)
Received: from
 runnervmg397c.j0i0vdg5kpze5pinaxgsdnxvhc.dx.internal.cloudapp.net
 ([40.65.58.134]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef470dsm7993344eec.4.2026.05.25.07.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:15:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Mon, 25 May 2026 14:15:27 +0000
Message-ID: <20260525141527.4052-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525100452.336518-2-mmenashe@redhat.com>
References: <20260525100452.336518-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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

SGkgTWljaGFlbCwKCk9uIE1vbiwgMjUgTWF5IDIwMjYsIE1pY2hhZWwgTWVuYXNoZXJvdiB3cm90
ZToKPiBbUEFUQ0ggMS80XSBmdXRleF93YWl0MDY6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2Ug
dGVzdAoKPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMK
PiBAQCAtMTkwNywzICsxOTA3LDQgQEAgaW9fdXJpbmcwMyBpb191cmluZzAzCj4gICMgVGVzdHMg
YmVsb3cgbWF5IGNhdXNlIGtlcm5lbCBtZW1vcnkgbGVhawo+ICBwZXJmX2V2ZW50X29wZW4wMyBw
ZXJmX2V2ZW50X29wZW4wMwo+ICtmdXRleF93YWl0MDYgZnV0ZXhfd2FpdDA2CgpUaGlzIHRlc3Qg
ZG9lc24ndCBjYXVzZSBhIGtlcm5lbCBtZW1vcnkgbGVhay4gU2FtZSBpc3N1ZSBhcHBsaWVzIHRv
CmZ1dGV4X3dhaXQwNywgZnV0ZXhfd2FrZTA1LCBhbmQgZnV0ZXhfY21wX3JlcXVldWUwMyBpbiBw
YXRjaGVzIDItNC4KQWxsIGZvdXIgZW50cmllcyBzaG91bGQgYmUgcGxhY2VkIGFsb25nc2lkZSB0
aGUgZXhpc3RpbmcgZnV0ZXggdGVzdHMKKGFmdGVyIGZ1dGV4X3dhaXRfYml0c2V0MDEsIH5saW5l
IDE4NzgpLCBub3QgdW5kZXIgdGhpcyBjb21tZW50LgoKWy4uLl0KCi0tLSBbUEFUQ0ggMy80XSBm
dXRleF93YWtlMDU6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2UgdGVzdCAtLS0KCj4gKyAqIFBS
T1RfTk9ORSBtZW1vcnkgdHJpZ2dlcnMgRUZBVUxUIGJlY2F1c2UgdGhlIGtlcm5lbCBjYW5ub3Qg
bG9vayB1cAo+ICsgKiB0aGUgZnV0ZXgga2V5IGZvciBhbiBpbmFjY2Vzc2libGUgcGFnZS4KClRo
aXMgd2FycmFudHMgYSBub3RlOiB0aGUgdGVzdCBjYWxscyBmdXRleF93YWtlKCkgd2l0aG91dApG
VVRFWF9QUklWQVRFX0ZMQUcgKG9wZmxhZ3M9MCksIHdoaWNoIHRha2VzIHRoZSBzaGFyZWQtZnV0
ZXggcGF0aCBpbgpnZXRfZnV0ZXhfa2V5KCkgYW5kIHJlcXVpcmVzIHJlc29sdmluZyB0aGUgcGh5
c2ljYWwgcGFnZSDigJQgaGVuY2UgRUZBVUxUCmZvciBQUk9UX05PTkUuIFRoYXQgcmVhc29uaW5n
IGlzIGNvcnJlY3QgZm9yIE1BUF9QUklWQVRFfE1BUF9BTk9OWU1PVVMKdG9kYXksIGJ1dCB0aGUg
Y29tbWVudCBkb2Vzbid0IGV4cGxhaW4gdGhlIGRlcGVuZGVuY3kgb24gdGhlIGFic2VuY2Ugb2YK
RlVURVhfUFJJVkFURV9GTEFHLiBBIHJlYWRlciBtaWdodCB3b25kZXIgd2h5IEZVVEVYX1dBS0Ug
KHdoaWNoIG5ldmVyCnJlYWRzICp1YWRkcikgY2FuIHJldHVybiBFRkFVTFQgYXQgYWxsLiBXb3J0
aCBhIGJyaWVmIGNsYXJpZmljYXRpb24uCgpbLi4uXQoKVGhlIHJlc3Qgb2YgdGhlIGNvZGUgbG9v
a3MgY29ycmVjdDogbW1hcC9tdW5tYXAgcGF0dGVybnMsIHNpZ25hbApoYW5kbGluZyBpbiBmdXRl
eF93YWl0MDcsIE1BUF9TSEFSRUQgZm9yIHRoZSBjcm9zcy1wcm9jZXNzIGZ1dGV4LCBhbmQKVFNU
X1BST0NFU1NfU1RBVEVfV0FJVCBiZWZvcmUgU0FGRV9LSUxMIGFyZSBhbGwgZmluZS4gTWFrZWZp
bGUgdXNlcwp3aWxkY2FyZHMgc28gbm8gZXhwbGljaXQgZW50cmllcyBuZWVkZWQuCgotLS0KTm90
ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxs
IHJldmlldyBjYW4gYmUKZm91bmQgYXQ6IDxyZXZpZXdfdXJsPgoKVGhlIGFnZW50IGNhbiBzb21l
dGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdz
IGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UK
Y29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApM
VFAgQUkgUmV2aWV3ZXIKYGBgCgotLS0KCioqVmVyZGljdDogTmVlZHMgcmV2aXNpb24qKgoKVHdv
IGl0ZW1zOgoxLiAqKkFsbCA0IHBhdGNoZXMqKiDigJQgcnVudGVzdC9zeXNjYWxscyBlbnRyaWVz
IG11c3QgbW92ZSBvdXQgZnJvbSB1bmRlciBgIyBUZXN0cyBiZWxvdyBtYXkgY2F1c2Uga2VybmVs
IG1lbW9yeSBsZWFrYCBhbmQgYmUgcGxhY2VkIHdpdGggdGhlIG90aGVyIGZ1dGV4IHRlc3RzICh+
bGluZSAxODc4KS4KMi4gKipmdXRleF93YWtlMDUqKiDigJQgdGhlIGNvbW1lbnQgYWJvdXQgUFJP
VF9OT05FIHRyaWdnZXJpbmcgRUZBVUxUIHNob3VsZCBjbGFyaWZ5IHRoYXQgdGhpcyByZWxpZXMg
b24gdXNpbmcgdGhlIHNoYXJlZC1mdXRleCBwYXRoIChubyBgRlVURVhfUFJJVkFURV9GTEFHYCks
IHNpbmNlIEZVVEVYX1dBS0UgZG9lc24ndCByZWFkIGAqdWFkZHJgIGFuZCB0aGUgcmVhc29uIGZv
ciBFRkFVTFQgaXMgbm9uLW9idmlvdXMuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
