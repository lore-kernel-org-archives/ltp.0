Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFD7C369B2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 20:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744661453; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rONVO/ROsvyOYy6fDoHoz5llh+5HzqU+GTUrZ45wIco=;
 b=XEX2F1BhxQmvGP10myjINccUmOMr8PuWWd6KSN7/4nvbYE3sJ/CxnhfQT/iA+R0ljVhrB
 g5FQkqglKnxYSnmpiIQT1iXQzXw9Jt5tdzUC/uYHGn3OTHtoEahXwp6usuhPTI+8c8+3agF
 5g1KK1GGSHGjUEhrP4SKwhS5GUj3WUU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ED723CABE1
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 22:10:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E89D03CB824
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 22:09:48 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4B8F160035B
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 22:09:48 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so2447933f8f.0
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744661387; x=1745266187; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Li7reCJuHtZ7LUwuOA5MyuTkjXPL2ERAyqoBNp7Aq84=;
 b=dmlCG/MGoNy69iUsF78aVH8aXK2YsbCPjJfV6qAOrCB2OQSVEV7BqIxDjipAIqZJZO
 /xW/kJJCQ/aaSCLqPx41IBxhZ5W659EXDZX3/iaH8HvDjdlV+/cDo3lzUsXkom4E/N6f
 ZucCUn0ceZ05uBJVvwNnjONwpTv0KiTQbDf+yYH1SL8czI8YP5AZ7bBhSPZ/n2Ow9MwE
 WVTT4wCxgM1okBJdBeSOXCFjwZ52VP0TJDehiqV4pjevEVffH8bsPQEH9HCDNl1pv5Js
 deHuC3hpKFbihBp0kpfXi+4+hG02qwTZXWqkQ04CcK+JhlDjCsGnonZ3C6b4DkHVnZGp
 hpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744661387; x=1745266187;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Li7reCJuHtZ7LUwuOA5MyuTkjXPL2ERAyqoBNp7Aq84=;
 b=JUwUL74/TEjCzv0/nEo0YDOXr/9I0sgAO4RpenE20bINPH/9gXgqAO3P+mkp+l56zc
 gsxsD5znjRD+cHTMhQYOt+rxFYlLplR+1VejDMLOxlvZ5BEgpB6dNDbl7jFAvGvNEeRb
 dmJJqYwwaAEEjxp26GjFtxQq9zEvARQhQyIBJJ1pCzDXj212qLBDwRLxsUst4ao1u0WU
 7PqxfTsu2wMXxqc4EQ2rPFX1cpnv2vzVZlaMoVJUspVcbk22XzEDNnnmVXhCz90IlMek
 XCIhi+/kUQBcomDCy2xqjLwpWWFXP2Idn5kXsE1Fy2Yt4WySFsCHDHLB6nnRVN9yUcFg
 pOJA==
X-Gm-Message-State: AOJu0YxEfVR9nNU145LaAT3IR6j0SJsDE73GPYE1VSCu49GZO46Pjw4A
 eY9bpdoIKHeOGjtFF2QEn6O3cNHqu0AOw2HJFTAIZBbbGYcYdsAgKnvTIxS4lndyQwoA5hVsblj
 j
X-Gm-Gg: ASbGncv8blUJ8yB1BCq0y+7a195aTt+Ns6T3dK3oYQiCiOdGukLucYFn5iUI7b9aDJQ
 2A2fnWfkmPZjgG3MGlDsBPwVfQAeY5cehephtwFDDKYchK4NTeaAZ/DMKFopql2+cCb2FhLiD8l
 u3WsfMpyjArSvSVlKZC7W9bfxkTW4cq5h1dS4M/sEf2okExlP9WtmSi3+uJSgs7MWutkuZI4sZB
 NZXtteA2j65bYHQb/GFiAWuema5Vvl1fO/7uNr2WTl/4wRGCKZYuX6kG18UZ9KTVE6/Xot9t45j
 oyRaUzJKukiwTs3VSI/vmeAiSovfpJOX4hYXKqgj
X-Google-Smtp-Source: AGHT+IEv+0oW1hpCDqyOdyFJjant2t2v4zMz7HmCRoF4e0kflTSz1GYCSUF63KXcwGvBPsZHQHtdpA==
X-Received: by 2002:a05:6000:2906:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-39eaaed558dmr9090164f8f.49.1744661387056; 
 Mon, 14 Apr 2025 13:09:47 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3082280bb79sm7850409a91.16.2025.04.14.13.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 13:09:46 -0700 (PDT)
