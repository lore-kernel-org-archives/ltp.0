Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DD4C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782809344; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nlXhe5M/4A70kv3qvp1lc28NjfHVVyQRm7pwELkd9BQ=;
 b=RefamVWrBw0jO4cXPNRVYXCLtVTIqWpxG6z09XuJdAIZx74Y70XyctYW078t/PU+J/THJ
 SGKjaBGQUp/vefHJDzqA0+dTORSr+RwUyShgMqFtfzJSUp7uvGBBEkBli6lNI9vDwZxXfkQ
 Et5ZyaHPJJMllFzNSwDbOT/KCcvyBA0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A28103E4B38
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:49:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 693B03E229D
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:48:44 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B6D861A0114E
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 10:48:43 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493b7612475so6393545e9.3
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782809323; x=1783414123; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=041HbhLOTCUupMd9+ocZc66nqCpU/i6f3HBERInujD8=;
 b=ObdpoCdi2ocH6gh51mcfWBlTfDf450y0NqE5XEQ8E57KfL91Jb8afdNX9FH1CJbvoo
 hfVg0q0XEwh8XO2WfcTi4KxplnFiK92Tc2zmdn8phGwzSYM6l2gXa6Ymb7CAIk7HAmfA
 CkCV2Xlo/rdf7yySqX6/h0a4CfyUhZ6D6xMszXNUcMwBLpHQ4g8QvudY1+BAOT0Ejrtw
 DCN8dOfHZo3bwfWV5oEODW0hTSTEgmHfS1bYnqzSDa3/S5910PPGo1RaX+NrTsgh6ILR
 +9geImaAqOKhtIzfa8Qg1ubs2jht6Wpd1A1hnJ4y+iiqwGZ4A3pMFfE10vXMzeo0S2uv
 bQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782809323; x=1783414123;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=041HbhLOTCUupMd9+ocZc66nqCpU/i6f3HBERInujD8=;
 b=Bvs0rXi5Ubzf51iyfydMqkcGlpy3t++6JxnjRmV4L3siubgO0bII2U9KY/zdOSn+/e
 /Ec6pQYVN4frNSMVqK8IvJ4PmAWj7qoiKWL+GDaRknnFWZ0RQFvZHN+pwkuuFkS7OVH1
 YBs9/S65eOoHTPSHkR4JjGYu/Gb2c5Ss8A29ajgx9HRpRRRYseMdcNVbFuocBgs4aCNW
 iZnOS0Z7ULGjxwhYdFxut4MvU5rmAINFfILyzUVfqXwkDjR44DDo6kOJWp5u16r4Kna/
 W8RvP/yJ+jn2/qLyiSSU04bFdStLnY+kfdI1C1MVRUdNB7RSpVwiM1EjWnCHV9G7g8zZ
 1neQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Eq1KZM+AVAzJytt+QGuB5t6RCYuY86W0UV+xJ0T34QQIWlMx3w3vgAtavtd2uLLR2cmA=@lists.linux.it
X-Gm-Message-State: AOJu0YwvByoUsdY2TlU1H/46R/t5lFYwoxaTkQuWAu+8wefpkOn4o0lD
 MF6ufwc01EWL/JYwqQJdt9Y0MjGp5rIQK8SEPmrazoqfcYAYzj0rO4gNf4u8Dy6Be9Bz1biCQoT
 2DB7k91/H3Q==
X-Gm-Gg: AfdE7cm0BG1fa+Qjh1o7CtB3IUuNimL2NaH7+r+Na94eh1aREYYv3yPyY03bAKdeeLm
 cP3vOrIGPPh9xcXFeyr8qe6ujAuKWEASvPFruYq58N97VrneAzqR7rqWY85Z2uioAka9VgJn2lr
 fdexrzMlyRkVK8URpIzAOg5qenargbm9aEbLQghgBPTudF5g0KY9vEpvdZRrpiYGEA26JA88ao7
 cLxno5JMfnOwnYZv7F98XOPLukzZMgyyL6uaAerjhDEw/HC2ph4TFDYJ5Bmw9zyu9HXXCCOwsEl
 7Qn/MIBroFa9Dz/2C6X3hSPRwdxtJvdq1wBRLQHOmK/tP5UzhirmPG87v8T+UfR7Sp9Ddw/6r0S
 BJ/anOT8OttP0lYrryFDo4YdzwVph+tb1vuxJ/pKSkFR7WhcUrkxd1zhmIvLXXOWM2fZGrp90o1
 x8nRAUZJnswEoVhLVZCjajzmfzGoUM358li+a6ePFYCQ2F28TWvT4KtumnrSdwcvjWi3DRD/w+w
 nkP7fZwazplEXfvfh75CqU4FNYCU5lRqnghiCeX93Wr6wkURTr83RLdGWM/MDTreQ0=
X-Received: by 2002:a05:600c:37cf:b0:493:bd2f:c5dd with SMTP id
 5b1f17b1804b1-493bd2fc698mr2196435e9.21.1782809322914; 
 Tue, 30 Jun 2026 01:48:42 -0700 (PDT)
Received: from p200300ef2f13eb00680747d6cefceff6.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8cb111fsm50638715e9.14.2026.06.30.01.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:48:42 -0700 (PDT)
Message-ID: <6a4382ea.abb839ae.10559d.dfe8@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260531000822.4114-1-linuxtestproject.agent@gmail.com>
Date: Tue, 30 Jun 2026 08:48:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb: Migrate library and numa helpers to libs/
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
Cc: ltp@lists.linux.it, Pradeep Susarla <pradeep.susarla@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pradeep,

can you please split the tse_hugetlb.h and tse_numa.h changes
into 2 separate commits? They are unrelated changes, but related
to a bigger picture that is the full patch-set.

The overall idea LGTM.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
