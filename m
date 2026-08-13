Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0267C5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:48:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6815D3E264D
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 13:48:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BDFE3D9E8C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:48:06 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DF2ED10007B8
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:48:05 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-38fd9408220so255778a91.1
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786621684; x=1787226484; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uMd0DiXVXQpe65ryGttI8iS9G02R6sswUwACEekSuuY=;
 b=Y6KzQ/wxVl8LC4faZJyG0AA/ncuF0K+a8jvzJS0TdjPKGVgahg5tW2FieZYoiByw+p
 r+h0jRYJ0ALYp8Y0ZHU8LibVkmHxe8LdaC/rITSq2AsqRYfimGG/bqAxcbteszvnB7kr
 WCnQJfYbOSbhJ3j6qWkZ1T67T+hXliBojmnLiNgkl7kM3dcjcJZef4V58Mkia1B5Q7DG
 QAILpjcsDeqbSgWGbQiXUnN/N76vjZfdRzr1X59RClIwo+1nmFb3q5UHNerhak/H8Jf2
 OBd8qQ9hX7oIVQSnhSc33O1PAQZ2XExWXRt0eIjlSdfRPtTSQWTZzJx1MIrBeLBAnZYJ
 rMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786621684; x=1787226484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uMd0DiXVXQpe65ryGttI8iS9G02R6sswUwACEekSuuY=;
 b=RbcqSy+KCUIzyNlpcmVRsKs0CWuXLwu+Llcs5C6EF4fABjRN24OLgDD1zRy4gTHxdk
 ETB/+J+pFykCnvAXo49kzy1TfF+SCtiuPhBqmzzbtJlo/pRMaaU+gjWiEKy/DYBjPiMF
 CybTZgbCozAl4Tw62v1Q6Mxx95x5iE64YFoOGQmecS1jfp8Gi1Xr+88UsRwWJ7cRFlbk
 Blq9cg10Owjm8PdC3ma+j4klXJ5MrqPAhiLxKP+q3Nf8ZMQV8w4EgIBG0JFt11HmrhjM
 Wr+qbTnLB8YPbedacfo4Xi0LnvnRaA79W4MXYrTxu5xKi3b/cVzKhXNqL9KjsyOBo8iU
 SPDQ==
X-Gm-Message-State: AOJu0YytHdQcTAtjd3+WR+Zs9SjSs4W8qUthIti5uPE6WpSe1qD8Eim9
 ORLREgroDA7HUwQHghDU7SPNBy7BDW6m1ycBdvZ0A09UYU73kDoMuLUz
X-Gm-Gg: AR+sD13Exf1AiUqr8S2R609Gg77TWy/t+3tLvUJuYgP1uSiQWs4ysS9Jw/+s2AtzO0b
 Q6AKzAVuZh0rff/aBPd180jVznl5USHbFQHil+PVjfKZ3XH4uLZKt1TvcLZ9g78WT+KbNea5G4M
 wPBA+7qIqDFTVl7hFSiNNKZLZJFiTXYEWGX/H3C0wzh8UD911Y7FLlKs36yPBfi1Z5tKd4x8Bvo
 ZQKnXC/inu6HDD2KWjRM0NOdp4JexeNtmcoIH4LFKAqu9W2dAAG/Fr8Mqy07+kVx+U+becK376r
 EccXTs5Ti7ww8ptL8YTFCJUHIlmrqwkucdxmH3BzETzapteLY4VQm6RRTuVzh/9X9pCDsSW6DcQ
 YVZ1SZpkjwAhA6bWQu0jnLY0HytFvbrsVstcQ4SLOqn3HeeP3nK2fPknCns4dvhJp1Odw0aEEBL
 uZ2smP/HAcBeI23wWwcvOXOvoQE0J5u5P+IvpdLy0Sor88JsBYDcycwwfv62d0puKmT/0Vr5Iqt
 D7+7wJDTaBVQMT0to/jmjHCJDqLvCCVvp7gqYLBnZVPtqQLItYNUZwGh232Oz7wC/jF4YGm6tDM
 0A==
X-Received: by 2002:a05:6a21:7111:b0:3c3:af85:85e7 with SMTP id
 adf61e73a8af0-3cc55423424mr7196383637.34.1786621683971; 
 Thu, 13 Aug 2026 04:48:03 -0700 (PDT)
Received: from
 runnervmvrwv9.sn4w2sm1cbqubdurwn4beskzfa.phxx.internal.cloudapp.net
 ([20.169.74.21]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebc760524sm7681603eec.1.2026.08.13.04.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:48:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 13 Aug 2026 11:48:02 +0000
Message-ID: <20260813114802.4043-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813112524.1849695-1-pvorel@suse.cz>
References: <20260813112524.1849695-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_setup.sh: Use tst_umount()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On August 13, 2026, Petr Vorel wrote:
> ima_setup.sh: Use tst_umount()

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
