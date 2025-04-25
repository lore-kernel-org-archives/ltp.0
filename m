Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C332C369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745604426; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=D4jorgsASwUnem84iCFdlYyE0ww6nfTaJw3Gliia7cM=;
 b=X5lL0+PubFDFVhj++3A+VQ0ipli5anfTENHMwNkrxP+t7BPlWDYSeFMOGv0MXO5BPW3hs
 JzkMw4p2m0TMKImPuA6Dh0sgg2vP1wpFz7NKX6H31Z6efLUXQ0BgJSWk9vfcIiBS4z4l7f6
 koDVnDbhc5A+3bHuxFQCZhVaW2VoHPk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ACE63CBAB9
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 20:07:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE83F3CBA3F
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 20:06:15 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 208F7200A04
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 20:06:15 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso19064215e9.0
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745604374; x=1746209174; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=udh7WQisxb76qYjtANbysaZCZCcCybHWMLZqzW5NUac=;
 b=eP/CQPgQhgfDtYQApYX5OYwMG6Pl05TfGqWlrDeyJn8WykoC6OUlSzcEZmfUKsoN6H
 oXSJYUaBLVVhKyoz/q/5T10aApeQVmA09cDAeYvfNOo+44s5HYqXiRcNUvWTGKv6+JdG
 K6u/dsqK7qXd5XiXfpqVuSeRm+ftN2N+GPaTOeE5/HBoZ9Cib/ndzvT37HxgR+m2lq4P
 0aHrhTl4qIbSSnBYony7GMuSrIJoiuFKhQ0zqcnKaumECnhMYqqHuDToeCqrxlFKh1Fn
 6Q4VrbzNS2m+ValfEJwmEuAEBkxMhBtUuitwI/w8sjO9gub/Y/qrpB7fMqS12zmuGuVK
 DJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745604374; x=1746209174;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udh7WQisxb76qYjtANbysaZCZCcCybHWMLZqzW5NUac=;
 b=r6ti31Pakdzs72jAZ5D+vry+Vmlio3PldRwtsr+cKbvzoF9LNNYF3Bmkn9f6fri/QA
 AOz7dLtg3PJtURoxSkyxTVkgmsDYn3/QKmrDR3M5alZUobbQStGQG3i0P8DL37jTeZiw
 OMmo5cpq+sIyz6Mrt34e8jE4kNVrzZQrmXS/jE/Y/tMCiBCzSv3zqvoiyVFBvI4IefQQ
 ktH9xfoYiqqMa5PeZCZDVGmP/iXVHlbnsqUpk9nh0pwAr/iTlIIRlyFJpLfY5wsMLTc3
 W2nC4ttMHRQa//eG/mj1gCa9BqXij44WD/GRSPKTHiwVtld2ZM4izH5L7wR8942rKWaA
 aULA==
X-Gm-Message-State: AOJu0Yxliy4lu08g8Y0qI6uZDADKYrv6YQwF5+4hAQCtZHUq3LIvrlkT
 ehIxZRR30rIj5U2JbroPsGzvHG0YisUGSc7CwlXuNNX7Qnuj4ISABtmt34Rb4NqTf39B+zEd7KA
 q
X-Gm-Gg: ASbGncsm/J3QdZdYJRMIenTJdVZ96rUMUDkC5sLixZ2Ndwt6qKwjNTI7zCLnfq4Sg7j
 sDtOrW1yDF/EZFCs0NEe9FScyR6UKwKpxCVslGdYbkM5C200vmji0zU059n0gL5mSsw+R7g1L4K
 CEuBBuH0806wi/gZjDYcbw6ewLRZZXQDiRpfaCQsh0ibmC3JCF6pnONkEmVtvIR3A9WzBQTDvE0
 qGCzXkGid0c3EgLAXV4aAfVtC73TzVbx4CSWVT2tWrXF4gSzQzDMEldWZ0LhXyESlCStLNmVgis
 5KVkukJEEFnNp9ZOtZJblssyMBEvrw==
X-Google-Smtp-Source: AGHT+IHSF6L+D4IJUv6P1hIyqeDf+mj5ZmdA3y7o2AlCa1HgzWkug50B25ldjREu08ZQxKt42F6/GQ==
X-Received: by 2002:a5d:5f4d:0:b0:391:1222:b444 with SMTP id
 ffacd0b85a97d-3a07aa666fdmr246723f8f.20.1745604373742; 
 Fri, 25 Apr 2025 11:06:13 -0700 (PDT)
