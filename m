From: Petr Vorel <pvorel@suse.cz>
Date: Sun, 8 Apr 2018 21:19:54 +0200
Subject: [LTP] [PATCH 1/1] Remove ht_interrupt test case
In-Reply-To: <20180406145240.13120-1-clanig@suse.com>
References: <20180406145240.13120-1-clanig@suse.com>
Message-ID: <20180408191954.zugqfgfnddr3b2sm@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> Signed-off-by: Christian Lanig <clanig@suse.com>
> ---
> Balancing CPU interrupts has been removed from Kernel with Kernel commit
> 8b8e8c1bf7275eca859fe551dfa484134eaf013b in 2008. The interrupt affinity can be changed
> from userspace with syscalls and by setting the processor ID in /proc/irq/.
> Usually the irqbalance system daemon distributes the interrupts on the processors.
> Retrieving the distribution of interrupts in /proc/interrupts the ht_interrupt test case
> appears to test a userspace program instead of the Linux Kernel for contemporary release
> versions. Because of this reason it seems to having become obsolete. smt_smp_enabled and
> smt_smp_affinity do exist to test remaining kernel functionality.
> This patch should also fix https://github.com/linux-test-project/ltp/issues/211

>  runtest/hyperthreading                             |   1 -
>  .../sched/hyperthreading/ht_interrupt/.gitignore   |   1 -
>  .../sched/hyperthreading/ht_interrupt/Makefile     |  31 ---
>  .../hyperthreading/ht_interrupt/ht_interrupt.c     | 117 ----------
>  .../sched/hyperthreading/ht_interrupt/ht_utils.c   | 252 ---------------------
>  .../sched/hyperthreading/ht_interrupt/ht_utils.h   |  21 --
>  6 files changed, 423 deletions(-)
>  delete mode 100644 testcases/kernel/sched/hyperthreading/ht_interrupt/.gitignore
>  delete mode 100644 testcases/kernel/sched/hyperthreading/ht_interrupt/Makefile
>  delete mode 100644 testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c
>  delete mode 100644 testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
>  delete mode 100644 testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h

> diff --git a/runtest/hyperthreading b/runtest/hyperthreading
> index a0a2e2326..8c89cd48e 100644
> --- a/runtest/hyperthreading
> +++ b/runtest/hyperthreading
> @@ -1,5 +1,4 @@
>  #DESCRIPTION:Hyperthreading stress tests
>  smt_smp_enabled smt_smp_enabled.sh
>  smt_smp_affinity smt_smp_affinity.sh
> -ht_interrupt ht_interrupt

> diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/.gitignore b/testcases/kernel/sched/hyperthreading/ht_interrupt/.gitignore
> deleted file mode 100644
> index b9e72b006..000000000
> --- a/testcases/kernel/sched/hyperthreading/ht_interrupt/.gitignore
> +++ /dev/null
> @@ -1 +0,0 @@
> -/ht_interrupt
> diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/Makefile b/testcases/kernel/sched/hyperthreading/ht_interrupt/Makefile
> deleted file mode 100644
> index 2ff6f04ba..000000000
> --- a/testcases/kernel/sched/hyperthreading/ht_interrupt/Makefile
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -#
> -#    sched/hyperthreading/ht_interrupt testcases Makefile.
> -#
> -#    Copyright (C) 2009, Cisco Systems Inc.
> -#
> -#    This program is free software; you can redistribute it and/or modify
> -#    it under the terms of the GNU General Public License as published by
> -#    the Free Software Foundation; either version 2 of the License, or
> -#    (at your option) any later version.
> -#
> -#    This program is distributed in the hope that it will be useful,
> -#    but WITHOUT ANY WARRANTY; without even the implied warranty of
> -#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -#    GNU General Public License for more details.
> -#
> -#    You should have received a copy of the GNU General Public License along
> -#    with this program; if not, write to the Free Software Foundation, Inc.,
> -#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> -#
> -# Ngie Cooper, July 2009
> -#
> -
> -top_srcdir		?= ../../../../..
> -
> -include $(top_srcdir)/include/mk/testcases.mk
> -
> -MAKE_TARGETS		:= ht_interrupt
> -
> -$(MAKE_TARGETS): $(patsubst $(abs_srcdir)/%.c,%.o,$(wildcard $(abs_srcdir)/*.c))
> -
> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c
> deleted file mode 100644
> index 38f235ec8..000000000
> --- a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_interrupt.c
> +++ /dev/null
> @@ -1,117 +0,0 @@
> -/***************************************************************************
> -                          HTinterrupt.c  -  description
> -                             -------------------
> -    email                : sonic,zhang@intel.com
> - ***************************************************************************/
> -
> -/***************************************************************************
> - *                                                                         *
> - *   This program is free software; you can redistribute it and/or modify  *
> - *   it under the terms of the GNU General Public License as published by  *
> - *   the Free Software Foundation; either version 2 of the License, or     *
> - *   (at your option) any later version.                                   *
> - *                                                                         *
> - ***************************************************************************/
> -#include "ht_utils.h"
> -#include <unistd.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include "test.h"
> -
> -char *TCID = "ht_interrupt";
> -int TST_TOTAL = 1;
> -
> -#define INTERRUPT_NAME	"/proc/interrupts"
> -
> -int HT_InterruptDistribution(void)
> -{
> -	FILE *pFile;
> -	int ci[32], cj[32];
> -	int cpucount, i;
> -	int cmax, cmin, d;
> -
> -	tst_resm(TINFO, "Get interrupts distribution with HT.");
> -
> -	if ((cpucount = get_cpu_count()) <= 0) {
> -		return 0;
> -	}
> -
> -	if ((pFile = fopen(INTERRUPT_NAME, "r")) == NULL) {
> -		return 0;
> -	}
> -
> -	fgets(buf, 255, pFile);
> -	fscanf(pFile, "%s %d %d %d %d %d %d %d %d \
> -%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \
> -%d %d %d %d %d %d %d %d", buf, ci, ci + 1, ci + 2, ci + 3, ci + 4, ci + 5, ci + 6, ci + 7, ci + 8, ci + 9, ci + 10, ci + 11, ci + 12, ci + 13, ci + 14, ci + 15, ci + 16, ci + 17, ci + 18, ci + 19, ci + 20, ci + 21, ci + 22, ci + 23, ci + 24, ci + 25, ci + 26, ci + 27, ci + 28, ci + 29, ci + 30, ci + 31);
> -
> -	fclose(pFile);
> -
> -	for (i = 0; i < 10; i++) {
> -		sleep(1);
> -		printf(".");
> -	}
> -
> -	if ((pFile = fopen(INTERRUPT_NAME, "r")) == NULL) {
> -		return 0;
> -	}
> -
> -	fgets(buf, 255, pFile);
> -	fscanf(pFile, "%s %d %d %d %d %d %d %d %d \
> -%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d \
> -%d %d %d %d %d %d %d %d", buf, cj, cj + 1, cj + 2, cj + 3, cj + 4, cj + 5, cj + 6, cj + 7, cj + 8, cj + 9, cj + 10, cj + 11, cj + 12, cj + 13, cj + 14, cj + 15, cj + 16, cj + 17, cj + 18, cj + 19, cj + 20, cj + 21, cj + 22, cj + 23, cj + 24, cj + 25, cj + 26, cj + 27, cj + 28, cj + 29, cj + 30, cj + 31);
> -
> -	fclose(pFile);
> -
> -	printf("\n\n");
> -	printf("Timer interrupt counts per CPU:\n");
> -	d = cj[0] - ci[0];
> -	printf("%d ", d);
> -	cmax = cmin = d;
> -	for (i = 1; i < cpucount; i++) {
> -		d = cj[i] - ci[i];
> -		printf("%d ", d);
> -		if (cmax < d)
> -			cmax = d;
> -		if (cmin > d)
> -			cmin = d;
> -	}
> -
> -	printf("\n\n");
> -	printf("max value: %d\n", cmax);
> -	printf("min value: %d\n", cmin);
> -	printf("\n");
> -
> -	if (cmin == 0 || cmax / cmin > 10) {
> -		return 0;
> -	} else {
> -		return 1;
> -	}
> -}
> -
> -// return 0 means Pass, return 1 means Fail.
> -int main(void)
> -{
> -	tst_resm(TINFO, "Begin: HyperThreading Interrupt");
> -
> -#if (!defined __i386__ && !defined __x86_64__)
> -	tst_brkm(TCONF, NULL,
> -		 "This test suite can only execute on x86 architecture.");
> -#else
> -	if (!check_ht_capability()) {
> -		if (HT_InterruptDistribution())
> -			tst_resm(TPASS,
> -				 "Interrupt distribution is balanceable.");
> -		else
> -			tst_resm(TFAIL,
> -				 "Interrupt distribution is not balanceable.");
> -	} else {
> -		tst_brkm(TCONF, NULL, "HT is not enabled or not supported.");
> -	}
> -#endif
> -
> -	tst_resm(TINFO, "End: HyperThreading Interrupt");
> -
> -	tst_exit();
> -}
> diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
> deleted file mode 100644
> index 66bf69212..000000000
> --- a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.c
> +++ /dev/null
> @@ -1,252 +0,0 @@
> -
> -#include "ht_utils.h"
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <alloca.h>
> -#include <string.h>
> -#include <linux/unistd.h>
> -#include "ltp_cpuid.h"
> -
> -#define PROC_PATH	"/proc"
> -#define BUFF_SIZE	8192
> -#define PROCESSOR_STR	"processor"
> -#define PACKAGE_STR	"cpu_package"
> -#define HT_FLAG "ht"
> -#define FLAG_STR "flags"
> -
> -#define MAX_CPU_NUM 128
> -
> -char buffer[BUFF_SIZE];
> -
> -int is_cmdline_para(const char *para)
> -{
> -	FILE *fp;
> -
> -	if ((fp = fopen("/proc/cmdline", "r")) != NULL && para != NULL) {
> -		while (fgets(buffer, BUFF_SIZE - 1, fp) != NULL) {
> -			if (strstr(buffer, para) != NULL) {
> -				fclose(fp);
> -				return 1;
> -			}
> -		}
> -	}
> -	/* If fopen succeeds and the pointer para is NULL,
> -	 * It won't enter the above if-block.
> -	 * so need to close fp here.
> -	 */
> -	if (fp != NULL)
> -		fclose(fp);
> -
> -	return 0;
> -}
> -
> -int is_ht_kernel(void)
> -{
> -	FILE *fp;
> -
> -	if ((fp = fopen("/proc/cpuinfo", "r")) != NULL) {
> -		while (fgets(buffer, BUFF_SIZE - 1, fp) != NULL) {
> -			if (strncmp(buffer, PACKAGE_STR, strlen(PACKAGE_STR)) ==
> -			    0) {
> -				fclose(fp);
> -				return 1;
> -			}
> -		}
> -		fclose(fp);
> -	}
> -
> -	return 0;
> -}
> -
> -int is_ht_cpu(void)
> -{
> -	/*Number of logic processor in a physical processor */
> -	int smp_num_siblings = -1;
> -	/*ht flag */
> -	int ht = -1;
> -	unsigned int eax, ebx, ecx, edx;
> -	cpuid(1, &eax, &ebx, &ecx, &edx);
> -	smp_num_siblings = (ebx & 0xff0000) >> 16;
> -	ht = (edx & 0x10000000) >> 28;
> -
> -	if (ht == 1 && smp_num_siblings == 2) {
> -//              printf("The processor in this system supports HT\n");
> -		return 1;
> -	} else {
> -//              printf("The processor in this system does not support HT\n");
> -		return 0;
> -	}
> -}
> -
> -int is_ht_enabled(void)
> -{
> -	int cpu_map[MAX_CPU_NUM];
> -	/*A bit-map shows whether a 'logic' processor has ht flag */
> -	int ht_cpu[MAX_CPU_NUM];
> -	int logic_cpu_num = 0;
> -	int package = -1;
> -	int cpu_id = -1;
> -	char *ht_flag = NULL;
> -	int i = 0;
> -	int j = 0;
> -	int k = 0;
> -
> -	FILE *fp;
> -	char *proc_cpuinfo =
> -	    (char *)alloca(strlen(PROC_PATH) + sizeof("/cpuinfo"));
> -	strcat(strcpy(proc_cpuinfo, PROC_PATH), "/cpuinfo");
> -
> -	if ((fp = fopen(proc_cpuinfo, "r")) != NULL) {
> -		while (fgets(buffer, BUFF_SIZE - 1, fp) != NULL) {
> -			if (strncmp
> -			    (buffer, PROCESSOR_STR,
> -			     strlen(PROCESSOR_STR)) == 0) {
> -				sscanf(buffer, PROCESSOR_STR "\t: %d", &cpu_id);
> -				ht_cpu[cpu_id] = 0;
> -				while (fgets(buffer, BUFF_SIZE - 1, fp) != NULL) {
> -					if (strncmp
> -					    (buffer, PACKAGE_STR,
> -					     strlen(PACKAGE_STR)) == 0) {
> -						sscanf(buffer,
> -						       PACKAGE_STR "\t: %d",
> -						       &package);
> -						cpu_map[cpu_id] = package;
> -						printf("cpu_map[%d]=%d\n",
> -						       cpu_id, package);
> -					}
> -					if (strncmp
> -					    (buffer, FLAG_STR,
> -					     strlen(FLAG_STR)) == 0) {
> -						ht_flag = buffer;
> -						while (*ht_flag != '\0') {
> -							/*printf("ht_flag=%s",ht_flag); */
> -							if (strncmp
> -							    (ht_flag, HT_FLAG,
> -							     strlen(HT_FLAG)) ==
> -							    0) {
> -								ht_cpu[cpu_id] =
> -								    1;
> -								break;
> -							}
> -							ht_flag++;
> -						}
> -						printf("ht_cpu[%d]=%d\n",
> -						       cpu_id, ht_cpu[cpu_id]);
> -						logic_cpu_num += 1;
> -						break;
> -					}
> -				}
> -			}
> -		}
> -	} else
> -		return 0;
> -
> -	fclose(fp);
> -
> -	for (i = 0; i < logic_cpu_num; i++) {
> -		if (ht_cpu[i] == 1) {
> -			for (j = i + 1; j < logic_cpu_num; j++) {
> -				if (cpu_map[i] == cpu_map[j]) {
> -					for (k = j + 1; k < logic_cpu_num; k++) {
> -						if (cpu_map[j] == cpu_map[k]) {
> -							/* Not proper HT support, with 3 logic processor in 1 cpu package */
> -							return 0;
> -						}
> -					}
> -					if (ht_cpu[j] == 1) {
> -						return 1;
> -					} else
> -						return 0;
> -				}
> -			}
> -			/* in this case, processor[i] has ht flag, but is not ht enabled */
> -			if (j == logic_cpu_num) {
> -				return 0;
> -			}
> -		}
> -	}
> -	if (i == logic_cpu_num) {
> -		return 0;
> -	}
> -	return 0;
> -}
> -
> -// return 0 means Pass,
> -// return 1 means ht is not enabled,
> -// return 2 means CPU is not support ht,
> -// return 3 mean kernel is not support ht.
> -int check_ht_capability(void)
> -{
> -	int result;
> -
> -	if (is_ht_kernel()) {
> -		if (is_ht_cpu()) {
> -			if (is_ht_enabled())
> -				result = 0;	//HT is enabled by default in this system.
> -			else
> -				result = 1;	//HT is not enabled by default in this system.
> -		} else
> -			result = 2;	//This processor does not support HT.
> -	} else
> -		result = 3;	//HT feature is not included in this Linux Kernel.
> -
> -	return result;
> -}
> -
> -#define PROCFS_PATH "/proc/"
> -#define CPUINFO_PATH "/proc/cpuinfo"
> -#define CPU_NAME "processor"
> -#define STAT_NAME "stat"
> -
> -char buf[256];
> -
> -int get_cpu_count(void)
> -{
> -	FILE *pfile;
> -	int count;
> -
> -	if ((pfile = fopen(CPUINFO_PATH, "r")) == NULL)
> -		return 0;
> -
> -	count = 0;
> -
> -	while (fgets(buf, 255, pfile) != NULL) {
> -		if (strncmp(buf, CPU_NAME, strlen(CPU_NAME)) == 0)
> -			count++;
> -	}
> -
> -	fclose(pfile);
> -
> -	return count;
> -}
> -
> -int get_current_cpu(pid_t pid)
> -{
> -	int cpu = -1;
> -	int da;
> -	char str[100];
> -	char ch;
> -
> -	FILE *pfile;
> -
> -	sprintf(buf, "%s%d/%s%c", PROCFS_PATH, pid, STAT_NAME, 0);
> -
> -	if ((pfile = fopen(buf, "r")) == NULL)
> -		return -1;
> -
> -	if (fscanf
> -	    (pfile,
> -	     "%d %s %c %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",
> -	     &da, str, &ch, &da, &da, &da, &da, &da, &da, &da, &da, &da, &da,
> -	     &da, &da, &da, &da, &da, &da, &da, &da, &da, &da, &da, &da, &da,
> -	     &da, &da, &da, &da, &da, &da, &da, &da, &da, &da, &da, &da,
> -	     &cpu) <= 0) {
> -		fclose(pfile);
> -		return -1;
> -	}
> -
> -	fclose(pfile);
> -
> -	return cpu;
> -}
> diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h
> deleted file mode 100644
> index 6b484e1ff..000000000
> --- a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -
> -#ifndef _HTUTILS_H_
> -#define _HTUTILS_H_
> -
> -#include <stdlib.h>
> -#include <sys/types.h>
> -
> -int is_cmdline_para(const char *para);
> -
> -// return 0 means Pass,
> -// return 1 means ht is not enabled,
> -// return 2 means CPU is not support ht,
> -// return 3 mean kernel is not support ht.
> -int check_ht_capability();
> -
> -extern char buf[];
> -
> -int get_cpu_count();
> -int get_current_cpu(pid_t pid);
> -
> -#endif

Pushed, thanks!


Kind regards,
Petr
