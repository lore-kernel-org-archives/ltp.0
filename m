Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE9B606A324
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Y32jZv8c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PXJKvtG7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794398461; h=message-id :
 to : date : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FKzLNUskMav1U9ytSzKEmAwBjE/troMme586qsauyYs=;
 b=Y32jZv8cjwMoevU0e0TkR+2rPPEKE8hfI3k2q/ztpx3iFV3UPP1B3ngTvU84ZK7D/cfvF
 eIqkqHjfsrCDvSlUXqI2f7kj1pTPAYt0lf4AUEz0z7Ij8UA2UAytRSQHIGGuiEtFjdSZEr8
 PniXgmWjdWVg2e5EGlxHesJnpZioMYk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CBD23EA0D7
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 13:01:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A1913CD699
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 13:00:41 +0100 (CET)
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 27D741A00A3C
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 13:00:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1794398433; bh=aJOQ2W+BscF0muZsVlXBC3BsjahHGdLqHoNrZQWeBOo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PXJKvtG7NoJ3VhYtnqRea1Xw4fWxf8E3TVKrm/K8SGsFPILZM561JGGgt7KsYNaPN
 lsm5I25omiuEhBNjpSQZIXf7OLbQbMfgdj0Oy9vGgSmBqnif7+p6wR3RCdKPbIrrn1
 bcsTXAtjkUPuvoZb7aiwaOlaII3PaQMsLkigeCUg=
Received: from LAPTOP-KQCD4QBN.localdomain ([123.121.144.196])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 1FB9807; Wed, 11 Nov 2026 20:00:31 +0800
X-QQ-mid: xmsmtpt1794398431t9pqpfc81
Message-ID: <tencent_31DCAB3A1723CF1E1623155B4571DD5F8808@qq.com>
X-QQ-XMAILINFO: NxKoLLhE22aTyTPlNyxciKNdU5e+DDHH/GLhGp6Ufnv/jhtL5ksLMy4BwojNbG
 24dbdAoGwXn8+HppD9RDVvj5OtnXFONK/uJXXC7+qv6z+loK57Jzi3rKX/JB7Uw5mg+G6UQ6As0D
 6TkRykBt2OCAiOjgRr9W4j0qfi4IMh8wGDyfTC98Asv5Ga0DP3dGNHD2cdl+v1hr9x4g+YotPA8s
 UW4vQlN2c4RP3889iNXfHA9uYLT3jggiTs51m77DbXIAFqVDqxvpPX1w8akvUmiYfzy/wYlMGYKK
 ZYc0pSoJI+sgR1MNcCxxR3s6DxvmNVsL1IBjYP5hkE90MxI3xr3oxu1bLI6BpUyqHUdUAdYyjXni
 KW2i9Ax6EmKbxT78/toZ3CJiiTw5qDLKsdf1LYWd4wfdSgn3kqRj69z0uJf40prfh0Jnaqmvq1Pd
 HlUu+dPwbvISI/5NGx1Q+ZK6V4RhA9EUN8WxbiV0lSdoq6S8FyE4BxIzOx1K76EDrK+ErRvzd9tr
 7VLpeGipo7PjEYjJy5dKCh/0e9YN6TaJ4kauXbYU9MFSrQ+fXzcZYMmr6XEpB67sRNcWo59mdclZ
 U286ZasLoQT6BWGmCgZScAYMsD5Np1/pfTmyXfHvjwqX8R1xJcnSoyMFdh9jS40kpppeL7kACFst
 m4isBTK2UblAJR+QL066ezRCOhufsfIFixBmUslU9UvvUaAXImUn6BHRjgTvZgFg6NJcovD294qC
 FnRXjyQPvjo0LptDH/ofcx7BXwIpiXEDOspdBP6r2T5BHranlqk9/BfUNRpqXqZWCdhaUUkhxAdC
 HKHtuUrH1WqFS2hLlTdlWgTiWcsKHoHV7287/6yuzPfVbDnYaGpKHYiux4+I4EdznbY0jVJd1K2w
 DrleYsMpnMK7+JV8gMzcttPGEaSgw3jZEuf3Vy3Taf2Q6o5j4ew6n6KwGV6QGUn8e64ydcO6K0rS
 JjaOzsmHpG6P2x88F7ANPxySt0rTrM0kXOhwv5HGlHbnbnE3dV46lT+exzPQFqX7bfAq+iRteUFB
 iADH6uBGrpqYDBJuaV4QhKp1SETJZmHwQLLYqa4Ht2kJeHej2QsJ+cfmxPS74mp+qX15Tsmgh1al
 2bzn4AaHs5JxVCXVs=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
To: ltp@lists.linux.it
Date: Wed, 11 Nov 2026 20:00:31 +0800
X-OQ-MSGID: <20261111120031.726-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104110021.7870-1-2063309626@qq.com>
References: <20261104110021.7870-1-2063309626@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_REPLYTO_END_DIGIT,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Harden safe_sysconf() and add madvise13
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wenyuan Li via ltp <ltp@lists.linux.it>
Reply-To: Wenyuan Li <2063309626@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

A gentle ping on this series. Both patches were Reviewed-by Cyril on
Nov 4 and the CI checks came back green. I noticed they are not in
master yet (as of Nov 11, HEAD 0ee0ca54).

Is there anything blocking them, or anything you would like me to
change? I'm happy to rebase on current master if that helps.

Thanks,
Wenyuan Li


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
