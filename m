Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q4tm1-00071t-04
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 11:41:17 +0000
Date: Wed, 30 Mar 2011 14:04:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110330120421.GB29707@saboteur.suse.cz>
References: <437944141.670068.1301482679509.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1119407155.670083.1301482784916.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1119407155.670083.1301482784916.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 1/2] add a vm nr_hugepages tunable test
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
> +char *TCID="nr_hugepages"; 
> +#define BUFFER_SIZE 256
> +
> +
> +#define NR_HUGEPAGES 30 /* the value set to /proc/sys/vm/nr_hugepages */
> +#define BUFFER_SIZE 256 
> +#define FILE_NAME "/mnt/hugepagefile"
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
> +int TST_TOTAL=1;
> +
> +/* check whether the /proc/sys/vm/nr_hugepages file exist
> + * if not, then the test can't run continue.
> + */
> +int check_system();
> +
> +/* We're not sure one hugepag size is 2048kb or not, we can confirm
> + * it by catting /proc/meminfo: Hugepagesize
> + */
> +unsigned long get_one_hugepage_size();
> +
> +/* set hugepages value */
> +int set_hugepages(int nr_hugepages);
> +
> +/* get the total of hugepages */ 
> +int get_hugepages(int *nr_hugepages);
> +
> +/* try to alloc nr_hugepages hugepages */
> +int alloc_hugepages(int nr_hugepages);
> +
> +/* make some cleanning work. */
> +void cleanup();
>
> +int old_hugepages = 0; /* save the old nr_hugepages value */
> +

Functions with no paremeters should be written as fn(void), otherwise
compiler thinks that they takes some number of integer parameters.

Local functions and variables should be declared as static.

And please avoid trivial comments like:

/* this function sets hugepages */
set_hugepages(int nr_hugepages);

or

/* make cleanup */

As this doesn't add any additional information.

