From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Feb 2019 07:52:09 -0500 (EST)
Subject: [LTP] [PATCH] adding s390x tests to ltp
In-Reply-To: <20190204161328.4616-1-elas@linux.vnet.ibm.com>
References: <20190204161328.4616-1-elas@linux.vnet.ibm.com>
Message-ID: <1740320205.101841684.1549543929404.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> ---
>  runtest/s390x_tools                           |  2 +
>  testcases/commands/s390x_tools/vmcp/vmcp_m.sh | 58 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 runtest/s390x_tools
>  create mode 100644 testcases/commands/s390x_tools/vmcp/vmcp_m.sh
> 
> diff --git a/runtest/s390x_tools b/runtest/s390x_tools
> new file mode 100644
> index 000000000..c88f0cac4
> --- /dev/null
> +++ b/runtest/s390x_tools
> @@ -0,0 +1,2 @@
> +#DESCRIPTION:s390x_tools tests
> +vmcp vmcp_m.sh

Hi,

There is already a runtest/commands, any reason for making new one?

> diff --git a/testcases/commands/s390x_tools/vmcp/vmcp_m.sh
> b/testcases/commands/s390x_tools/vmcp/vmcp_m.sh
> new file mode 100644
> index 000000000..d1f7752de
> --- /dev/null
> +++ b/testcases/commands/s390x_tools/vmcp/vmcp_m.sh
> @@ -0,0 +1,58 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2018 IBM Corp.
> +#
> +# Copying and distribution of this file, with or without modification,
> +# are permitted in any medium without royalty provided the copyright
> +# notice and this notice are preserved.  This file is offered as-is,
> +# without any warranty.
> +
> +#set -x
> +#
> +
> +TST_CNT=2
> +TST_TESTFUNC=vmcp_main
> +TST_USAGE=usage

Maybe also: TST_NEEDS_CMDS="vmcp" ?
Not sure if all s390x distros have this command installed.

But that should also be sufficient check to run this on any arch,
if command doesn't exist it will TCONF.

Regards,
Jan
