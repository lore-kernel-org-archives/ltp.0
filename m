Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531C0C54E5D
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 17:01:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA3593D00E1
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 18:01:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CC2B3CB2AC
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 18:01:13 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9C0931A01184
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 18:01:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11BA434C9D;
 Mon, 18 Mar 2024 17:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710781271;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RK+ftXkSXHr0PTk2Eny6wMAB2J7fSF1IaEMVy9YFvx8=;
 b=F6HmByIaHY26LLVjDQuHfH+0F4YNZUxaNslUcMoeUIFIqy4sSiYXCvOiMtYLt0KVIpuYaE
 jgf9WlTis1d8I6POzj00Ad7+XOti2kbarN5h8oCmdpxGPvlyQO/zYET1PJM8YxZfImWIsG
 7PZozhZ+d3AAMaEF5JYRr7vtXyk2zM0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710781271;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RK+ftXkSXHr0PTk2Eny6wMAB2J7fSF1IaEMVy9YFvx8=;
 b=iy7AzoT8qRzOjPITr6GmtSPNveds4FvV1+9ar5e3gLhJx1+KYxNEwBXWK0f9t5WYejrcNQ
 m9Rwluv+kD0QjUCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710781269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RK+ftXkSXHr0PTk2Eny6wMAB2J7fSF1IaEMVy9YFvx8=;
 b=uiV+UbSOCZBRjNiqF/ajhNc6CWjhCCF/TCBcH125e6+AnqvF31mlEqX7ulpu/XM+7N4jGy
 IzBK8XHe9l71eW05EnrNwg7Mde+gZ/IQCJArnSu1yCDY+69moPKMAQ8NMaAkiEGITATRl+
 GBMUe4jdbKT/JHQQJgfVN3LDvxGJuVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710781269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RK+ftXkSXHr0PTk2Eny6wMAB2J7fSF1IaEMVy9YFvx8=;
 b=uL1L+Ss4kqRc6x5PNmuj61sUYE/eRjwRoXXXzsrYLLrxXmD7HZSfLjn2nF+NTw+3qibUZh
 EZmz4IDIZApQsaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED056136A5;
 Mon, 18 Mar 2024 17:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +kvvOFRz+GUOcgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Mar 2024 17:01:08 +0000
Date: Mon, 18 Mar 2024 18:01:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240318170107.GC408613@pevik>
References: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6868ae95-b004-4fb2-8aac-7ccf96b32f90@suse.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ltp-acerv.readthedocs.io:url,readthedocs.com:url,linux-test-project.github.io:url,sphinx-doc.org:url];
 SUBJECT_ENDS_EXCLAIM(0.20)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] New LTP documentation!
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

Hi Andrea, all,

First, thank you for doing this POC.

> Hello everyone,

> as already mentioned in the monthly LTP meeting, Linux Test Project lacks of
> a nice and clean documentation that can be easily accessed by users,
> developers and maintainers.

This was from the start confusing for me, because we have docs in wiki and
metadata documentation. But the text below explains the main advantage :).

> The current LTP documentation is also not matching with our expectancy
> towards the entire project, which is has been heavily refactored and it has
> changed in the past years, providing a higher quality code and new testing
> features.

> For this reasons, we think it's time to move forward and to start working on
> documentation, helping people to use, to develop and to maintain LTP in an
> easier way, increasing quality of the overall project and to call more
> developers in the community.

> I started to work on documentation refactoring, re-organizing the overall
> structure. The first prototype can be found here:

> https://ltp-acerv.readthedocs.io/en/latest/index.html

+1, nice POC. I see from your github LTP fork it's generated via
.readthedocs.yml - +1 for docs sources staying in LTP main repository and
generated as a result of simple push.

I wonder what to make with our static page:

https://linux-test-project.github.io/

Could we somehow redirect it to our github URL or to docs on readthedocs.io?

> The idea is to move documents from the current asciidoc format to RST
> format, following the current kernel docs guide lines [1], and to move API
> headers descriptions from regular C comments to Doxygen format.

IMHO library docs generated with Doxygen is IMHO the main advantage.

> By using the powerful readthedocs service [2], it's possible to deploy a
> documentation website with one simple setup, using Sphinx [3] as the main
> documentation framework.

Maybe, we could later generate our metadata docs with Sphinx. To have single
source

Although markdown is supported elsewhere (if we one day want to migrate e.g. to
gitlab), using readthedocs.

> For now, website prototype is showing a couple of pages, but the overall
> structure is there and ready to be filled.

> The purpose of this email is to ask for feedback and ideas from the LTP
> community, so we can make documentation even better. Let me know what you
> think.

+1

I hope you plan to do the conversion and plan in the future to add Doxygen
generated docs (to actually add more content than what we have now with github
wiki).

Kind regards,
Petr

> Have a good day,
> Andrea Cervesato


> [1] https://docs.kernel.org/doc-guide/sphinx.html#writing-documentation
> [2] https://about.readthedocs.com/?ref=readthedocs.com
> [3] https://www.sphinx-doc.org/en/master

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
