Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D42CA9EBE
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 17:26:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B0523E9EFC
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 19:26:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E2A33C198F
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 19:26:04 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F44C1A00920
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 19:26:04 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-5332a0f6dbbso58001061cf.1
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791566763; x=1792171563; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O74Ia4HIkW4Nuasi0O1t5Fq/T3DjHpPaBGq4qxMxhnY=;
 b=fLtg3ggvMr7Q6b4NaP3F8MjwTG/9eXpv15Mp5KKqkuLo7s8rAX9EdEQmmJEwZXy/hO
 Gn0nMHigwJhzHfUYrDRxn3PUGAzHYzBiefoNNpJ23w3rRqyJRj9V/FqVKXt4a96NLyIx
 syfwBtpT4fobDhxjkOmFRTn8AS5BL7jD+BCyxbNkoUAdLgRwE2P3gDNGORjIYgeIuRKw
 jtomnp7l3jLkMhj5MFDNNqODxgXCbTkHLRbPfSTpE5CuXD65qkMZipKzzQrjaN78r4yv
 rtXIHDVhxubi9BKLyCEw2cWReDB4/auqWv+I+cvL7vMZ1oFBn5WtCd6uv2lsgTaLIt+L
 HH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791566763; x=1792171563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O74Ia4HIkW4Nuasi0O1t5Fq/T3DjHpPaBGq4qxMxhnY=;
 b=MTCh/Jw4Ya8QCiFX+n64c7gG0hpykDl6mu74nWA+T8pFuNZNeCqHnEiLe9SEQXW6zK
 lOXbq4PXCth+sOJPnpMrUtTjlchX/bpAL/PaOtFyfITPbjxmjSTc8SZxj8MVBt/dSFse
 g2A099px8Kgsoa0GoE1YqxGwaIEbkQdno6Ih16iT80OT4O0LCXgkeEMuovXptl639wpA
 1juhAzXNCpAOxEKY4G2xLDgDT7rKIkR2kwtxF3r2Vn4BAOPc77nLvOdo1pi/Ltlu6huM
 BzlYsSe/1vn5seOFS/IO2ASRCVtf00ApC8ew5bjGXgR062ukHOnWs+5JposN1x9VoBqe
 9aSw==
X-Gm-Message-State: AFuF++k52n26UrjE5E96kmcZ2Cgcnyx1SDsbdnOcAxdDfhcvXE3M1y9a
 izgSTLy276nBzuV5a0FrdbRJVJOmdogt4CkQvBln7diWvZ+dZsXu8b2a
X-Gm-Gg: AYBFou1M6Tqh6SCGNrHwNttKlTWC/bKm3XlVTrRTYlK2npIJB85pVbyiRWTJK8IOB1/
 kXLdIK4zA2O9YiXn5ga0bIc0KOTGp+PmhRLop2gqWNfbm/8hIFtrGPce3HelYWwmQqOCabkDoDG
 spfRooLezlYM8oihRIANWHT3WLbRMXbtlN9uK68OLFP2l1iwyJ9WJz0LXZzdJEMeOwZbKCgzNYU
 bBcnnbTPYT7Le9uj80ftuO74IRAAJoXUSnebDWJZdz6vFvuwP4SXEOPJofwR7eCtXfqvUB4bK1o
 Y+G8CDzupO5XawAoRg3uq+0uMYOs1wAL4zAmZTn4gZaWcURnqhzVfqM23RFrYH2FPiDB4R1zsK8
 sNult/5tGW3zdOVssgUFsUURUOml/vOIkkRdYUJ+wdR/vHgMVM8CNVtpYVjS8G4AJCErars13Ns
 VeCbGHCuOPxAULi0/wLD/gb3El35AKtL0dn7SANyzeImk5OUz+EBuj5pq0SMqUvmusxfKhU6Va/
 RICPhYx7MSbdSoh3fcHoeuhwjRtqI2sT/uHnRv0ZNnAfuDyUE9JIyDiRATpYdCTDk5W6CA3mdAE
 kB+pdM7l0g==
X-Received: by 2002:a05:622a:1b88:b0:535:1f03:32aa with SMTP id
 d75a77b69052e-5359fb85a7bmr47021341cf.45.1791566762911; 
 Fri, 09 Oct 2026 10:26:02 -0700 (PDT)
Received: from
 runnervmmprz5.tam30pcoubfehpvxim35l0nwzh.bx.internal.cloudapp.net
 ([20.83.175.27]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b46c470sm23053051cf.2.2026.10.09.10.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 10:26:02 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Stancek <jstancek@redhat.com>
Date: Fri,  9 Oct 2026 17:26:01 +0000
Message-ID: <20261009172601.34695-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <24014310ac600340c4ef9720980eac1c047f4b6f.1791543115.git.jstancek@redhat.com>
References: <24014310ac600340c4ef9720980eac1c047f4b6f.1791543115.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timers/twoevtimers: Wait for both timer signals
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

Hi Jan,

On Fri, 9 Oct 2026, Jan Stancek via ltp wrote:
> openposix: timers/twoevtimers: Wait for both timer signals

> +	PTS_WRITE_MSG("Caught abort signal\n");
> +	PTS_WRITE_MSG("Caught alarm signal\n");
> +		if (errno != EINTR) {
> +			perror("nanosleep() did not return success\n");
> +			return PTS_UNRESOLVED;
> +		}

Medium: PTS_WRITE_MSG() calls write() without preserving errno. If the
second signal arrives after nanosleep() sets EINTR but before the new
errno check, a failed handler write (e.g. EAGAIN on a full nonblocking
stdout pipe) causes a spurious unresolved result even when both timers
fired. Save errno on entry and restore it before returning in both
handlers.

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
