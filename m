Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C3DD767D8
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 16:32:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 332443CC423
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 17:32:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C98C3CC004
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:31:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 996D61A0D2CD
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 17:31:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39A4C2200C;
 Thu, 31 Oct 2024 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730392310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6d9kmttVVFZBAKb6Q3rBB+KjqTwwUt/paRioK2UkJs=;
 b=YF6iUZhu0e6ENv/Du+KQ4zrLlHiMIhpHKtcD758PC2gMnq9uGAEK32rd60gR/HaWV9Zw+s
 Fi/HimtHwd9TscTf+vj68nxjucZ6U2VF7e8OunAca21Kcryfii9yMXY26dsa7CKESQoLGK
 9lKFFcufA6yTvLEQeGaOYDk/Mxnsoho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730392310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6d9kmttVVFZBAKb6Q3rBB+KjqTwwUt/paRioK2UkJs=;
 b=NbHBKaInBKxdJrfGmXGssejjtV2T6c7if3NfSblyfDIZbQW5HrXUcCB+HeO6uJJS27XKJw
 4KN8u1/F8p2sjFBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730392310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6d9kmttVVFZBAKb6Q3rBB+KjqTwwUt/paRioK2UkJs=;
 b=YF6iUZhu0e6ENv/Du+KQ4zrLlHiMIhpHKtcD758PC2gMnq9uGAEK32rd60gR/HaWV9Zw+s
 Fi/HimtHwd9TscTf+vj68nxjucZ6U2VF7e8OunAca21Kcryfii9yMXY26dsa7CKESQoLGK
 9lKFFcufA6yTvLEQeGaOYDk/Mxnsoho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730392310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U6d9kmttVVFZBAKb6Q3rBB+KjqTwwUt/paRioK2UkJs=;
 b=NbHBKaInBKxdJrfGmXGssejjtV2T6c7if3NfSblyfDIZbQW5HrXUcCB+HeO6uJJS27XKJw
 4KN8u1/F8p2sjFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BCBF13A53;
 Thu, 31 Oct 2024 16:31:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /LW8CfawI2eyNgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 31 Oct 2024 16:31:50 +0000
Date: Thu, 31 Oct 2024 17:31:46 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZyOw8qyh3py6wO8t@yuki.lan>
References: <20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com>
 <20241031-generate_syscalls-v8-4-8e35a9d6783b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031-generate_syscalls-v8-4-8e35a9d6783b@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 4/4] Add documentation about syscalls.h
 generator
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

Hi!
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  doc/developers/test_case_tutorial.rst | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/doc/developers/test_case_tutorial.rst b/doc/developers/test_case_tutorial.rst
> index be9a0ea8bac1d690b4ed4879d110f87c3f2a381a..b48ea4a7a3594266466fcca364f5d0ff1e42d235 100644
> --- a/doc/developers/test_case_tutorial.rst
> +++ b/doc/developers/test_case_tutorial.rst
> @@ -302,24 +302,25 @@ for a distribution's C library version to be older than its kernel or it may use
>  cut down C library in comparison to the GNU one. So we must call ``statx()``
>  using the general ``syscall()`` interface.
>  
> -The LTP contains a library for dealing with the ``syscall`` interface, which is
> +LTP contains a library for dealing with the ``syscall`` interface, which is
>  located in :master:`include/lapi`. System call numbers are listed against the relevant
>  call in the ``*.in`` files (e.g. ``x86_64.in``) which are used to generate
> -``syscalls.h``, which is the header you should include. On rare occasions you
> -may find the system call number is missing from the ``*.in`` files and will need
> -to add it (see :master:`include/lapi/syscalls/strip_syscall.awk`).
> +``syscalls.h``, the header you should include.
>  
> -System call numbers vary between architectures, hence there are multiple
> -``*.in`` files for each architecture.

I would keep this sentence in there, probably as a last sentence in the
upper paragraph.

> - You can find the various values for the
> -``statx`` system call across a number of ``unistd.h`` files in the Linux kernel.
> +On rare occasions, you may find that system call number is missing from ``*.in``
> +files. In these cases, they will need to be updated using
> +`include/lapi/syscalls/generate_arch.sh` script as following:
        ^
	Just `generate_arch.sh` here, we list the full path in the code
	block, no need to repeat it here as well.

> -Note that we don't use the system-call-identifier value available in
> -``/usr/include/linux/uinstd.h`` because the kernel might be much newer than the
> -user land development packages.
> +.. code-block:: bash
> +
> +    $ include/lapi/syscalls/generate_arch.sh /path/of/linux/sources
                                                      ^
						      to

> +The script will generate all the needed ``*.in`` files according to the Linux
                                                            ^
							  accordingly
> +source code which has been used. Make sure that your Linux source code has
> +been updated to the latest version.
>  
> -For ``statx`` we had to add ``statx 332`` to :master:`include/lapi/syscalls/x86_64.in`,
> -``statx 383`` to :master:`include/lapi/syscalls/powerpc.in`, etc.  Now lets look at
> -the code, which I will explain in more detail further down.
> +Once the new syscalls files have been updated, to rebuild our ``syscalls.h``
> +file, please use ``./configure`` command.
            ^                         ^
	 re-run			      script


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
