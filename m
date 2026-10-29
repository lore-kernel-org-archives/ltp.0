Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3299606A31A
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qoD+9CQ3
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 857BB3C01CB
	for <ltp@archiver.kernel.org>; Thu, 29 Oct 2026 20:58:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5566A3C74CC
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:57:58 +0100 (CET)
Received: from mail-oa2-x00.google.com (mail-oa2-x00.google.com
 [IPv6:2607:f8b0:4864:30::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F3CBE1000A0F
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 20:57:57 +0100 (CET)
Received: by mail-oa2-x00.google.com with SMTP id
 586e51a60fabf-4a86da07919so1087233fac.0
 for <ltp@lists.linux.it>; Thu, 29 Oct 2026 12:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793303876; x=1793908676; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dR446zzEFoQeGTato6/W/Lglyx6fooU0rtErODNXK9Q=;
 b=qoD+9CQ3ndLoK3oRjNVJD0UPmMJmdMcD3ZVotSwAnVCpM16Hv5Qcp8LYhwJrw3bsxM
 VXJNz2zXgt8LS9GAuGF52X7EO0mCNHSWan06L0EzCLEbXVjcTfg9x4Y0VRDZVp0SNFfP
 noGViKmhWVGWVG9GDJa2UPb/4YrYjRGqCdYdvsb6nZNdQj/rp0ji3Nq1wvh6hMRgxJ92
 vl5Ti81rxeQ/zWPfDNxPR4SP8eDTszvrmmt381O81crvs+dRwj8HQulFKiyu0fdGenUc
 pdVYw2NMDjqI195ZbW4ZAFGdP64HMS12n/obiEgGlq9YZB+VrWRZoHNtcayoCHvJr/+/
 fxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793303876; x=1793908676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dR446zzEFoQeGTato6/W/Lglyx6fooU0rtErODNXK9Q=;
 b=VZgT0OA8KNtGT/UkKTABGo64pINBV1PTls+8SJF7vpzs8cQeuZByPFwiI0IVci6Im8
 i9uwV5iG129Cj2q2bQ02BNI3TkyF0FiPxx8HGTZMasy0nEDXLH/SZ10qPoXncG36x/Vb
 VVbxg7836olGTGFHxCsNavAPGjIAe2JQRdATjrneOEgsCqDWQKOwdfZjVhrXHhwMXSmY
 usfwMNUbRg1qAai+JiL3y5MG9YX6wkxJWE56NoGIPt5M7aylbprXhFq5i2p/f8Ohoe26
 6bbIE76bBVmo3lCqwj5yOhORgHS/QTxr66Mt4pxygRgb5AOGOgVXlvNqCEgQ7ldPI4w7
 jHjg==
X-Gm-Message-State: AFq9FYJK96rs1aszXMQjvkd7wNoSsNldQfCu8cSEYVcph/pwxU+CHrC8
 T4czXVD8pxUeAx1/5aaXYTeZPOuaocOngfTYvtBGJHqiX3388ua700Ta
X-Gm-Gg: AYBFou0yMv9q3rmnHHFjKfBrOfYNqsdrndqzVRq9FMOO1jNvwOjtNgG/gqFGnneNmos
 zkb2QImsxCVtMa05WJzPf3210YqWA6stz06pBn9sJPijkv/UQR0xDJI8bf+8TFTB/012JErklyU
 gRsrEXbhv7yOIa4ykRMWf1V9IAxUyMtsplq6lC1xjykomT7fU1QL63vzJq/UBbKc4QkSrUAmLr2
 LL949DG5G+DysnAV3UBj3Ae9i1sY7PypakjdHfPtgCe3zCjeav4ve3fq/YUl0cEM7BPE+OGNkeE
 /Pgid3dUHpo4oKm/e7PtR4YECAjl3ig+BYHMEAZP7CyiZ5hgSwMWjUw870DTujO9lh/ULt+JWFc
 KaN/QbjP6e7sO+Tc2QTdRXjLdVlujdM7qOdraHjLDVdJE/9x7R8Hxy+EsngIDDvKs5EDGeKAB95
 fUrJQl1rE5upRBfBrlWHQ7hcZtWAepO+BZC62reXxFqAIr8ip9n5P0UxQwWtoPXb7FlI7lYq2u8
 MfoXY0X9NzJsZpiOOCc3Fu8Izz3ORGztRF/gtjepIDvjODVY8SmNKs/WFAE3fCYuSfY5sWXii6i
 fpu7OLUSm7U55N1yMYYvYiDiIHuSXIbsq8AZrwc7cZEIk/L2XW0rqK+ceoBrnfc0I6RUHf9ZIX9
 3nLdxpT9GzkUyvUyknNiAbWWLg3EQT+5O425LhMvoC2mb
X-Received: by 2002:a05:6870:450:b0:4a6:a925:e13 with SMTP id
 586e51a60fabf-4a90763f9a8mr132168fac.14.1793303876391; 
 Thu, 29 Oct 2026 12:57:56 -0700 (PDT)
Received: from
 runnervmnwato.rxxrvns4gc3e5ng4kbsxw1xzhf.qrox.internal.cloudapp.net
 ([158.23.147.98]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a9048e6ab1sm326669fac.8.2026.10.29.12.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:57:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 19:57:53 +0000
Message-ID: <20261029195753.3590-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027191956.5015-1-dennylin0707@gmail.com>
References: <20261027191956.5015-1-dennylin0707@gmail.com>
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

On Tue Oct 27 19:19:55 2026 +0000, Hungyu Lin <dennylin0707@gmail.com> wrote:
> inotify13: check rename cookie pairing after adjacent moves

> +	len = SAFE_READ(SAFE_READ_ANY, fd_notify, buf.data, sizeof(buf.data));
> +	SAFE_CLOSE(fd_notify);
> +	fd_notify = -1;

SAFE_CLOSE() already sets fd_notify to -1, so the manual reset should be
removed.

> +static void cleanup(void)
> +{
> +	if (fd_notify >= 0)
> +		SAFE_CLOSE(fd_notify);
> +}

Use if (fd_notify != -1) to check file descriptor validity in cleanup().

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
