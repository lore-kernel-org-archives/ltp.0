Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380B4C678D4
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 06:47:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 962053CCDFB
	for <ltp@archiver.kernel.org>; Fri,  3 Mar 2023 07:47:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B71363CB8E2
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 07:47:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DDED1600435
 for <ltp@lists.linux.it>; Fri,  3 Mar 2023 07:47:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA0EF22863;
 Fri,  3 Mar 2023 06:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677826053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Upc9Fgt+X0scgmZUmFqPrGECKWO7BCtKylecuoQOipk=;
 b=pf2i9OEbnl8M7YIyqtWKPk8y5kWct3cbpz3ViWDgyO8EwnZyKSAn9hbuS8KpdpceAYela9
 dblvnSdwymRw+RA/m4CIaIV/tFkzewnq9ZSfmE05OzEBaO5PjskG6ygZsty0dshdNGHiJq
 JW5j7pNM7Ak6pIzg2k75sJbJaSK8zSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677826053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Upc9Fgt+X0scgmZUmFqPrGECKWO7BCtKylecuoQOipk=;
 b=ONXbfHRDYUx+XkSC8gBzrw59vR+gGzVj97cOFYhRCs2JgHa4lUz55KSZf/MpSErq50szpz
 rD6LErUMF+Y00BBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 982391329E;
 Fri,  3 Mar 2023 06:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GkdxIwWYAWShGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 03 Mar 2023 06:47:33 +0000
Date: Fri, 3 Mar 2023 08:46:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230303074606.GA4255@pevik>
References: <20230301193332.27694-1-Liam.Howlett@oracle.com>
 <20230302141956.GA20234@pevik> <ZAECZhVuBCX2WTl7@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZAECZhVuBCX2WTl7@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mprotect: Add mprotect05 testcase
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
Cc: ltp@lists.linux.it, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Liam,

> Can we also add a git tag to the test? It looks like fix is in mainline
> in:

> commit 2fcd07b7ccd5fd10b2120d298363e4e6c53ccf9c
> Author: Liam R. Howlett <Liam.Howlett@oracle.com>
> Date:   Fri Feb 24 16:20:55 2023 -0500

>     mm/mprotect: Fix successful vma_merge() of next in do_mprotect_pkey()

Good catch, thanks!
Merged with git tag + added .gitignore and runtest/syscalls entry.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
