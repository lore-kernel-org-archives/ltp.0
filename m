Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TOTGl-0000DQ-AZ
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 13:02:43 +0000
Date: Wed, 17 Oct 2012 15:00:27 +0200
From: chrubis@suse.cz
Message-ID: <20121017130026.GB27890@rei>
References: <20121015182122.GA6698@rei.suse.cz>
	<1350443616-20186-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1350443616-20186-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] tools: add tst_ncpus/_max api to get number of
	CPUS
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
>  lib/tst_cpu.c             | 50 +++++++++++++++++++++++++++++++++++++++++++++++

Hmm, aren't you missing header for tst_ncpus() and tst_ncpus_max()?

> +/*
> + *   Copyright (c) 2012 Fujitsu Ltd.
> + *   Author: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> + *
> + *   This program is free software;  you can redistribute it and/or modify
> + *   it under the terms of the GNU General Public License as published by
> + *   the Free Software Foundation; either version 2 of the License, or
> + *   (at your option) any later version.
> + *
> + *   This program is distributed in the hope that it will be useful,
> + *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + *   the GNU General Public License for more details.
> + *
> + *   You should have received a copy of the GNU General Public License
> + *   along with this program;  if not, write to the Free Software
> + *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include "test.h"
> +
> +long tst_ncpus(void)
> +{
> +	long ncpus = -1;
> +#ifdef _SC_NPROCESSORS_ONLN
> +	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	if (ncpus < 1)
> +		tst_brkm(TBROK|TERRNO, NULL,
> +			 "failed to determine number of CPUs online");
> +#else
> +	tst_brkm(TBROK, NULL, "could not determine number of CPUs online");
> +#endif
> +	return ncpus;
> +}
> +
> +long tst_ncpus_max(void)
> +{
> +#ifdef _SC_NPROCESSORS_CONF
> +	long ncpus_max = -1;
> +	ncpus_max = sysconf(_SC_NPROCESSORS_CONF);
> +	if (ncpus_max < 1)
> +		tst_brkm(TBROK|TERRNO, NULL,
> +			 "failed to determine number of CPUs configured");
> +#else
> +	tst_brkm(TBROK, NULL, "could not determine number of CPUs configured");
> +#endif
> +	return ncpus_max;
> +}

Looking at the code makes me wonder if creating SAFE_SYSCONF() wouldn't
be more universal solution.

> diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
> index 59ce6be..faa49b5 100644
> --- a/tools/apicmds/Makefile
> +++ b/tools/apicmds/Makefile
> @@ -26,7 +26,8 @@ include $(top_srcdir)/include/mk/testcases.mk
>  
>  CPPFLAGS		+= -D_GNU_SOURCE
>  
> -MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp res resm)
> +MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp res resm \
> +			     ncpus ncpus_max)
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>  
> diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
> index fe7349b..a1ddb5c 100644
> --- a/tools/apicmds/ltpapicmd.c
> +++ b/tools/apicmds/ltpapicmd.c
> @@ -266,6 +266,12 @@ int main(int argc, char *argv[])
>  		else if (exit_value > 0)
>  			exit_value = 2;
>  		exit(exit_value);
> +	} else if (strcmp(cmd_name, "tst_ncpus") == 0) {
> +		long exit_ncpus = tst_ncpus();
> +		exit(exit_ncpus);
> +	} else if (strcmp(cmd_name, "tst_ncpus_max") == 0) {
> +		long exit_ncpus_max = tst_ncpus_max();
> +		exit(exit_ncpus_max);
>  	}

That part looks okay.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
