Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C3BC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 17:07:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D34F63E5CC4
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 19:07:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D9253E270E
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 19:07:19 +0200 (CEST)
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6FF671A00CCA
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 19:07:19 +0200 (CEST)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-451c1431f18so283958fac.1
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783703238; x=1784308038; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7wLoMaNoB1U5fWLK5r2UXcwLVY2lXx8z2PqVtpvqXOU=;
 b=UoT/+plDP4f3QV/rROtLUuOFzQhkIHoeD/+hHPy/+U2DrU8IuBeMwkCc+FQt4AYxd6
 9NO6J5az1chDra5fDRBWluvTOHYo1aGv9upo/xj9Jy6X0clhcBXGgE4IrXhZCh1O5efN
 iJLp6iyEqhXFnO3jhtwo1NoMADk3gio5vT94d8x1ltj9lKGiE2+F8lKg0WhQthn1cD1M
 lkPWK3MbIiN+Zhq7JFW/iDA1h5qxcnb+2fCofTGNFCMOz1rMWXCoGcongsCESkW2JBYY
 rz5dLcuMn640oa588E+4M3tIHhFnEPvQvW3EicsVyRane1k3ZdufUmQQTCsAK1UeDfHt
 0gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783703238; x=1784308038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7wLoMaNoB1U5fWLK5r2UXcwLVY2lXx8z2PqVtpvqXOU=;
 b=GRWge3uLK1kPLg7NJLzuK2r0vlrha7QSPNAj4doRYhaZ2xeM+wDd+N63s3FKBwFhec
 Dlg3u5sbN+JecGvkclhl/7mYxWb4LNwGgW7MdK42fcpDwYLpacgXzwJ7AqB+jG2fPbfv
 Fp9IN1vEkBX1ZXoqHm0xkRVOWXaFjwcwsBVbmfLB6MovDnjE/vYY8SKGlJA3+Cek1U/N
 S8X6CJ7p98UXjBvJEOpXoxxN7JyAJfvSWLPz15dHLUmKLGPsC7+8HkANLAdBxvxD9LuK
 PW9xMNkPcCPUq07/2JFdc5KDT2Vo62a66VH1LIei86VaqbaPGY/dy2qovMUz2fhbStUS
 pe0g==
X-Gm-Message-State: AOJu0YzosXjMe611irk61fVDw++dZJS///u31fa0RT3+Vi35uOvX1hQ6
 40Jby1E0VobnRSWyV46NXMCsP8oeU4Br1umh65U3zZgMts8Qxiz1X+AftyBnaxILVpw=
X-Gm-Gg: AfdE7cm7Eh9NGQlhxnrqnVlv5yOYqTgcJCjsnfu9PiTka+jSRiiHDZiOq6aLMCItlyN
 PcX1OFiDhaHAItCMRxu/Lrr1Ph6AZSOLy5sOM7H+CQRtXlOS0uZxCHn5o+RtYoHEODjEAFtbPZu
 ugClU8bMdc2xBFgmvKIFHgh1bW51rgt/QCk+F8Tapq1ngPGgnFIKeEK49YjwJJT7ouyEFkGDtbJ
 V4eFZN2ZlS1jrbxeWT45ZZoKMl2eU/3c4JFCN9SF0BNtId4n7dO25uXyj5/3gPjyk0DKYHo3F/k
 +gOJzZzHgWM554xtX9SOwEj9jd/0wWeic+ebBqcv9wUFbaiPLRgjnQW0Q+MOLpcp/51omGc1fn3
 cDcPD2rMWXwNLBqPQHv7ciYCXHrCcOekDgmCLz6/LDuWNujiBeCemVUFgdL7YFeDPbAeHU6yUSH
 nf1Uja6GNUUBl5YVncuPZlolbmTFjg4/u1eYKiMZbeS8HjKCdVXVDlWEpTsECudImkPmr2u7A+1
 QanhANE4r+XPEscRN071ufs7P1fi6guVDSwRw==
X-Received: by 2002:a05:620a:4613:b0:92e:675e:8ef0 with SMTP id
 af79cd13be357-92ecf8d2becmr1360017785a.68.1783702820892; 
 Fri, 10 Jul 2026 10:00:20 -0700 (PDT)
Received: from
 runnervm5mmn9.eryogxzmxa1u1oo0v2c1amj0ie.cx.internal.cloudapp.net
 ([20.161.60.20]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5cf78a5sm248528885a.31.2026.07.10.10.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 10:00:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Fri, 10 Jul 2026 17:00:19 +0000
Message-ID: <20260710170019.4022-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710143155.588390-1-sbertram@redhat.com>
References: <20260710143155.588390-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pipe13: Scale child reap window with LTP_TIMEOUT_MUL
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

Hi Stephen,

On Fri, 10 Jul 2026 10:31:19 -0400, Stephen Bertram wrote:
> pipe13: Scale child reap window with LTP_TIMEOUT_MUL

> The post-close wait used a fixed 1000000 us cap on exponential backoff
> (~524 ms total).

The total accumulated sleep time is 1+2+4+...+524288 = 1048575 us,
which is approximately 1048 ms (~1 second), not 524 ms.

524288 us (~524 ms) is the maximum value of a single usleep() call
within the loop -- not the total.

> on a debug kernel, about 1 to 2 times when iterated 5 times.
> With the addition of the function, under the same conditions,
> it has not failed in 100 iterations.

"paralell" -> "parallel".

Verdict - Needs revision

Pre-existing: pipe13.c carries an old-style "Test Description:" comment
block instead of the /*\ ... */ RST doc-comment format now required by
LTP conventions. Not introduced by this patch, but worth fixing in a
follow-up.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
