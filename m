Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED357C32773
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:42:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF0333CA1BA
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:41:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDBF73CA1A4
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:41:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 565B61000527
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:41:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A06D05CACF;
 Fri, 19 Aug 2022 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660905708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4W+7oLLUD7QZ0G78N+NETcRvTop3U2j3VRBOK06mA8=;
 b=www3jtikyc4kF0IpsaOqeFPhho77T4rKQMzrHhxhTFl6IcEwVgtukZy5S/LIn+xwxhfuvx
 xtnW0ANXTrP52pkRqGLO3Vslq1B0CVNP4JMEs8mjBeFksaehzrN+FR+7CSEtLlVzrCVKu6
 JAaMNqkNnqi6iqslfXn1Goq4co5tJg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660905708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o4W+7oLLUD7QZ0G78N+NETcRvTop3U2j3VRBOK06mA8=;
 b=2JyifsN+MIl+D2l0e7xmk9fJQlqP705mmeIaQXJ+H/n6zOH8UIWDgvGO2JWFB7Dx+X+89A
 SvoPPIZhScZUEJDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E6DA13AE9;
 Fri, 19 Aug 2022 10:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 73CUIexo/2KqHAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Aug 2022 10:41:48 +0000
Date: Fri, 19 Aug 2022 12:43:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yv9pYTr967Id2H+Z@yuki>
References: <20220818171724.9182-1-pvorel@suse.cz> <Yv9Jafy8AzSCH437@yuki>
 <Yv9lxML3bw61wI1o@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yv9lxML3bw61wI1o@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] bpf_prog0[5-7]: Run with
 kernel.unprivileged_bpf_disabled = 0
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I expected that as well, but well, I don't know why, but:
> 
> # cat /proc/sys/kernel/unprivileged_bpf_disabled
> 2
> 
> # id
> uid=0(root) gid=0(root) groups=0(root)
> 
> # ./bpf_prog05
> tst_buffers.c:55: TINFO: Test is using guarded buffers
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> bpf_common.c:16: TINFO: Raising RLIMIT_MEMLOCK to 10485760
> tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
> tst_capability.c:29: TINFO: Dropping CAP_BPF(39)
> bpf_common.c:39: TCONF: Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled
> bpf_common.c:40: TCONF: bpf() requires CAP_SYS_ADMIN or CAP_BPF on this system: EPERM (1)
> 
> Summary:
> passed   0
> failed   0
> broken   0
> skipped  2
> warnings 0
> 
> I.e. 1 or 2 kernel.unprivileged_bpf_disabled results bpf() returning EPERM for
> *all* users including root. 0 allows running again for all users, but we need
> root to set it 0 via .save_restore:

Ah, right, these tests test bugs in unpriviledged bpf and drop
priviledges before they start, see the CAP_DROP in the .caps in the
tst_test struct. So obviously we have to enable unprivileged bpf to run
them. So I guess the patch should go in as it is.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
