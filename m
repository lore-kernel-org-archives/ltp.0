Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BAAC5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 12:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749127992; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7e4nDKcnBToq/m5BSYZesJLJ4IbIlhOHhuqIfsuS2t4=;
 b=M5S7wkNolwITq/yyO1/wVIsRwkm09vLnPfZlN8kGKjpi3vpxIMkSC5Ak2eB7IWumZMFNS
 A63RF6I2geZaS8t+Lw8abMZgksFJgNMs7dZS7h7IlbPfjHRSZWo2d3yYulE5QnwXCMIo4vu
 +Mo0k6KM9QPjWO3Mh9xBW61UfUw+RDU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC7783CA3DB
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 14:53:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7441B3CA30B
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:52:27 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF0E714010DE
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:52:26 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so4911575e9.0
 for <ltp@lists.linux.it>; Thu, 05 Jun 2025 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749127946; x=1749732746; darn=lists.linux.it;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LV8nTtPTA00v2Eq/bzh4RFqitQfCMvXKWap+1W3btks=;
 b=KMN/Zcxxvg4HOA6lVN0wirAf3kzvAqbjnYOrpzbZs+8Gfm5ZI0lwJgfxPwN7BZaxL6
 VChhaVhFgIUUH0dCUjWokMzNVGNValBpa9QIknoJjpVxUvNS9P6ENNjvgSLx+MMopDMh
 8pfLL1cevNphGsWV38RI838hMe5ji2m2dxkEK6oQ11Nvk/Tpw1m4FHgRG/ApxUT1IMk/
 BMR8YJy0rn+A6wtujYmQ943+8x/1Gbc7O/7YoysSl/OSUmVHoS9iPpexBZntd2NLm9FT
 RFgfdedPxNy2oFDcPuViY2ETcY5n1hvzSQIVgZaAvZ2qRqjIOx5GZHBOxTBP+cM46oNQ
 k1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749127946; x=1749732746;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LV8nTtPTA00v2Eq/bzh4RFqitQfCMvXKWap+1W3btks=;
 b=Tmr+6txAjELUVK65lw1riJkD4oeTBSEx6sHdepdR91+bA5DlHYF8Gvz0wDr/6yKlkA
 feUaRJHwSLU5BsNhxLD5J2pCOQT88/ipAvuHqhhVRl1+E+iFv/PUWXNPQiGGTGTdhjpF
 wmVd1S4EQsM05VP7e1CIYBVlKKS2CcYBz8JuEKp/2LEO0kZBjP3Gva3EENaWB8999OU+
 dhnFAIsliOXlkGWkQMM+1bm7avtt8GAtWZGngPIYEsllZZ/9RAS5ikA6XnwUaxncXAxv
 CszVPPOZ64g27gpUI+TTBXEOA8MTxxoeWZSJeh2sevehkSmBdgymByBLJE2UWFXuz7BC
 /Uzw==
X-Gm-Message-State: AOJu0YwYMEPOQjum5P2BGKTTApnCQsjC6UtCXZ7B9Jn9Qz81rqi2dtqn
 tX6CDf6/WKkAkEQjLTH8VRvzsLjbWWwCdnXhYej85AmUTUF395sPKb3pWmMo+398+T4=
X-Gm-Gg: ASbGncuTflug62J6STZzGvfUD53Rz6XgqB/6gDmgwFG19BZGHFtMXZajiAMclRJ/7KC
 ohu2tDVgN/uRVHGrLlRZP8oBZ42iMawC9W0qGJMYc+IzjCSR1gvpMUn9FK+yfZCx49DVyrGWLqB
 XSV+JN/Rsbsijy1pWPsHMAtGg1O3CkRpsa+gR/RwWiRyAG02YDLCcmDtydXmQ7Kg554MqyoE1zu
 /uF53iLK0S/EWEecDtpXfqFpFnxHrYHmL9Mmia9rmMyI8DcgO7FaddNVlyQDTSXiwwi5VcaGsgB
 NY8TXfUkr5E8MgPV3yyGlTJQXE8dr+e9H/EPpBY=
X-Google-Smtp-Source: AGHT+IEp5vAuUUjhVbb5KVYofDUTro7K19VaKNzeTSd8hwvzhmg28yRLaiymbsK5YvI2whZzZBNoHA==
X-Received: by 2002:a05:6000:24c8:b0:3a4:e082:c8f4 with SMTP id
 ffacd0b85a97d-3a51d96e4f1mr5580497f8f.47.1749127946258; 
 Thu, 05 Jun 2025 05:52:26 -0700 (PDT)
