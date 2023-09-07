Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B437EE14DF
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 10:42:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B05A73CE9B8
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 12:42:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B56153CB62A
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:42:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8958B1A027BC
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 12:42:25 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D53DD1F45F;
 Thu,  7 Sep 2023 10:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694083344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SsL2W+jIdnAtjwfENHsq73dMYzCG/hWhyYUpGx+xeA=;
 b=pEJuvd/6kBeZRxZTyBdNm/FAAgqwHg3eHdVnhfjAeZ9gqDDbrLULJFLYDHkSTiU/v1RrFL
 dBfZGv65ynMAu4/9kUqPgznFYBx+yn6ASb4b/2MNPkAD5BgJXwVw0U6jwxPRcY7W1Dv+sq
 lvGT0ovKhilM8NVf00ER4/PBALb5zyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694083344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6SsL2W+jIdnAtjwfENHsq73dMYzCG/hWhyYUpGx+xeA=;
 b=dY5ejpANWHD4wn8oh61w+iv5A/ZkSyOs0WEap025/zv1IhMpfQ0W2DR6y3HVWKG+o4XX7a
 yHg3AQkTFWR01CBg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 94B992C142;
 Thu,  7 Sep 2023 10:42:22 +0000 (UTC)
References: <014a7886-865f-109a-acc4-bc06ba92ce9b@linux.ibm.com>
 <20230829101327.3862937-1-vishalc@linux.ibm.com> <ZPg9qfsTeU0xoClt@yuki>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 07 Sep 2023 11:42:12 +0100
Organization: Linux Private Site
In-reply-to: <ZPg9qfsTeU0xoClt@yuki>
Message-ID: <87msxye039.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ebizzy: prevent integer overflow in 64-bit
 systems
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
Cc: srikar@linux.vnet.ibm.com, sshegde@linux.vnet.ibm.com, raj.khem@gmail.com,
 chris@mips.com, ltp@lists.linux.it, tdavies@darkphysics.net,
 Vishal Chourasia <vishalc@linux.ibm.com>, gaowanlong@cn.fujitsu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hello,

Merged!

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
