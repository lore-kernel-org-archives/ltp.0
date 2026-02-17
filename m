Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE01E909A4
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 14:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771337550; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=q2fsg7CAqsjXmLsGtCCZQBten0hICcTUMYF2TQzNuEg=;
 b=RiwycdKolOB8a6O37Dpu7TdV+rpnW9JIgME1frRvdNSbtYI9MlzH8rp5FgQS1BXhuxjof
 AbyxPZPzLvImmQ880JZSxPviJSXFc3V3/jvbDlCG7UiOimW/kZ9efqwZOHns14kIfvlPYpB
 hgywZjub0gY5fKsT/bJ1ZmSeQO8hrQM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 197163D0633
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 15:12:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAACA3CF2B9
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 15:12:07 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54CEA1400512
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 15:12:06 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso34470035e9.1
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 06:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771337526; x=1771942326; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imHzzQrBh+A0DbU2t8sSB52vV+oIlhqaOU7bLrcLPc0=;
 b=OXQEDaFtUdhly9ULVOnZWPTSC5nyONS2CEnSkj/Two8OaCYJwnXivDFnC73FMcgnkr
 PskWjRMcHA7Jeb+dfATxvaur9w/uZ65+ln6q1ByICyVMz+jyrsQ/4r1wYl7EP9GcLk+j
 +/TTOkjFn/xwzYdAsC7nivuPZk8NVypMkx/+xrJWmpSTWIvVWXLl4ITkKqiCGMRXwKdt
 n60AcP+nCPYphSrXdFjzHk+tubCEPzbfvi6PUm6K/v5BOXThhg2OlwIQ5zye+JZURGI5
 7vXOeVQwfcsD5YABx5TDORo4LdftMVl+Xio15rsrUsi9TzTjVcbcXPg/uCt/Z+gc6HnN
 PLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771337526; x=1771942326;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=imHzzQrBh+A0DbU2t8sSB52vV+oIlhqaOU7bLrcLPc0=;
 b=vc6c5QUP1BlLTRb0dAXnj3LWuFJ4XqfBE4UR1iBbq+QMCFL1Rz8QS1hE0S89IzS5vm
 tEcGsIGukjpCdsacmbC13L45Dk3/95u7dvoHjAEQnEc0sWRdPfVvQu6XcRv8280dPtKD
 +ayzn9ikpe+0Q8r476C2J63YndhezJMGQK5HAvdD3CKiUqxuRLZdDAcN/QEBsLfoX1kD
 YmN4Lq3IGJPRkTOq/p7vQx952ZjojOSmnXlrxfyG4WY4sHZXvd8ooe6cb+pUuuSpJBH+
 17ge7WBrGuqHcJ33o3h260Q3B2tQcHDML/44yp3ln5+XMpWHqgqb31J9hMbuItXzo0Tu
 xp1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhOmri8GyoMQceg4hENilpXzdns/OV9iFswEv8AHfHQAnF1cHhEW4MaB2P2XPJGi0OgFs=@lists.linux.it
X-Gm-Message-State: AOJu0Yz3nYwPQXFXxPSx8CnL0z4uziWvIpGMcwHdC97HYlgKtK7xSPKQ
 LJRPS8TZFLWRsQjBsN40NkNH0BNdpq9Nce40Nf6pPrkjaUxcaM/D3aNJgkmLNU5HcJc=
X-Gm-Gg: AZuq6aIZRaSiMcILfHgM7KQ4ikdgh198YCiji24RzajCjabx0z7dwQYDv8gugfJQEVE
 wZq5T0mnucamjdZfEYUrwROP70M5jNcKoXdkg2YTe8gkTv0RmtmQAzyUS3dJJbJ2BClb/Afrcke
 emIhPDS6oWMmrOvgZx9+8G5DTCsPU5Jhvzgf0eLrIx5v4KFh7WFBnE5gT0LOLYZnD4DImHxxE+6
 InN8sR05U98qmm6KkMpGJAI3ci4jr6n3uPoklhB7RGbwnDVRi4YfqlEC0zaCXuPgNaQaiCmeFzv
 qx9N7ZcPoWxp6lBDuRPCXc5kQCy6tdF9MtVwEQ8MHPwAygsNEHPutLW8B5v24coEe4iPU+6cVeg
 Glf1oFhku2P9892ksZQkGdp3aC9JX9Zwnr22xuM+wwR1ykUK6mG6ngKsS541rN37e+kEto5qcbt
 IgPjrpbj00bQCEmRFIzX1rzApNUqfBPirwGJ9c6DOwDhzFQTJGvOqWyTXG2rug0bq+2wNCgy7d4
 VR1S04IoZOYlu5W1lQ=
X-Received: by 2002:a05:600c:a10d:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-483778355e0mr174975535e9.27.1771337525557; 
 Tue, 17 Feb 2026 06:12:05 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483709f8812sm194916745e9.0.2026.02.17.06.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 06:12:05 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 15:12:04 +0100
Message-Id: <DGHAQWTB4E3E.YW5HW8AVZB96@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260122150540.28343-1-chrubis@suse.cz>
In-Reply-To: <20260122150540.28343-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: chdir02: Add test for valid buffer
 lenghts
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

A few typos below.

On Thu Jan 22, 2026 at 4:05 PM CET, Cyril Hrubis wrote:
> This test tests all buffer lenghts shorter than PATH_MAX and expect the
                               ^
			      lengths

> +	if (!fails)
> +		tst_res(TPASS, "Path lenghts <1,%i> worked correctly", PATH_MAX);
                                       ^
				       lengths
The rest LGTM. Feel free to merge.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
