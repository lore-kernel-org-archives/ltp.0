Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF742C77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751043082; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yt64H4hpRHOe8PUUWIyPtNHXiYF7dtMTFcLjMZL/+s0=;
 b=SiqOqH+Stvy+G7aJV8noqO9A5kyGH6rQWBS6d0hv+3QUZLTHdopKhcWUIJ7Jwwg7/Yolu
 PnC4apucoHRYLEOG+j3D4cEu/vIyOlyvs/J542bCHUqwRptUN6NODX7FT9dCaHHHGbWZPk2
 FYtoi5xRciLDX7iwd4yy0M/NjuF6v5E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 630153C91C2
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 18:51:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1C13C9245
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:48:25 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 94A93600ABF
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 18:48:24 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453066fad06so15219575e9.2
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751042904; x=1751647704; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=frROmKW2PIsBmQe37QVxAinpVFSrssJRyn6uCiqdkVg=;
 b=ethKqgquyRv+D3TJFjDdhkqpipjOVDUWn53Rb/HJkSZfVrJrLcRTZdSxQtsfPodxXb
 5lvWbJXkpvOFa8Z/CaFFWHbR3vkJWN3XXwg4A3wdl7HMihQE+bMphGjkjQI14OPgbeqN
 55VFogP4eb0s+GD5cJLw7MlLSx+ec8YKjAGf1hU62tKxFlX/PF1zcmPULE1cenIzgAgj
 JinoqzHVCnRkkn4A08SYnm3CH0wHrrZVbeQ4kuf8u7n9Pnhir0fJdWohWZVWZxWzdE5I
 +HUkJv27p5KyxQjAtKLJKX3WdGXi9P4Fg7imMTn479t9POXkzV32Cs0EPXdjuGZbYHy6
 sksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751042904; x=1751647704;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frROmKW2PIsBmQe37QVxAinpVFSrssJRyn6uCiqdkVg=;
 b=B1s6wzHNaOVRnoTFaqp4CiseFpBultYo/DA//22QNbJ0oOsK4FHlLkXuytnpTTtLuO
 7sGHgEUBjYpHEyLcv0Deqco6a+MjuS+5suqqAhrDFUlIsqWIQe+p160Qz5f0VH7CZDmA
 OaT5Izvpi4LRd7+omzLSKRdV+2pyduHJ+IUwVHDDN692bMKbaJUJ1c0JiKNuJMtkG9Fe
 fn0NQCYHyDGCgvkiof3Vo8LhLoml+S5NeSqf1eMFIUgd+7n5xTjuiZCXWSn3lY8t4uEg
 tffeyA4ir0c5cEyvS225NiZAYc1xToCEfCSaluNh5dZ2frAa1CZ/WGFYjgDI7dxDZezE
 uUMQ==
X-Gm-Message-State: AOJu0Yz7dDf8kp3xfId+trSDcEwGzDKxIqceIXIDHNoyNnNdFidQO9x3
 Qw4aWVqKygHIqxjf7cbNmcxxZXHVbvjMn0zgdIkEB0/+vjxVdh2yMC4k+hbWheATH7P8zwQBaQV
 +UQSU
X-Gm-Gg: ASbGncvJBe+kwT1yffrmOU4QtdiWCVbUDb0bepuwKm8gV2ErviU97LSEeTqdz124RPp
 5Nx2arYWwoQWI9uPsbiIlGP2u6HL5geV2dfW2kPhgMtf7XXnnS9n1dNO+/Uvwpo4htKt20jOjxK
 NO0/m87DRhjWlNPvytCIClwFsjwqlqxj5koed1uCVFocNMn4nyzmgZ83pldZ02SFzyW9ofULzmR
 ZiRvf9JbQEcicsFdlDtveFFro1JfBEmYmnGU7I83qTI5W3CjVzGC9/YMEefk0KSV0YhwMpqioot
 UVuoChnYAr8PEgnB6Ax3QwfrKzIQgxDmuF5yluJPexYVdaNrdQ==
X-Google-Smtp-Source: AGHT+IEOrNWlpebhM2TQClyJjYmmXnMJGqEI2CjTLjwsKnGzZeS/nwRN5zwplGdkJopWg551t/TAzA==
X-Received: by 2002:adf:f045:0:b0:3a4:d98d:76b9 with SMTP id
 ffacd0b85a97d-3a90038b6ffmr3284724f8f.41.1751042903894; 
 Fri, 27 Jun 2025 09:48:23 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-6fd772e3f38sm23332376d6.61.2025.06.27.09.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 09:48:23 -0700 (PDT)
