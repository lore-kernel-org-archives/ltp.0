From: Pengfei Xu <pengfei.xu@intel.com>
Date: Wed, 7 Nov 2018 21:20:04 +0800
Subject: [LTP] [PATCH ltp v2 1/2] Add Intel umip(User Mode Instruction
 Prevention) basic function tests
In-Reply-To: <20181107101520.GB8603@rei>
References: <20181101014928.23628-1-pengfei.xu@intel.com>
 <20181107101520.GB8603@rei>
Message-ID: <20181107132004.6dc7t36pxznb4xyb@xpf-desktop>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 2018-11-07 at 18:15:20 +0800, Cyril Hrubis wrote:
> Hi!
> > +# check kernel config already set or not
> > +kconfig_check()
> > +{
> > +	config_content=3D"$1"
> > +	result=3D""
> > +
> > +	if [ -r "/boot/config-$(uname -r)" ]; then
> > +		result=3D$(grep -E "^$config_content" "/boot/config-$(uname -r)")
> > +	# for clear linux, kernel config saved in /lib/kernel/
> > +	elif [ -r "/lib/kernel/config-$(uname -r)" ]; then
> > +		result=3D$(grep -E "^$config_content" "/lib/kernel/config-$(uname -r=
)")
> > +	elif [ -r "/proc/config.gz" ]; then
> > +		result=3D$(zcat "/proc/config.gz" | grep -E "^$config_content")
> > +	else
> > +		tst_res TINFO "No config file readable on this system"
> > +		return 1
> > +	fi
> > +	[ -n "$result" ] || return 1
> > +	return 0
> > +}
>=20
> Is there any other way how to find out UMIP has been enabled in kernel?
>=20
> I would like to avoid maitaing code that tries to look for all possible
> config locations if possible.
>=20
  Could find "Activated the Intel User Mode Instruction Prevention (UMIP)
  CPU feature" info in the head of dmesg, but afraid boot long time dmesg
  head is covered... And no sysfs file for umip to check.
  So could I add the info when cases failed=EF=BC=9A"possible due to
  kconfig not set CONFIG_X86_INTEL_UMIP=3Dy"?

