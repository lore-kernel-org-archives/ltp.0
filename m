Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D3BCCD18E
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 10:55:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03C0A3CECFD
	for <ltp@archiver.kernel.org>; Wed, 15 Oct 2025 12:55:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C4B93CDDDE
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 12:54:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DE01920021C
 for <ltp@lists.linux.it>; Wed, 15 Oct 2025 12:54:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8EBFE1FB88;
 Wed, 15 Oct 2025 10:54:52 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 809A113A29;
 Wed, 15 Oct 2025 10:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5r1bHnx972i/MAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 Oct 2025 10:54:52 +0000
Date: Wed, 15 Oct 2025 12:55:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aO99sW4_5_ntsHNr@yuki.lan>
References: <20251014145020.178840-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251014145020.178840-1-pvorel@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 8EBFE1FB88
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] doc: Convert tst_kvercmp.h to RST
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
> Could you please check my English.
> @Cyril you're the author of the functions, please check my description.

Will do, btw some of the functions there are actually older than my
involvement in LTP...

>  doc/developers/api_c_tests.rst |  1 +
>  include/tst_kvercmp.h          | 78 +++++++++++++++++++++++++++++-----
>  2 files changed, 69 insertions(+), 10 deletions(-)
> 
> diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
> index ad384a1bbd..5ab945fe51 100644
> --- a/doc/developers/api_c_tests.rst
> +++ b/doc/developers/api_c_tests.rst
> @@ -41,6 +41,7 @@ Guarded buffers
>  Kernel
>  ------
>  .. kernel-doc:: ../../include/tst_kernel.h
> +.. kernel-doc:: ../../include/tst_kvercmp.h
>  
>  NUMA
>  ----
> diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
> index fbefa0f793..bfe943a304 100644
> --- a/include/tst_kvercmp.h
> +++ b/include/tst_kvercmp.h
> @@ -6,39 +6,97 @@
>  #ifndef TST_KVERCMP_H__
>  #define TST_KVERCMP_H__
>  
> -/*
> +/**
> + * tst_kvcmp() - Compare given kernel version with kernel in string.
> + *
> + * @cur_kver: Kernel version in string (struct utsname.release).
                                 ^
				drop the 'in', i.e. just "Kernel version string"

And maybe add:

"Everything after first three version numbers till the end of the string is ignored".

> + * @r1: Required major kernel version.
> + * @r2: Required minor kernel version.
> + * @r3: Required kernel patch level.

Requied is probably not the right word, since we just compare two kernel
versions. At this point we have no idea about the purpose of the
comparsion.

Maybe just:

@r1: Major kernel version.
...

>   * The same as tst_kvercmp() but running kernel version is passed as parameter
>   * instead of utilizing uname().
> + *
> + * Return: Negative if older, 0 if the same and positive if newer.
>   */
>  int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3);
>  
> -/*
> - * Parsers string into three integer version.
> +/**
> + * tst_parse_kver() - Parsers string into three integer version.
                             ^
			     Parses

Also the words in the sentence should be reordered as:

Parses a version string into three integers.

> + *
> + * @str_kver: Kernel version in string (struct utsname.release).
                                ^
				Here as well.

And we should probably add the sentence that everything after the three
numbers is ignored.

> + * @v1: Major kernel version.
> + * @v2: Minor kernel version.
> + * @v3: Kernel patch level.
> + *
> + * Return: 0 on success, 1 on error.
>   */
>  int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3);
>  
> -/*
> - * Returns distribution name parsed from kernel version string or NULL.
> +/**
> + * tst_kvcmp_distname() - Get the distribution name from kernel version string.
> + *
> + * @cur_kver: Kernel version in string (struct utsname.release).
                                 ^
				 Here as well.

> + * Return: The distribution name parsed from kernel version string or NULL.
>   */
>  const char *tst_kvcmp_distname(const char *cur_kver);
>  
> -/*
> - * Compares versions up to five version numbers long.
> +/**
> + * tst_kvexcmp() - Compares versions up to five version numbers long.


> + * @tst_exv: The tested kernel version in string (struct utsname.release).
> + * @cur_kver: The current version in string (struct utsname.release).

Drop the 'in' here as well.

> + * The return value is similar to the 'strcmp()' function, i.e. zero means
> + * equal, negative value means that the kernel is older than the expected value
> + * and positive means that it's newer.
               ^
	       This should probably be in the tst_kvercmp() description
	       as well.


> + * Return: negative if older, 0 if the same and positive if newer.
              ^
	      N (since we end the sentence with dot)
>   */
>  int tst_kvexcmp(const char *tst_exv, const char *cur_kver);
>  
> -/*
> - * Compare given kernel version with currently running kernel.
> +/**
> + * tst_kvercmp() - Compare given kernel version with the currently running kernel.

"Compare a kernel version against currently running kernel."

> - * Returns negative if older, 0 if the same and positive if newer.
> + * @r1: Required major kernel version.
> + * @r2: Required minor kernel version.
> + * @r3: Required kernel patch level.

Here as well, drop the Required.

> + * Parse the output from 'uname()' and compare it to the passed values.
> + *
> + * The return value is similar to the 'strcmp()' function, i.e. zero means
> + * equal, negative value means that the kernel is older than the expected value
> + * and positive means that it's newer.

Maybe it would be shorter and more to the point to explain here that
this is the same as calling tst_kvcmp() with `uname -r` as str_kver.

E.g.:

Parse the output from 'uname()' and compare it to the passed values.
This is shortcut for calling tst_kvcmp() with `uname -r` as str_kver.


> + * Return: negative if older, 0 if the same and positive if newer.
              ^
	      N
>   */
>  int tst_kvercmp(int r1, int r2, int r3);
>  
> +/**
> + * struct tst_kern_exv - describe vendor kernel.
> + *
> + * @dist_name: A distribution name, e.g. "SLES", "RHEL9", "UBUNTU"
> + * @extra_ver: A vendor kernel version to check, e.g. "5.14.0-441".
> + */
>  struct tst_kern_exv {
>  	char *dist_name;
>  	char *extra_ver;
>  };
>  
> +/**
> + * tst_kvercmp2() - Compare given *distro* kernel version with the currently running kernel.
> + *
> + * @r1: Major kernel version.
> + * @r2: Minor kernel version.
> + * @r3: Kernel patch level.
> + * @vers: struct tst_kern_exv.
                                  ^
The array has to be NULL dist_name terminated.

> + * The return value is similar to the 'strcmp()' function, i.e. zero means
> + * equal, negative value means that the kernel is older than the expected value
> + * and positive means that it's newer.

Here we completely miss the purpose of the function, something as:

Attempts to look up a distro specific kernel version from the
tst_kern_exv table first and if no match is found falls back to the
version passed in r1, r2, r3. The distribution name is detected either
from the kernel release string e.g. el9 is mapped to RHEL9 or as a
capitalized value of the "ID=" variable from /etc/os-release.

> + * Return: negative if older, 0 if the same and positive if newer.
              ^
	      N
> + */
>  int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);
>  
>  #endif	/* TST_KVERCMP_H__ */
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
