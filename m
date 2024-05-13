Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D468C25B75
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 20:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715632123; h=mime-version :
 message-id : to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Ry+sO/URzuodQ26A43bOB6w33UI0EVQu2RMdPrP1scE=;
 b=I3yQOrQIPPajFWmtjkjoo9bQArz7iB5NLzBE/wtit/lfdw9APbclBXrpcbVJjZkuA0WiH
 j3VdoTHSj8oXarakOz9EdqnAjUmjKGlcFDFFITmkQpPJd+ntZVv3L5/V35yzFl9hw7o1m9e
 5P7sT6Lqsm5ZdUST4dARWNMDbYUgOmw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E25E3CF180
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 22:28:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 956313CDEBC
 for <ltp@lists.linux.it>; Mon, 13 May 2024 22:28:19 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=web.de
 (client-ip=212.227.17.12; helo=mout.web.de; envelope-from=wine.dev@web.de;
 receiver=lists.linux.it)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6DD811400B6F
 for <ltp@lists.linux.it>; Mon, 13 May 2024 22:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1715632097; x=1716236897; i=wine.dev@web.de;
 bh=uvLZtRkey8BrWHZHBUCA65JkDg/HJ1KjYETP607CDY8=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
 from:message-id:mime-version:reply-to:subject:to;
 b=EHpPSnRCCGW9dNPy6eeK8+K1VTxTY25CMwSMsyb9ungY9vGmCeWOkQdFpfEkXXDU
 TAVxe2o217YjxEr6MW16iIJcpaMxbk379TWxU74eLKkwHgIyakspzizmZQgaEPxef
 UMS1V4IlLqJ9OMTwBj9M8da9hm0sw8I1AWiW8D/k4xMXTR+MRGK/UsJDI9+6fNJOd
 kvQhTNUnfhoXBg7WyFT4QhPt83QMRnVq0FyNzbatLUOYkWnrrkxfHWpjMsEAgYjeE
 LQ7n1DC7sit5XFrp2AL51Vk6hVkIzQ/g9BJhW4uMwJnPBDQL6D9J+jezqodnHQ8fW
 qRrud6IeKmtavfBHAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [84.188.37.204] ([84.188.37.204]) by web-mail.web.de
 (3c-app-webde-bap30.server.lan [172.19.172.30]) (via HTTP); Mon, 13 May
 2024 22:28:16 +0200
MIME-Version: 1.0
Message-ID: <trinity-126eb986-5945-4f40-a313-c68bcc2c16cb-1715632096898@3c-app-webde-bap30>
To: ltp@lists.linux.it
Date: Mon, 13 May 2024 22:28:16 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:7wVG6ETgPTZrhTv1EGokAPrpe6vPlCIs9r9gMD7Y927MHfgyS8OxjcCnDD1wDuYUlxrp3
 tWmgHp7N/CSJkgvAZgLGlYwvsMvxD1eF8Xiba4NMInnF47DCDYXX05uU8rBvYE9v6vXtlh9N8Ihv
 6xCsWfnH60ISuM1Wa31cYBYtoOU4aR+OnGRb5Bb55s8E26nVvKKWXDnCSmj8pQXY/oAOip54RKQV
 EcdZJZQiz7RnWH4w39gh8pFqd+VTkBuIi4cZ0pT563fUtgC7QHWq4H3JQcjOAXxMvVKtdA6mb3Hf
 bM=
UI-OutboundReport: notjunk:1;M01:P0:S3LxSwdQ+nU=;9g54ouZwobCMmSgboiCgJisjZc+
 ida7n+a52hODEkrkRDbHyLeczdiyY0mFV80/+plo10HmEkPvW+G9bwbsjd9OLGg4UnpeH+Nwv
 IIc3rV0bznjG+/cb9Gf+1SGrLjnacBR60fThpPBQFloJE5V6Jte2NO2qv5Ls1A5CmCZHaCRe1
 HfN4W20PmSXQbExAqVB/lur2Ays6YFoVNyoph5/795c38iSHNPR1tFYYmRFdDPuLidovhDyeh
 kyieSHOZA0VKvm4rodiOCy0eyg+U/MivV+Z4Y8yPBMQ10tIe9EZrxLh9drMe+h6tViq0rjxOo
 UbuawRCX5Wa70hm3MkCnyG/DD3DuyU0ERxFuV6zGen+6nL2cdeYh16aLl5TrHF/2c7hSjjgFU
 8quJRJqPSx6th7zFDUL/IJ/XyGF0Fhv4/t2nvYvCElJzVW6kAQM6jy3FCD0ZurPMliNKys671
 eltfFNkOEsQvJm3/i13YJJFo8EhqHmjwy9HLEDQ5V3X5rAtqUSxSwNpbjiHyQDUspzFTyDEWR
 +hYz18ZzaGnJrcfJ4kVNCnrvNPjuWakDdPlnw3a+rHt/nEMaUxw5MEKdnoJ82vY0qsQbjQfC9
 MqtHas76VpmDDsTaHIYtRni9ZmwSGOFNG3O3pKbfDnPmBtw90QqtGuMlJCypxFbMXztqyHLvJ
 hiEjM7F4qS4v1Yr+opmyEwR9jJFcAIra3JnapcgTKMg+OhMPQkuF1iWzL+o26E4=
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH] open_posix_testsuite: Replace old -W commandline
 argument
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
From: Detlef Riekenberg via ltp <ltp@lists.linux.it>
Reply-To: Detlef Riekenberg <wine.dev@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


The Open Posix testsuite calls the compiler with the old
gcc commandline argument "-W", but that breaks other compiler

This patch renames the old "-W" to the more common "-Wextra"
(as suggested by LTP mailing list members).


Reference:
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

gcc 3.4 renamed "-W" to "-Wextra" in 2004:
https://gcc.gnu.org/gcc-3.4/changes.html

--
Regards ... Detlef

Signed-off-by: Detlef Riekenberg <wine.dev@web.de>
---
 testcases/open_posix_testsuite/include/mk/config.mk.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
