Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56C0ECAAD1
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 14:52:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D608D3CA6F7
	for <ltp@archiver.kernel.org>; Wed, 31 Aug 2022 16:52:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CBDF3CA4E1
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 16:51:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1F0BA680E5A
 for <ltp@lists.linux.it>; Wed, 31 Aug 2022 16:51:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58BEC218FC;
 Wed, 31 Aug 2022 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661957514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXxfa5CvndonpaK4tpk++G+4yfreAoZVf6vWX/y+cCo=;
 b=JK0RTbVfonXQKhB9IfMlUD0EuoEAbL8MJNqYblPyNCFM3kZKBQGh7ziWHtelaLaKw2VrKc
 LcyQiNKad0unTYU6JAFNDxqk+dI/jYKacgrU4syhoP+VtyODByIA3WwBvdejexbdxp8ubF
 B6ziy/FjTIrgXbPN85A1m6umULX+6d8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661957514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXxfa5CvndonpaK4tpk++G+4yfreAoZVf6vWX/y+cCo=;
 b=adI9ejrMSGveMWYefh+fqgzElJdsJuWGdKctYNBh02BYlT89SMLKBGMYRe8JExLrY8aQVo
 OzuZrwKzGaqelJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4673513A7C;
 Wed, 31 Aug 2022 14:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3Z2SAYl1D2MkXgAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 31 Aug 2022 14:51:53 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Luo xiaoyu <luoxiaoyu9@huawei.com>, ltp@lists.linux.it
Date: Wed, 31 Aug 2022 20:21:50 +0530
Message-ID: <5857767.lOV4Wx5bFT@localhost>
Organization: SUSE
In-Reply-To: <Yw9VzAE1YhkwaR1f@pevik>
References: <20220831112620.54251-1-luoxiaoyu9@huawei.com>
 <Yw9VzAE1YhkwaR1f@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/open04.c: Rewrite open04.c using new LTP
 API --------------------
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Luo, Petr,

FYI, There is already a patch for this on the list which I had sent last month, it might have been missed.
http://patchwork.ozlabs.org/project/ltp/patch/20220714060722.18894-1-akumar@suse.de/


Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
