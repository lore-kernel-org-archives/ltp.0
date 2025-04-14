Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EFCC369B2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744661429; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ORczxnnsSrs+wrjL9hNgE4/Pz4xpX4S2gyyDDCbNwdA=;
 b=LA/ZKZxDLr2pXXDB0vjBB1jwzRS7gR1DpjdmljsJNm1mVi9y4kJMUGhPi2TfzHUvMwFw3
 L1Rj9hs24MXZu6MSw6XHI2BID8Dmm39bZ+tKPeow5f/dM0A9cMDEg1YJEo5fJ5SBEX0cDPI
 DsalsyoGdJgrDdhmlCZR/kXWsU3Z6wM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DBF83CB81A
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 22:10:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D18EB3CB7E9
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 22:09:46 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F555600D1E
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 22:09:45 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so33686955e9.0
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744661384; x=1745266184; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B+fhpFL9vsx1Z2YzDXBldQjUCrAgjIzpd7VBhcu8Ue0=;
 b=HDuZjzkcNBFvpV1bbbQGmtKZRPktz0Lug6+7CtSs5hSV/JDg+2PK2+1vGX5ILs9fQQ
 fF6EFPGHLzEisQs2jbu55ybQVxLu0M0RETiso/0ts8mEyV116X0fxBvUJyK2YcLLnL/C
 6NBJbPchsGeWRlxMBCI8VTGikPlijXlBTQIQ1INHfqSbvpD6NI+r2eVqMY053R72w1i6
 vKKxFSRbBgaWkhmFwT3KxFPnu6JSCfm7umoH6fyTqjQgR8GNqYsQCC7nfdkhXrWJLAEj
 hVOUXcZyIwps07w0mlWzSjSmymC5jWhDO47Kh/o16h3g192MDFBypeVfaT6v3b/DA33y
 3OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744661384; x=1745266184;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B+fhpFL9vsx1Z2YzDXBldQjUCrAgjIzpd7VBhcu8Ue0=;
 b=ZD4bG1jUhWWiMvZT9OljoVtTMnPtMozsgvAKpm6jlsR9fJytTmqlThK02QAN0rxK3D
 8xBzgnRZXooest7JA6mqUFYdXQO4shhRV9xa+93en0+MyRkpPs7E/RitAUO/pXcP+bif
 OoZmOPTVMkAnMa+tcHq8WLhg7xkoEYUMNjrGirm2HgVW5gNyzsNfRLH4+qb5MV5jLLpi
 y+eZCSzV7egACUmo0zn0cT8zipEIQ02zRF0/FEJy4oM0tzEisJgyEAT1huQJJFjpctH6
 CrsdHPppt9y8KG25PJcYd6JrI9yg0WoJ0TqeLfcajcoHUV9ZUuSSvOKWkMQHiNlk7sYh
 kgmw==
X-Gm-Message-State: AOJu0YyJk/5n714KPpRJbsk+fArX21s4V61ChzbPbBG/59BJmXwFSm3o
 i1viMzRXyIBkreMdqeKiW5TPG0kY19S52yyS9UuZI0yOfZxS+6Zdja2b5LaFyowRqF2Z05U+3LB
 C
X-Gm-Gg: ASbGncvQO3TjE4KqW8TWsAHv5iIoO4Z/UgeKqLa89foUTUbLMrhewlSQyq9Wl6Vjh1X
 UUf4GtRowV0MrWpRHobfjg9xhWpEaFGpsmEHyigTxUtMcGz6L86yvLpEtEsH7n+B6U8UTQKrQtP
 sl6/8aPRsIff3fz6iCVZAR7t3yBrN9lFocfo48AYxd9rpTc1TmB2zkNY+JCo/WfKE5j99B184Mq
 alek/fr21WkTxe36urE28BLIADcg4yfQhnU3JyQCTfo4+MAbIm6bjej6PGUw9Ce7rK0Jys3J7h4
 OvBEFtLJQDr00y7+E1icVaDneku6Cw==
X-Google-Smtp-Source: AGHT+IHpiR1oMP70HaiGl5fs5MV3S/6VIFHPU+8/EMf9xL8guGpDQTkhfhGxravEN4vt2fUBxvU8RQ==
X-Received: by 2002:a05:6000:40c9:b0:38d:e0a9:7e5e with SMTP id
 ffacd0b85a97d-39edc2fe09bmr520998f8f.6.1744661384324; 
 Mon, 14 Apr 2025 13:09:44 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73bd230e33fsm7233218b3a.133.2025.04.14.13.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 13:09:43 -0700 (PDT)
