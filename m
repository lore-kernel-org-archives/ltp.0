Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43188C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 13:00:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0794E3C9EDD
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 14:00:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA14D3C5446
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 14:00:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 232F9601C63
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 14:00:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 354AB1F3A8;
 Thu, 10 Feb 2022 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644498030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alIC7zPyyph8kxZOO6aBFQhCMjNS2/wx90O95FabKS4=;
 b=VkgvR+58yIDQgi3DvAkZqBItsvLm/xLYa/jfjzz/LmakcfQLmMb3nplgG+K+l5Ny4KsgxS
 Si7Bt84/Wg91mAZbxbxma70TysKdUEwjdNI3za2H88ZlCrOncO8HoXA/gYgJqKBJIVXLG3
 zz0E2RKWzZWquOhyA2t5CzKeZMcWFnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644498030;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alIC7zPyyph8kxZOO6aBFQhCMjNS2/wx90O95FabKS4=;
 b=wH0K9VE+aW3sR92bMJHn5s4XXA+stKf5t3zPatcbF+I/LudtnCbKF3XUaTD/DlP0RMkeu2
 LsMQtQe3USKfBNDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D41E13B84;
 Thu, 10 Feb 2022 13:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cdXgBW4MBWJHQwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 10 Feb 2022 13:00:30 +0000
Message-ID: <77bcf013-4ab3-5eb0-8a2c-9f346a5b1a77@suse.cz>
Date: Thu, 10 Feb 2022 14:00:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Kautuk Consul <kautuk.consul.80@gmail.com>
References: <CAKWYkK03vnioG=XBmGOzAruwVo_XtZgn9k+dw8HPXyvTwfaVQQ@mail.gmail.com>
 <YgUK/1qWA0qQ304h@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YgUK/1qWA0qQ304h@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open Question about KVM test-cases.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 10. 02. 22 13:54, Cyril Hrubis wrote:
> Hi!
> Currently there are no tests for KVM in LTP, however Martin Doucha is
> working on some CVE reproducers and send a RFC while ago (added to CC).

You can find the RFC patch below. I've rewritten a large chunk of the
code in the mean time and the example CVE reproducer doesn't actually
work (the setup is incomplete so it passes even when it shouldn't) but
I'm getting close to something that actually works. You can expect the
first finished version before the end of the month.

https://patchwork.ozlabs.org/project/ltp/patch/20220106165435.16556-1-mdoucha@suse.cz/

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
