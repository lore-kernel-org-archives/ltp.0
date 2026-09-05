Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0CFC79F89
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 03:07:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61CB83E97A1
	for <ltp@archiver.kernel.org>; Sat,  5 Sep 2026 05:07:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DD9F3E93CB
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 05:06:50 +0200 (CEST)
Received: from mail-qv2-x07.google.com (mail-qv2-x07.google.com
 [IPv6:2607:f8b0:4864:33::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D6FB710008FE
 for <ltp@lists.linux.it>; Sat,  5 Sep 2026 05:06:49 +0200 (CEST)
Received: by mail-qv2-x07.google.com with SMTP id
 6a1803df08f44-90ccffc2654so10096706d6.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 20:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788577608; x=1789182408; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z/WMDOKCRMfHt1r6kWTNJpxSsKRaXfiXAzb/fmb0y3A=;
 b=FMnZvoXG//WBeu+9hjMRnriqTyK01rc2Vyc/90ULmu63FMRgyAShcZWFIssR19X730
 wkxXvk9P9eBs4zvVKHoLV6/rC2nUmPRORshiFdKdK0ZwF4iBa8b1jcxN8wVFLayC09yo
 Kwr8Dqt1TDzICtfHrEV1VMTGCPVqU1USoD0jcuj74zLWMtBBx8cmPH8z17JLnOdfAzTE
 4j04c93awcRgrvbVZntRXFfwzdzRuN/zfyLBOeBCHoLzBK/Cscd6JgoV0Qs175bFSwKa
 9Wggin5xGVkeD2g47A9FMgqANl6xTrNKd3iqHdT/Ih0HgjVIq+YD4W+VkhU7KkApcHp1
 nSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788577608; x=1789182408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z/WMDOKCRMfHt1r6kWTNJpxSsKRaXfiXAzb/fmb0y3A=;
 b=cRzwB0QfofyIGHEuzift7LYRsWYB1GZRUK8AJA3FVnRf1qA9CVNOdVhwMMaSM9SQxY
 zh2/2b4VN4QI6r6ttdmYRRz+eFIKiXgNbEbeMDaYqwkQjVnxhKpN7LaTOiNnjQEtm7OL
 fHapvOilJ9AkAELOwYbOxjKG2OyozaWpZldQhY90GLkN1lPMJt9GYwRHrVpWCN4RXDpe
 AYBR6XneTJOIS27oYypAXnSytvj4Z+Z4DLCs8UKvihPNg9d+cTo6xZ1IcoT4mB2KF1s2
 Gp9Wu5f4mfaCT8L+thWIXfEwbH/xx51jcbcpAQDxesc/cVCUf5OMxp/7n3MrdSbpY0+I
 Swig==
X-Gm-Message-State: AFuF++lPFMzq+3FnEg7wLXj9qbH+kaRrJUx79COgI8skmN3ES0oQ0/mS
 2oy7bqppsYx5RfJV+bdMnZ7FsPjL54fPPEWLdx8MtU2SZk952XNzTeyUzr2WfPNW
X-Gm-Gg: AYBFou3/FslCFq9Nps7eMJ2PRscVEtsFGuoNAt1hxg664HEXxaDXxGiSyUCU9aQ3rAH
 EMivo05ycY5MPwLYLpcq2Grq5tCK7ZX4L58ecg14V43w+CiM42Y6zUxCTkC4GFdj/DkRmvGme/A
 9tIuZ7CLLscAGLy8Kqn2INIXQEc8619oAbqsxCohXkpSzwhfDU1f1UUodDqABlULd4nhM234fQf
 cn/NlpbSdIFihdsQKNDsPhfYjuCc2V/kiGIH3ms+7sm9XMP8nLnDwu0zEM4Am+NWd1FKN3IapVG
 PNo79tGPofqF1k+JusVjVoGH46Y4VbrUh+kPfY9omHv63013qf0iqiGx2YOHdJjgU3Q65a3tr0M
 OjfSCKooC6xlNaJMQY/hVjkGt4KlEIT21TaRTLymBD+DM5YFdqG6vhzf8DA7zDn/HyKkWaM+WL5
 kQb3FziqaqymAdfVeLJt9CTcmJE2FC49whmk5lwm5a3VdyyFaqE3RstlX6SizcTWfauxQDGzee9
 YRV1C0WMKkK/hgmMM9LNJtqpQ+UlUQRWh11JzDtf1iahI26uhncMaxaQ/E4Xez3B+rigTQH3Osn
X-Received: by 2002:a05:6214:8009:b0:90c:e2e2:1abd with SMTP id
 6a1803df08f44-9103efdedb5mr120723086d6.21.1788577608626; 
 Fri, 04 Sep 2026 20:06:48 -0700 (PDT)
Received: from
 runnervmejwal.y4bsw0ouv5iebbr4funvx4sq3a.bx.internal.cloudapp.net
 ([4.227.135.152]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91040693f75sm35740936d6.35.2026.09.04.20.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 20:06:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Sat,  5 Sep 2026 03:06:47 +0000
Message-ID: <20260905030647.4006-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905015104.23497-1-changwei.zou@canonical.com>
References: <20260905015104.23497-1-changwei.zou@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuset_memory_spread: count only the test file's page
 cache
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

Hi Changwei,

On Sat, Sep 5, 2026, Changwei Zou wrote:
> cpuset_memory_spread: count only the test file's page cache

> 	for i in $nodelist
> 	do
> 		# every expected node must hold a share of the cache
> 		if [ $(get_memsinfo_val $i) -eq 0 ]; then
> 			return 1
> 		fi
> 		expected_sum=$((expected_sum + $(get_memsinfo_val $i)))
> 	done

This accepts any nonzero share on each expected node. In a two-node spread
case, one page on one node and the rest on the other still passes, although
the kernel contract requires an even spread; check the balance among expected
nodes against an appropriate tolerance.

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
