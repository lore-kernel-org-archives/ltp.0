Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3BDC0218D
	for <ltp@archiver.kernel.org>; Thu, 30 Jan 2025 11:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738237076; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=4wIzWQC7KNj5f1ySfm5S/dmCRH3LR31GFoH3zj5RKOg=;
 b=HeWOi5sQVgUoJLgWElPsjfuPFHqHUrZljSJORQVaJvAmRGiAOcEsnz6O0Y9SwEvI3ysJd
 C++qMACN4EbkI5VhsAsQAAuYvpHSiY4EAK+uZCyTNE+XFq0tPXh30d/9Mgct7B9Lza2PBUC
 M7Ozd1Q/syKS3NdW7mjbqjB7CoSEQ00=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F2423C76F4
	for <ltp@archiver.kernel.org>; Thu, 30 Jan 2025 12:37:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8B653C718D
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 12:37:34 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0890660562C
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 12:37:32 +0100 (CET)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso153122766b.3
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738237052; x=1738841852; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Wpc/aRD5iss2wpafbyjZsRKUGHwn1XkVQLhn2K57yc=;
 b=SvNrgW0XbgjBH+mgRSJc2qGhKS8dyNNA3LRd1cESwK+q+PLXRdYHrX2B4S95ArcxXR
 ULQYlHdb9XGjBulJ+1/lr9QkSSRnWhGwFXDEjz328Ueo9GQDSLEZEY40fWVmyVs4hRRM
 W0BsSJOZnjY3sUZlKmDvmOfMcxm6aBFn4kUCZ/azIYKLb902YoEMPzbVEBmoioYLhSkQ
 sSL91UhD1qc1r7AF+6+dzH4kSj7F2e8sdPSjxoMYfQ5rB2CYnmvw8PvYaSBCYf8j+aOI
 NeBtHt5GHJcVqHyIgrfwfp/MLfdEfV2AgOerGXbvVwm83oH39T7Dte1IFSiD2vbYJsLh
 gcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738237052; x=1738841852;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Wpc/aRD5iss2wpafbyjZsRKUGHwn1XkVQLhn2K57yc=;
 b=dPHQXW0qCLn3yx9FvOcIpEWrT0zvYHq0X4Ick9M/JFlKdqT/Sze6hFAKoA0h+NNCj6
 Z5pCP9SiBfN5WYBKM2/dIJQdv52BbXLz7O6kyRA7/BPa2kRpjQ4cUjVTlaoiyA1XL/Qm
 VpWCPiNwfLK8P9Ovc3zL//eI9np5nPfTbLsvh5Md3Pdu9oZMvwvN906wW+eTl9AL8PYP
 xHi9SnnbklK/yZP7KWrSUFIkyXEShETVUn44jEReSuWbqTMv1ybyVLpXw0uFalvxLSOs
 ghYH47JEMHJY9XpKYJkKyns9fV/kiGvsFjjUWducwBpixK83NzZC/9EVaWPBbCov9Vy4
 Pcow==
X-Gm-Message-State: AOJu0YxPeFLeRWEBETAa5x3BkcNaSTszumSJtR66uA5okqwCHqqlN1rE
 5INKth8SQrO/ZU/RQbrHlkESO31ivUQFrijTCMPOEZNlCOS8lGa1SsWpjcngy04TIigDQeE5R39
 EUyY=
X-Gm-Gg: ASbGncsk5/BXLPyNPWg7JiD7WHl1MKCl+RwsBEaJxEIlfXYp1Gd5e6wwSwT7exFa/Z6
 oE2mFKxmbc3Z9rwYwp+NZr4B8EScWlzY9iEvKhUJLuOa17+prXwsQ7KDakxOToDlBFou4SYzwNF
 cwY0qd/LXU/6xRfBya4PoimhRHjv3Gpuze/plXJpvXDAhY1lT2cybgwolpmxE+qv+0V2ZaKcwNF
 W+V6unK/uvgSEphrOWoM1//NfLdq3k/Pm2UcvH/epa8thxlVwXPLugqTBZFH5z6FGkLqIKR+VVW
 EG/oENXRqjVdI0nfiH4eAYcQdw==
X-Google-Smtp-Source: AGHT+IH+WVPiPC+unxmoV1u98mM0d1KNG0AIoTpcaHnZr60WX3UzCWfEo9J3wS5/DsAWsj/IAuaRzw==
X-Received: by 2002:a17:907:c28:b0:ab3:7720:d87c with SMTP id
 a640c23a62f3a-ab6cfdbddafmr744361266b.35.1738237052059; 
 Thu, 30 Jan 2025 03:37:32 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.75])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e4a34be6sm105069366b.158.2025.01.30.03.37.31
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 03:37:31 -0800 (PST)
Message-ID: <67cabd64-fb43-4d1a-a471-995fd51a0e2b@suse.com>
Date: Thu, 30 Jan 2025 12:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Test Project <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Meetings schedule
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

As you may have noticed, we haven't been able to follow our regular 
monthly schedule for LTP meetings. This has been due to time constraints 
on my end, as well as holidays and other commitments. As we enter the 
new year, I believe it would be beneficial to establish a consistent 
schedule so we can meet more frequently via public video calls.

I have a few proposals for our meeting frequency:

- Monthly meetings
- Meetings every two months
- Meetings after each release

I suggest we aim to hold our meetings during the first week of the 
month. If a meeting cannot be held due to public holidays, we can 
consider rescheduling it for the following week.

Please feel free to share your suggestions and vote based on your 
preferences. I look forward to hearing your thoughts! :-)

Best regards,
Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
