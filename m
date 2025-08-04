Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65312C87FCF
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754301822; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=TsJ8YoUTN4279Mq+sc61r0bWj0k2H1R8tKyFwIjzJSc=;
 b=je7MqYzLXM1Vkx6v7b02w9UfvqlgU1kvrWbuUxdeE48jIZuqgy7veZ/Oo/SQHTisiTmyb
 3CWNJQ0dfJ2mCycearvbTd+hitSs3eoduEDIVSvQA0DEqKptUf4BIXvp5yZB/OSxy5CvNje
 Ht1RYhiaY1ia4TxLaTQP86kEN1VOluA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99D573CCF2A
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 12:03:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92C2E3C8818
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 12:03:21 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51FC4200748
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 12:03:20 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ae0bde4d5c9so919764766b.3
 for <ltp@lists.linux.it>; Mon, 04 Aug 2025 03:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754301799; x=1754906599; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5J0ULrIMOwtj9LfOTRs+MTWtvVEWKkQ9hxH9sIm7oug=;
 b=Ala7Y2VOrfFOTTzzKPFpT0bG7ZfmLvSaFoklJs3LXZckbjqCYdwhkp91PVqQuKg5P5
 d/uZ2O0FmTipCIbVt2UMzDl/9C+DG078yWIVatBsplOhakIxGlgqPkLbNXQUT4mZJ0/I
 DubVcRp5QCZdXH73krNDfuCN51Fc7eUGdENMkedy/jwh0LgWWamahxNAfk7UIQLJGYGR
 Lfkav9gcpSBk+ogAzsvIvysVd5BU41KsoVyHNx5/fNPjo5JTvZz6j1VtUuUdctco2ffd
 JFV/5B9lxVB4gLpoQGMUfS2FINQow03e5T7hd83cKAf7m07d1RBb7xmmrbnuojPHSyBX
 U0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754301799; x=1754906599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5J0ULrIMOwtj9LfOTRs+MTWtvVEWKkQ9hxH9sIm7oug=;
 b=bTiqxWfFwC59YaXjL8Caxkoy/y4rh/guYDdZhVUs2/J5Ipkv3dkiwgWkJoqxtO0C/3
 HyBbf6HZskAPHmC5EawEhaukE45ZKIgFJ3Sh4JOtD0ZOOvmS61s3fg4xBNN7Ss1KgK9f
 XA21V7LNcY/SK0RoJKc2RYCwSwmCZxDNJ6oNAI9DEnT3kOIgGsoNvmTfQ0V1IXldJ/Jt
 fd8Y/vG6V7NvWK3OtPIBUkIas+x5z1TofQt2caLRK6GeLdz5jRR2UW/ug0p4yxbN/vZI
 r/gSlq0S8ZIRn3HQfsaM/iMvq+AqsoWkdCyMAkZ5U674Dao0NPqdM7xWXdxSZ5yxlB+v
 VQnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTOTZUF0nHP8e96PVcqF+pT31Z0qFVoKh/yFDQDfijUz20tA6za6XgAvHSMs7tmKRzhAM=@lists.linux.it
X-Gm-Message-State: AOJu0YyktlgoHCWSZx7AWqZkhdD9PFDrgs452PdRuyuBm1UtAZhrtcMq
 o5+q10RGPT+G17wDl5qio6i5v2c30U5XTndm+xL1uep2EAjbTjQztCTEsDT3moyta6i+iXTHqCR
 iiErZmNQ=
X-Gm-Gg: ASbGncvEpDrluF2e1+vaR+gftX+K04LD/kQOhebRe/ds2XKHeo3l0v0yu1NlwbgTwuB
 xZYHzaX8POtnm7lU1yASss6C0tnVRInqASqUw4afBz5VXyu+3VGGQg/Ijm/rpoKSPR3W9+u+vJH
 aaN/d7PZ1HtUxstJ3SFJiJoZ1hJLaDTBVwVyFURuX1nTyl/JStCjOZJlFt0IdKz5aY7Tpchkng2
 a0lX1iB4Vk3NlqpGF/a6mfKTgVsMer3WnQBbr+JOwfzy6nAvlx31Vwe57Y/u6NQewU46XmZPlT3
 7+XNoHz0WolPurmdm7rnEsycVoTUGNqXcPTnTJBZHaVlVmccHUBr3idf5NBz0pBEVn5SOfyy7WH
 0nrlsMjQnr3kFl3fAtOncCyxH5XSIOEXsBbUb4h+IVInr
X-Google-Smtp-Source: AGHT+IH1cQhXenVnhbO2QghjAm2Slm1zC476kOQ7iFDFQKXZyXksDGcvjSzkIYdhNUhbtQ5Fi+szBg==
X-Received: by 2002:a17:907:9689:b0:ae0:d332:f637 with SMTP id
 a640c23a62f3a-af940174b2dmr823217766b.31.1754301799509; 
 Mon, 04 Aug 2025 03:03:19 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.162.118])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a21c050sm698238566b.104.2025.08.04.03.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 03:03:19 -0700 (PDT)
Message-ID: <931b9765-a4e0-48e5-812f-ab3bd43569cd@suse.com>
Date: Mon, 4 Aug 2025 12:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: pvorel@suse.cz, ltp@lists.linux.it
References: <20250804093520.212221-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250804093520.212221-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH 1/1] commands: Remove eject
 test
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
Cc: automated-testing@lists.yoctoproject.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Go for it.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
