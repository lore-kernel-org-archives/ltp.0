Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A9AC55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 10:39:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 708FC3E7064
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 12:39:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B2FF3E2659
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 12:39:24 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61A6D2005CC
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 12:39:23 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-c9fcd903839so1078055a12.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 03:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786012761; x=1786617561; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=slavshsVIuQWP7gcIuEMDveUwln8z8Ut7VMxaLmPnuk=;
 b=rZERtT2uRDTNyNC+9cU/D3hkNdWaR5VWFnrJ14MLvBbOkXsHQMPRGbS0jpqr0HOGjk
 lcXmFo4WBrJtShzHZuUCvrYTj80adSWedHuZj+iW56GiE2S+iq+i5xQPXdcmVDzyYp44
 5SXq8Zme2VxB6Q+L7fSSLV5woAlRHb5QrtiljsyZp0XbtoF1oc2iFVC51ZBr3IPOwefY
 9pCaggQNox1JMTc0mwwUVHVVLXTpX5yXgEb2Lq1ouBWfBG9RE4FiVTmfSfByVkj+tuSE
 tH0kzyGkodL9nfVfu+SclJRh/1I/5t2IXbWYZXvjfl548+1nuWa07wvqRt9h2DItfICJ
 RzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786012761; x=1786617561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=slavshsVIuQWP7gcIuEMDveUwln8z8Ut7VMxaLmPnuk=;
 b=s33Gnk2/0CIAplIh/RgE1qbnCM5OayHND9i6cybfylXz1+lbxjKiRpZ8byUUkuuJ3H
 LnTkhHF89wkhLbbaC23JmNfFussFn5nB/sYLBVx1FVwxayq3wRgY7VclKIeDq8X9L0Kx
 9/+DEffh48+wLwkTZbWNnCP+Yo0AWVXkMjGx7ogh30MzdY00/lcYuqhuesESqYRBbl1n
 YcHSStW9UUnJ69JMhDTwkz+qsg3Yya7/HDwZlcmlddC67EBgAsk6v2/41NPsj0Xr3bun
 0MGSap3B1iQi6zFFgvWnnLnAzuLn9RX/qJjjcmzqEIbsXBR8ReD5IibbqyRfV9VivZAd
 mK3A==
X-Gm-Message-State: AOJu0YzJZUVuvliUCRG2O5tJ6CIlnxEzqq3KPkkyAkzeGqM7CIQisK/5
 DxzQ0xtx0dvTY8Hn+mDLV04i8x/QDHQsBrbAG/qDHwTI3W89fBbRWSKv
X-Gm-Gg: AR+sD13v6ozEjVe1h7UuSTsZefrBaR5iO+w8sxBk2ysmD16SIbQcusXmmXe32yC5hNi
 5WNHKssoQvK0KYOQBv58mAQ5vamJzjKMaHcoc6H4QlGQuHvFVsSXLXdoM5+y5RqyvIf4n0s7Ea6
 1Vc5hmADEaL6Sv/ZsU87jTK3XgtgPxufjouOJoDFn9FF9BNNgTXs/q8dyu82DerFbrsB909SAt+
 5/XJLTUP8ctVnnERRjf/Ck3hj0Z9rwp3CGwreKvMisA1N+wpyKER+Oa3O0ZloNtzm0ILmKuPAU0
 A87BakVK13yyKVQDpE6Rn1MkyiywXMty+VJ8j462whCgt8XPOPv/x3gi/ELTXAb956p1Gmq6Mw8
 4zB4+BQq46XF7AUQYac1sBmsI+IPTwbesZpeGXVMxVLSxIsdIQVEnAMR9URsy7UI3W+TrQWsNR5
 xH+NVlp0aWeXv/aW5Wuv0d+pjucJRDZdhwJ2gNKbVYv4Fa0Ts9lm0JAOghTncIQNf7QLmLFFXSK
 R+CUX2V6lSC/cbsrmE9HOKCawPqRSFuWW9iQx1jjo/mMFg9GkAPifv/Lh+127SRi5kkDMPCrq7S
 bA==
X-Received: by 2002:a05:6a21:6014:b0:3c1:85d:fa2f with SMTP id
 adf61e73a8af0-3cb85f4a66dmr18281647637.36.1786012761417; 
 Thu, 06 Aug 2026 03:39:21 -0700 (PDT)
Received: from
 runnervmd93pd.fkpelg5r4hguxmdb5uu5df2fgc.dx.internal.cloudapp.net
 ([20.184.150.167]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fca9111b6sm23100777c88.13.2026.08.06.03.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:39:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Thu,  6 Aug 2026 10:39:19 +0000
Message-ID: <20260806103919.3882-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806074713.158271-1-avinesh.kumar@suse.com>
References: <20260806074713.158271-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nfs_lib: Skip NFS versions disabled on server
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

Hi Avinesh,

On 6 Aug 2026, Avinesh Kumar wrote:
> nfs_lib: Skip NFS versions disabled on server

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
