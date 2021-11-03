Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5DEC433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 09:19:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A15B61101
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 09:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A15B61101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F86C3C71E9
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 10:19:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37F993C67E6
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 10:18:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D9C9D1A0027A
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 10:18:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 160DA218EF;
 Wed,  3 Nov 2021 09:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635931131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ray30MK3nhCFWfSBf3KSCBTrGKqYgUhbJXUt+ZqVJ5s=;
 b=Isjl0mKhKQiYTGbVEsLtHTLmryDyx6QGa9ljjzwl+HA0YaRom3od60ItVK5IQvv1pFpTN5
 caLFIZNEW2+/MBKDUNezx4LOyYKRl/FwzL7gMsrfBqatQwWwPQO296P39j5f5w00KgLhH5
 gMI5Vhjsi+9ql+jnjq7zPw6QKAf3Ij8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635931131;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ray30MK3nhCFWfSBf3KSCBTrGKqYgUhbJXUt+ZqVJ5s=;
 b=EfR4BYBHQ2Mf2ErK1roKOdIPPifwMbfdZO0oJoWZMJNEDx3ZzN6xPPLyJTxkseCuRI9LZN
 g3YSifwWUOP89eCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0099013CE3;
 Wed,  3 Nov 2021 09:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MXwbAPtTgmHvbAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 Nov 2021 09:18:51 +0000
Date: Wed, 3 Nov 2021 10:19:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Krzysztof Dynowski <k.dynowski@samsung.com>
Message-ID: <YYJUMqGVWfoTo9qg@yuki>
References: <CGME20211103090509eucms1p3879e480f890ad8e00a40febd3cf98279@eucms1p3>
 <624569115.65438.1635930309226@mail-gb0-0>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <624569115.65438.1635930309226@mail-gb0-0>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Make global vars/funcs static, where possible #879
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Can you please send patches inline so that we can reply and comment on
them?

See also:

https://www.kernel.org/doc/html/v4.17/process/email-clients.html#email-clients


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
