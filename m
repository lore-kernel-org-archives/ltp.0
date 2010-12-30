Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYGMR-0004nt-Cz
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 11:07:59 +0000
Date: Thu, 30 Dec 2010 12:23:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230112321.GB17327@saboteur.suse.cz>
References: <226698669.962241292305534287.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<939184772.962261292305595152.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <939184772.962261292305595152.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v2] a vm tunable testcase that can test
 /proc/sys/vm/nr_overcommit_hugepages
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +/*
> + * vm tunable test
> + *
> + * ********************************************************************
> + * Copyright (C) 2010  Red Hat, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of version 2 of the GNU General Public
> + * License as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> + * is free of the rightful claim of any third person regarding
> + * infringement or the like.  Any license provided herein, whether
> + * implied or otherwise, applies only to this software file.  Patent
> + * licenses, if any, provided herein do not apply to combinations of
> + * this program with other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> + * 02110-1301, USA.
> + *
> + * ********************************************************************
> + *
> + * File Name: nr_overcommit_hugepage.c
> + * Author: Zhouping Liu <zliu@redhat.com>
> + * Description:  
> + * the program is designed to test a vm tunable
> + * /proc/sys/vm/nr_overcommit_hugepages can work normally.
> + * you can change the maximum size of the hugepage pool through
> + * /proc/sys/vm/nr_overcommit_hugepages.
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +char *TCID = "nr_overcommit_hugepages"; 
> +int TST_TOTAL = 1;
> +
> +#define NUM 50UL /* the amount of hugepages try to mmap */
> +#define HUGEPAGES 30 /* set /proc/sys/vm/nr_hugepages */
> +#define OVER_HUGEPAGES 30 /* set /proc/sys/vm/nr_overcommit_hugepages */
> +#define BUFFER_SIZE 256 
> +#define FILE_NAME "/mnt/hugepagefile"
> +#define HUGEPAGESIZE 2048   /* 2KB */
> +#define ONEPAGESIZE (1UL*HUGEPAGESIZE*1024) /* one hugepages size */
> +#define PROTECTION (PROT_READ | PROT_WRITE) /* mmap mode */
> +
> +/* Only ia64 requires this */
> +#ifdef __ia64__
> +#define ADDR (void *)(0x8000000000000000UL)
> +#define FLAGS (MAP_SHARED | MAP_FIXED)
> +#else
> +#define ADDR (void *)(0x0UL)
> +#define FLAGS (MAP_SHARED)
> +#endif
> +
> +
> +/* set hugepages */
> +int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages);
> +
> +/* get the total of hugepages and surplus hugepages */ 
> +int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages);
> +
> +/* 
> + * /proc/sys/vm/nr_hugepages change the minmum size of the hugepage
> + * pool and /proc/sys/vm/nr_overcommit_hugepages can change the 
> + * maxmum size of the hugepage pool, and the maximum is
> + * nr_hugepages + nr_overcommit_hugepages.
> + * if no the two files, this test can't run conitune. 
> + * and check_system() check whether this two file exist.
> + * 
> + */
> +int check_system();
> +
> +/* try to require overcommit hugepages */
> +int test_overcommit_hugepages();
> +
> +/* do some clean after test */
> +void cleanup();
> +
> +int old_hugepages;
> +int old_overcommit; /* the original hugepages data */

Here again some comments are useless and you are missing the void in the
cleanup() and check_system() declarations.

> +int main(int argc, char *argv[])
> +{
> +	int lc = 0; /* loop counter */
> +	char *msg;
> +	
> +	/* the test need to be run as root */
> +	tst_require_root(tst_exit);

Please remove these two comments.

> +	/* if check_system() return zero, the system can't support the testing */
> +	if (!check_system()) {
> +		tst_resm(TFAIL, "Can't test %s,no such file", TCID);
> +		tst_exit();
> +	}
> +
> +	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
> +		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s", msg);
> +	}
> +
> +	get_hugepages(&old_hugepages, &old_overcommit); /* save the original data */

And this one.

