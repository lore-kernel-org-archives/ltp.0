Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BB7C54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711109515; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=hnS1K+6nLoKc+z3t9NPxMqmfRKSEtF/8lTr3aQfwPQo=;
 b=WMbUE8dm006kyMsN6M4NkfuMzpcegiRYHf2Qbx7UNHH9g05pu2vgzEI2Ly7zomm/60pvW
 g8hCjxqhdi1aRguC8YSPNp1+eIKiXmblpfiPtfC5fo1fPNMKF7lVxYmNphV+9WhiTt1au6W
 pr9SEo4O9IdwMuSQ7CTxHIVqJEJKRzc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8692B3CFB9A
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 13:11:55 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7235D3CDB7E
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 13:11:35 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9EB126657DA
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 13:11:34 +0100 (CET)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56899d9bf52so2393613a12.2
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711109493; x=1711714293; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2SmbxK7hzDLzbMQWstYditOtCGC+ieSTlfbZGDKMrA=;
 b=IUC2vmmBMXYtSh2FX8c746DfRcuWjvQphR4votPbdH10jVBiYOvCp18cFnDzbuDfAS
 /Gm0zEQMugk1p8cFlmFTKyjnXl6VO2E42MDdjeLPtCJ16iEswjQHDZqeg46BQMofi91r
 uZL/rynTCsvgKqlJP/bjmTtF/UpIwaenXiOrEVUFJRZ/+lNxtNategZk8+cLJX/fMvnI
 0qKXND1jH12bUET/GqQSM5bbvNVlK/4ptaixPSqxTZVrptGCaHMhQaTXwSNedlnWXaAy
 e02m5NeHWGIph94aT9IPYB5bD5+mLpFcFF4f7VWjWdddvFeHx4sbgQqb2Ht2uT+RCYKK
 I1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711109493; x=1711714293;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M2SmbxK7hzDLzbMQWstYditOtCGC+ieSTlfbZGDKMrA=;
 b=EKMPLyNArFR0f9IEcNLwo+FeZUHptpbTC5bAKvaYmLmLDdJV5PR2rAK15MWsBGwoRm
 B/LGKe48kn8BCqV6V/k+oSGEtgSsMfIORnVqL0uXfCRv8A3UOKf4BHyhjiuRNJgUDnjs
 x1rgvTDyWtD7NbVkcgicxIwwlBgEoKfsVMGtiZyMb0JXvFfyf1l74I3dzufZTsV2xKhL
 2nehZoSLJIaGdwiIeG5AG9ZqV5ipezqMlI3sWgxHUN+TLOO+GZz/X6soJnGw/w6Zavoe
 ySfS5831Nm3UoYHtwrIs3AaU9zfhwSJkL2mG7NMz6hF35fugFuZ66Rx+K63FCb2G19aH
 mBEw==
X-Gm-Message-State: AOJu0YzRUceNCfBu2MnlGuijv4vocjpmd+ntu3i8zEpvp90RAezsg/dS
 GB7ZGgDW5TNndc4vKYOihA7vcFkNYtjQgk6XKkm5O0IWVi7MpFW+dd3AZPbNd+85O8a+qYfxzWQ
 c5CazsrrG
X-Google-Smtp-Source: AGHT+IEhkMYt+P9dXXz72xyHiVOfh5BZ/I0FV0pA1mXQg6mufPgD06tXamkpBAze2pWH0cYHTWIC8Q==
X-Received: by 2002:a50:d6d6:0:b0:566:ab90:1073 with SMTP id
 l22-20020a50d6d6000000b00566ab901073mr1510083edj.34.1711109493331; 
 Fri, 22 Mar 2024 05:11:33 -0700 (PDT)
Received: from [10.232.133.97] ([88.128.88.144])
 by smtp.gmail.com with ESMTPSA id
 bo19-20020a0564020b3300b0056bd13ce50esm977445edb.44.2024.03.22.05.11.32
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Mar 2024 05:11:33 -0700 (PDT)
Message-ID: <75b59f47-5e94-4293-8f9d-746aab4ef7d5@suse.com>
Date: Fri, 22 Mar 2024 13:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Next open monthly meeting request
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

Hi all,

as you noticed I took responsibility to manage the last LTP meetings. 
The next one will be the 3rd of April, but, unfortunately, that will be 
my last vacation day.
Which means I will be free the 4th of April. The reason of this e-mail 
is to kindly ask you if we can postpone the meeting from the 3rd to the 
4th of April, so I can attend it and show progresses around the new LTP 
documentation, which will be an important feature for our project in the 
next future.

If it's ok for you, please reply to this e-mail.

Thank you very much.

Kind regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
