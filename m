Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4454606A321
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s2ZWtlcm
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 463B53E92E6
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 11:33:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ACCD3C008D
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 11:33:43 +0100 (CET)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B3F8E10009D0
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 11:33:42 +0100 (CET)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-18818daa3e7so3306975c88.0
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 02:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795602821; x=1796207621; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ud6l1aoyX7EDXg5gVmXhnXYaAHD7bXHQbXm2fJyIBBk=;
 b=s2ZWtlcmSgMzGXOV4tNelOklV6DyGVhUkhILQ1cCb1AMrxcBnl1mB8QWu3Np0TfcUW
 F4XcupaitYgKoNYeU+0tkTUNSnQC0+jg6OJthFJMZY36J0NhY16Az3RLBQuNZGoFjAJJ
 qg9uSKfXEeFsmhi1TwVStXAsfykeBbypahcVzggLZbR3gryrJcQAylgCkpgxGDje1Bhy
 u83rsQGv/6wkCQZUS8yWwIx6KmRH8l5W2ciPR+WrN0jeG1qurTpy6KybxOQpEeqbzbib
 BE69gxcTR7MrqTVssX506m50mJgGVUosUrpRfrL3IztIvEsm4/48pWUtilZWZg5jKvqi
 hJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795602821; x=1796207621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ud6l1aoyX7EDXg5gVmXhnXYaAHD7bXHQbXm2fJyIBBk=;
 b=D2Ilz0X3oPcdFa/5FK38oZH5Cf/FCyoTwegbXBNcOG/2eK30nBcjIKNprNIX7JXZ52
 6QaIZ7aROjTeO+I1yaLsk+1J71Yvm0H1qPgOZ5XKZDNSfMpwii5JVcD5BEoVfjazeh0t
 If1mqVrw8N5Wh9hoM8Id3Za6v6lGS1EoahMOZpX3zyt+gKojNTz7r/BPbpAkmspiaqkp
 +thiZQDzj009/LPFhROUO1o8cVpduVfJ2vQLG8i2VkKukkFoUNhDdNlsvn67lDRfUMce
 LzbfxNad1eHhla+E2IMDOnJmHnl+V05qhoEdS91CoqQhJTsVfVp4AKjFid8Q3biWktYC
 O72Q==
X-Gm-Message-State: APuU4Z8ODxhYsTCfcCBLooH/KuroNFJeMVXXXmIpHqKU36fyXLrWgwRL
 UUXb8mzJGed1SmNmX0yh2o+MuF8N/494wYdRXP743UNK0kTCuFY6436x
X-Gm-Gg: AZFdTZcjxx0Wd/Z6KTCFYVPDTEfA0/8c1K9CbxjAZOlV2ISuppx768jKSl5ErNVV9iQ
 SEk6uLA2fpe4F4pOdrNFOs8qvUX2Kth0JN7ltGyF/hGKO9szgsVVyMh5cxp+kBcjHbV28J84cA3
 spVW2F/hkwjWolP0bSYariGc7SRE1bVUPeUx7n9Gvo2DvjKi5M7aTd/1vuFWfHuG0D9fW75ghVY
 mZW3IWx2dq2cmOl7MT4s8yRHrL6WLpfwVcfHTe9Sb9DIfC//iDlE7suTTCoXCqSMflUdgLf8Trb
 SSsjcu4DJnlkAGtynM3FSA0SBeOQVJRyFq/+Uz3KGo+hmYdiXAyDYKISg1TOp4zQGX/nUZMQomQ
 IO0grhgjCHIkb6MCBAl4t0cREJaiA5RGJMSvVqjkl37sqIeft+khUMTTK7r9FV5YFof5/5XdqRo
 IX3Ox8HRqpKB+62Cj4kMoUYbSZh59MYo3A3K27xLjenka6tzZq3gq4hZpJUUMPv87r2zBRk9NRK
 geCNpgIrM0um9StC7G0Av8G9XMQ0jdFDqbHM3oBqQM8lcV2lpMy3djJSAmHAH+8ghFQsUurOsHw
 +OlBJ9hjnj+HEmGSeaauET2jG+l7HCn6jttSSpVYfgMIb8gsLXbIuHkiA35MRnrHd9QQBiMFXb8
 VBKGDQero7WtNh6tcdyM4FHL/ktT4VM/MnEnUsFZPD7yQ6+ZfsDXyXP6X7bo6w3L4iw==
X-Received: by 2002:a05:701b:2704:b0:1ae:d447:6c84 with SMTP id
 a92af1059eb24-1b5525eed02mr16140789c88.19.1795602820755; 
 Wed, 25 Nov 2026 02:33:40 -0800 (PST)
Received: from
 runnervm0hi8g.fkzuwk3srtzuziqu02k1cpypyb.yx.internal.cloudapp.net
 ([172.208.158.175]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b556847fdasm46992734c88.13.2026.11.25.02.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:33:40 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: "jingxian . li" <jingxian.li@shopee.com>
Date: Wed, 25 Nov 2026 10:33:39 +0000
Message-ID: <20261125103339.5248-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124061814.271452-1-jingxian.li@shopee.com>
References: <20261124061814.271452-1-jingxian.li@shopee.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/inotify13: Add the linux-git tag for rename
 event fix
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

Hi jingxian.li,

On Tue, Nov 24, 2026 at 02:18:14PM +0800, jingxian.li wrote:
> syscalls/inotify13: Add the linux-git tag for rename event fix

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
