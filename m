Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6243EC433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 09:11:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5BBC3CAEFF
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 11:11:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD6FB3C6DE4
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:11:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 736151A01127
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 11:11:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 042BE21CA9;
 Thu, 13 Oct 2022 09:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665652272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWxmrVUWZR6RgAtNGl5Gr+OVeAqzmvjsaZkbXdEh1s0=;
 b=H8B0ewFfwgc5C4RJIThX6ViQ/tQTmuFnlbDYOITGgKrfiF5VwmtNgCjbRAbUcSRTTt4j+1
 Ezq6AWOs5oO2tquDN21r9/jiBZuhCwAGYle2MBv4gd93Rp2mACLoi1/YLWfXzs1csfMz5P
 YqBn0+5W94eSBh3u/jnuRa9yY1vEH84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665652272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qWxmrVUWZR6RgAtNGl5Gr+OVeAqzmvjsaZkbXdEh1s0=;
 b=o+3whGselQrw7SzGfPnFBuzRe6wiPsXQREAwgb06EOq3BwQFldxO8RFzZLnI9FWz1n/UtU
 XVraydoGVyT83KAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82CBB13AAA;
 Thu, 13 Oct 2022 09:11:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oV1nHS/WR2NhBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 09:11:11 +0000
Date: Thu, 13 Oct 2022 11:11:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Y0fWLY7XQWjS4Err@pevik>
References: <43b06441d7be49e6b3c06303abb3b41f@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <43b06441d7be49e6b3c06303abb3b41f@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add checking of needs_root
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi petr,

> The testcases referenced mount_device and needs_device are more than 88 in kernel/syscalls:

FYI I asked about the number of tests which need needs_rootgroup.
https://lore.kernel.org/ltp/Y0fAgGH6R8uEbcqh@pevik/

I thought these tests are somehow special (use root GID).
But if needs_rootgroup was meant for mount_device and needs_device I don't get
the point why (needs_root would be enough, but as Tim wrote that might be strict
for some people, thus we'd need the cyril's solution mentioned at
https://lore.kernel.org/ltp/Yx8I0ponDUIFC8le@yuki/

Or am I missing something obvious?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
