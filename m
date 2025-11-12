Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C3ACCF9F8
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 14:06:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3CA73CF793
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 15:06:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DAC83C9ACB
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:06:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D7CF01000762
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:06:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F86621BBB;
 Wed, 12 Nov 2025 14:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762956379;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAH5Kqu3foYTQC1njyZ+On+Gy2EGPFXTL98JyEuaT3w=;
 b=rWOzESnX8BDTiz01NYyMTLLnVQ/OVzC9mw9QgxNGYDUrC0RTEr0awTNmbvxVL/fwC6294Q
 CkZIxwqWQMGo6Bhk6w61Z/fIO03X5MIs4z/GC1eKFMYvdlmC7FxrOyFY5aJw0lL8eyDQPW
 S/kcOMVsqIcL2SX5d6VXXTgawlKJCcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762956379;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAH5Kqu3foYTQC1njyZ+On+Gy2EGPFXTL98JyEuaT3w=;
 b=lLBQA9BbOuZXrg4zNISQyG5M2bewk1PFgqLFhppw9op072wqFQDJmbTifqSJ3t9caiUMTK
 uoWtszUBF0EDO6Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762956378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAH5Kqu3foYTQC1njyZ+On+Gy2EGPFXTL98JyEuaT3w=;
 b=0dxbXclpbAZ06oiWsFL8W4spUR7dge9HyZ0fVCrcMIJeo8waBL4p+CtwuahdRGQblKdqOw
 LeDNN0U8FnRi1jGrwK9UgPxqCDLur0oTKa9hs2pZqw5ATAsaTqV6VOIL5qnLdccLilL2LC
 CKdR7hp3muXWFWt6JtCviyPk/Dwf4dA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762956378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HAH5Kqu3foYTQC1njyZ+On+Gy2EGPFXTL98JyEuaT3w=;
 b=nzkHhXUi4wmRnO3ToP94a0mpajkqwqCOSq4ILJdKmo3t7T9Q5taQDhu+wWowXTwedrIyvu
 2pUTw466jBkScQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D35BA3EA61;
 Wed, 12 Nov 2025 14:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7I1mMlmUFGn4GQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Nov 2025 14:06:17 +0000
Date: Wed, 12 Nov 2025 15:06:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251112140608.GA141617@pevik>
References: <20251110102407.15308-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251110102407.15308-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[email.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add basic shell test description
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

Thanks for this!
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Few notes below.

> diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
> index b6e8560d9..bad9f1f4b 100644
> --- a/doc/developers/api_shell_tests.rst
> +++ b/doc/developers/api_shell_tests.rst
> @@ -2,3 +2,94 @@

>  LTP shell API
>  =============
> +
> +Shell API overview
> +------------------
> +
> +First lines of the shell test should be a shebang, a license, and copyrights.
> +
> +.. code-block:: shell
> +
> +   #!/bin/sh
> +   # SPDX-License-Identifier: GPL-2.0-or-later
> +   # Copyright 2099 Foo Bar <foo.bar@email.com>
> +
> +A documentation comment block formatted in ReStructuredText should follow right
> +after these lines. This comment is parsed and exported into the LTP
> +documentation at https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html

+1. Great, I did not realize it's ok to use at least #doc part for normal shell
tests (i.e. these without shell loader).

> +
> +.. code-block:: shell
> +
> +   # ---
> +   # doc
> +   # Test for a foo bar.
> +   #
> +   # This test is testing foo by checking that bar is doing xyz.
> +   # ---
> +

I would frankly link the old API doc (and link :master:`testcases/lib/tst_test.sh`)...
https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Test-API.asciidoc

> +The shell loader test library uses the C test library internally by parsing a
> +special JSON formatted comment and initializing it accordingly. The JSON format
> +is nearly 1:1 serialization of the C tst_test structure into a JSON. The
> +environment must be always preset even when it's empty.

And here would have subtitle "shell loader test library".  Why? It'd be good to
admit we have plain shell (which uses tst_test.sh) and shell loader. Of course,
shell loader could be a mentioned first, then old API:

Shell Loader Test Library
-------------------------
The shell loader test library uses the C test library internally by parsing a
special JSON formatted comment and initializing it accordingly. The JSON format
is nearly 1:1 serialization of the C tst_test structure into a JSON. The
environment must be always preset even when it's empty.

Legacy Shell Test Library
-------------------------
See :master:`testcases/lib/tst_test.sh`) and
https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Test-API.asciidoc


.. warning::

    :master:`testcases/lib/tst_test.sh` is deprecated, please use Shell Loader
	Test Library.

> +
> +.. code-block:: shell
> +
> +   # ---
> +   # env
> +   # {
> +   #  "needs_root": true,
> +   #  "needs_tmpdir": true,
> +   #  "needs_kconfigs": ["CONFIG_NUMA=y"],
> +   #  "tags": {
> +   #   ["linux-git", "432fd03240fa"]
> +   #  }
> +   # }
> +
> +After the documentation and environment has been laid out we finally import the
> +`tst_loader.sh`. This will, among other things, start the `tst_run_shell`
Could we please instead `` use :master:`relative path` format which convert
source to the link:

:master:`testcases/lib/tst_loader.sh`. This will, among other things, start the
:master:`testcases/lib/tst_run_shell.c` ...

This will help people to look at the sources which is always helpful.

> +binary, that will parse the shell test environment comment and initialize the C
> +test library accordingly.
> +
> +.. code-block:: shell
> +
> +   . tst_loader.sh
> +
> +At this point everything has been set up and we can finally write the test
> +function. The test results are reported by the usual functions `tst_res` and
> +`tst_brk`. As in the C API these functions store results into a piece of shared
> +memory as soon as they return so there is no need to propagate results event
> +from child processes.
> +
> +.. code-block:: shell
> +
> +   tst_test()
> +   {
> +        tst_res TPASS "Bar enabled Foo"
> +   }
> +
> +In order for the test to be actually executed the very last line of the script
> +must source the `tst_run.sh` script.
> +
> +.. code-block:: shell
> +
> +   . tst_run.sh
> +
> +In order to run a test from a LTP tree a few directories has to be added to the
> +`$PATH`. Note that the number of `../` may depend on the depth of the current
> +directory relative to the LTP root.
> +
> +.. code-block:: shell
> +
> +   $ PATH=$PATH:$PWD:$PWD/../../lib/ ./foo01.sh

> +
> +
> +Test setup and cleanup
> +----------------------
> +
> +The test setup and cleanup functions are optioinal and passed via variables.
> +Similarily to the C API the setup is executed exactly once at the start of the
> +test and the test cleanup is executed at the test end or when test was
> +interrupted by `tst_brk`.
> +
> +.. literalinclude:: ../../testcases/lib/tests/shell_loader_setup_cleanup.sh
> +   :language: shell

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
