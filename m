Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6ECE7E62F
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:14:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2FD73CDC96
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 14:14:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1AF83C9981
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:13:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE4221001195
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:13:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9C5A1F855;
 Tue, 26 Sep 2023 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695730436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvmcm+uARnltcxIg4eY/WWpQL+7910Mop2ziojf96B8=;
 b=P1wcYr0DrNLSH42wkFJpz01/kyptUPIBJ5D/LD/2yUJSeN9cdutGMzztR6/ntlAHaHZqLK
 dSgVzcWh2vfiasSJGVdyAZ/9dzIjFnhsCAgrd/y1enqgzC5cKAFjcEEoHCdhaNBWyH4F4J
 5LxO232qVC9NlypzP6xwSMMRVRpr1U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695730436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yvmcm+uARnltcxIg4eY/WWpQL+7910Mop2ziojf96B8=;
 b=UK+uLN6s17J05uE2H+rcXAfYpt0L8QwQA9Tq45jHqj/6NQKBLJtUiebN/albUrmgmwv0y7
 2+05bX31N5ReaxAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A31E11390B;
 Tue, 26 Sep 2023 12:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lSqZJgTLEmU4DAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Sep 2023 12:13:56 +0000
Date: Tue, 26 Sep 2023 14:14:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZRLLL_h8V8rk-H3T@yuki>
References: <20230920095318.340582-1-pvorel@suse.cz>
 <20230920095318.340582-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230920095318.340582-6-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] doc: Update release procedure
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
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> * Mention release preparation (Li Wang).
> * Replace skeleton commands with the release scripts.
> * Update link to the release announcement.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/LTP-Release-Procedure.asciidoc | 111 +++++++++++++++++++++--------
>  1 file changed, 80 insertions(+), 31 deletions(-)
> 
> diff --git a/doc/LTP-Release-Procedure.asciidoc b/doc/LTP-Release-Procedure.asciidoc
> index cd7682fb8..26d85d1fa 100644
> --- a/doc/LTP-Release-Procedure.asciidoc
> +++ b/doc/LTP-Release-Procedure.asciidoc
> @@ -5,54 +5,103 @@ This page contains quick summary of what needs to be done to do a LTP release. I
>  
>  NOTE: The string YYYYMMDD should be substituted to the current date.
>  
> -1. Tag the git
> +1. Release eve work
               ^
	       ?
> +-------------------


> +a. Collecting the (must have) patch list for new release
> +b. Reviewing and merging the patch list of (a.)
> +c. Widely testing, explicitly post results
> +d. Tiny fix according to release testing
> +e. Writing release note

To be honest this list looks too sparse to be really useful, what about
a paragraph with more detailed explanations:

The release procedure generally takes a few weeks. In the first week or
two patches that should go into the release are reviewed and possibly
merged. These patches are either fixes or patches pointed out by the
community. Patch review, when finished, is followed by a git freeze,
which is a period where only fixes are pushed to the git. During that
period community is expected to run a LTP pre-release tests, reports
problems, and/or send fixes to the mailing list. In this period we are
especially making sure that there are no regressions in the test results
on a wide range of distributions and architectures. Once the
stabilization period has ended the time has finally come to proceed with
the release.


> +2. Tag the git
>  --------------
>  
> +Use './tools/tag-release.sh' script, which creates the tag and push it to github.
>  [source,sh]
>  --------------------------------------------------------------------
> -cd ltp
> -echo YYYYMMDD > VERSION
> -git commit -s -m 'LTP YYYYMMDD' VERSION
> -git tag -a YYYYMMDD -m 'LTP YYYYMMDD'
> ---------------------------------------------------------------------
> +$ ./tools/tag-release.sh
> +===== git push =====
> +echo "new tag: '20230516', previous tag: '20230127'"
> +tag 20230516
> +Tagger: Person-who-released LTP <foo@example.com>
> +Date:   Tue May 16 07:08:27 2023 +0200
>  
> -2. Push changes to github
> --------------------------
> -[source,sh]
> ---------------------------------------------------------------------
> -git push
> -git push --tags
> +LTP 20230516

Do we want to have the XXXXYYZZ here instead?