Date: Mon, 14 Apr 2025 17:09:32 -0300
MIME-Version: 1.0
Message-Id: <20250414-conversions-mknod-v3-1-e08e7463bfaa@suse.com>
References: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
In-Reply-To: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=rbm@suse.com;
 h=from:subject:message-id; bh=KZ6Txui0VmNidKOdV8nwFNbodDzokvRAdat+3OvswBk=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBn/WuB9Uob4Itk/0FNNHFf7cejKsQcvPbBLMpqN
 UVhJ3rq8fyJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ/1rgQAKCRDJC4p8Y4ZY
 ppxTD/kBS0GTcEouPT111xNb2kjfvbzP8HhXd9F/y5oKBqA1F8WRbDcCvCXFIJ/wlVmP9aNUGqf
 uEJIlY5Ao0sLI6vDVR/Pd6TSI6TLPeF5GhmZlPDJrkVe9/pI5FtQSc47Bjzi0i/cjm0VQAXk50X
 NfB303W3qT3bYtyDnY4FnQt1YCAEuKJligTGYwb/InSi6TacYknaC/vbl8IFQIqURKwoQa14BOn
 i1KcHBMufhH0rH9mgs27YsK79gT+NbI/4L/gXWjuc/OQJBxGCXyEy6t32v9T0AUaa3hG9TZ2FN0
 Q8hz8ADLo/0ihejOHoKj8l0hiNfWxs7rKJNfo1YhKE9mDGRTw4nefHP2j1glOLnUM6kntY7N+u2
 sX9DHC/VDcdy5jMBBNw0+yfpC+ambQDVo7vxeftS/QYZB1deMvN8G0miRcWXj4uFR35F4Q8Ek3U
 g+y+LsA0411STyl4SHY0zbl2C6MOKqPv8H1BAnEssEZxwTE5CH7u7LWwOvkv39F8KqreW8C/gq4
 j63EqZhZzDkIV8ALU0pAydxTdkgg30GHjg+SIADoDsRNZt3t3xqcrcdyWPgqZNwhUipm2DLVTw/
 09ruM+mc4ePpqnWQXhVOMEzxJcTSFULqcjccglr/PZdzWRRccs+q2wA1Xc7E2U/EW0LhOLp65cm
 WaCJQvS4N3sHd6A==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/8] syscalls/mknod01: Fix checkpatch.pl warnings
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

RnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KCkZpeCB0aGUgZm9sbG93
aW5nIHdhcm5pbmdzOgoKCUFsaWdubWVudCBzaG91bGQgbWF0Y2ggb3BlbiBwYXJlbnRoZXNpcwoJ
UGxlYXNlIGRvbid0IHVzZSBtdWx0aXBsZSBibGFuayBsaW5lcwoKU2lnbmVkLW9mZi1ieTogUmlj
YXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL21rbm9kL21rbm9kMDEuYyB8IDUgKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9ta25vZC9ta25vZDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9k
L21rbm9kMDEuYwppbmRleCBmZTBhMWNmYTZhNDczZjljMmIyYTU1NDkzZjgzMGYxM2I4NjU2MGE4
Li4zOWU0MDJlZTQxMmRlMzljNzkyOWRjYWU2NWZkZjNlMzAyZGU5YjQ1IDEwMDY0NAotLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDEuYworKysgYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDEuYwpAQCAtMjYsNyArMjYsNiBAQCBzdGF0aWMg
aW50IHRjYXNlc1tdID0gewogCVNfSUZSRUcgfCAwNjcwMCwKIH07CiAKLQogc3RhdGljIHZvaWQg
cnVuKHVuc2lnbmVkIGludCBpKQogewogCWRldl90IGRldiA9IDA7CkBAIC0zNSw4ICszNCw4IEBA
IHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgaSkKIAkJZGV2ID0gbWFrZWRldigxLCAzKTsK
IAogCVRTVF9FWFBfUEFTUyhta25vZChQQVRILCB0Y2FzZXNbaV0sIGRldiksCi0JCQkJIm1rbm9k
KFBBVEgsICVvLCAlbGQpIiwKLQkJCQl0Y2FzZXNbaV0sIGRldik7CisJCSAgICAgIm1rbm9kKFBB
VEgsICVvLCAlbGQpIiwKKwkJICAgICB0Y2FzZXNbaV0sIGRldik7CiAJU0FGRV9VTkxJTksoUEFU
SCk7CiB9CiAKCi0tIAoyLjQ5LjAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
