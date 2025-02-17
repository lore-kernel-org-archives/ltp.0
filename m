Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC26C021AA
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:00:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 400AA3C9CDC
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:00:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C58B63C9BD0
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:00:16 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5A0662814DD
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 13:59:46 +0100 (CET)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fa7465baceso8789433a91.0
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 04:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797184; x=1740401984;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:dkim-signature:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k5rwua4nMFPsnNegoIaPoOYQr6Q1teHHBxdWb6cs/rA=;
 b=W9fWgsCYvCyOighKbDb9CsPz5SkajdTeTG0vv8l7kDYlwvlIjIVxHPtAtjc8y3v8b+
 y+DkQBEBC1p9clL0piWuZMeDchyFHGZlEwFCu48S20eXTIp5RU3FQ7qPzPFqq2H7EFhO
 u5G7RgCQ+MpGOVQGHSZIxuzUmEl9JjTxpVbQHBFmsy4cVoVjB+L8QizkKBQ6mgutSwVP
 3G5sUeswQvgy2TRafFOWL1OZqVAqYzg6WFgoDC4uCZymLPbT5wva2NdV92dSIRSNlH3G
 aNTGfk0yPQDkVDo0MWUjMFxqRwYyPPfp2h6ePzjuio6kxFc/9YhTFv29C+YSSxyG0d6D
 SrMg==
X-Gm-Message-State: AOJu0YwfYAplCzdnj+4M/mZk+zl32R8IQ3f0RIAziQGMHGnKrqZsWqYW
 7903I1BXBqc6eC5PW+V+5sj5tym/wBdnqUMV/ZlmX4AroEtuH8kfvOS5c/bK
X-Gm-Gg: ASbGnctUGua+EGQf7PGH2PPNCd55EyYPqmmiGzp3Ro9ha54t5qcG5jwAmlgr/VzZw5K
 CpqLFNx8Hw9gjtrlf+9S3sItslVghL+zmL7zMwOGpKdLUVya7VUidnkh+7QS4L+Vk4jyMHu+mxN
 LqRzJi6asEEvGvs1Kf6uVQW9OTR9p5cISDWMShjMY3l7vhloDLOIA1kC/qL5xffenkysgmbK9+i
 mlx3tEL2ItF8Y6jzS3jtpRZHdMEoIoKO/q5fHydBKmOL1kc4nBwyeSmPsyyjtDgIPoL69vXmchy
 D++JsKXLuHeMJB51UVr/kNX5ISmKHCsg