> +-----BEGIN PGP SIGNATURE-----
> +
> +iQJDBAABCAAtFiEEIBb+pIWLHDazLoM6wN7C7nLzOl8FAmRjD8sPHHB2b3JlbEBz
> +...
> +-----END PGP SIGNATURE-----
> +
> +commit 3ebc2dfa85c2445bb68d8c0d66e33c4da1e1b3a7
> +gpg: Signature made Tue 16 May 2023 07:08:08 AM CEST
> +gpg:                using RSA key 2016FEA4858B1C36B32E833AC0DEC2EE72F33A5F
> +...
> +Primary key fingerprint: 2016 FEA4 858B 1C36 B32E  833A C0DE C2EE 72F3 3A5F
> +Author: Person-who-released LTP <foo@example.com>
> +Date:   Tue May 16 07:08:08 2023 +0200
> +
> +    LTP 20230516

And here?

> +    Signed-off-by: Person-who-released LTP <foo@example.com>
> +
> +diff --git a/VERSION b/VERSION
> +index af4c41fec..ae488c0e7 100644
> +--- a/VERSION
> ++++ b/VERSION
> +@@ -1 +1 @@
> +-20230127
> ++20230516

And here?

> +Please check tag and signature. Proceed? [N/y]: y
> +===== Creating skeleton file for release notes =====
> +Skeleton file for release notes: /tmp/ltp-release-20230516
> +
> +Pushing changes to upstream git. Proceed? [N/y]: y
> +Enumerating objects: 1, done.
> +Counting objects: 100% (1/1), done.
> +Writing objects: 100% (1/1), 811 bytes | 811.00 KiB/s, done.
> +Total 1 (delta 0), reused 1 (delta 0), pack-reused 0
> +To github.com:linux-test-project/ltp.git
> + * [new tag]             20230516 -> 20230516
>  --------------------------------------------------------------------
>  
> -3. Prepare tarballs
> --------------------
> +3. Prepare tarballs and metadata documentation
> +----------------------------------------------
>  [source,sh]
> +Use './tools/create-tarballs-metadata.sh' script.
>  --------------------------------------------------------------------
> -cd ..
> -git clone ltp ltp-full-YYYYMMDD
> -cd ltp-full-YYYYMMDD
> -# Update mce-inject submodule
> -git submodule init
> -git submodule update
> -# Generate configure script
> -make autotools
> -# Prepare the archives
> -cd ..
> -tar -cjf ltp-full-YYYYMMDD.tar.bz2 ltp-full-YYYYMMDD --exclude .git
> -tar -cJf ltp-full-YYYYMMDD.tar.xz ltp-full-YYYYMMDD --exclude .git
> +$ ./tools/create-tarballs-metadata.sh
> +===== git clone =====
> +Cloning into 'ltp-full-20230516'...
> +done.
> +Submodule 'testcases/kernel/mce-test' (git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git) registered for path 'testcases/kernel/mce-test'
> +...
> +make[1]: Leaving directory '/home/foo/ltp-release-20230516/ltp-full-20230516/testcases/open_posix_testsuite'
> +===== Creating tarballs =====
> +===== Creating checksums =====
> +===== Creating metadata documentation =====
> +checking for a BSD-compatible install... /usr/bin/install -c
> +...
> +asciidoctor -d book metadata.txt -b xhtml
> +make[1]: Leaving directory '/home/foo/ltp-release-20230516/ltp-full-20230516/docparse'
> +make: Leaving directory '/home/foo/ltp-release-20230516/ltp-full-20230516/metadata'
> +'docparse/metadata.html' -> '/home/foo/ltp-release-20230516/metadata.20230516.html'
> +Generated files are in '/home/foo/ltp-release-20230516', upload them to github
>  --------------------------------------------------------------------
>  
> -4. Upload the tarballs to GitHub
> ---------------------------------
> +4. Upload the generated files to GitHub
> +---------------------------------------
>  
>  Click on 'releases' then switch to 'tags' then click on 'Add release notes' there should be 'Attach binaries ...' link at the bottom of the page.
>  
> -Don't forget to upload md5 and sha-1 sums for the tarballs as well.
> +Don't forget to upload checksums for the tarballs and metadata documentation as well.
>  
>  5. Send release announcement
>  ----------------------------
>  
> -Have a look at http://sourceforge.net/p/ltp/mailman/message/34429656/ to get the idea how it should look.
> +Have a look at https://lore.kernel.org/ltp/ZGNiQ1sMGvPU_ETp@yuki/ to get the idea how it should look.
>  
>  The announcement is send to:
>  
> @@ -64,4 +113,4 @@ CCed to:
>  
>  * lwn at lwn.net
>  * akpm at linux-foundation.org
> -* torvalds at linux-foundation.org.
> \ No newline at end of file
> +* torvalds at linux-foundation.org.
> -- 
> 2.40.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