Received: from localhost ([179.228.213.210])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22db4d77ab1sm35620485ad.23.2025.04.25.11.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 11:06:13 -0700 (PDT)
Date: Fri, 25 Apr 2025 15:06:01 -0300
MIME-Version: 1.0
Message-Id: <20250425-conversions-mknod-v4-1-222e0d2e7ef1@suse.com>
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
In-Reply-To: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1317; i=rbm@suse.com;
 h=from:subject:message-id; bh=twnhIB7eH/7VIf0ZM2yDntmIXI8tRqpOsH1ZMc3AuQc=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoC88NtE6lgtsCVNbDmktdG4s9tqvVN/DsJPREZ
 bYTFWMI2yqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaAvPDQAKCRDJC4p8Y4ZY
 pubND/9IgPvVz+q5k0w4Z7SZNaTh/DKngban2MxJMN25sROmkK/oayappEdH2oPBr0soJdWxrlY
 0w5hUqTkGw39jkdz8GEeZTDyR1LcCfcOgbFxzTyZkKu1aP8b3NEwNznGWtdpGavpW0XpqzwfV6J
 9J+fkBMQoEJkwBovaRc2WXLUtEoWL3DqlP0/TwLQuTQlTN9NlBQ1jtnORYAIOYuF0fVIx5HEUi3
 al8Q/njeAQ5fzFnjVsse936tLhN3sawQfQqU0afXQfEk8XJBShN4/3tcUNwIAqETl2+CD7MpqFV
 52bmtaVPW0AZOHOPUsG9rr+iYtHzJ5ml9WhSCm9zGim0ZcTxpfAJJK6zPuykO5oqY4S9ON6RkWj
 gB+mrUO4LSp6cAxUwSt0nTWw5sL3mUFXnlsVbgOio/3YSwiAJMDvkSWKB/isF1tw0IQ2MSTXNeV
 B4m36U0z/X/CFoZnCTt4C6JPPH/LDANhAw9jcHwBSFSuysQoIL03ZRBH4re4yNBsV1Ff14JQddi
 i2VJiCNiqYEJtF+eaioWDeG5HDCglHFMXcUFRNX8ld59pS2qdYfIUamM0jLENl3VrdMKri7Ler7
 /pMxCojUxyw0AITJ0qLSTs8BP+qvc1Sx6mDZHtZX2BNlJ64BMmVsZ6EibtqcQGgyG553dH54/aD
 FhSwIJynQp0MTog==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/8] syscalls/mknod01: Fix checkpatch.pl warnings
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
UGxlYXNlIGRvbid0IHVzZSBtdWx0aXBsZSBibGFuayBsaW5lcwoKQWxzbywgZml4IDMyYiBjb21w
YXQgbW9kZSB3YXJuaW5nOgoKbWtub2QwMS5jOjM3OjIyOiB3YXJuaW5nOiBmb3JtYXQg4oCYJWxk
4oCZIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSDigJhsb25nIGludOKAmSwKYnV0IGFyZ3VtZW50
IDYgaGFzIHR5cGUg4oCYZGV2X3TigJkKClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnD
qHJlIDxyYm1Ac3VzZS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9t
a25vZDAxLmMgfCA3ICsrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25v
ZC9ta25vZDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDEuYwpp
bmRleCBmZTBhMWNmYTZhNDczZjljMmIyYTU1NDkzZjgzMGYxM2I4NjU2MGE4Li4wZjBjMTdhNWZk
MTU3ZTU4MzU5YTU4NmJlMmUyNjhlNDJmYTBlYjBiIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL21rbm9kL21rbm9kMDEuYwpAQCAtMTAsNiArMTAsOCBAQAogICogdmFyaW91cyBtb2Rlcy4K
ICAqLwogCisjaW5jbHVkZSA8aW50dHlwZXMuaD4KKyNpbmNsdWRlIDxzdGRpbnQuaD4KICNpbmNs
dWRlIDxzeXMvc3lzbWFjcm9zLmg+CiAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKIApAQCAtMjYsNyAr
MjgsNiBAQCBzdGF0aWMgaW50IHRjYXNlc1tdID0gewogCVNfSUZSRUcgfCAwNjcwMCwKIH07CiAK
LQogc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBpKQogewogCWRldl90IGRldiA9IDA7CkBA
IC0zNSw4ICszNiw4IEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgaSkKIAkJZGV2ID0g
bWFrZWRldigxLCAzKTsKIAogCVRTVF9FWFBfUEFTUyhta25vZChQQVRILCB0Y2FzZXNbaV0sIGRl
diksCi0JCQkJIm1rbm9kKFBBVEgsICVvLCAlbGQpIiwKLQkJCQl0Y2FzZXNbaV0sIGRldik7CisJ
CSAgICAgIm1rbm9kKFBBVEgsICVvLCAlIiBQUkl1TUFYICIpIiwKKwkJICAgICB0Y2FzZXNbaV0s
ICh1aW50bWF4X3QpZGV2KTsKIAlTQUZFX1VOTElOSyhQQVRIKTsKIH0KIAoKLS0gCjIuNDkuMAoK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