Date: Fri, 27 Jun 2025 13:48:02 -0300
MIME-Version: 1.0
Message-Id: <20250627-conversions-shmt-v1-7-52449291b036@suse.com>
References: <20250627-conversions-shmt-v1-0-52449291b036@suse.com>
In-Reply-To: <20250627-conversions-shmt-v1-0-52449291b036@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4817; i=rbm@suse.com;
 h=from:subject:message-id; bh=AVqGz1UfvQTLYGfQuSaSXPlg2ZNshPDnQL+SnYhvUqo=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoXss+FHUIRVmL90hR69VHK83FVecwgcZGSEztj
 zyS4EB+1CqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaF7LPgAKCRDJC4p8Y4ZY
 pqQAD/9CXbf5KlZ0dlJOLnDYHCMyLpOZFLLbbUsxY0sqMUlM2YOeyglPxCgShJt53EFqk1YVgQp
 q8vUUM6B7BCTkmX69Gm/O6Iv4cvB3bgwcBE7wmqjZkjBpXeBejHZT+Ko/ED/cIGVDqlQIDgI+OL
 /IHYKIWPN7/te/8aP/YtGbt5Fm6LJ5BgdAVlLUFnmWb63iItkoJJNx/8zlD6C21OU7YqfNZTeDO
 EwgTKR6jeZ+5WxpBkYTrADQtAjZi4dxqTdGjaGsJnXi+KWMOuIkOJcTR5uBV34aU2s8NeehwBcq
 PHuYHKdIFRVqjeGuglTZ0LMw1vWwxi1Z0N003WX22750EV0zcRt/m1f2oYY0NtbCt5HmoQ7hWxE
 TK2/i2D1xvv8dMzz8yUYyEH4qLADce0MmVWyZCB9VYOH1iPzVUjy7c7cnW4w/7UUCANonp9oeGd
 fgqqnOgsnjjhHlKxUd3nvP9cxyd5dnUUrhdNYdoH3E9RWbEYdvJps96DEnphgK/sE5RN2wrs+Cc
 JUFHoH7gf6mjGecjEhcl3X4f3Yo0t3/BArN0CIxeGs0jvX8sfbgE/38mZGjwfAGGvSFqsmQCC4m
 /TbkXzOAkJ4nKILz0Onsz1YiHKHAn6LRHcdBs7zWvxJI5PcGUyVmNonT79Ac3HwKW0ttc5RPmsp
 v/wuotkqAX4zsVw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/9] mem: shmt08: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KClNpZ25lZC1vZmYtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5l