X-Google-Smtp-Source: AGHT+IGlilG2010pVhXqcgOSYGhRkFMdx/RGPDvAsVAx+HSGfV6C0ur4elOJjeurh/W6tY6Ca6TbCA==
X-Received: by 2002:a17:90b:3c04:b0:2fa:2252:f43c with SMTP id
 98e67ed59e1d1-2fc411509a1mr13297740a91.34.1739797184254; 
 Mon, 17 Feb 2025 04:59:44 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf9ab01bcsm10111441a91.45.2025.02.17.04.59.43
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 04:59:43 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
 s=2025; t=1739797182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5rwua4nMFPsnNegoIaPoOYQr6Q1teHHBxdWb6cs/rA=;
 b=dnPGzXoXA0J4DeP8ByB53P8v7XOWynWEWRCLA0ji8P/HB2DcJHUkXNAPco3PBvWJrKndoC
 JGQ5aLt9nepBV7A/lqPfhr9AvgXA+E/xH4Xwpna3Z/jPAnOmIOv236SDNfF8VAqgcIlbfq
 Gpmn7AlAfQyG5KujoKhs8srCGmSSEQ8fFy29j43CEmQAN81LPUAFF6p+oZqMlzDDW4CxSl
 +VnGabSsNK1pr6OrebqS5Yb5hJMm/S4oKiKd42HV8s16RsSyhRx/07u7E52wwZAPrgBpRN
 6OY0cuwzwoTETjtPZiQbQvbjao9Wt1HrI/xYRvnOTlumwG2wmQIjKoApu5QqRg==
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 17 Feb 2025 09:59:27 -0300
MIME-Version: 1.0
Message-Id: <20250217-clear_descriptions-v1-2-90e8229d52b4@marliere.net>
References: <20250217-clear_descriptions-v1-0-90e8229d52b4@marliere.net>
In-Reply-To: <20250217-clear_descriptions-v1-0-90e8229d52b4@marliere.net>
To: Linux Test Project <ltp@lists.linux.it>
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=VL5DkH/sechmF5WBpyHyycad/ctqlUD9obmq/iJUvFw=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnszK1x6AdKbaRj5bnG2Njwr2gPjQTgyWnBOP+9
 4i9GUeb92iJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ7MytQAKCRDJC4p8Y4ZY
 pkySD/9NLeCt/q6o3Uzhj+EVu7YabSkb5UCzW7iLrPF2UCP/MeOBIICBEuWaF3MTXR72IqXyrGG
 pbEDqBVt7tvb7Vj7fHW9Lim3lD67QPjZqdUwx9cTt4zUdrZ2Nn32yqP7gpetoHdeCIwCl8F6BY5
 je0NUk6ndurTHizizu8jRg+TaOUjOFuNfR4CAgOx5PcCQ0slXqnmIV1nkjlSCdFXBkp7Tqlmeam
 KE2wb7R8cBXwjpar4xy/DtwbcnZiKf/DciKqM2TRbgpeU4ABB8m6p7O+phkhf3Xzt13P8b8UgKU
 7+QPD9hFMddECePMddF5dcxwCUKZ8Ek5i+HtSqhDgWuzkUu2iwvvdbM81rqyHTlsoVFYZsNRxuX
 O/4Ek9nugmJ55bFCNWRni1uM++s/J3kqmj/AF2fkqDJup9ZJ3zy7utxkhN/+eEDNVfygVeqVQdi
 rh7pCnAHWFk+zAOfa4/Qf5hBPA6xjobIopOSuCUDTfLMvJ6zpPC3cBPsJQ4jV62pQSLmIVxrcEt
 cDf7kySoJwjRzPG15/8fFYwwFXOq1mcC0y6Uy/LRt3h7GwStmIfm5NShjuTt83D+8e9YZ2mTMcy
 qq9MbQOc5rXK70YOKybUpXLR8E1O9K1QWw8y/V2QjjlnfH8GHqUzdwfbkKDIRKiFdBWa+PQHMsp
 DhMREAFTMVzhhwQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/fork01: Improve test description
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QWRkIGEgcHJvcGVyIGRlc2NyaXB0aW9uIGluc3RlYWQgb2YgdXNpbmcgYnVsbGV0IHBvaW50cy4K
ClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyaWNhcmRvQG1hcmxpZXJlLm5l
dD4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazAxLmMgfCA0ICsrLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswMS5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmswMS5jCmluZGV4IGQ2ZjZiY2ZiN2JjNWFiMDI0YmNj
MDNkMjRjNTFjOTU4YzU4N2NhMWQuLmIwMzBjNzNhMDE4Y2E5MDU3MDA5M2Q5NTcyYjI2ZjU1ZTBl
MGU4NDIgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMDEu
YworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazAxLmMKQEAgLTYsOCAr
Niw4IEBACiAgKi8KIAogLypcCi0gKiAtIGZvcmsgcmV0dXJucyB3aXRob3V0IGVycm9yCi0gKiAt
IGZvcmsgcmV0dXJucyB0aGUgcGlkIG9mIHRoZSBjaGlsZAorICogVGhpcyB0ZXN0IHZlcmlmaWVz
IHRoYXQgZm9yayByZXR1cm5zIHdpdGhvdXQgZXJyb3IgYW5kIHRoYXQgaXQgcmV0dXJucyB0aGUK
KyAqIHBpZCBvZiB0aGUgY2hpbGQuCiAgKi8KIAogI2luY2x1ZGUgPGVycm5vLmg+CgotLSAKMi40
OC4xCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