> > +# check /proc/cpuinfo contain test function or not
> > +cpu_info_check()
> > +{
> > +	cpu_func=3D"$1"
> > +
> > +	[ -n "$cpu_func" ] || tst_brk TWARN "no cpu info check item"
> > +	grep -q "$cpu_func" /proc/cpuinfo || return 1
> > +	tst_res TINFO "/proc/cpuinfo contain '$cpu_func'"
> > +	return 0
> > +}
> > diff --git a/testcases/kernel/security/umip/umip_func.sh b/testcases/ke=
rnel/security/umip/umip_func.sh
> > new file mode 100755
> > index 000000000..8719409e3
> > --- /dev/null
> > +++ b/testcases/kernel/security/umip/umip_func.sh
> > @@ -0,0 +1,58 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (c) 2018, Intel Corporation
> > +# Authors:      Pengfei Xu - pengfei.xu@intel.com
> > +# Description: it's for Intel User Mode Instruction Prevention(UMIP)
> > +# function test, below instructions should be GP exception blocked if
> > +# Current Privilege Level (CPL) is greater than 0.
> > +# UMIP protected instructions are as below:
> > +#    * SGDT - Store Global Descriptor Table
> > +#    * SIDT - Store Interrupt Descriptor Table
> > +#    * SLDT - Store Local Descriptor Table
> > +#    * SMSW - Store Machine Status Word
> > +#    * STR  - Store Task Register
> > +#    kconfig requirement: CONFIG_X86_INTEL_UMIP=3Dy
> > +#    cpu requirement: /proc/cpuinfo need contain umip
> > +
> > +TST_CNT=3D1
> > +TST_SETUP=3Dsetup
> > +TST_TESTFUNC=3Ddo_test
> > +TST_POS_ARGS=3D2
> > +TST_USAGE=3Dusage
> > +TST_NEEDS_ROOT=3D1
> > +
> > +. tst_test.sh
> > +. umip_common.sh
> > +
> > +bin_name=3D"$1"
> > +parm=3D"$2"
> > +
> > +usage() {
> > +	cat <<__EOF
> > +	usage: ./$0  [bin_name][parm]
> > +	bin_name:  Test cpu bin name like umip_gp_test and so on
> > +	parm:  Test bin file parameter like 'g' and so on
> > +__EOF
> > +}
> > +
> > +# kernel config should set CONFIG_X86_INTEL_UMIP=3Dy
> > +# /proc/cpuinfo should contain umip
> > +setup()
> > +{
> > +	func_name=3D"umip"
> > +	config_umip=3D"CONFIG_X86_INTEL_UMIP=3Dy"
> > +
> > +	kconfig_check "$config_umip" \
> > +	    || tst_brk TCONF "kernel config not set $config_umip"
> > +	cpu_info_check "$func_name" \
> > +	    || tst_brk TCONF "/proc/cpuinfo no umip function"
> > +}
> > +
> > +# umip protect instruction should be blocked when user execute
> > +do_test()
> > +{
> > +	tst_res TINFO "Test $bin_name $parm"
> > +	EXPECT_FAIL "$bin_name" "$parm"
> > +}
> > +
> > +tst_run
> > diff --git a/testcases/kernel/security/umip/umip_gp_test.c b/testcases/=
kernel/security/umip/umip_gp_test.c
> > new file mode 100644
> > index 000000000..ae1068a60
> > --- /dev/null
> > +++ b/testcases/kernel/security/umip/umip_gp_test.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +/*
> > + * testcases/security/umip/umip_gp_test.c
> > + * Copyright (C) 2018 Intel Corporation
> > + * Author: Pengfei, Xu <pengfei.xu@intel.com>
> > + */
> > +
> > +/*
> > + * This test is for Intel User-Mode Execution Prevention(umip) test
> > + *
> > + * umip is a security feature present in new Intel Processors.
> > + * If enabled, it prevents the execution of certain instructions
> > + * if the Current Privilege Level (CPL) is greater than 0.
>=20
> It would be nice to write here in which generation of intel processors
> this feature was added.
>=20
  umip need Intel CPU of 11th-generation(maybe) Ice lake or newer to suppor=
t.

> > + * If these instructions were executed while in CPL > 0, user space
> > + * applications could not access to system-wide settings such as
> > + * the global and local descriptor tables, the segment selectors to
> > + * the current task state and the local descriptor table.
> > + * UMIP is enabled by default at boot.
> > + *
> > + * History:    Oct 23 2018 - created
> > + *        - Tested sgdt, sidt, sldt, smsw and str by asm in C
> > + *          all above 5 instruction should be #GP(general protection)
> > + *          exception in UMIP supproted and enabled platform, if
> > + *          disabled UMIP, will show instruction store results
> > + *        - Add parameter for each instruction test
>=20
> Since we store the source code in git we do not track history in
> comments in source files as it is tracked in the git commit messages.
>=20
  Sure, will remove them.

> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +
> > +#define GDT_LEN 10
> > +#define IDT_LEN 10
> > +
> > +void usage(void)
> > +{
> > +	printf("Usage: [g][i][l][m][t][a]\n");
> > +	printf("g      Test sgdt\n");
> > +	printf("i      Test sidt\n");
> > +	printf("l      Test sldt\n");
> > +	printf("m      Test smsw\n");
> > +	printf("t      Test str\n");
> > +	printf("a      Test all\n");
> > +}
> > +
> > +static void asm_sgdt(void)
> > +{
> > +	int i;
> > +	unsigned char val[GDT_LEN];
> > +
> > +	memset(val, 0, sizeof(val));
> > +
> > +	printf("RESULTS SGDT save at [%p]\n", val);
> > +	printf("Initial val:0x");
> > +	for (i =3D 0; i < GDT_LEN; i++)
> > +		printf("%02x", val[i]);
> > +
> > +	asm volatile("sgdt %0\n" : "=3Dm" (val));
> > +	printf("\nSGDT results in val:\n");
> > +	printf("val:0x");
> > +	for (i =3D 0; i < GDT_LEN; i++)
> > +		printf("%02x", val[i]);
> > +	printf("\nDone.\n");
> > +}
> > +
> > +static void asm_sidt(void)
> > +{
> > +	int i;
> > +	unsigned char val[IDT_LEN];
> > +
> > +	memset(val, 0, sizeof(val));
> > +
> > +	printf("RESULTS SIDT save at [%p]\n", val);
> > +	printf("Initial val:0x");
> > +	for (i =3D 0; i < IDT_LEN; i++)
> > +		printf("%02x", val[i]);
> > +	asm volatile("sidt %0\n" : "=3Dm" (val));
> > +	printf("\nSIDT results in val:\n");
> > +	printf("val:0x");
> > +	for (i =3D 0; i < GDT_LEN; i++)
> > +		printf("%02x", val[i]);
> > +	printf("\nDone.\n");
> > +}
> > +
> > +static void asm_sldt(void)
> > +{
> > +	unsigned long val;
> > +
> > +	printf("RESULTS SLDT save at [%p]\n", &val);
> > +	printf("Initial val:0x%lx", val);
> > +	asm volatile("sldt %0\n" : "=3Dm" (val));
> > +
> > +	printf("\nSLDT results in val:\n");
> > +	printf("val:0x%lx", val);
> > +	printf("\nDone.\n");
> > +}
> > +
> > +static void asm_smsw(void)
> > +{
> > +	unsigned long val;
> > +
> > +	printf("RESULTS SMSW save at [%p]\n", &val);
> > +	printf("Initial val:0x%lx", val);
> > +	asm volatile("smsw %0\n" : "=3Dm" (val));
> > +
> > +	printf("\nSMSW results in val:\n");
> > +	printf("val:0x%lx", val);
> > +	printf("\nDone.\n");
> > +}
> > +
> > +static void asm_str(void)
> > +{
> > +	unsigned long val;
> > +
> > +	printf("RESULTS STR save at [%p]\n", &val);
> > +	printf("Initial val:0x%lx", val);
> > +	asm volatile("str %0\n" : "=3Dm" (val));
> > +
> > +	printf("\nSTR results in val:\n");
> > +	printf("val:0x%lx", val);
> > +	printf("\nDone.\n");
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	char parm;
> > +
> > +	if (argc =3D=3D 1) {
> > +		usage();
> > +		exit(1);
> > +		}
> > +	else {
> > +		if (sscanf(argv[1], "%c", &parm) =3D=3D 1) {
> > +			printf("1 parameters: parm=3D%c\n", parm);
> > +			}
> > +		else {
> > +			printf("Get parameter failed.\n");
> > +			exit(1);
> > +			}
> > +		}
> > +
> > +	switch (parm) {
> > +	case 'a':
> > +		printf("Test all.\n");
> > +		asm_sgdt();
> > +		asm_sidt();
> > +		asm_sldt();
> > +		asm_smsw();
> > +		asm_str();
> > +		break;
> > +	case 'g':
> > +		asm_sgdt();
> > +		break;
> > +	case 'i':
> > +		asm_sidt();
> > +		break;
> > +	case 'l':
> > +		asm_sldt();
> > +		break;
> > +	case 'm':
> > +		asm_smsw();
> > +		break;
> > +	case 't':
> > +		asm_str();
> > +		break;
> > +	default:
> > +		usage();
> > +		exit(1);
> > +	}
> > +}
>=20
> The coding style is all messed up here and we also do not exit with zero
> at the end of the main.
>=20
> What happens to this process when it attepmts to execute one of these
> isntructions? Is it killed by a signal? I guess that we should run the
> instruction in a forked process here, wait it in the parent and check
> that it was properly killed.
>=20
  Instruction will be killed by signal SIGSEGV(#11) general protection.
  Will follow the ltp style to write and add the signal check.
  Thanks!

> --=20
> Cyril Hrubis
> chrubis@suse.cz
