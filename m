Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECFEC98314
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:21:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3815A3E65C9
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 15:21:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 567E03E5DDE
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 15:21:26 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1DC381401258
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 15:21:26 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2df5ab2f7b4so5510755ad.1
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790256084; x=1790860884; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KDUpUnra8fZLhRR4SmlaFNMM4x2uRbXrgVh8CM7P8mg=;
 b=l1IECAposOzCZaxh5pCBfGOukHD66aVZSINp1LNxZnOwdv+s6qunIaAkNAgeduq8WV
 16TLvv7IALIdtmP7HCK76V/ow2X20xKiJ8Hw6WqvtQ+fFF71cbLXLCyAO9C+lKVeVWSD
 wJg4g3UaKUJWmW2Viq8htaKeJQkRukA+Bq3b9Ke6C+OQqpWGps532qn1L8Os6Hg2TOhZ
 lefNrkUHwP/3Mlm1BidAdUxBp+/4cYCFCH4uM3Dq4RUJu/j47cUZOmZFAcIwCfCYnqVj
 jGLIaS7v/IGXahpVOAh/LVuG3IAy1IopsWdOeDvo1cVO4jgSkPKiyTU0ZpKUleFsgo/U
 646Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790256084; x=1790860884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KDUpUnra8fZLhRR4SmlaFNMM4x2uRbXrgVh8CM7P8mg=;
 b=aBWEOzx4PVeJBf6ybR/FNtBXkGRLuqSe8d9t3fAR7wy1TRqxqzea6H55rDPOAr+MHf
 NGJxDZeNeaOrrdMZ7rsNKW3Of4vZyt/fYto674eTg6js9JKngbJ4lN8srajb8A1a/G/z
 NDET3JrIHZeYYe24hGnvZ/DtgUbTOwpOVq2e/FfknF7BCcUlW6VOsrS1kTtdgJ1AEAhO
 y3WIUg7nEfbyMiuHC1RestjHbdkoM4jr1cwg1BUgzKlRwEQqdAu6t/BSCM6gx9IetfsL
 TIL6Ux2g3Ta/dfW5ebRkYcikau5kgD/gF+CJZO9UefsAJ4dYk4VUO6G1L1pRQ4kVB7uX
 wIYg==
X-Gm-Message-State: AFuF++mCEZX5VNNWQCdlDTKtOLr9VPAhEFtDiBGUJqH0KlBVsrJiGB85
 oiZtUqcGXEUGQuXu/052RC1svi3UikqWoIzpXrnzLtq/fiY6t/Bq48sy
X-Gm-Gg: AYBFou2TIds/+82faxBJBpL/v78lfmbog1bp127tngHv27/PQoPf1AvO3ZINsd9oJAK
 /8xEGHRZQt7EWJqwvb5coPt7N4FbdfkfVE2bMJIZCZxgV1CpPe+vw+AneS+2TWPERLj+hyL0pIf
 QtH0Hu/MD9yz8JjLpQg7lXqgC/zFOp/L9HEI1Avf3l9vC0buU25xrAS5EIvTdZWS5rJv/qyy2XL
 KyohjVSBlIckjHi89Wg1aBhDJvGdbQAbWVoGvz1VeQ2+RomIx7BMxVrlIAoHk7miw9pv8yBuT1k
 iwJZhvUEgfgzV2TfMuQwyzAEQI+Ic85TBR9EmaOwNjHluyHJhIQUfxbZ7m58nG7f7zDS/72wRVI
 LXFoB+7UsWY6wqvjZScxt75dWubKTVaOhgZlry2er/TRatE5Dw5fcDnvKSJfRNP4Pu1CkewXhE3
 uOAE4mRBhTD4jcndJSNrcfvfGSgvOY2Q+dyaF9OasqIi+9hOYR28/kvIRm81m2M3NINUDfe65BW
 0Shd6MQBH6Mmdnh+I0IDLYI7p/m3YBH4WcXw/qbHAYkK9J2lThhj+FUwST8DfIN94X/f/eb8hqE
 1Buhu8vrhQ==
X-Received: by 2002:a17:903:244b:b0:2dd:c100:4b80 with SMTP id
 d9443c01a7336-2df7dd77203mr19732175ad.55.1790256084220; 
 Thu, 24 Sep 2026 06:21:24 -0700 (PDT)
Received: from
 runnervmtr4k5.0dag1445wiqurpv2peo3esqijf.dx.internal.cloudapp.net
 ([52.159.227.8]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5c0ce4sm26173165ad.34.2026.09.24.06.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 06:21:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Sep 2026 13:21:21 +0000
Message-ID: <20260924132121.9274-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924095933.4183470-1-chrubis@suse.cz>
References: <20260924095933.4183470-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: tst_test: Clarify the .needs_abi_bit TCONF message
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

Hi Cyril,

On Thu Sep 24 11:59:33 2026 +0200, Cyril Hrubis wrote:
> lib: tst_test: Clarify the .needs_abi_bit TCONF message

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