> +	tst_resm(TINFO, "original nr_hugepages value is %d", old_hugepages);
> +	tst_resm(TINFO, "original nr_overcommit hugepages is %d", old_overcommit);
> +	
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		set_hugepages(HUGEPAGES, OVER_HUGEPAGES);
> +		tst_resm(TINFO, "the current nr_hugepages value is %d", HUGEPAGES);
> +		tst_resm(TINFO, "the current nr_overcommit hugepages is %d", OVER_HUGEPAGES);
> +		
> +		if (test_overcommit_hugepages()) {
> +			set_hugepages(old_hugepages, old_overcommit);
> +			tst_resm(TPASS, "Succeeded using overcommit hugepages");
> +		} else {
> +			tst_resm(TFAIL, "Fail using overcommit hugepages.");
> +		}
> +		cleanup();
> +	}
> +
> +	cleanup();
> +	return 0;
> +}
> +
> +int test_overcommit_hugepages()
> +{
> +	char *addr;
> +	int fd;
> +	int hugepages = 0;
> +	int overcommit = 0;
> +	unsigned long i;
> +	unsigned long length = 0; /*the total size of mmap() */
> +	
> +	/* mount hugetlbfs */
> +	if (system("mount -t hugetlbfs nodev /mnt") != 0) {
> +		tst_brkm(TBROK, cleanup, "Can't mount hugetlbfs");
> +	}
> +
> +	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
> +	if (fd < 0) {
> +		tst_brkm(TBROK, cleanup, "OPEN File %s error", FILE_NAME);
> +		tst_exit();
> +	}
> +	
> +	length = NUM * ONEPAGESIZE;
> +	addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
> +	if (addr == MAP_FAILED) {
> +		tst_resm(TBROK, "mmap() Failed on %s, errno=%d : %s",\
> +				FILE_NAME, errno, strerror(errno));
> +		tst_exit();
> +	}
> +
> +	tst_resm(TINFO, "Returned address is %p", addr);
> +	for (i = 0; i < ONEPAGESIZE; i++) {
> +		*(addr + i) = (char)i;
> +	}
> +	for (i = 0; i < ONEPAGESIZE; i++) {
> +		if (*(addr + i) != (char)i) {
> +			tst_resm(TINFO, "Mismatch at %lu", i);
> +			break;
> +		}
> +	}
> +	sleep(1);
> +
> +	/* get the hugepages and surplus hugepages after mmap successfully */
> +	get_hugepages(&hugepages, &overcommit);
> +	
> +	/* free addr */
> +	munmap(addr, ONEPAGESIZE);
> +	close(fd);
> +	
> +	/* if everything is okay, overcommit should equal (NUM -HUGEPAGES) */
> +	if(hugepages == NUM && overcommit == (NUM - HUGEPAGES)) {
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +/* get nr_hugepages and nr_overcommit_hugepages values */
> +int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages) 
> +{
> +	FILE *f;
> +	int flag = 0;
> +	char buff[BUFFER_SIZE];
> +	
> +	f = fopen("/proc/meminfo", "r");
> +	if (f == NULL) {
> +		tst_brkm(TBROK|TERRNO, cleanup, "open /proc/meminfo error.");
> +	}
> +
> +	while (fgets(buff,BUFFER_SIZE, f) != NULL && flag < 2) {
> +		if (sscanf(buff, "HugePages_Total: %d ",
> +			nr_hugepages) == 1)
> +			flag++;
> +		if (sscanf(buff, "HugePages_Surp: %d ", 
> +			nr_overcommit_hugepages) == 1) 
> +			flag++;
> +	}
> +	/* if flag = 2, that indicates the sscanf have gotten the 
> +	 * HugePages_Total and HugePages_Surp.
> +	 */
> +	if (flag != 2) {
> +		fclose(f); 
> +		tst_brkm(TBROK|TERRNO, cleanup, "Failed reading size of huge page.");
> +	}
> +
> +	fclose(f);
> +	return 0;
> +}
> +
> +/* set nr_hugepages and nr_overcommit_hugepages values */
> +int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages)
> +{
> +	FILE *f1, *f2;
> +	char *fname1 = "/proc/sys/vm/nr_hugepages";
> +	char *fname2 = "/proc/sys/vm/nr_overcommit_hugepages";

It's more common to define such paths as macros at the beginning of the
file.

something like

#define HUGEPAGES_PATH "/proc/sys/vm/nr_hugepages"
...

so they could be used as HUGEPAGES_PATH in all functions.

> +	
> +	f1 = fopen(fname1, "w");
> +	if (f1 == NULL) {
> +		tst_brkm(TERRNO|TBROK, cleanup, "open %s file error.", fname1);
> +	}
> +	f2 = fopen(fname2, "w");
> +	if (f2 == NULL) {
> +		tst_brkm(TERRNO|TBROK, cleanup, "open %s file error.", fname2);
> +	}
> +
> +	/* write nr_hugepages to /proc/sys/vm/nr_hugepages and 
> +	 * nr_overcommit_hugepages to /proc/sys/vm/nr_overcommit_hugepages
> +	 */
> +	if (fprintf(f1, "%d", nr_hugepages) == 0) {
> +		tst_brkm(TBROK, cleanup, "write date error to %s", fname1);
> +	}
> +	if (fprintf(f2, "%d", nr_overcommit_hugepages) == 0) {
> +		tst_brkm(TBROK, cleanup, "write date error to %s", fname2);
> +	}
> +
> +	fclose(f1);
> +	fclose(f2);
> +	return 0;
> +}
> +
> +int check_system()
> +{
> +	int flag1 = -1;
> +	int flag2 = -1;
> +
> +	flag1 = access("/proc/sys/vm/nr_hugepages", F_OK);
> +	flag2 = access("/proc/sys/vm/nr_overcommit_hugepages", F_OK);
> +	if (flag1 == 0 && flag2 == 0) {
> +		return 1; /* access these two file */
> +	} else {
> +		return 0;
> +	}
> +}

Please remove the comment here.

> +void cleanup()
> +{
> +	unlink(FILE_NAME);
> +	set_hugepages(old_hugepages, old_overcommit); /* recover the original data*/
> +	tst_exit();
> +	return;
> +}

Plese remove the comment here and the return;

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
