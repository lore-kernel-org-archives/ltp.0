Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSTNQ-0007vu-Ef
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 15:34:56 +0000
Date: Tue, 25 Mar 2014 16:34:31 +0100
From: chrubis@suse.cz
Message-ID: <20140325153431.GA10754@rei>
References: <4506ACC2AE90484D87F9A883BA36C21C548C89@LCHQEX03.lancope.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4506ACC2AE90484D87F9A883BA36C21C548C89@LCHQEX03.lancope.local>
Subject: Re: [LTP] Suggested patch for Debian distro testing, part 1 of 2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Joseph Beckenbach <jbeckenbach@lancope.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Let's give this a whirl.  I'm posting from my work account, which (sadly) interposes Outlook whether I want it or not.
> Apologies in advance if a lexical garble happens -- intellectual garbles are of course my own fault. :-)
> 
> This first part contains changes I'm pretty sure are minimal.
> Mainly just changing "sh" to "bash" on the shebang line, where my test runs had tripped up.
> Two pull the shebang line back to the top after a copyright header submerged it.
> And one removes a bash-ism from an m4 file, so `./configure` won't choke either.
> 
> Thanks!
> 
> Joseph
> ----
> Joseph Beckenbach, senior QA engineer : Automation
> 
> ====
> diff --git a/ltpmenu b/ltpmenu
> index d1d890f..6a2338b 100755
> --- a/ltpmenu
> +++ b/ltpmenu
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>  ################################################################################
>  ##                                                                            ##
>  ## Copyright (c) International Business Machines  Corp., 2001                 ##

This is fine.

> diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
> index ba53bc1..fd3d328 100644
> --- a/m4/ltp-kernel_devel.m4
> +++ b/m4/ltp-kernel_devel.m4
> @@ -54,7 +54,7 @@ if test -f "$LINUX_DIR/Makefile"; then
>  ^PATCHLEVEL = ,,p' ${LINUX_DIR}/Makefile`
>  fi
>  
> -if [[ -n "$LINUX_VERSION_MAJOR" -a -n "$LINUX_VERSION_PATCH" ]]; then
> +if test -n "$LINUX_VERSION_MAJOR" -a -n "$LINUX_VERSION_PATCH"; then
>  	WITH_MODULES="yes"
>  else
>  	WITH_MODULES="no"

This is important enough to deserve to be commited as separate patch.
I've pushed this change with your signed-off-by.


And for the testcases, I would rather see them fixed to be able to run
with POSIX shell because there were people running LTP on embedded HW
with BusyBox. Are the required changes more complicated than [[ vs. [?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
