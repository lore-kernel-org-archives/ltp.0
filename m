Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6800C83F1A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753269580; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=M0zPkTePQKtwYLRo/R3x1qOHywftYZRFWfu7NqO9UiA=;
 b=i2794pdDut08RBGTGUArKjTQpkMD/4DY2Xa4MyBMpTc+1B4BiqIm5fy3ZQd1mPo3TLgSv
 DumU1Nz4Yxc/OKDeT+Ncm4YkeCmbb+mw5NPFk/IRM7dZxR+72V/J9ITEx7LB2fz1uNoK6T7
 chFcd+wpNVU/4oxdDcPkhLAEf7NMmzM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 721513CCD87
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 13:19:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E38333CCD39
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 13:19:19 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B6EB200253
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 13:19:19 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so3493345f8f.3
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 04:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753269559; x=1753874359; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nAYPx1CyWwv/y8Z5dnwZuY+/VfPJ60wGBnzVZfeNuT8=;
 b=NVs8MN+qqCv0d4XEmGztNA9IkbCFc3eXcn7LBSiRVn/cdBKvfNtPaw01C9shl2r33s
 tcESlHPQopNfI5qDfB+qIqkib+aTxUYgmpwBnR29pqw+2x83JeyvaOA7wUBj0gSe7cWg
 TApHw0kY/ov9EPsDYmd1gjarYdyvG80YD06HWzdYq8izFc+7F6varMqWJAdDNYm2+GDJ
 uThym5RS/PylZMJlAoe0LxVqUtZEsznghSMIfqhDLf7tWeAIlIx63fyfijghf11oURSJ
 kcDwHnW3y3Ks7HyEFcEn88wOLOlbTDJwZC5XItqTgmh6EkN0sNr0L7xepfmf/2z1inoQ
 tAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753269559; x=1753874359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nAYPx1CyWwv/y8Z5dnwZuY+/VfPJ60wGBnzVZfeNuT8=;
 b=YyJFt82Wh4lLiqYR+tb/NiYrmN5/ZsbL1w87b3nVaip+5L8gCYVcbKYJDto9TrmNDR
 LuVfmPbZpRiLDId80FIaEcT5I/SYDDvolMi39rgiNTxBzQpOK4FdcC5YBp+XI6+dUVOi
 7qljCWGrwkAybCuUJmjMP4dUsstSsWme6gGahS195XVj2Ri+ck9OhIzEoM4czf8fUico
 ZnMWJSzsarRgPJe5vF88BTzH6Mv0y7izsd7AMQ1ZI5QCLb9RADUSv2nUMydaCe5RgGsn
 WJZaqcNx0sm+mXSTQRo/luj2f92iKSeZtWXqBmyBJSo3upWInQEtMPqnMwNmHmXoshTv
 o9Hw==
X-Gm-Message-State: AOJu0YzD+/iJe9lcyZPDyG5drqXFeheoRxa69MhG+K0JVxVYuRf172GQ
 nJTu/ptN3BSlZOZNGswx7bbXg2Vyx6wFnsG5S5UO34pxtW2jEDSwrnaFgVrfR4L3WI0=
X-Gm-Gg: ASbGncuWj3+AIBGKLihNgEL9DW06bglgZtpbvVogy0b98pKuJGenhchCUTI6X/vfoGA
 WYThhaWbxeSj8upWcRt/QWuwrjCr952iDCpF5vYFqN3dJ2aUiDchPMRg9syGRkmNzb2kT9Z0WlJ
 npvQIYpANt5XPUW/jqrVzNp+UsrjUcCKRzWkk3+VwwktMPomKwx9TFpOLClrQHM0mE9ZwIPqdA0
 BSyCQUpOwNba1uC1ZBRdvbXJhUGRR7PeS/njg9lp6vp5pLIKTncPMRJNNFcmzQ3VJzE9nNibH84
 DN+mmJnUY7G7HfWFVVximjc5k2hX2PUzW81qKdR5kK91hrXWUxeo1kOsEQGxl+mlwTBMoKpuWpi
 dACy1ukkX5dcFUZRMfNIYOawejZ+6kkbJPAnxlLDVBdI7lOBc0Ennpwln//tf7+RTZ2FjDM6qvJ
 /S7Vq8Qx8ICCMiYeZ8XfhIn5dsTB6eseYxeydqSxboiaPvxTKIl+knCqN8MuiC2g==
X-Google-Smtp-Source: AGHT+IFPfzqXIDx2wi0CFTaqFl+dEGU7cvdwqKNSX2guOnbYYms2tuiDUFqe98Wl4vJc3hjVf0YPvg==
X-Received: by 2002:a5d:588c:0:b0:3a5:3a03:79c1 with SMTP id
 ffacd0b85a97d-3b768f02715mr2378582f8f.48.1753269558643; 
 Wed, 23 Jul 2025 04:19:18 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f5bc4af12sm2369016a12.43.2025.07.23.04.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 04:19:18 -0700 (PDT)
Message-ID: <a911cbc1-ad7e-4b0e-97f0-4e2c594c7084@suse.com>
Date: Wed, 23 Jul 2025 13:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
Content-Language: en-US
In-Reply-To: <20250722120635.GB22975@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/22/25 2:06 PM, Petr Vorel wrote:
> +++ lib/tst_security.c
> @@ -107,7 +107,7 @@ int tst_selinux_enabled(void)
>   {
>   	int res = 0;
>   
> -	if (tst_is_mounted(SELINUX_PATH))
> +	if (access(SELINUX_STATUS_PATH, F_OK) == 0)
>   		res = 1;
>   
>   	tst_res(TINFO, "SELinux enabled: %s", res ? "yes" : "no");

This is more or less what I was doing at the beginning, but Cyril 
suggested this approach which is more similar to libselinux. Please, 
check v3.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
