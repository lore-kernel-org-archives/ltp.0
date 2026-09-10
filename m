Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CE2C79FBB
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 19:33:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 579403E9287
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 21:33:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 658943C2024
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 21:32:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CECFD600207
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 21:32:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8F9B1FED2;
 Thu, 10 Sep 2026 19:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789068773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13JG5ZJ8L1D8xV/itSNv+PR0lLIQZOXR7kgFF7ZxHmc=;
 b=LUoNCEUWMyWQqVzRw8JbLvZtUbCJxiM5OX6KenRCF/FSgU3xM8G1Vj0JgIYJ/R+MtvflUf
 YAkApN74bMsaXXidisABdTSCy4uZQlCJC36Gp2q1AJMEa+lXgJm4QdGiCDLV5oXKjTdyGl
 PXnAI9l3rNqGeMrW1BQIECKhdNe7dLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789068773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13JG5ZJ8L1D8xV/itSNv+PR0lLIQZOXR7kgFF7ZxHmc=;
 b=LJP8O2dk/ls8DLgr1fw+bkagREFpYTQnLFFL8bZsfieOV7zK2IJTzKzfm3G12KrrhETFuf
 JMbAb3vPipAVl1Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GDcGJt1Y;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5r2bXkBJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789068769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13JG5ZJ8L1D8xV/itSNv+PR0lLIQZOXR7kgFF7ZxHmc=;
 b=GDcGJt1YOOWuyD7mZJbEJ0jTlOB3JmRvM9OxtLrCKZOLLDXis4HgRjqsTEoimIve+Op87y
 CbRcxe027yAC9Iz86+SFhPFGxDE/q5I8F29feSZyH/RM3cN4LDhX7JHtdCHfpgx66Ph7TG
 CgU/V8v9f6QyDUBKVuVpelQk8cu8nZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789068769;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=13JG5ZJ8L1D8xV/itSNv+PR0lLIQZOXR7kgFF7ZxHmc=;
 b=5r2bXkBJvEAN8zVOzQ35skXhR5BnmmgLL2cHcdpgs945S+i8e7qqdg+1mXiExjAyu7oZmi
 GJ/8+kwfIac0EhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECC1A1326D;
 Thu, 10 Sep 2026 19:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0UGnMOAFo2pnCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 10 Sep 2026 19:32:48 +0000
Date: Thu, 10 Sep 2026 21:32:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260910193231.GB255237@pevik>
References: <20260910-fix_documentation-v1-0-44313069bbe8@suse.com>
 <20260910-fix_documentation-v1-2-44313069bbe8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260910-fix_documentation-v1-2-44313069bbe8@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A8F9B1FED2
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/9] doc: Correct guide and API descriptions
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Again, very good catches.  Thank you!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> diff --git a/doc/developers/build_system.rst b/doc/developers/build_system.rst
> index 8af431517..e62db7d97 100644
> --- a/doc/developers/build_system.rst
> +++ b/doc/developers/build_system.rst
> @@ -135,7 +135,7 @@ been fulfilled (libraries, headers, etc).
>      * - $(CC)
>        - The system C compiler

> -    * - $(CCP)
> +    * - $(CPP)

+1 (obviously nobody reads the docs as no human found that :)).

> +++ b/doc/developers/test_case_tutorial.rst
Test case tutorial would deserve update (some things are updated.
Also it might concentrate too much on git skills.

Also, it'd be nice to use link functions (tst_brk(), tst_res(), SAFE_CLOSE())
and TINFO/TCONF/... to kerneldoc, but I can do it later.

> @@ -205,7 +205,7 @@ please do:

>  This should build the test and then run it. However, even though the test is
>  in :master:`testcases/kernel/syscalls` directory it won't be automatically run
> -as part of the syscalls test group (e.g. not run via ``kirk -f math``).
> +as part of the syscalls test group (e.g. not run via ``kirk -f syscalls``).
>  For this we need to add it to the runtest file. So open :master:`runtest/syscalls`
>  and add the lines starting with a ``+``.

> @@ -292,7 +292,7 @@ Check coding style with ``make check``.
>  Install the LTP and run the test with runtest
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

> -Run ``statx01`` on its own, also using ``-I0`` amd ``-I10``.
> +Run ``statx01`` on its own, also using ``-i 10`` and ``-I 10``.
nit: Both ways are working, I usually use the shorter variant (-i0).

>  Call the system call
>  --------------------
> @@ -435,7 +435,7 @@ there is a system in place to handle it.
>          .min_kver = "4.11",
>      };

> -The ``TEST`` macro sets ``TST_RET`` to the return value of ``tst_statx()`` and
> +The ``TEST`` macro sets ``TST_RET`` to the return value of ``sys_statx()`` and
>  ``TST_ERR`` to the value of ``errno`` immediately after the functions
>  return. This is mainly just for convenience, although it potentially could
>  have other uses.
> @@ -589,6 +589,9 @@ again on the hard-link, then ``stat`` the file".

>      #define LNAME "file_to_stat_link"

> +    static int fd = -1;
> +    static int lfd = -1;
> +
>      ...

>      static void setup(void)
> @@ -600,10 +603,10 @@ again on the hard-link, then ``stat`` the file".

While you're at it, could you please fix ... indent?

Kind regards,
Petr

+++ doc/developers/test_case_tutorial.rst
@@ -612,7 +612,7 @@ again on the hard-link, then ``stat`` the file".
 
     static void run(void)
     {
-            ...
+        ...
 
         TEST(sys_statx(AT_FDCWD, LNAME, 0, STATX_BASIC_STATS, &statxbuf));
         if (TST_RET == 0)

>      static void cleanup(void)
>      {
> -        if (lfd != 0)
> +        if (lfd != -1)
>              SAFE_CLOSE(lfd);

> -        if (fd != 0)
> +        if (fd != -1)
>              SAFE_CLOSE(fd);
>      }


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
