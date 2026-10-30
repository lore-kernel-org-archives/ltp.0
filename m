Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B97606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0psCyuDP
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1495C3E5E97
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 07:31:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AE183E5E8C
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 07:31:35 +0100 (CET)
Received: from mail-dl2-x03.google.com (mail-dl2-x03.google.com
 [IPv6:2607:f8b0:4864:38::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 887BE600A0C
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 07:31:35 +0100 (CET)
Received: by mail-dl2-x03.google.com with SMTP id
 a92af1059eb24-1521c45a248so324675c88.0
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793341894; x=1793946694; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5rrwVVaAyxPbmfNKSsBlW7G+BI3FjsP9p+W4afGP1W4=;
 b=0psCyuDP9A55R/gtyeBRT2w15Kdt21xU21yEtjrXgjokccilJCOIK6xLtKu6Eb/fX5
 GMB0fO9ZxRBiLuCoYCKbLLABi9feRbwMVXmCPYHWwp35WJwheKXFcJzsV6WyaYxdMeww
 /QZPvwxW+gU17vb4dMG4nXkJG0feZDaewria3aT+UoTCuFhxdrPMNvx8gaGnj6RTfMdy
 kHcFngoA+vjR5s2agjza+Z5r5wKsjW6PfD3FPAbK6KUH5QMa7sZL8GrdQWcbrl2LWos9
 UZbfGGsz2OiQbt+MtQEOKuRDdV2M7rhUEOaBnt5mZ8TPYli3EtDPPbNB54fA8tIoeEgz
 dKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793341894; x=1793946694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5rrwVVaAyxPbmfNKSsBlW7G+BI3FjsP9p+W4afGP1W4=;
 b=oOaD6r1Oh1RPFbvmtfWde5rqF2EW+VX7w4NoGGQIOeDtD/l6GVeetBz3p1gSvRB16L
 XlCCfqEzZ3pp0OpDMtq5/jc7YzgpFGSR+VVXhwNGbG3fmuJPhSpxaPdrg6n677k8Wj6z
 GY8PmEAe1d8MiCKkV9Fh14K8oxmgSSuTd52O4HhyXoQyN2dbA+hHlCFxdDgtRf74UOGB
 moVnxloq2SugsI7lu/zEd1FS6vhFz2Srwi92+P+Ew1ywD/6DvWXfEgnKwcPIaU/MVwW9
 KQPIT9HTp1cJTKuu7JYAz6lLS4dMWYOHK2nXmEsGQGw1LcutD3h6G00pxhrsFa4aPQbw
 H+ig==
X-Gm-Message-State: AFq9FYJkePc+8/3IEakZB1yrGIBgZGjaaX69lle/3ly3TrfSrmjUPM3q
 nQ4kncBn7XsK/Trtu7U2q1Pbv9p/Rf+DbvwC99saAIhdE8kHscoOCLWh2RldSnlPqd0=
X-Gm-Gg: AYBFou1SjYNQSlUOV8ee2WVdgOPJ96rDqlcdqCFLgR/VUlNossaObc6a6mv5ecJwati
 7vFrmoY/sY5W1IvPha2ineMFZtKAhnAZnOTkTu1BQBdB4aAxUd76BeHC6g+RFMzHIRjJ4oPQAWV
 +cZzJ1JENt11blmhEm1eRc5JHTLrZUJ40nRQ/sOUhg+0uTOkA/UIzOONQmBZvSKyAOevPuuK8M9
 YuzOi8rMdLsWFnzudjSmG5o4tbj7HtaTXLF+j1sWtXuiXeO0p/EtQxAbGptoQfnBd6v09SNFR9m
 NTwOSduEGFX9sMW5dLEo8mT3eD0cLYC74NRlhWX4teU2Gdgu61Qu0BgOoTnlZTkcmyjOQj2FMSb
 0bqZ2eFdl4RTdR1ARNQtA59AvUub6E2ACBZ4BKBkm4lbPQ6wBDczqZ23Tw5PksCRUuxgpFLPYv1
 py53JndAfUQGlr6Iy7fLr7N0HXwdqgHS6YAlJ0kFJf7Kwal1Dcn56XLRAP54rkDi72p8WKuL44f
 jsurJkgWCZ/wYbFpbZ/sUipdVAkrXEs04CwL+53cuG3vTHE9H6U7XboETg5JWUzPLchwXEhDQ1L
 fUAK+YL41Cejlm08YHz3V3zTd673ESZBxrskF9uNOx3nYUzZQdt3MQI5ne4AnKtm91nqk8AITdK
 r2pHfWJh32lqFV+8DPhy9Y47ZjvUvN7Mm1eOGQMvhMiI=
X-Received: by 2002:a05:7022:1181:b0:154:e9d2:d741 with SMTP id
 a92af1059eb24-1ac5bbb4870mr1798495c88.8.1793341893631; 
 Thu, 29 Oct 2026 23:31:33 -0700 (PDT)
Received: from
 runnervmnwato.wk1ev0ecf2nu1o2megafru0dtg.phxx.internal.cloudapp.net
 ([20.169.53.182]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac13ef1d4dsm4105890c88.3.2026.10.29.23.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 23:31:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Fri, 30 Oct 2026 06:31:32 +0000
Message-ID: <20261030063132.4993-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030005718.3343899-1-cyyang772@andestech.com>
References: <20261030005718.3343899-1-cyyang772@andestech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_submit: Use TST_PTR_TO_UINT() for aio_buf
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Victor,

On Fri Oct 30 08:57:18 2026 +0800, Victor Cheng-Yen Yang wrote:
> io_submit: Use TST_PTR_TO_UINT() for aio_buf

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
