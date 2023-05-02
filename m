Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5BAC77B73
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 11:18:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58B483CB948
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 13:18:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5FF33CB8A0
 for <ltp@lists.linux.it>; Tue,  2 May 2023 13:18:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B98EE600641
 for <ltp@lists.linux.it>; Tue,  2 May 2023 13:18:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9081B1F8CC;
 Tue,  2 May 2023 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683026280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qp2djQYQkq3ZWh0ifNXZwHrv2HcgnoRvrzOuX7SiPoA=;
 b=CozL4pLM40pcLYcjmsLb/p+VARgTpf4jOXhbX1jFr6+mZGt4EEjMo59lbbrI1VCQkMgpSj
 Zhe7NpF9mXm4lZLIJJI6MuLEWPUMsVzWAlMfHi+Euf4rhYzg5cIBsiLXjMIUeYAgJ32fAL
 q2p8j5l3c1sodsRNNhkONfN9++GNTms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683026280;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qp2djQYQkq3ZWh0ifNXZwHrv2HcgnoRvrzOuX7SiPoA=;
 b=GxopCyGE3oode88q9E6Ls1/Vo3eEzoLVaIIKYb6Mc9mD0z5QQH1yzoj1s4LroT9/8QBgiq
 FcOZ2wgDMziQoVAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5491C134FB;
 Tue,  2 May 2023 11:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PCY9EmjxUGTiEgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 02 May 2023 11:18:00 +0000
Date: Tue, 2 May 2023 13:18:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20230502111813.GA3640896@pevik>
References: <20230427120800.27849-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230427120800.27849-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] dup01.c: use TST_EXP_FD macro and add inode
 check
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

> ---
>  testcases/kernel/syscalls/dup/dup01.c | 25 +++++++++++++++----------
...
>  static void verify_dup(void)
>  {
> +	TST_EXP_FD(dup(fd), "dup(%d)", fd);
IMHO only this is enough:
TST_EXP_FD(dup(fd));

Kind regards,
Petr

> +
> +	SAFE_FSTAT(TST_RET, &buf2);
> +	TST_EXP_EQ_LU(buf1.st_ino, buf2.st_ino);
> +
> +	SAFE_CLOSE(TST_RET);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