Date: Mon, 14 Apr 2025 17:09:33 -0300
MIME-Version: 1.0
Message-Id: <20250414-conversions-mknod-v3-2-e08e7463bfaa@suse.com>
References: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
In-Reply-To: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1029; i=rbm@suse.com;
 h=from:subject:message-id; bh=OFHRY3J3wD+gC3q/AE2HRIe5MXt6mSJPdmXQvDmuzbw=;
 b=kA0DAAgByQuKfGOGWKYByyZiAGf9a4GiPOCqyVvHAIQ1L1b177J360T+eAa48zYfn4VVWs8s7
 okCMwQAAQgAHRYhBAMKjp5CTuPAZVeH4ckLinxjhlimBQJn/WuBAAoJEMkLinxjhlimtIYP/0/N
 EoRSNKiIX/1LnervESUzBJbwyL4Pr5BWGU4zVrmTr1bbW6QBvGgb7PclMxSuSUy2FUVh5RU2a1B
 doSC+FCx+AkuHGiGESYCYXlb11D08ReOHrBP5KFY0wkxL5DQpQR3AYysjQcYG6MOltwr48MIz7B
 a1X8m43tRV/gWhXR2X1smRVfc9mEjeA9YkWZUBeqITnrPbsDqQ9s51vOhjAA0lVtPRf3tcJ80h0
 mgylf+mClAGjGqAEYl4AWFlVLWOXMtSLbOGGSaWp4he1GYduVqGWtNXg8dFm6qjsPEyrwEcDJuL
 qUdWlCnBN8daY9uVeudPkSFv5kw8I5NT/98y2IZR9PnMi9eTe9zv9JDl+3p6mzChT5pDl7k2VNa
 qxtTi2NhlT6CXm2ZhSy48uMJrx+UJ6fhZGqWYq+ELBfuT/wj0Pnaa5Mf5eVfsaeYEH9+2Y00T+q
 8JReljANNpRbs/yJOwSufHjy2fG88n6ilCU9l1pNEeS20vJ3UZ12x/qQ+ekN6txX2Vj9PelgLBZ
 HUp/Kt16+2691lBZhygCU5iHG5AqU87QZIVXNUEfDX3HDWJvVBfWSB4iXj4BS6269tqBMcV9oDz
 JzRi5IfhmqgDVH7aUI8GCVng4uvATAE3fvOQieusOiNqxJAWAkQXOrkfBiAjtwmGj5XPOEtwuDB
 nil7Q
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/8] syscalls/mknod02: Use relative path to avoid
 use of SAFE_CHDIR
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
bC9zeXNjYWxscy9ta25vZC9ta25vZDAyLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL21rbm9kL21rbm9kMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtu
b2QvbWtub2QwMi5jCmluZGV4IDg5ZGQxZDg3NDAyMzRiNzg4NTU0ZTYyNWU2OTM2OTNiOTU0NDQw
Y2MuLmJkNDc2ZmZmNzljZGRlOTA3M2RkNDk2NjRmNmZkMzIwMzFmOWQ5NjYgMTAwNjQ0Ci0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwMi5jCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbWtub2QvbWtub2QwMi5jCkBAIC0yMCw3ICsyMCw3IEBACiAjZGVm
aW5lIE1PREVfU0dJRAkwMjAwMAogCiAjZGVmaW5lIFRFTVBfRElSICJ0ZXN0ZGlyIgotI2RlZmlu
ZSBURU1QX05PREUgInRlc3Rub2RlIgorI2RlZmluZSBURU1QX05PREUgVEVNUF9ESVIgIi90ZXN0
bm9kZSIKIAogc3RhdGljIHN0cnVjdCBzdGF0IGJ1ZjsKIHN0YXRpYyBzdHJ1Y3QgcGFzc3dkICp1
c2VyX25vYm9keTsKQEAgLTM3LDE0ICszNywxMiBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQog
CiBzdGF0aWMgdm9pZCBydW4odm9pZCkKIHsKLQlTQUZFX0NIRElSKFRFTVBfRElSKTsKIAlUU1Rf
RVhQX1BBU1MobWtub2QoVEVNUF9OT0RFLCBNT0RFMSwgMCksICJta25vZCglcywgJW8sIDApIiwg
VEVNUF9OT0RFLCBNT0RFMSk7CiAKIAlTQUZFX1NUQVQoVEVNUF9OT0RFLCAmYnVmKTsKIAlUU1Rf
RVhQX0VRX0xJKGJ1Zi5zdF9naWQsIDApOwogCiAJU0FGRV9VTkxJTksoVEVNUF9OT0RFKTsKLQlT
QUZFX0NIRElSKCIuLiIpOwogfQogCiBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cgot
LSAKMi40OS4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
