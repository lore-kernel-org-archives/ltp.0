Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A7BF44873
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775831598; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3/MQT+HnztCXIHkvA8DwIfAMLUbDr5RxWuI6Hjmksb8=;
 b=GFAYdftmR3TJTnbHRc6yyEbEB22jwDCE/2dm6DuNFPKk0dXPkYOJGliAGfqaOc/W1IE2O
 iGHMOeM9pYYSfZgG24n/NSwEt4i4bEy9bg1/VNrmt3au5lKEd+HvaOom5mp0hculKXfmytG
 mMOtMsJSzYVYaBAY33CvZLtxsUIwnmg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ED8B3E203E
	for <ltp@archiver.kernel.org>; Fri, 10 Apr 2026 16:33:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C054E3E203E
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 16:32:55 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5C71D600A65
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 16:32:54 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso22580215e9.1
 for <ltp@lists.linux.it>; Fri, 10 Apr 2026 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775831574; x=1776436374; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6LJL3T9tPVYMDAKXtxRxkzkxS3UCL/emmgIxkXwzAgI=;
 b=SCHPP79C5NoWDzQbAc+4ic9puq5g6ZOMHnGoI6dMDGO/SF1Kw2yBEg5QYF2Ut5Ps9v
 Y7o3lN2ad/pw2kWlXxmwjANa4kGmiI86nsjnAl0J58I0w/hlCPGE6UhkEisVCMODaEaO
 ApbC7BT0RyR6fv8O7N9Vs1oTcPwSkC/CvCD6EextDKaW987omnUS2yiop+QOZu72NS7X
 toaEcHE1SpR8CnzlAPj+iT9UNph/CC+5LOkRegpMqGz8HrUYhP1ycztU34Vclx+ogfTM
 ktETcnZIWDEK/WAzzxbb0k/C3vcp4cGtmxSJWlzh2Twh/n74tJUcTBjvIAeYjHOn5RuH
 StRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775831574; x=1776436374;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LJL3T9tPVYMDAKXtxRxkzkxS3UCL/emmgIxkXwzAgI=;
 b=MAU+LzasQsL6261/LCJPssqqhyIl7uc79ms7nbuwyQRKVjPTLz9aVbW0CgHjkBLvPW
 QWpHPwAhuImjuOasrDl57kaOicrQMHXTVNfMIDKDjbEKnCT8l7HdO+ZXDm4+K3FF/++d
 hOUPWzMyli/Oogcke4tJ/s8vopQ6JwAKhbb1la4Wp6hfd7x86CyL0wL0jSCunoW/EOZq
 MZrainETX/aemo1OSKtqvIxhaGnMTwWEsm4J9D5K0Oj4wYTwRKdI7F3l4TQVMd3E+IRZ
 uWkzQulSsWNST0HB1QUlJA0BqgpO0XAW5eJamDswuOuMYMg3mLoWiOH15MriS5iuRN0i
 MNkQ==
X-Gm-Message-State: AOJu0YxfrsNKLQHvz0YjVTzvv5opvrEomWKAoLrS8T8G5sZevlNngaKS
 kuvHqHTzv+Gons+x0l/kwxGGREZfoCQSNaKugJgaKR/ZrJNWAE9OFqdn5MLls3QA2rYXhPLgV7Z
 yaPFshRMINg==
X-Gm-Gg: AeBDieuhvi5Y44Bw+zICY39yJ1d23UcGlZch63tzZYjUXqtTuGNRC+C3OhJ65q1reGN
 hHTscj0xL0qUw0l4wVeBoNFnCUk1m6eyxSbLULQdRujjPStO9LFhkOLmyKPxLb/h3WNCGeh2ZIZ
 /lE09+hHhuSiqD7ddxzNLYQWYjZMEucnqauA9Ffflhv5NjF11PPKzJ0Ko+ZNCLLiXdMaqFQ1TTP
 lplJPGHoGaSuSbXqqkf9FYpZUDSisqkzZtIw8uQgxVEDx4D//xxn46am8/ZJURR9yr5u6tUBpWa
 PxivOeOVCsvpfO2/G+hT4slfR1mRJbSuFttI7N85UveWyEEHtSs8QtxsbhuhQsGfSDDh79FiJjz
 Ngbg0rKPSNITu9TKzBx5zvNx2PJgNMO2fH52I/Xs9FKrCUnl2cPm8dnlZhvE4bGYYK3i6lYY5Fa
 KE+b2ge6RuOWpnJCy8/BzMV3FK4nsyN1Xf/hWVqzRXIVG9ZaV7989ct6exQsfMG5cGkZFrlRNMw
 4LyRo1j0vv0ji61kY7Ky6qtqV3BvOxVNOk=
X-Received: by 2002:a05:600c:8b2f:b0:485:3423:727d with SMTP id
 5b1f17b1804b1-488d688d46cmr40806135e9.26.1775831573708; 
 Fri, 10 Apr 2026 07:32:53 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d53807d7sm128637215e9.10.2026.04.10.07.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 07:32:53 -0700 (PDT)
Message-ID: <69d90a15.050a0220.9b96e.ad00@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <adkFMHufCHMsp0u1@autotest-wegao.qe.prg2.suse.org>
Date: Fri, 10 Apr 2026 14:32:52 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] shmctl03: Fix 32-bit compat mode failure by
 forcing limits
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Wei Gao via ltp <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> I will update the subject line and use INT_MAX/UINT_MAX as AI suggested.
> But I'd prefer to keep TST_ASSERT_SATURATED_ULONG even without a current caller,
> as it completes the logic for the helper function. The logic is clear enough
> that an extra comment isn't needed also, if you are agree then i will sent next patch.

Fair enough, feel free to ignore that part and to send a new patch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