bC9tZW0vc2htdC9NYWtlZmlsZSB8ICAgMSArCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10L3No
bXQwOC5jIHwgMTI1ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDIgZmls
ZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvTWFrZWZpbGUgYi90ZXN0Y2FzZXMva2VybmVs
L21lbS9zaG10L01ha2VmaWxlCmluZGV4IDJjZDY0MGEzMDBlNTNjMmRkMmNjY2JlMTQ3MDE1Nzc5
ODdkMGUxMGIuLmVmMzRmMjNlNmNkZjMzZWYwZTY4MTdkNmFiMjNkMzA1MzUyNTU5NDUgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvTWFrZWZpbGUKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vc2htdC9NYWtlZmlsZQpAQCAtMzEsNSArMzEsNiBAQCBzaG10MDM6IExUUExE
TElCUyA9IC1sbHRwbmV3aXBjCiBzaG10MDQ6IExUUExETElCUyA9IC1sbHRwbmV3aXBjCiBzaG10
MDU6IExUUExETElCUyA9IC1sbHRwbmV3aXBjCiBzaG10MDc6IExUUExETElCUyA9IC1sbHRwbmV3
aXBjCitzaG10MDg6IExUUExETElCUyA9IC1sbHRwbmV3aXBjCiAKIGluY2x1ZGUgJCh0b3Bfc3Jj
ZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfbGVhZl90YXJnZXQubWsKZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDA4LmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9zaG10
L3NobXQwOC5jCmluZGV4IDJjM2FlOWQ1NGVkMGM5Mjc2MDBlMWY1YjViMDcxZDhjMTEyZWJmYmMu
LjlmYjJmNmIyMjA2YTRlNjg5MThmNjU4MDU5ZDJlZWJjMzZjZGRiYWUgMTAwNjQ0Ci0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL3NobXQvc2htdDA4LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vc2htdC9zaG10MDguYwpAQCAtMSwxMTcgKzEsNDIgQEAKKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCiAvKgotICoKLSAqICAgQ29weXJpZ2h0IChjKSBJbnRl
cm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzICBDb3JwLiwgMjAwMgotICoKLSAqICAgVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3Ig
bW9kaWZ5Ci0gKiAgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Ci0gKiAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCi0gKiAgIChhdCB5b3VyIG9w
dGlvbikgYW55IGxhdGVyIHZlcnNpb24uCi0gKgotICogICBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKLSAqICAgYnV0IFdJVEhP
VVQgQU5ZIFdBUlJBTlRZOyAgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCi0g
KiAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4g
IFNlZQotICogICB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWls
cy4KLSAqCi0gKiAgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlCi0gKiAgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYg
bm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQotICogICBGb3VuZGF0aW9uLCBJbmMuLCA1
MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEgVVNB
CisgKiBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAu
LCAyMDAyCisgKgkxMi8yMC8yMDAyCVBvcnQgdG8gTFRQCXJvYmJpZXdAdXMuaWJtLmNvbQorICoJ
MDYvMzAvMjAwMQlQb3J0IHRvIExpbnV4CW5zaGFyb2ZmQHVzLmlibS5jb20KKyAqIENvcHlyaWdo
dCAoYykgMjAyNSBTVVNFIExMQyBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgog
ICovCiAKLS8qIDEyLzIwLzIwMDIgICBQb3J0IHRvIExUUCAgICAgcm9iYmlld0B1cy5pYm0uY29t
ICovCi0vKiAwNi8zMC8yMDAxICAgUG9ydCB0byBMaW51eCAgIG5zaGFyb2ZmQHVzLmlibS5jb20g
Ki8KLQotLyoKLSAqIE5BTUUKLSAqCXNobXQwOAotICoKLSAqIENBTExTCi0gKglzaG1jdGwoMikg
c2htZ2V0KDIpIHNobWF0KDIpIHNobWR0KDIpCi0gKgotICogQUxHT1JJVEhNCisvKlwKICAqIENy
ZWF0ZSBhIHNoYXJlZCBtZW1vcnkgc2VnbWVudC4gQXR0YWNoIGl0IHR3aWNlIGF0IGFuIGFkZHJl
c3MKLSAqIHRoYXQgaXMgcHJvdmlkZWQgYnkgdGhlIHN5c3RlbS4gIERldGFjaCB0aGUgcHJldmlv
dXNseSBhdHRhY2hlZAorICogdGhhdCBpcyBwcm92aWRlZCBieSB0aGUgc3lzdGVtLiBEZXRhY2gg
dGhlIHByZXZpb3VzbHkgYXR0YWNoZWQKICAqIHNlZ21lbnRzIGZyb20gdGhlIHByb2Nlc3MuCi0g
KgogICovCiAKLSNpbmNsdWRlIDxzdGRpby5oPgotI2luY2x1ZGUgPHN5cy90eXBlcy5oPgotI2lu
Y2x1ZGUgPHN5cy9pcGMuaD4KLSNpbmNsdWRlIDxzeXMvc2htLmg+Ci0jaW5jbHVkZSA8ZXJybm8u
aD4KLQotI2RlZmluZSBLXzEgIDEwMjQKLQotLyoqIExUUCBQb3J0ICoqLwotI2luY2x1ZGUgInRl
c3QuaCIKKyNpbmNsdWRlICJ0c3RfdGVzdC5oIgorI2luY2x1ZGUgInRzdF9zYWZlX3N5c3ZfaXBj
LmgiCisjaW5jbHVkZSAibGlibmV3aXBjLmgiCiAKLWNoYXIgKlRDSUQgPSAic2htdDA4IjsJCS8q
IFRlc3QgcHJvZ3JhbSBpZGVudGlmaWVyLiAgICAqLwotaW50IFRTVF9UT1RBTCA9IDI7CQkvKiBU
b3RhbCBudW1iZXIgb2YgdGVzdCBjYXNlcy4gKi8KLS8qKioqKioqKioqKioqKi8KKyNkZWZpbmUg
U0hNU0laRSAxNgogCi1rZXlfdCBrZXk7Ci0KLXN0YXRpYyBpbnQgcm1fc2htKGludCk7Ci0KLWlu
dCBtYWluKHZvaWQpCitzdGF0aWMgdm9pZCBydW4odm9pZCkKIHsKLQljaGFyICpjcCA9IE5VTEws
ICpjcDEgPSBOVUxMOworCWNoYXIgKmNwLCAqY3AxOwogCWludCBzaG1pZDsKKwlrZXlfdCBrZXk7
CiAKLQlrZXkgPSAoa2V5X3QpIGdldHBpZCgpOwotCWVycm5vID0gMDsKLS8qLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCi0KLQlpZiAoKHNo
bWlkID0gc2htZ2V0KGtleSwgMjQgKiBLXzEsIElQQ19DUkVBVCB8IDA2NjYpKSA8IDApIHsKLQkJ
cGVycm9yKCJzaG1nZXQiKTsKLQkJdHN0X2Jya20oVEZBSUwsIE5VTEwsCi0JCQkgIkVycm9yOiBz
aG1nZXQ6IHNobWlkID0gJWQsIGVycm5vID0gJWRcbiIsCi0JCQkgc2htaWQsIGVycm5vKTsKLQl9
CisJa2V5ID0gR0VUSVBDS0VZKCk7CiAKLQljcCA9IHNobWF0KHNobWlkLCBOVUxMLCAwKTsKLQlp
ZiAoY3AgPT0gKGNoYXIgKiktMSkgewotCQl0c3RfcmVzbShURkFJTCwgInNobWF0MSBGYWlsZWQi
KTsKLQkJcm1fc2htKHNobWlkKTsKLQkJdHN0X2V4aXQoKTsKLQl9CisJc2htaWQgPSBTQUZFX1NI
TUdFVChrZXksIFNITVNJWkUsIElQQ19DUkVBVCB8IDA2NjYpOworCWNwID0gU0FGRV9TSE1BVChz
aG1pZCwgTlVMTCwgMCk7CisJY3AxID0gU0FGRV9TSE1BVChzaG1pZCwgTlVMTCwgMCk7CiAKLQlj
cDEgPSBzaG1hdChzaG1pZCwgTlVMTCwgMCk7Ci0JaWYgKGNwMSA9PSAoY2hhciAqKS0xKSB7Ci0J
CXBlcnJvcigic2htYXQyIik7Ci0JCXJtX3NobShzaG1pZCk7Ci0JCXRzdF9leGl0KCk7Ci0JfQor
CVNBRkVfU0hNRFQoY3ApOworCVNBRkVfU0hNRFQoY3AxKTsKKwlTQUZFX1NITUNUTChzaG1pZCwg
SVBDX1JNSUQsIE5VTEwpOwogCi0JdHN0X3Jlc20oVFBBU1MsICJzaG1nZXQsc2htYXQiKTsKLQot
LyotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSovCi0KLQlpZiAoc2htZHQoY3ApIDwgMCkgewotCQlwZXJyb3IoInNobWR0MiIpOwotCQl0c3Rf
cmVzbShURkFJTCwgInNobWR0OmNwIik7Ci0JfQotCi0JaWYgKHNobWR0KGNwMSkgPCAwKSB7Ci0J
CXBlcnJvcigic2htZHQxIik7Ci0JCXRzdF9yZXNtKFRGQUlMLCAic2htZHQ6Y3AxIik7Ci0JfQot
Ci0JdHN0X3Jlc20oVFBBU1MsICJzaG1kdCIpOwotCi0vKi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCi0Jcm1fc2htKHNobWlkKTsKLQl0
c3RfZXhpdCgpOworCXRzdF9yZXMoVFBBU1MsICJBdHRhY2hlZCBhbmQgZGV0YWNoZWQgdHdpY2Ui
KTsKIH0KIAotc3RhdGljIGludCBybV9zaG0oaW50IHNobWlkKQotewotCWlmIChzaG1jdGwoc2ht
aWQsIElQQ19STUlELCBOVUxMKSA9PSAtMSkgewotCQlwZXJyb3IoInNobWN0bCIpOwotCQl0c3Rf
YnJrbShURkFJTCwKLQkJCSBOVUxMLAotCQkJICJzaG1jdGwgRmFpbGVkIHRvIHJlbW92ZTogc2ht
aWQgPSAlZCwgZXJybm8gPSAlZFxuIiwKLQkJCSBzaG1pZCwgZXJybm8pOwotCX0KLQlyZXR1cm4g
KDApOwotfQorc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0geworCS50ZXN0X2FsbCA9IHJ1
biwKK307CgotLSAKMi41MC4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
