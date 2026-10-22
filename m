Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBEA606A321
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=apW8YJPZ
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EAE13D23BE
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 15:38:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC3B23CFE58
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:38:14 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4DD5D1000DC8
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 15:38:14 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-3adc0ac3566so1981a91.1
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676293; x=1793281093; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=paJ3caAiuYfPouGfR9+/2gVpllDxGyiIa+CL78WLvmk=;
 b=apW8YJPZj3/HZugeZ3rjAaoR94iW9Ye2lpR8EIUrEV8GQUVAMYfpk0b8hnMAvaJUxy
 wvmyTiBsos5XBnm/KT8cSJg6m1m0BOMweaJbm5a8QD+AvS6IitgZQabwcAqkvOjDurxZ
 mAPbOtTYc98hawbtxXRlDm/ccrW3IHBcZWCROxmN0r0F72O/Cd+nhovoIBseJ9KQqXlH
 6Ot/vKHUQ9RohMKbFUNQ1BMGa5sEBBz2nGxVLbN8gbhciUUUV+wcZV/ByLbilO64Zlsk
 HUYHnGej4iweBFUmiBPIckEI9gaxhT901ZDME6yOxhcE5TvwZFhMjCXCeh3T6Nw6ZGPY
 XW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676293; x=1793281093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=paJ3caAiuYfPouGfR9+/2gVpllDxGyiIa+CL78WLvmk=;
 b=QCnrPI+UDx3VdE0hzODMwg2yhbN5jrzSLTkygWkJ0pLCQ+JcHJhMxXIiyNNroWU3Ey
 CFpIGa1uEwYFgqIQg963ecWa9T2kL2Mt1bRwkp1BQgRdno1uYGHvSIUYwE1BSfytwhqh
 akWGV+Ryj+qF5DjlnXqWy85j++NHE8V+SCjU0bJK0MYvWkDtumVaNpkEsEarY+N3VG2u
 AaMkZo2BWZFMI++bfeW1wOIO5d6LA0I47qxusvd/2a3seck5gJ90HaIf1i4q0Y6wUXVB
 GA28bX9Bqu1rzkEuT+uClWN7uePBn+9hjq11arAjlD/MdIRxhaptHX7TzmH2IXJgu5zo
 2V0w==
X-Gm-Message-State: AFq9FYLdNFKTSlNOXQPaqPN9qrFpPjoO/1QtMBode+rK2lxNj5KKwDFv
 XqwqYFZYPvH4DJpS6z4/eGSQ+Ijppe7vc1dJJ1z6LND3Cx/2U6zxZBWV
X-Gm-Gg: AYBFou1YSAO4rgOw1mlkbTBiiF5yg1YjT0S0GgV5wrvUFDyH3prbBtvg11cBkfq0pqy
 dEv7ag+KNV5++PoCKA05Ivsk9QTpgv7TWA1Odb/7YlmwkhX8b58GaxF4KYwYVoZcaCobOXg0r5A
 YOPcqxnKt1iDHXCRPN6R1QeCWRuoWUW4PJrjkasZxm+QjNDGHzfgA8niqyQ7d9AZzXLcypnAK3l
 8E9wG3Bv9CYWrRzTVZ2slNoDaPmbfsbhAefoZ6jGshHLFbA2wwEmunlROphpWMbshspu3QiSyrx
 Adc4aRNZScZpf+uNt/sPR5BPNY7iVmC5SscoPg0fFp84XTCB4prUOGF1c2/PBRpjTrRpirYLLhx
 /LJEorsCMuVKPDR+sOtGAa022rmost0I0eOpVzQpcfqpFx8YDqc/uZWuSBMXpn6dUl/cXOjJF1L
 gZ0nVs0ynXSjZlHpW1EmQvqN1oNQ94rRbM7jstj8tT8jzfZOIG/xV1MZL+naL0+KofH4l+rvL1N
 nb4IG3aBdvs/uo4yQKSQ7jPLAxWKjZex3reP0dHZBCWaEJBFijPp3wv9dgJB6Xn06JPCQKqjNHQ
 aZmcwO468KAzLDSPg4Z2NK1rTDHB5c9sh+J2Mzqs3xlpVJm//wnqx2smzBfXX32QdfDo8IkiVo8
 dTZq9ttHY398Z7A==
X-Received: by 2002:a17:90b:514d:b0:3ac:a521:960 with SMTP id
 98e67ed59e1d1-3ad86b0c6famr4391418a91.1.1792676292596; 
 Thu, 22 Oct 2026 06:38:12 -0700 (PDT)
Received: from
 runnervm8k3b6.kqwjbbvdnqqefdcj3x0m33zbne.xx.internal.cloudapp.net
 ([4.154.117.243]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada49366fdsm4321635a91.14.2026.10.22.06.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:38:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wenqiang Zhao <berringtoni36@gmail.com>
Date: Thu, 22 Oct 2026 13:38:11 +0000
Message-ID: <20261022133811.9500-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019-research-select-time64-rk3576-v1-1-a65d6b72e21f@gmail.com>
References: <20261019-research-select-time64-rk3576-v1-1-a65d6b72e21f@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/select: use kernel timeval for _newselect
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

Hi Wenqiang,

On Mon, 19 Oct 2026, Wenqiang Zhao wrote:
> syscalls/select: use kernel timeval for _newselect

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
