Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76205C4332F
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 20:39:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7726C3CBD6A
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 21:39:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B90703CB893
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 21:39:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA4D52003A6
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 21:39:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E26C3220D1;
 Wed, 14 Dec 2022 20:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671050373;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8amZlRMIh2ooZ2/P6e8DMNjnMraufJQ3ZuPPQwrcFlA=;
 b=cw7QFWnZXoh2x2KqcLp43AXOW/fnIpeBj2U73FGPwWw18TskJaZFK9FZglHnISrpznAQvM
 udTPfJX0QaoEYYXfqqGdzY6C/nCBttI+CPgduDLAHeilqK9scB25xWE4jSv0CyiPy6Dodf
 D93gPiqnhuioV96MEiojffXO7xoEzsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671050373;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8amZlRMIh2ooZ2/P6e8DMNjnMraufJQ3ZuPPQwrcFlA=;
 b=X2vUFHYuQjx2ivBt7zNfiULVZOe5baVHUhu0Yu0Njd+vxD0NqLXyffcz5cKImz5W/vxEMl
 oQsmuMTh3mGOJWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E591138F6;
 Wed, 14 Dec 2022 20:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /V1MDoU0mmPHYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Dec 2022 20:39:33 +0000
Date: Wed, 14 Dec 2022 21:39:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Zijun Zhao <zijunzhao@google.com>
Message-ID: <Y5o0gkRnpdWb0oCm@pevik>
References: <20221213003553.3693243-1-zijunzhao@google.com>
 <87359jshpc.fsf@suse.de> <Y5o0DF5paB5iox5p@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5o0DF5paB5iox5p@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] signalfd01.c: put the right round bracket to the
 right place in tst_resm
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Zijun,

also, more suggestions:

Add to each patch:
Signed-off-by: Zijun Zhao <zijunzhao@google.com>
You can notice all commits have this.
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
Richie asked you to do this and thus set your pat
https://patchwork.ozlabs.org/project/ltp/patch/20221213003553.3693243-1-zijunzhao@google.com/

Run 'make check-foo' on target you modify (substitute foo for make target).
That checks for common code mistakes and code style.

You can also use this to check your code:
https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
