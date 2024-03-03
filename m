Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5B2C48BF6
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 13:14:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAD503CEC1C
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 14:14:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89DB73CCBCF
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 14:14:06 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D3B731A003D9
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 14:14:05 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 30D5E609D3;
 Sun,  3 Mar 2024 13:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709471644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLq18WS0b9DO5mm5/90pKBwn8NgHLqOFgUlu5nOKP2I=;
 b=qezblJIvKB52ujTb9j3PwaZSc6FVHHdZqOIH1IpEXPwA+ypFQvevzGiscstFaGE/HnPV6n
 VjYAmYgQacfgWZTS8dgoTf5MoSGUk7xrgQ3RtBn1NbX0exLOSA9sgKnX0v6Je34WXi1i5B
 lyeO3ZzBRfZJpj6GgfFxxIEZduWfiek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709471644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLq18WS0b9DO5mm5/90pKBwn8NgHLqOFgUlu5nOKP2I=;
 b=DtBW5zqiob6r1oJEIVaJ5r9cRhI5Sk7yJc/VDnB761Zs1bUloUn7LXOAk33pzEQmuVb1QL
 V/qMDwURRWnydvBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709471644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLq18WS0b9DO5mm5/90pKBwn8NgHLqOFgUlu5nOKP2I=;
 b=qezblJIvKB52ujTb9j3PwaZSc6FVHHdZqOIH1IpEXPwA+ypFQvevzGiscstFaGE/HnPV6n
 VjYAmYgQacfgWZTS8dgoTf5MoSGUk7xrgQ3RtBn1NbX0exLOSA9sgKnX0v6Je34WXi1i5B
 lyeO3ZzBRfZJpj6GgfFxxIEZduWfiek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709471644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OLq18WS0b9DO5mm5/90pKBwn8NgHLqOFgUlu5nOKP2I=;
 b=DtBW5zqiob6r1oJEIVaJ5r9cRhI5Sk7yJc/VDnB761Zs1bUloUn7LXOAk33pzEQmuVb1QL
 V/qMDwURRWnydvBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 04B4B139D1;
 Sun,  3 Mar 2024 13:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id P1JMOpt35GWUNwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Sun, 03 Mar 2024 13:14:03 +0000
Date: Sun, 3 Mar 2024 14:14:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20240303131402.GC1856074@pevik>
References: <20240301062716.3023-1-wegao@suse.com>
 <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5681819a-2a3a-4c47-a1f1-3f9f49c994d9@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_EQ_ADDR_SOME(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.80)[84.78%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] libswap.c: Improve caculate swap dev number
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

Hi Wei, Xu,

> Hi  Wei

> > I encounter a dead loop on following code in our test on ppc64 machine:
> > while ((c = fgetc(fp)) != EOF)

> > I think "/proc/swaps" is not normal file and can not get EOF in some situation,
> > so i use fgets a line and caculate swap dev number.

I guess the problem has been fixed by another patch [1], thus closing it in
patchwork. Please let me know if not.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/0f5d8c520d4e5b22325526eab41ed6bcad1847fc

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
