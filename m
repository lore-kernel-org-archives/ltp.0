Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD973CA5FE4
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 04:31:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E8A93E1775
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 06:31:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C72863C2C00
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 06:30:48 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 446E320075F
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 06:30:48 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 d9443c01a7336-2e497ed2ccbso3963375ad.1
 for <ltp@lists.linux.it>; Sat, 03 Oct 2026 21:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791088246; x=1791693046; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=My8iKZJD97Aj5VpyzxXzKdr9PrrQUzgOQPNIALUdEr4=;
 b=Jiy/Nq2GfUQviThaV4j18dPgNTif+Xqnwj5oK/vM/mKah0NldFhcaSr0a1hRHA897o
 f5L4LEbxe87VFQ/ZHwwU+gbR3MVss9dINJDyo05GJzZnuk3g2Elhd9+KUS8kDxI14M2D
 jM4cDMMpBoIpYzBt8rtrlN45AxRoKlSy77Ewa2tsBPFVAkZGV5mCDzKBNT6rNtaPogqT
 iiNUk7T3t5V5jouJpQ7aeZAXn1oEejcJQbPH38160Q3khVBqy+u2ae5pMIx3Pe/0qnFY
 DGhATeI9ImUb/oWgsXhXuhEt/LCsPmf5Fsdg+6ClLe3L7KcpnGuE3ziunl/CEEtiNYq8
 Rp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791088246; x=1791693046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=My8iKZJD97Aj5VpyzxXzKdr9PrrQUzgOQPNIALUdEr4=;
 b=xrH1FE4rAUhpEcM0eM5lq2UeuodQmWiUMXl8jgl1tGe1E1NZ8aDvcT6ATPFtPF7ZUG
 qiFndeL/taxAMBOWv5gLnY29s9Dm+NkZfWdTMdvaYEMKbApT32Sjra2Po5nj0Iw7YXWr
 Ntz5So4Dcovm/+eMs83EPEFHjCOT+iJlw1Qbyqix4NWcC2oNPB4WG260VxpyVg8GArTR
 sc5j2BhfpeKaZ2ijWwFuFwvCQd96M7yLt8C8yAtRfLGoj3j+LyTX6glQ8kKtcgPPjigM
 J0achLvlsKNpia2WqqJ969sqpKaA+atOY+Pc4aDAIgmkZVjhUaoWHrHqnYWnrISc8lnh
 achA==
X-Gm-Message-State: AFq9FYK4pSn33GD8GXhz7If+sDkyQkYiPDGd3nZ9xQVF3Cm/hMxRpOGu
 AUj5s9cXPplJFvCdPq7Go5Baks/Hsn0aM14FAl4F/j6O5jQY53frBsZv1rsRiHEb
X-Gm-Gg: AYBFou1GHKBan4+gpE2xp+PCCephvPi2zfOz9xhW1hOdyg5yQmJPLYj2r8qAtUEwCQm
 sZCwPkeL7g8G8gOEBGBV7CStNYbweDjN/skoLE98PcFbI3VuS1jolbk5mLYvxwxCykAaE2x+cAm
 as+xHvMpDFPR5QwuvUsici4h06hUoUoSTaW1An9ljLVuFFlTtHN7caAIWUqMusy71c1UNMBFKHG
 DVHIaNHu3PZAqcRcYLgh5y5lwYMsw3T60cMJcN+A1QV209vUO4Da7SUuVgbxYsVPzkj3MCCuAc2
 U0HrFOB2q76Rui69ci0UhMAWgGgulWqkKHaaYeo3xTF6Di3MSjX9VdAq9OjROXJYEO98/PUibDB
 +XG3eU+KBWe7wCvfKq0bmByg/PVw3pU8pXts9UFU4D3T877F0LhSndfEBTRxYozQbAOM2lAcQ0e
 AD3EGsEFfh/Vb7MJSgJr5iE3IwIkyMA+A9eE2ItogW8vGwVjVYeGkN95ijRLg3upcUE4pkQwE40
 zVotEJdSbVOq4vnyRCpKh/SDPdJlBCYqsWFi5S4zrmk+zUiZxVS8/MttE9Y/2gSSLItfBQ1G8L8
 cWMdIKcwOA==
X-Received: by 2002:a17:903:3d0e:b0:2d8:d4ce:7e40 with SMTP id
 d9443c01a7336-2e49b64e249mr64285205ad.21.1791088246479; 
 Sat, 03 Oct 2026 21:30:46 -0700 (PDT)
Received: from
 runnervm8df0l.iasvrx1ljzae3kc3rga3kj4eie.xx.internal.cloudapp.net
 ([4.155.71.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5378611a2sm8304915ad.20.2026.10.03.21.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 21:30:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Sun,  4 Oct 2026 04:30:44 +0000
Message-ID: <20261004043044.9013-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004015424.3821821-1-wakel@google.com>
References: <20261004015424.3821821-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_{set, get}attr: Call the syscalls via tst_syscall()
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

Hi Wake,

On October 4, 2026, Wake Liu wrote:
> sched_{set, get}attr: Call the syscalls via tst_syscall()

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
