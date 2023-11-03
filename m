Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3076FC4167B
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 14:58:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0E143CE94E
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 15:58:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAF913CC025
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 15:58:17 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C1EA814010E1
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 15:58:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68395210E0;
 Fri,  3 Nov 2023 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699023495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gg4TtdmhhIjKqqEtqeX20r7KI09bCBcy2XlpD6Hv0iY=;
 b=CkTCUJFvEI5FnLExIdmHe58HSvXQShHojkykC1+R++ci0QP5CGsxiuZ47WXg99FCeVgaS8
 eDe6k2Tf1LBYl3HiDt6b9Co3UP4QwUb5ary5kFIGNZaRy5Rcb2ZSbom4SSXP9eHKJ702Aj
 Fs2rbOXBgmKETHrGGaKvNs4jW/f3FNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699023495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gg4TtdmhhIjKqqEtqeX20r7KI09bCBcy2XlpD6Hv0iY=;
 b=7q+cmBi0Xr3Zwn1wg/0tDu/niAn32yjfv1sNkGIQSPFOuRxRfZhMP9eb1NbGPbnPFhc1sL
 /p4ZOln1IYXlkODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49A8C1348C;
 Fri,  3 Nov 2023 14:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gbeZEIcKRWVoIQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Nov 2023 14:58:15 +0000
Date: Fri, 3 Nov 2023 15:58:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231103145813.GA1084358@pevik>
References: <20231013074748.702214-1-pvorel@suse.cz>
 <20231013074748.702214-3-pvorel@suse.cz> <ZUJ8K9nna0Poa9FS@yuki>
 <20231103121201.GA1005170@pevik> <ZUTluqkrUOBLHw7G@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZUTluqkrUOBLHw7G@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] lib: Add .modprobe
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

Hi Cyril,

> Hi!
> > Yes, but see safe_cmd() in lib/tst_safe_macros.c. tst_cmd() is called with 
> > TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING, thus this is covered.

> TCONF_ON_MISSING means to TCONF when the command is missing, i.e. if
> modprobe is not installed on the system. When module is missing modprobe
> will return 1 so I suppose we have to handle the return value from the
> TST_CMD() or do I missing something?

Ah yes, you're right:
modprobe: FATAL: Module foo not found in directory /lib/modules/6.5.0-1-amd64
uevent02.c:134: TBROK: modprobe failed (1)

But unfortunately we will have to parse error log, because exit code is still 1 [1]:

return err >= 0 ? EXIT_SUCCESS : EXIT_FAILURE;

And indeed, although this would be expected:

# modprobe foo; echo $?
modprobe: FATAL: Module foo not found in directory /lib/modules/6.5.0-1-amd64
1

This would deserve different exit code:

$ modprobe dccp; echo $?
modprobe: ERROR: could not insert 'dccp': Operation not permitted
1

> > > modprobe -r please, rmmod has been deprecated for ages.

> > Ah, here goes the reason. Should it be replaced also in tst_module_unload_()?

> Yes please.

+1

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/tools/modprobe.c#n1047

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
