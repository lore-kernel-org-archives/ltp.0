Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755EAC44507
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 10:53:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9EC53E65C5
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 12:53:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B60463E1693
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:53:30 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D321600856
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 12:53:30 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-381072761d4so3204923a91.0
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784112809; x=1784717609; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rnppTMOdB55LiG6zG1VbDXyFZT2d0KeUPv2CvzYd0UE=;
 b=Y0M+521/AVerUgYMxn7LhxpBLJV/epLWuNbHfQytUJF5VHvgM1xqEYnlRnsvPPLWXp
 CKeYhvyjKbN2q2vsi45EDNMF/ZgnxJR9KJes2lJLvpI61XKDQfjj9Jqb8Q4pgTET449K
 +TPQltMZJEwxaUdLuyyewVXso8qQitHUbFUO9D57uIMpnAJ2FfFsHJP/+xI23jlLBvSV
 sHpV2QjNjX9yQzusCpXaSQtyxM7yLesA/X0wjdI1M5JBuP6bFJX9L0NzOXz1sdm4/sXG
 1kd5VfG4Xxx23U9jthVENrPTk4ErRw+fjT+VJGx+f33t8v1Vzla1KVBTgrF5oUQv4Z6D
 lQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784112809; x=1784717609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rnppTMOdB55LiG6zG1VbDXyFZT2d0KeUPv2CvzYd0UE=;
 b=WR7LUcZeaeAaDkAl3q6pPa50Uws+jJsATsnMTu1/aD5xAkEBsXS5Ta1CFQpMdNW0ui
 ywjxZV/nLlXT0Dity8+LuI2UXkCeUg9GQegfZb+k4G1ISsLUd3Zsg9sotdPm8mjSgPhh
 P1kE0VQnA7Gwi91H7TzubrDzjtzcHWnGBl4TGXBRuVWF68zAxDZpi8edZvlBDbIxJ3vl
 x/nkmftFJGwR0ug0782V2+LLkzAe+K59TcGhgwhCMWsfeMnNJ4YlhME1KfHssB2DCHTR
 ULbTXzJ+m033ewCyY9EyME7Ef93JZPi79RN959e1j/JijAQ3os+yHosQyZ9J0tQKUET1
 h9zQ==
X-Gm-Message-State: AOJu0YxV1GUluVQfFjnx4rvWRhNgrr8Ya2jfUMb/qmPEY9hiB62zmJR7
 IjwI++NPrs9td+Wh5qekDXX19NMMav7QDfuGTusjZcrbBn+Ac7A7UUT7
X-Gm-Gg: AfdE7ckisBZdHc2y8yX0DQppSy+hAabulPQ8AYZFJ/wd7yFrKiT0quUJQ9f7Q6r9e6p
 5q9Cw0l5fR7rnXQ9EJvoLS61WX+43vFcrrSbXPwZMaxOcmXmHIEvWcjl8o4Ft4IQETRNALiuFY9
 pKLwEI01PGyKZez2fUYVLeBu3fZxqqW9dlLZn3bU3Nk7kNX7+FqVCyK1Ehpa42Zi/vL98mlhohT
 KzuHsfTYtbLuoP6hKtSrvSL7qkSr+7LdQXLzhGJd97zaWPJZG4NpvvoC+7LsNTso8EEnnNtmfs7
 kU260sSMUqEFSNWEoVZtsgwjlgm9EOCfvCXRyGoupOuiZ1fJP4XZYfPLPafL6L9weiaGCRAfOMh
 95ISHUAqMXLDG1/AO4V+cQ4Rq0qFw1fAnyce3DyP8zYCQ4nqhz+jFUaNRrbnEilrHMjDaJ9CBX9
 VfDyx9bSWpUtosV3Tb7KTqQ+0j0UqkE0Q0rzbqtKDrxpG4bG/SPs7If8Dod6MB83QORsON/WZRk
 u97DmRf2MrOIIYTpWP77Y8CzI6QV/ns7cS/4X8=
X-Received: by 2002:a05:6a21:618e:b0:3c0:9c19:65c4 with SMTP id
 adf61e73a8af0-3c36c4c6042mr2606414637.76.1784112808583; 
 Wed, 15 Jul 2026 03:53:28 -0700 (PDT)
Received: from
 runnervm5mmn9.ykpjs2xbt34uxgulnpvtw1u53f.yx.internal.cloudapp.net
 ([128.24.163.97]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6c2b17sm200228eec.25.2026.07.15.03.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:53:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Gang Yan <gang.yan@linux.dev>
Date: Wed, 15 Jul 2026 10:53:27 +0000
Message-ID: <20260715105327.4173-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715075850.66118-1-gang.yan@linux.dev>
References: <20260715075850.66118-1-gang.yan@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] loongarch64.in: add memfd_secret syscall
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

Hi Gang,

On Wed, 15 Jul 2026 15:58:50 +0800, Gang Yan wrote:
> loongarch64.in: add memfd_secret syscall

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
