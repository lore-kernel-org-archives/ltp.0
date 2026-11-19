Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90B606A320
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rXH1ufbI
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 604A73EA006
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 13:13:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80CAC3C9436
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 13:13:31 +0100 (CET)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2CE611000248
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 13:13:31 +0100 (CET)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-949589d273aso110351685a.1
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 04:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795090410; x=1795695210; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4z7G9VKa2ZzAPewCF7rPX3Pacf07jmX+Jn/Gi6Dugxs=;
 b=rXH1ufbIgJGSiQXmMGEaZ1X2YnKFAxUBS3HcFj7QS25VSqBSXBw+fDwYSVylkh8rt6
 Xnu7LkdGYMgHe72RVDFmZoacytqxaepr5vJcqQol515mbRk4zi2Vu5HgYa55osCbXeLT
 rWrtpCzO/1H1xlwO6akP6CtxaTFiDcIJ8QSmNJmImwXPzzPnesVMabzORM//JLPZEY+S
 2R5/mG3cgC2KJ8iSvRQvJ5mW/cPgPZte1nOh/9lZR67wfY6Il/ICbY0EGDq4H5fNowyr
 nsVuA+z7jtRppO64I2Mwj8rF2nzN6dOV2ei8LScAsJ69uSpMSAgfGFZt3T3Q4I37WYZR
 G6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795090410; x=1795695210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4z7G9VKa2ZzAPewCF7rPX3Pacf07jmX+Jn/Gi6Dugxs=;
 b=HOAUQRH0NcWzIFwy/P4aWkf7BV/isYlLIUV/nqjB+wwa6tyYJa0uyjB0KxmdpkgqOd
 tSDngQWaGSX10LwCoqGvL+UJfnbvQmMHX90J5XmCXP+Il4kpHVJkWw+V1Dcc+ESsVpsN
 oIfBT43XzcXie/kh+HoYrhmCMd7QBSIqrajXeTiauzGRzbCMe42/xFjFu4f5wrhyqJWB
 hpVrSPvM9t+8aE10zscw+2udbnn1SDHBwJ0uFfyifO51rwf8Jjq3zFFVqA/HZwoIR2t3
 beX4W3l/hN1D4s7b2r3YL9L4Ge9t5X5oXKeobVuHRnuE0gQACQ6qrFJFYyg/Tazcw4XD
 TKvw==
X-Gm-Message-State: APuU4Z9cdG0wiEPVxUftNRMy+xDnCk39+EbVdjw8tmoWVtqld0aOtVQD
 iA3nHjKVS2KZXhEUR6HhpXrrPgU+WQBCTq3NZtx6TbQnnPB/Hd/krii9
X-Gm-Gg: AYBFou2YXnwZe8EiNnjlGYSEIyMl8gaPWWR5QON01ed4Ud6nf1L91ywMK5fxkgz22eB
 4XoQoYn77ZKDy5KpFAAKJ0NsVdifu75f3uj4WOMe0sX4BGOyiR5tj1bg+ihr5yXzgLvNoqNMkAn
 XCO21UoPlS8tnIsYP4b6dKTfzdsNQLphNBuHLJSBviNdx7k5+vaa74jlc2QHBaIxd1lGmljkfb/
 8vJD7FbGEhpvxfxTedXeubuMHfIjP6iNt2XBMmJmZxrC6HZS+UYgtW586P/uB9K9iAYV/8eQPr8
 /SMMfqWx7Z2WiUer/XLhfJd1U89InG5GXMMa/VyQypF9IF6SmfcyqVkIeQgnLt50S/IbS7wgOTm
 avypGqVxRLMm9D+tGorOUEJ2ztTowCuJ6cveTWHwdQdPuH0xsBLnoSlSDtXnyCoLONdtDGBfqDU
 6FUcxIdDGttHvNTGhDbZzVPiIGnUuPFw+jPDKKKNwFUT+zunoTnAGYfkJTkfyhzDU48V03u8RmJ
 QUBUlPeA3qJat1NF0vlxGGwPykbt2IMVfgwE6ubLT68sHeX7I92IEdinN68LbfwiEm1J26JOvUm
 WvRvRByohC1RWSgjQJGzbNNYZJFd2h5SCfCgilbJAQkuYiVuDpcgginw/DfUofRlGIJbb2a9JhB
 TjCnHCsBqb6EJKgpjfKNWescZYmRHLyttxHe6fY/UrfiYg34wpEEqpiTb9SUIIX70
X-Received: by 2002:a05:620a:1a22:b0:93e:c12c:43f9 with SMTP id
 af79cd13be357-94999605c74mr966133685a.70.1795090409872; 
 Thu, 19 Nov 2026 04:13:29 -0800 (PST)
Received: from
 runnervmccnms.c1t3xxmpbwgejpupgp0ybbyz1d.bx.internal.cloudapp.net
 ([172.190.93.113]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b7ad72csm428516085a.29.2026.11.19.04.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 04:13:29 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2026 12:13:29 +0000
Message-ID: <20261119121329.3789-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119103711.3002153-1-chrubis@suse.cz>
References: <20261119103711.3002153-1-chrubis@suse.cz>
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
Subject: Re: [LTP] sys_rtc01: Rewrite the RTC check
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

Hi Cyril,

On Thu Nov 19 11:37:11 2026 +0100, Cyril Hrubis <chrubis@suse.cz> wrote:
> sys_rtc01: Rewrite the RTC check

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