> +int main(int argc, char *argv[])
> +{
> +	int lc = 0; /* loop counter */
> +	char *msg; /* message returned from parse_opts */
> +	int hugepages = 0;
>

And trivial comments here.

> +	/* if check_system() return zero, 
> + 	 * the system can't support this test. 
> + 	 */
> +	if (check_system() == 0) {
> +		tst_resm(TFAIL, "Can't test nr_hugepages and \
> +				nr_overcommit_hugepages,no such files");
> +		tst_exit();
> +	}

That is TCONF rather that TFAIL.

And there is missing space after comma in message.

> +	if ( (msg = parse_opts(argc, argv, NULL, NULL)) != NULL ) {
> +		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s ", msg);
> +	}

Whitespaces inconsistency. Should be if ((msg = ....)).

Also you should not enclose one command statements into {}.

> +	get_hugepages(&old_hugepages); /* save the current value to old_hugepags */
> +	tst_resm(TINFO, "the old nr_hugepages is %d\n",old_hugepages);

Another useless comment.

> +	for ( lc = 0; TEST_LOOPING(lc); lc++ ) {		
> +		set_hugepages(NR_HUGEPAGES);
> +		tst_resm(TINFO, "set nr_hugepages %d", NR_HUGEPAGES);
> +		get_hugepages(&hugepages);
> +		if (hugepages != NR_HUGEPAGES) {
> +			set_hugepages(old_hugepages); /* recover the original value */
> +			tst_brkm(TFAIL, cleanup, "nr_hugepages error");
> +		}
> +		sleep(1);

And here.

> +		/* try to alloc appropriate hugepages, it should PASS */
> +		if(alloc_hugepages(NR_HUGEPAGES) == 0) {
> +			tst_resm(TINFO, "try to alloc appropriate hugepages pass");		
> +		} else {
> +			tst_brkm(TFAIL, cleanup, "nr_hugepages error");		
> +		}
> +
> +		/* try to alloc overcommit hugepages, it should FAIL */
> +		if(alloc_hugepages(NR_HUGEPAGES + 1) == -1) {
> +			tst_resm(TINFO, "test overcommit hugepages pass");		
> +		} else {
> +			tst_brkm(TFAIL, cleanup, "nr_hugepages error");
> +		}
> +	}
> +	
> +	set_hugepages(old_hugepages); /* recover the primary value */
> +	tst_resm(TPASS, "nr_hugepages");
> +	cleanup();

And here.

> +	return 0;
> +}
> +
> +int check_system()
> +{
> +	int flag = -1;
> +
> +	flag = access("/proc/sys/vm/nr_hugepages", F_OK);
> +	if (flag == 0) {
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +int get_hugepages(int *nr_hugepages) 
> +{
> +	FILE *f;
> +	int retcode = 0;
> +	char buff[BUFFER_SIZE];
> +
> +	f = fopen("/proc/meminfo", "r");
> +	if (f == NULL) {
> +		tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
> +	}
> +
> +	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
> +		if((retcode = sscanf(buff, "HugePages_Total: %d ", nr_hugepages)) == 1)
> +			break;
> +	}

Missing space after coma.

> +	fclose(f);
> +
> +	return 0;
> +}
> +
> +int set_hugepages(int nr_hugepages)
> +{
> +	FILE *f;
> +
> +	f = fopen("/proc/sys/vm/nr_hugepages", "w");
> +	if (f == NULL) {
> +		tst_brkm(TFAIL, NULL, "No permission, using root user.");
> +		tst_exit();
> +	}
> +
> +	/* write nr_hugepages value to /proc/sys/vm/nr_hugepages */
> +	fprintf(f, "%d", nr_hugepages);
> +	fclose(f);
> +
> +	return 0;
> +}

Hmm, if your test needs to run as root use tst_require_root() function
in initalization. 

> +unsigned long get_one_hugepage_size()
> +{
> +	FILE *f;
> +	int retcode = 0;
> +	char buff[BUFFER_SIZE];
> +	unsigned long one_hugepage_size = 0;
> +
> +	f = fopen("/proc/meminfo", "r");
> +	if (f == NULL) {
> +		tst_brkm(TFAIL, cleanup, "Can't open /proc/meminfo");
> +	}
> +
> +	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
> +		if((retcode = sscanf(buff, "Hugepagesize: %lu kB", &one_hugepage_size)) == 1)
> +			break;
> +	}
> +	tst_resm(TINFO, "one hugepagesize is %lu", one_hugepage_size);
> +	fclose(f);
> +	
> +	if(one_hugepage_size == 0) {
> +		tst_brkm(TFAIL, cleanup, "Can't read one hugepage size");
> +	}
> +	
> +	return one_hugepage_size * 1024UL;
> +}

Missing space after coma.

> +/* try to alloc nr_hugepages hugepages */
> +int alloc_hugepages(int nr_hugepages)
> +{
> +	char *addr;
> +	int fd;
> +	unsigned long length = 0;
> +	unsigned long one_hugepage_size = 0;
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
> +	one_hugepage_size = get_one_hugepage_size();
> +	length = nr_hugepages * one_hugepage_size;
> +	addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
> +	if (addr == MAP_FAILED) {
> +		tst_resm(TINFO, "mmap() Failed on %s, errno=%d : %s", \
> +				FILE_NAME, errno, strerror(errno));
> +		munmap(addr, length);
> +		close(fd);
> +		unlink(FILE_NAME);
> +		return -1;
> +	}
> +
> +	tst_resm(TINFO, "Returned address is %p", addr);
> +	tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
> +
> +	munmap(addr, length);
> +	close(fd);
> +	unlink(FILE_NAME);
> +	
> +	return 0;
> +
> +}

the mmap returns void* so the (char *) cast is useless here.

> +void cleanup(void)
> +{
> +	set_hugepages(old_hugepages);
> +	tst_exit();
> +
> +	return;
> +}

The return is rendundant here.

Also could you pretty please use checkpatch.pl (which is packed with
linux kernel sources in scripts directory) before submitting patches.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
