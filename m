Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F05C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 11:15:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED8693CD9BF
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 12:15:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2CD73C0181
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 12:15:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 207ED10007FF
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 12:15:12 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DFB3B1F383;
 Mon,  7 Nov 2022 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667819711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ykFJBx9INvoyuL43Tiz/CkIvnjq4jcyFvaoJDhgBVI4=;
 b=TySBuoI4MaiqyRq5FGxxmrkIy3poqMXMpfZKkIuIn4tIAQ4ZS5zVVoRErnqZhYRxBgX8vj
 9ST1FaBKTYUoxDOJuz09xMHMX1CsU0e12i2uJ9EZ1EdviewRRO60IIs2guQvoj2lS/2bHg
 4nxXp37t37Sws5CBiYbaLOYxLDYJClg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667819711;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ykFJBx9INvoyuL43Tiz/CkIvnjq4jcyFvaoJDhgBVI4=;
 b=ok6jBshudGp1vyywi0mcUXLg5tb2TTl9XjeOONxfbR2mdi99CQtt9+Orj+jgMIiCQ/UNJX
 Yi0ogltH7sZG6TAQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 778D62C141;
 Mon,  7 Nov 2022 11:15:11 +0000 (UTC)
References: <20221021065032.139738-1-zhaogongyi@huawei.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Mon, 07 Nov 2022 10:49:32 +0000
Organization: Linux Private Site
In-reply-to: <20221021065032.139738-1-zhaogongyi@huawei.com>
Message-ID: <878rknxbgm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork02: new test for fork()
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

> Verify that current workdir correctly inherited by child.

I'm not convinced by Cyrils comments that this should be included. I
doubt LTP would work if the CWD wasn't inherited by children. At least
in the common case. The test needs to do something more IMO.

Perhaps there has been a kernel bug involving fork and CWD? Perhaps
relating to new file systems and mount options. I doubt we will see
issues on a common setup. This isn't adding any test coverage in that
case.

Also the path to the CWD and the CWD are two different things. The
kernel generates the path on each invocation of getcwd IIRC.

Marking this as changes requested in patchwork. Although really, I think
effort should be directed at clone3 which is lacking a lot of coverage.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