Received: from localhost ([189.99.237.136])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-87e2a3b67ddsm10512767241.29.2025.06.05.05.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 05:52:25 -0700 (PDT)
Date: Thu, 05 Jun 2025 09:52:17 -0300
MIME-Version: 1.0
Message-Id: <20250605-conversions-mknod-v5-1-0b5cff90c21c@suse.com>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
In-Reply-To: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=rbm@suse.com;
 h=from:subject:message-id; bh=MPZIwFbEW3Kh7O9ScINW+cFcchB/RB4tz+ACvKL3ua8=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoQZMCb6kqr6OkVTYRS2+KehvpXSp0t/CQyPaxI
 m28dyUtEiWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaEGTAgAKCRDJC4p8Y4ZY
 pj5aD/wIpWnruAgU+RLkwWXENwPi4AsNMaBzvJXRhRjcSDxmooMD746Lslv76Sd8yEu6niV/3VO
 oZaGbLlRKfZ+4eaYS7HV0mGlybWPalhN3jaFuqxBk6jvVN5bZSQ3i6N9JlvA7RFm5Lzz1CwDZ7K
 bk2NUoSDNRgh1/nbG/YxNsONOHcOedfX4IQ4aLSbiuZcOFLYwfJgBCpfBeeuTUYEcmKzgwwmRu/
 dNsYLyFga80B+F0+8ehzRece8ppfLXSStWliAAIO7JnvSilris8e5pQ18hEgidK1AKn8sCDczFg
 z82+lN01uZLt4yDy7Ls59+lEgay7JyaOD+P/SXNUaorsoEceF/ID10kiRwsjFCkUvdodq8nNS3d
 lNDy7YIfFxgvNQ4g9kXLCsgBq7ebj0ZHcf/jJZOnGgr/xukJAEvn6zsHaM0T8dlAJGXH1LATx4l
 iHMI81mHtMNUOe826+zYrvoseXaqjhkZqsSV1BM5KoN0yXfe6a8DGE/7OV146ChCE68dMN3qDEc
 ExFZwZLV9E+IQeNjfsegdVlOjnbPLwnvK1l3Mres6/08igdJWZBWXW89TRHWt1lIzyJtoo7Z5AK
 hj/btv0jSqbEewRO5PuL3KJjlgSbTa+s/CvYcjNNXPrr+T88u2EQcIRkmatX5uxGfKlkY+dii8n
 zMWvWKZUDJNq0hg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/8] syscalls/mknod01: Fix checkpatch.pl warnings
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
IDYgaGFzIHR5cGUg4oCYZGV2X3TigJkKClJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4KUmV2aWV3ZWQtYnk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9A
c3VzZS5jb20+ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5j
b20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25vZDAxLmMgfCA3ICsr
KystLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25vZDAxLmMgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9kMDEuYwppbmRleCBmZTBhMWNmYTZh
NDczZjljMmIyYTU1NDkzZjgzMGYxM2I4NjU2MGE4Li44MDFkMmVmMmEzMzk0NzkzYzdjYjRiYmU2
M2JjNGZlYTE1YmI0ZWMzIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21r
bm9kL21rbm9kMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21rbm9kL21rbm9k
MDEuYwpAQCAtMTAsNiArMTAsOCBAQAogICogdmFyaW91cyBtb2Rlcy4KICAqLwogCisjaW5jbHVk
ZSA8aW50dHlwZXMuaD4KKyNpbmNsdWRlIDxzdGRpbnQuaD4KICNpbmNsdWRlIDxzeXMvc3lzbWFj
cm9zLmg+CiAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKIApAQCAtMjYsNyArMjgsNiBAQCBzdGF0aWMg
aW50IHRjYXNlc1tdID0gewogCVNfSUZSRUcgfCAwNjcwMCwKIH07CiAKLQogc3RhdGljIHZvaWQg
cnVuKHVuc2lnbmVkIGludCBpKQogewogCWRldl90IGRldiA9IDA7CkBAIC0zNSw4ICszNiw4IEBA
IHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgaSkKIAkJZGV2ID0gbWFrZWRldigxLCAzKTsK
IAogCVRTVF9FWFBfUEFTUyhta25vZChQQVRILCB0Y2FzZXNbaV0sIGRldiksCi0JCQkJIm1rbm9k
KFBBVEgsICVvLCAlbGQpIiwKLQkJCQl0Y2FzZXNbaV0sIGRldik7CisJCSAgICAgIm1rbm9kKFBB
VEgsICVvLCAlanUpIiwKKwkJICAgICB0Y2FzZXNbaV0sICh1aW50bWF4X3QpZGV2KTsKIAlTQUZF
X1VOTElOSyhQQVRIKTsKIH0KIAoKLS0gCjIuNDkuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
