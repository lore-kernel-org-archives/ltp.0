Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYGET-00010M-FH
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 10:59:45 +0000
Date: Thu, 30 Dec 2010 12:15:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230111508.GA17327@saboteur.suse.cz>
References: <84488521.961801292304607525.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84488521.961801292304607525.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v2] add a testcase to test
 /proc/sys/vm/nr_hugepages vm tunable
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
> +#define BUFFER_SIZE 256
> +
> +/* the HUGEPAGES is the value that I will set /proc/sys/vm/nr_hugepages, 
> + * why I set HUGEPAGES 30, I think this value is appropriate.
> + * In general, all the systems can provide about 30 hugepages if they 
> + * support hugepage, if you make a much larger value, it will cause 
> + * shortage memory.
> + */
> +#define HUGEPAGES 30 
> +
> +char *TCID ="nr_hugepages"; 
> +int TST_TOTAL = 1;
> +
> +/* set hugepages */
> +int set_hugepages(int nr_hugepages);
> +/* get the total of hugepages and surplus hugepages */ 
> +int get_hugepages(int *nr_hugepages);
> +
> +/* check whether the /proc/sys/vm/nr_hugepages file exist
> + * if not, then the test can't run continue.
> + * */
> +int check_system();
> +
> +/* make some clean work. */
> +void cleanup();
> +
> +int old_hugepages = 0; /* save the old nr_hugepages value */

Most of the comments here are meaningless. There is no need to write
code like:

/* gets number */
get_number();

or

/* does cleanup */
cleanup();

And the prototypes are missing void as fn() says that function has
variable number of int arguments. The right way to define function
without any arguments is fn(void).

> +int main(int argc, char *argv[])
> +{
> +	int lc = 0; /* loop counter */
> +	char *msg; /* message returned from parse_opts */
> +	int counter = 0;
> +	int nr = 10;
> +	int hugepages = 0;
> +
> +	/* the test need to be run as root */
> +	tst_require_root(tst_exit);
> +
> +	/* if check_system() return zero, 
> + 	 * the system can't support this test. 
> + 	 */
> +	if (!check_system()) {

Here again, the comments just says the same as the name of the function,
please remove them.

> +		tst_brkm(TCONF|TERRNO,tst_exit, "Can't test %s, no such file", TCID);
> +	}
> +
> +	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
> +		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s ", msg);
> +	}
> +	
> +	get_hugepages(&old_hugepages); /* save the original hugepages */
> +	tst_resm(TINFO, "the original nr_hugepages is %d\n", old_hugepages);
> +	
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		/* try to set nr_hugepages from 30 to 39 */
> +		for ( counter = 0; counter < nr; counter++ ) {
> +			set_hugepages(HUGEPAGES + counter);
> +			tst_resm(TINFO, "set nr_hugepages %d", 
> +				HUGEPAGES + counter);
> +			get_hugepages(&hugepages);
> +			if (hugepages != HUGEPAGES + counter) {
> +				set_hugepages(old_hugepages); /* recover the original value */
> +				tst_brkm(TFAIL, cleanup, "nr_hugepages error");
> +			}
> +		}
> +	}
> +	
> +	tst_resm(TPASS, "nr_hugepages succeed.");
> +	
> +	set_hugepages(old_hugepages); /* recover the primary value */

The set_hugepages(old_hugepages) and get_hugepages(&old_hugepages) is
descriptive enough.

> +	cleanup();
> +	return 0;
> +}
> +
> +int get_hugepages(int *nr_hugepages) 
> +{
> +	FILE *f;
> +	int flag = 0;
> +	char buff[BUFFER_SIZE];
> +
> +	f = fopen("/proc/meminfo", "r");
> +	if (f == NULL) {
> +		tst_brkm(TBROK, cleanup, "open /proc/meminfo error");
> +	}
> +
> +	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
> +		if ((flag = sscanf(buff, "HugePages_Total: %d ", nr_hugepages)) == 1)
> +			break;
> +	}
> +
> +	/* if flag = 1, that indicates the sscanf() have gotten the HugePages_Total */
> +	if (flag != 1) {
> +		fclose(f);
> +		tst_brkm(TBROK, cleanup, "Failed reading Hugepages_Total.");
> +	}
> +
> +	fclose(f);
> +	return 0;
> +}
> +
> +int set_hugepages(int nr_hugepages)
> +{
> +	FILE *f ;
> +
> +	f = fopen("/proc/sys/vm/nr_hugepages","w");
> +	if (f == NULL) {
> +		tst_brkm(TBROK, cleanup, "open /proc/sys/vm/nr_hugepages error");
> +	}
> +
> +	/* write nr_hugepages to /proc/sys/vm/nr_hugepages */
> +	if (fprintf(f, "%d", nr_hugepages) < 0) {
> +		tst_brkm(TBROK, cleanup, "fprintf() error");
> +	}
> +	
> +	fclose(f);
> +	return 0;
> +}
> +
> +int check_system()
> +{
> +	int flag = -1;
> +	
> +	flag = access("/proc/sys/vm/nr_hugepages", F_OK);
> +	if (flag == 0) {  
> +		return 1;  /* can access this file */
> +	} else {
> +		return 0;
> +	}
> +}

The comment here is useless as well. And personally I would omit curly
brackets around one line code blocks.

> +void cleanup()
> +{
> +	set_hugepages(old_hugepages); /* recover the original data */
> +	tst_exit();
> +}

And here too.

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
