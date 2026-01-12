Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CA0D25046
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 08:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768205641; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=4EWo0jNH8lPmDePQZUTYUDbIJm7cSpPvD8aHMGavhuA=;
 b=bwm0eYo2hi0gDH/pP8O/97O2/v3ALe4xKedf/BDyRuj43TYLtdnqWdkD3ZLMETUniZWWo
 UfM9VLX3ZHQrN/m/G3aK9MLsk3U63spxXLNLxtZH4jI5zbc5448KbvJmBTsbbKUSSE/mjd7
 D4QwiSC0GsRu+e50NdyVW9Xmcj7swwk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BF923C2C9C
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 09:14:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B4E13C2B16
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 09:13:37 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9CC901A004EE
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 09:13:36 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64b58553449so9510934a12.1
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 00:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768205616; x=1768810416; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+f9G1hO5T1FbjqQd2cUtHLQJ5TUVFw9BqFIXfhIICKM=;
 b=MZ3fOCPN9484/ji9PkeT5tgXMGVgGaJukUvwSYlyD0+StU1/qFTeO70dUAYYmMrFsY
 jzWxx7BRLMo/ZvntvyLHc9WvKUeTsL7PB7PVBcw3YyoohCACbY1l++cBd/UoPa6BH+hY
 1vdrLd5btWsC1FKz4+B3Truwj8n1IF/Q2ipnQidMohQYgDkB1c06Jh7F8I3nSysrDAyT
 dBcWfiEaJDPoPl493D1DSNL75ov9L1HAZtSIUJ+ScEt736Ux5370wxL9IQ09XlfKfwZp
 7DjV+QON6amW0whqhfCPoKBsEhC8HbzO4wwL5iBBSlFkNuDAZUUVukonoxDgxQo711L9
 BTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768205616; x=1768810416;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+f9G1hO5T1FbjqQd2cUtHLQJ5TUVFw9BqFIXfhIICKM=;
 b=nXCcvEsj8sDrBnXdupAqg1b8Kr6F/dvbk9H3KhHESDcQD74qLuSs6kKGUX19YHriRC
 hBLYZnARlvkjc9thV1Vfjkz+pvQ3cXX9YS3FyrVu3/tdM2J5033jCw8Kku6rrdEvjz6r
 uC/TQPDc+LB9Mgnw4nEgEowH0o69GmKJOQdg65vXrbuzjQvOTxCxrMfNrYgspm5Jtcaz
 IIVBX/bqMEQeiMGylPZoKAkZH60fuggkjQaRXY9uoQt/vW2ISfq1H1nio9aicA0dbTSv
 ziJJ9eA7dxDJgVX87+irupnLVV7kHQOpmRFkI/V/poX3R4KEAOChVrAAKzdHj4FjEpoX
 dGJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4IPqYyK0TV/oerCQLgFGAWIpLOZ+s4Xs9Frmrr+fUiofmVr2UnT+m/EnXDyub0vKauZA=@lists.linux.it
X-Gm-Message-State: AOJu0Yzvdriu4g/Q1t/vnju/4m2U0qJ9LbVCUOaUaiRAm67xhx/lp6kB
 puhC0vvNJ28rDcWRtMRIirgxrk2CxXsyoDn1CtsGFEY1ZwlF/ru5G0XZUhtAw0uUfpw=
X-Gm-Gg: AY/fxX5Fxnbqbyc2uDgcintMjf1SGwOkXblS2Bxm91Wd+tPdgn4R1LKwL08YOtQbTCp
 O+6RF5USQcEj/wP3aiOeap/LTPT0xu9rac9cBwkD5AQ4+TuOGDaASNgG1dDEcjBwC/JtpJYFhWz
 pdiK7q3HRwrvNHnbBJfhEFTRn75z+Q9HH6ciqC8QpnofA23lYfC2f2HV5q4CfT0IeqF+/EfWC0o
 ZJqM6InfMlFTmiwd7EiDUTVPKH1e7U/BOYR4jt5fji2B+wSEHu9uE761U7F5F5h5duNzkaE21l3
 5RdTa5QTggQT5pDAb7GXWUUvQG3a4T9TlukPZrULfXR65SYKe9XHv6fu7a4Zr82m1AcwzyDpIkI
 uUYef1uVe2KovIs3DPRJhjDW1Ix7Ij/PUvsl4v6HjxkzhEuRRLqyWeDpqvL09X5Wqr9Ez9EEc0e
 S2v63S1IVmY75lAY2t2A7F7vWqA9+M4SXYPNSENALl5NciIWtOPxUBJco4Fl5bqmXfZnzw20/qT
 xaTAtep27dxEhFDjA==
X-Google-Smtp-Source: AGHT+IEQEHP7vRZFcK4v49fjLhInJN4Plxr6t0KctyA6wRZ1AL2kCeVnYW6IUo89rpcbvS7n61lCHw==
X-Received: by 2002:a17:907:cd07:b0:b87:24e1:1a4c with SMTP id
 a640c23a62f3a-b8724e126cemr103393366b.35.1768205615882; 
 Mon, 12 Jan 2026 00:13:35 -0800 (PST)
Received: from localhost
 (p200300ef2f19f800fd6433c69db8d45a.dip0.t-ipconnect.de.
 [2003:ef:2f19:f800:fd64:33c6:9db8:d45a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a233fdfsm1884943966b.7.2026.01.12.00.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 00:13:35 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 12 Jan 2026 09:13:35 +0100
Message-Id: <DFMGKTNDFOLO.20XYMS3I1KIJO@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260111235751.201056-1-pvorel@suse.cz>
In-Reply-To: <20260111235751.201056-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Use :manpages_url: for man pages links
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Good catch.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
