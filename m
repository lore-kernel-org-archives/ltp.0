Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0BDC5518E
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771582158; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=eIsUzZ/zCkn0YbOLvT6fWXM/T107JUVq1wmnVXu472w=;
 b=TEGSrUUHDMQxVK8Sq437BbdvUidqH3WzcHQ8NUApXc3JoC1BlFnOhdtrltYeErXMjb1eW
 Y2UAK5oMEvGowikKLkAW13uZYyjny3/ueSCl7dSuxyt25TM2iAi7+WTOyYjdbMGEKtyMRce
 eVmrr+A1nrygJwSiTK8As8RSaV1EX3A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 225F93D0817
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 11:09:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4CD3D07E9
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 11:08:54 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96F0E200AD0
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 11:08:53 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4833115090dso17764145e9.3
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771582133; x=1772186933; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33VXZ+rmBxpvRxJR2sWdqRMO7DOjSJ/zgs87J6tG2jQ=;
 b=COMvBeEgzqH54peI1DH4umOn6KvYtO4xxS5qGpiQIjzsIl/lA5XgVGK41OuzhUT1m3
 QXA3dUenlBp/QD8RTOMhcuWnmBjYZUpkvQM7K1y/Cfc4mO9OPP9gCEcfoyS52ETBr9bK
 m+UZ7q1gzMz6cS0u+PlTHUW0R55I4M1jPtomXWHMSKM1ytPCRV3giN3qf4W+zUmt0rZL
 9G+Z3Qi8c36OILaos14AHLrVmdXIWvMRvKMgF++1KdAKA2UCdz290w6M1sM+JSABRo9k
 b53JIXLtfYesT68BZC2FFTWFR6l7QsgsUH+FYblSenmrNkAjuyhAsidE9RVHIwvbXqru
 7MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771582133; x=1772186933;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=33VXZ+rmBxpvRxJR2sWdqRMO7DOjSJ/zgs87J6tG2jQ=;
 b=gU5NdzmkVXFtK6Z3rdF3rLBXlYPODgdapkIhf7kDGGwKOHytmQSnDRFMZTHM3tuQMj
 nzXaBpmglatloRMuyxFiwYvACy5+6IyMqad+he4w6lsBwehoDPeQtOXQTApZuoypaZ3Z
 OEDfTWGpx8Hbue8Jsx2ViifUfWvc+BJCFxoxrN1w/SL0jN82xDpmTNzaPKkRK5d33aRN
 Q4pmpPWxCEIGn+Wp7GQ1gQ/IqdVp4tnX1x+y038yBYnBzUMFctGSERTqOJO6C9HrLT92
 48rYEHTasg6R/KpmjU4JOjJJwAt6b1ZDmvwF+FoiWw8J4u2/dyWs+PHBLH+XmaUZqs8g
 P8hg==
X-Gm-Message-State: AOJu0YxyYFdw8qPNqhyKz7PlxQIVYVKtzI3FapwkYcdwYQ/g3ZxY4eKi
 DRJ0deGyzXjG8guxConUJXYTk4dVXwVjcpzN8iDnYz7V6dwQrwhnqNv0alfdBVUirFQ=
X-Gm-Gg: AZuq6aKqi+lhfn4T1ByzjqjEZ52iolKEn9V+IK6uk8+k95twrJ7ahBs48Jh+9kZ/uHY
 Qv6OJwLxE0laWJNhCqOiWGXxauQ91IthDZ+6DD901qG+BHtZ7Gf0bNjayczpEV+bazhYCoGwbYM
 PVSVjlckRV3xXkk95OvK0UTulFBfke4/5BUPEqye0AvJrObwuhDkC+LzfbIn+cb8OAj1uLr4D96
 07UCQMF82kZQocr+5JtNFlqtNFwKTFyuaqAE1IqSbyjAT5xTpR8B9ZKW0iVRx+w+EZORZEVBBxF
 VHp5j/XyyimAUIq3RQj28aefX53OYTTall17ezGnUPKqhhvcWaHyJSHwzxp/bzQ8JAq3+QeeBdG
 6J8/4c7RNxPJo++5A9Zdmgmn11L6P9wHyQy4kokM8Eq8saxMwFNGRHB1QoEQbhb9ccRlmqMj12D
 hT5ojoIytrbEdG9DE2/JypspvTBVvPqycalzI81dnUdwetcwcQN/rn+JXHd9dMiODxOvP1w/oLV
 5mfJZ6lXqrZ1J5DoNI=
X-Received: by 2002:a05:600c:35c8:b0:480:3a72:524a with SMTP id
 5b1f17b1804b1-48398b5e28cmr142089205e9.19.1771582132962; 
 Fri, 20 Feb 2026 02:08:52 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31bfef4sm94345965e9.7.2026.02.20.02.08.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 02:08:52 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 20 Feb 2026 11:08:52 +0100
Message-Id: <DGJPGC2SP94I.2UMW9XN3UT720@suse.com>
To: "Jan Polensky" <japo@linux.ibm.com>, <chrubis@suse.cz>, <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260219163030.69022-1-japo@linux.ibm.com>
In-Reply-To: <20260219163030.69022-1-japo@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] [STAGING] ioctl_pidfd06: accept
 EREMOTE/ESRCH for PIDFD_GET_INFO across pidns
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LGTM
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
