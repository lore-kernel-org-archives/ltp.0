Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C26606A31F
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tVLcS9ni
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 031673E98D1
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 20:58:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D5D93C01CB
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:58:24 +0100 (CET)
Received: from mail-dl2-x07.google.com (mail-dl2-x07.google.com
 [IPv6:2607:f8b0:4864:38::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CB97F600110
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:58:23 +0100 (CET)
Received: by mail-dl2-x07.google.com with SMTP id
 a92af1059eb24-13985f8229aso445508c88.1
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793303902; x=1793908702; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=47uzAUS+0qQvG1LHdxqO+d/8ShyiWDhY/yE+14LdNEY=;
 b=tVLcS9niOnOSScq+vKA5+qm376OD8DGPk+PUs4JOJQbXEt0pwaFXdLq7pzFsOp+XdX
 GUiUK/eYtIlltu8+/XyghvMwwQSCjQyZfKxMRb/cOFG7nDPCaTkUKbABmkFS8KaOMglZ
 jlY7vdZiSXGhwZbVar5ZrYy34kgAlp4m04nak3txWjl0/SsujLqlGpOOPvzygFQt7laA
 Kv0um3azJfmjrRuvh/XTDcBFiw/xm+ojAaUzOTSlVEljHnyoOJeUiimuN/2MuMJdtGjs
 xWrajR3+qAWsO02QuMtSQ1aU4CvfRMY+2mu3/To4O3wgERbxQakl8fI3LVdv9WAjDkTV
 mgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303902; x=1793908702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=47uzAUS+0qQvG1LHdxqO+d/8ShyiWDhY/yE+14LdNEY=;
 b=W2lw+J/tkQF9/H//vxyhDcG7k+dnbXowFmgBYYT2/26rcBm4N+YxkIFFDTxCsnoos4
 tnDgcoLGyFUBEK6Mk1+CR9sUJ2AD3rd7+c9iC+HBvkcSUyR0I61u5QnBl7XYd7cZeetd
 bW4A3fE4mjz4IPK44/2RU5HANQusfaDAVZq6QuqXkyeyzunZSo5L8TQ2Rt4w1o3VCyoo
 knlKBhvDHdlzcujtW7boHMCc/Wq+4Y4LkpmmX5SSGRazGFRB/Bd+Y33yVcyg/ucnZZJ7
 ucEjOQu+MyHuR/8HRLsNTBN2VtjcyO26GCzzss+GgG/l7TharIONJChxEeLb+b1cCeTq
 KpWQ==
X-Gm-Message-State: AFq9FYIuViDj7Qh+SkVbzGBnddhrrzwjRLkQ1R8LDVCkR3GxxFCnYpZK
 mwn5soESqKXrjBzC/eaf/yPO5w5aK3CeB+HgwDpCVns8j9jbQV4ofTPJ
X-Gm-Gg: AYBFou0xGAV194ru8dMoBw9zBN77fnv2xCfa/Io+vpSTtr7bIAaRVHoPv+eUx827l7i
 q4hM7azeQELR2AoLWg62wTcjIXbGC/u5kQrg5jtslJmSj+NKwgtsFc8QULWVl7/2ZJqbdfPqaF0
 xgsDbuHiAME2szXy5zjgk6Gv1nC+j7IUZ5UqQm9m5OPAC1wns4EjVxm7Tst84C7OeDgOeECy9RG
 0lPDFZdELV8q7dsW2pobYY3/GVoX09hSX5bHOThXKSMhRUmPcCh0bUJDSuvZvpZym20vkDyd4f0
 /uTOKaeDm4tYl0Zda2V63Q2iHRp2qasKz/NHrhQAyR0Z6kyqAHPzpK9MZjUXhiz4dUIe0ACxiAT
 XFH9DBd8Md5+2PVCKE8YLarL/xaN0hkk37zJwxH3B34dI9kfYEZQVG9o8FgukDabgibDdBQL7mO
 kHkZWObbjpUQP32ASCjK8Y6X5FIrp7y4B7vd40STVyB5dUJjVnhds45wuHLvTtbY8rWqfvmKDpD
 E4xMih7MmaToGyRD/BTHnO5wNU/wfqR1rO7L783lEL/R31oygHafc/EujQh53lWRGZ/vI1KPhag
 Kk0+0mEpvxzAah+SlLASSsrELIRuXzs1YZ5mnxh7WuRLzAMwh7lhFzjsKKFNrl8o/VWhUwfMESZ
 1y6tbl9eUwd+/NSX/36pJd4p79yiRlra9Lmvq6tC1
X-Received: by 2002:a05:7022:f517:b0:193:9aa3:4758 with SMTP id
 a92af1059eb24-1ac55968b07mr109547c88.4.1793303901866; 
 Thu, 29 Oct 2026 12:58:21 -0700 (PDT)
Received: from
 runnervmnwato.gpul2q2ne1je3mz5a1ebwezpna.yx.internal.cloudapp.net
 ([13.71.228.196]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429018casm739145eec.14.2026.10.29.12.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:58:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 19:58:19 +0000
Message-ID: <20261029195820.3869-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029174907.98721-1-dennylin0707@gmail.com>
References: <20261029174907.98721-1-dennylin0707@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] inotify13: check rename cookie pairing after adjacent
 moves
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

Hi Hungyu,

On Thu Oct 29 17:49:07 2026 +0000, Hungyu Lin <dennylin0707@gmail.com> wrote:
> inotify13: check rename cookie pairing after adjacent moves

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
