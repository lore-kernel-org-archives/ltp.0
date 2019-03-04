From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Mar 2019 14:53:31 +0100
Subject: [LTP] [PATCH] added vmcp test
In-Reply-To: <20190304091247.2057-1-elas@linux.vnet.ibm.com>
References: <20190304091247.2057-1-elas@linux.vnet.ibm.com>
Message-ID: <20190304135331.GC27682@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  runtest/s390x_tests               |  2 ++
>  testcases/commands/vmcp/README.md | 29 ++++++++++++++++++
>  testcases/commands/vmcp/vmcp_m.sh | 49 +++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 runtest/s390x_tests
>  create mode 100644 testcases/commands/vmcp/README.md
>  create mode 100644 testcases/commands/vmcp/vmcp_m.sh
> 
> diff --git a/runtest/s390x_tests b/runtest/s390x_tests
> new file mode 100644
> index 000000000..0c2bf05a5
> --- /dev/null
> +++ b/runtest/s390x_tests
> @@ -0,0 +1,2 @@
> +# Those tests are designed to be executed in s390x environment (zVM or LPAR)
> +vmcp vmcp_m.sh
> diff --git a/testcases/commands/vmcp/README.md b/testcases/commands/vmcp/README.md
> new file mode 100644
> index 000000000..7ff79a89c
> --- /dev/null
> +++ b/testcases/commands/vmcp/README.md
> @@ -0,0 +1,29 @@
> +# vmcp tool and module test
> +
> +The tool allows Linux users to send commands to the z/VM control program (CP). 
> +The normal usage is to invoke vmcp with the command you want to execute.
> +
> +## Getting Started
> +
> +The test case contains one shell script:
> +
> +- **vmcp_m.sh**: *basically executes the vmcp tool with different parameters and verifies that 
> +              output and exitcodes are as expected*
> +

This description should rather be part of the top level comment in the
test. Nearly all LTP tests have description as a part of the test which
means that having it anywhere else would only confuse the users.

> +## Prerequisites
> +        
> +z/VM guest must be prepared to be populated with guest Linux OS.         
> +
> +## Running the tests manually
> +
> +Transfer the scripts to the target system and run:  
> +
> +./vmcp_m.sh
> +
> +## Versioning
> +
> +Tested already on SLES 12 SP3
> +
> +## License
> +
> +The files in this directory are licensed under the GPL v2+ license.

This information is mostly rendundant and useless.

> diff --git a/testcases/commands/vmcp/vmcp_m.sh b/testcases/commands/vmcp/vmcp_m.sh
> new file mode 100644
> index 000000000..f33b6fc71
> --- /dev/null
> +++ b/testcases/commands/vmcp/vmcp_m.sh
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#!/bin/sh
> +
> +TST_CNT=2
> +TST_TESTFUNC=vmcp_main
> +TST_USAGE=usage

This is still missing TST_NEEDS_CMDS=vmcp

> +. tst_test.sh
> +
> +usage()
> +{
> +cat << EOF
> +usage: $0
> +
> +OPTIONS
> +EOF
> +}

Do we really need a help that just prints the script name? I doubt so.

> +vmcp_run()
> +{
> +
> +        $2
> +        if [ $? -eq $1 ]; then
> +        tst_res TPASS "'$2' returned '$1'"
> +        else
> +        tst_res TFAIL "'$2' did not return '$1'"
> +        fi

Missing indentation inside of the if blocks.

> +}
> +
> +vmcp_main1()
> +{
> +        echo "verifyBasicVMCPCommands"

No echo in tests. Use tst_res TINFO. Also the message should be a
sentence, this is not a test indentifier but message that appears in the
logs.

> +        vmcp_run 0 "vmcp --version";
> +        vmcp_run 0 "vmcp --help";
> +        vmcp_run 0 "vmcp -v";
> +        vmcp_run 0 "vmcp -h";
> +        vmcp_run 0 "vmcp q dasd";
> +}
> +
> +vmcp_main2()
> +{
> +        echo "verifyErrorCondition"

Here as well.

> +        vmcp_run 4 "vmcp -L"
> +        vmcp_run 4 "vmcp -m q dasd"
> +        vmcp_run 1 "vmcp dasddasddasd"
> +}
> +
> +
> +tst_run
> -- 
> 2.17.2 (Apple Git-113)
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
