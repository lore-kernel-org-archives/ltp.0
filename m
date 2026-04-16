Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C096CF433E3
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 05:37:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D4F23E12E3
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 07:37:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 293213CC8C5
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 07:37:03 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EAE861A0066C
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 07:37:02 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8d68bcf50fdso867565085a.2
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776317822; x=1776922622; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ch9pjkyNvEqV67bVc3eRzkbNAQ6BWjSkUSQ7BhnnKFM=;
 b=aEIqfaqMwAADYWKEcDd77cEUNZHBJecWLb0v2+V4NAJ78fJfiiUOYqqGMQt+Nq9+1L
 5iOPFqV2W7PBUaHAxXnkdqDf/JTAl4+aKUbCzMhp8JU70iHMwsL3s6SsdS+zHL0KALAj
 LEQDLcWlJmUcn3rChhbQn+vsTi5C4AFrnrY1KE+oyiSD2xBdaJM1vpMhrrG0w4HIuZTJ
 DCzCl1iuTKTFSE/pKKb/qwqPp1ssPGEw7cR1Pw/dX0Edp5anBLv4aadw9VXF24Xab6ad
 Wga24qOr1dtgDCCIDYhQThg4pErzfe2koDqBZUkZDJwl/tExeSReS3f6/3e7cmxa+/v2
 txpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776317822; x=1776922622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ch9pjkyNvEqV67bVc3eRzkbNAQ6BWjSkUSQ7BhnnKFM=;
 b=s+JHQZKr0B+reQw/TiEpASEI8ocxfFRirXGom6G/YpJOnZrBeZVY6JGQ1GUjWOg4fq
 LCwSDnsJVHzvi3Z1sey8KwOqJZEGjROJub1T5a6DkYgNwGd9UWEBLZaSiVc7pvekN62h
 aQm3AGaphCcDxFOURo05BIxT8oInKOpxRCHTcQGVJpMw6iufFX+ikECCaFeIPprx2hjM
 USkaWp0pIRMO8RuQJnxFzs3onBPH8vgu4/7rlt2H4l6Aiml1ekzn29aqYG4L45drhe8r
 QS0dZAJrbxXdNl4A3oPSzGZWuZkQj0jU3Iy7009XfyFPBfCSO76LoxYCbAMhLXU5qIzf
 kINg==
X-Gm-Message-State: AOJu0YyYL8QGm+AZ1BC/FpIGW7zmHO7U7Y8n8NSHZUGo9cNUIv25C0qa
 tTMJr9yrSNcMzQg1hbatTfTA1mKhB1GFu5sEt+xUi6/c38aT2fJUJPg8
X-Gm-Gg: AeBDiev/Dox/e2/m2Iinb+XR15Lea7XZ1khz+X6cKoEUaf8zQ2hqiJ+MaLcC6zSXVL7
 62sq7CFkFPNLYZ2DKsFglEuYFSgEIwCbF+5UWW4oS/luOZfZpnjQSp4/uXPIUOnS49P73n2akbb
 uA6fhbjbxBdOtkjuhkuQGn3Iu9Qcz+MtWxLgcKIggTigetWMK78k14Rj48uhopJpYx7c0U065yb
 kndfKTGHWk8jeys2jFL4S+58LdhKlPIZmh+Vgt88Ol/sewH87zuvHV+I4YDDe8I28YloejRXznQ
 WJyoUJF1efLtwVhOfDtvcikvS/mb6hFrbwHULvC5IIeWKy4IsGrFm6VPdeVREBMe7FW6Z0PILPz
 1BBX7WokwYwK4qYSNrDmS8ukehvKaqvZDaqiT7cYAhjdDnW28CkhVYx08vHm/I7ueQPAVS3K1Nh
 EVYWTsA3PPeDvuGdk3syYO+avmh+SjqGhSdrj+X2UsDSeiU3eyYzxLju80BwW0pK+5yJD2hY93f
 64M+4xONBzJhuYecLyi/KvYwoNP5y9bqzyNv+MvPtiM6Bv8uw==
X-Received: by 2002:a05:6214:449e:b0:8ac:7f70:4441 with SMTP id
 6a1803df08f44-8ac862b51ccmr399067076d6.48.1776317821716; 
 Wed, 15 Apr 2026 22:37:01 -0700 (PDT)
Received: from
 runnervm35a4x.4c4mgltpvnwe1ovrcbuq33uxla.bx.internal.cloudapp.net
 ([4.236.159.230]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6cbbc1bdsm28013136d6.38.2026.04.15.22.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:37:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Thu, 16 Apr 2026 05:37:00 +0000
Message-ID: <20260416053700.3930-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416042531.81093-1-sachinp@linux.ibm.com>
References: <20260416042531.81093-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring: Add test for READV and WRITEV operations
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

SGkgU2FjaGluLAoKT24gVGh1LCAxNiBBcHIgMjAyNiwgU2FjaGluIFNhbnQgd3JvdGU6Cj4gaW9f
dXJpbmc6IEFkZCB0ZXN0IGZvciBSRUFEViBhbmQgV1JJVEVWIG9wZXJhdGlvbnMKCj4gQWRkaXRp
b25hbGx5IG1lcmdlIHByZXBhcmVfd3JpdGVfYnVmZmVycygpIGFuZAo+IGlvX3VyaW5nX2luaXRf
YnVmZmVyX3BhdHRlcm4oKSBpbnRvIHVuaWZpZWQgaW5pdF9pb3ZlY19idWZmZXJzKCkKPiBmdW5j
dGlvbiB0aGF0IHN1cHBvcnRzIGJvdGggcm90YXRpbmcgYW5kIHNpbXBsZSBjaGFyYWN0ZXIgcGF0
dGVybnMKCnByZXBhcmVfd3JpdGVfYnVmZmVycygpIGRvZXMgbm90IGV4aXN0IGluIHRoZSBjb2Rl
YmFzZSDigJQgZ3JlcCBmaW5kcyBubwptYXRjaCBhbnl3aGVyZS4gVGhlIGRpZmYgb25seSByZW1v
dmVzIGlvX3VyaW5nX2luaXRfYnVmZmVyX3BhdHRlcm4oKQpmcm9tIGlvX3VyaW5nX2NvbW1vbi5o
LiBQbGVhc2UgZHJvcCB0aGUgcmVmZXJlbmNlIHRvCnByZXBhcmVfd3JpdGVfYnVmZmVycygpIGZy
b20gdGhlIGNvbW1pdCBtZXNzYWdlLgoKWy4uLl0KCj4gK30KPiArCj4gKwo+ICtzdGF0aWMgdm9p
ZCB0ZXN0X3dyaXRldl9yZWFkdih2b2lkKQoKRG91YmxlIGJsYW5rIGxpbmUgYmV0d2VlbiBmdW5j
dGlvbnM7IHVzZSBvbmUuCgotLS0KTm90ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmll
dyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxsIHJldmlldyBjYW4gYmUKZm91bmQgYXQ6IGh0dHBzOi8v
Z2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwLWFnZW50L2FjdGlvbnMvcnVucy8yNDQ5
Mzg3MDg0MgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMg
YWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1
ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0
aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
