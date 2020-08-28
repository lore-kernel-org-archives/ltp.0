From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Aug 2020 15:18:56 +0200
Subject: [LTP] [LTP v4 3/5] IMA: Refactor datafiles directory
In-Reply-To: <20200820090824.3033-4-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-4-pvorel@suse.cz>
Message-ID: <20200828131856.GA29915@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> --- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
> +++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
> @@ -1,6 +1,8 @@

>  #    testcases/kernel/security/integrity/ima/policy testcases Makefile.

> +#    Copyright (c) Linux Test Project, 2019-2020
> +#    Copyright (c) 2020 Microsoft Corporation
>  #    Copyright (C) 2009, Cisco Systems Inc.

>  #    This program is free software; you can redistribute it and/or modify
> @@ -20,12 +22,10 @@
>  # Ngie Cooper, July 2009


> -top_srcdir		?= ../../../../../..
> +top_srcdir	?= ../../../../../..

>  include	$(top_srcdir)/include/mk/env_pre.mk

> -INSTALL_DIR		:= testcases/data/ima_policy
> +SUBDIRS	:= ima_*
It looks this broke build on out-of-tree build:
https://travis-ci.org/github/linux-test-project/ltp/builds/722003659
https://travis-ci.org/github/linux-test-project/ltp/jobs/722003661
https://travis-ci.org/github/linux-test-project/ltp/jobs/722003662
https://travis-ci.org/github/linux-test-project/ltp/jobs/722003663
...

I'm sorry I overlooked that. I'll have look on Monday (unless anybody fixes it).

Kind regards,
Petr

> -INSTALL_TARGETS		:= measure.policy-invalid *.policy
> -
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
