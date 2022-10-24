Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552B3C38A2D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 11:25:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7F813C9817
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 13:25:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 338943C0475
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 13:25:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 63AB01400153
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 13:25:29 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id AE6F41FD91;
 Mon, 24 Oct 2022 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666610728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1wFVwOKNB4VH+gTObHcMFLQj4fZDqYHxdlnC+uV4UA=;
 b=RjIPjkvVaC/LnSK54XsGot3qvdkYBVBwZKqV7b2cDOsABO/VnD/MupuyjNi17A8/f+C2RK
 qvMLyUuXCJ3gAMSQuS9D1Y5y5P5W9T+8+310nXG3gK1ZnOEMkPTnuMjUtnXnMJDHUSRlCh
 rqXpeh3/s1XZHhcpYiuUDETH3LoIYSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666610728;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A1wFVwOKNB4VH+gTObHcMFLQj4fZDqYHxdlnC+uV4UA=;
 b=n0bXEkklQTsnw7N+Ya57WhnUqiqQuFOEYVRdRhiJx8paZRqMTAeiiTFtlfEghxY34gTbet
 g1glyK3Qq3b4GiCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 47C412C141;
 Mon, 24 Oct 2022 11:25:28 +0000 (UTC)
References: <20221014035615.185057-1-zhaogongyi@huawei.com>
 <20221014035615.185057-2-zhaogongyi@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 24 Oct 2022 12:20:22 +0100
In-reply-to: <20221014035615.185057-2-zhaogongyi@huawei.com>
Message-ID: <87eduxzcnt.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/nice06: new test for nice()
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Zhao Gongyi via ltp <ltp@lists.linux.it> writes:

> Verify that the errno is nonzero when callling of nice
> legitimately return -1.

This does not require a separate test and EPERM is the only errno that
is listed in the man page.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
