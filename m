Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VQgQX-0006MD-Ik
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 16:34:29 +0000
Date: Mon, 30 Sep 2013 18:34:52 +0200
From: chrubis@suse.cz
Message-ID: <20130930163452.GB5370@rei.suse.cz>
References: <1380266492-7199-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380266492-7199-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] tools: added tst_kvercmp2 binary
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> +MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp kvercmp2 \
> +				res resm ncpus ncpus_max)
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>  
> diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
> index e2b0061..1e48a90 100644
> --- a/tools/apicmds/ltpapicmd.c
> +++ b/tools/apicmds/ltpapicmd.c
> @@ -151,7 +151,8 @@ int main(int argc, char *argv[])
>  	tst_total = getenv("TST_TOTAL");
>  	tst_cntstr = getenv("TST_COUNT");
>  	if (TCID == NULL || tst_total == NULL || tst_cntstr == NULL) {
> -		if (strcmp(cmd_name, "tst_kvercmp") != 0) {
> +		if ((strcmp(cmd_name, "tst_kvercmp") != 0)
> +				&& (strcmp(cmd_name, "tst_kvercmp2") != 0)) {
>  			fprintf(stderr,
>  				"\nSet variables TCID, TST_TOTAL, and TST_COUNT before each test:\n"
>  				"export TCID=<test name>\n"
> @@ -265,6 +266,84 @@ int main(int argc, char *argv[])
>  		else if (exit_value > 0)
>  			exit_value = 2;
>  		exit(exit_value);
> +	} else if (strcmp(cmd_name, "tst_kvercmp2") == 0) {
> +		int exit_value;
> +
> +		struct tst_kern_exv vers[100];
> +		unsigned int count;
> +
> +		char *saveptr1 = NULL;
> +		char *saveptr2 = NULL;
> +		char *token1;
> +		char *buf;
> +
> +		if (TCID == NULL)
> +			TCID = "outoftest";
> +		if (tst_cntstr == NULL)
> +			tst_count = 0;
> +
> +		if (argc < 5) {
> +			fprintf(stderr, "Usage: %s NUM NUM NUM KVERS\n"
> +				"Compares to the running kernel version\n"
> +				"based on vanilla kernel version NUM NUM NUM\n"
> +				"or distribution specific kernel version KVERS\n\n"
> +				"\tNUM - A positive integer.\n"
> +				"\tThe first NUM is the kernel VERSION\n"
> +				"\tThe second NUM is the kernel PATCHLEVEL\n"
> +				"\tThe third NUM is the kernel SUBLEVEL\n\n"
> +				"\tKVERS is a string of the form "
> +				"\"DISTR1:VERS1 DISTR2:VERS2\",\n"
> +				"\twhere DISTR1 is a distribution name\n"
> +				"\tand VERS1 is the corresponding kernel version.\n"
> +				"\tExample: \"RHEL6:2.6.39-400.208\"\n\n"
> +				"\tIf running kernel matches a distribution in KVERS then\n"
> +				"\tcomparison is performed based on version in KVERS,\n"
> +				"\totherwise - based on NUM NUM NUM.\n\n"
> +				"\tExit status is 0 if the running kernel is older.\n"
> +				"\tExit status is 1 for kernels of the same age.\n"
> +				"\tExit status is 2 if the running kernel is newer.\n",
> +				cmd_name);
> +			exit(3);
> +		}
> +
> +		count = 0;
> +
> +		buf = strdup(argv[3]);
> +		if (buf == NULL) {
> +			fprintf(stderr, "Allocation for buf failed\n");
> +			exit(3);
> +		}

You don't have to copy the argv[3] string, you are allowed to modify it
by the C standard.

> +		token1 = strtok_r(buf, " ", &saveptr1);
> +		while ((token1 != NULL) && (count < 99)) {
                                            I would use
					    LTP_ARRAY_SIZE(vers) - 1
					    just to make sure it does
					    not get out of sync

> +			vers[count].dist_name = strtok_r(token1, ":", &saveptr2);
> +			vers[count].extra_ver = strtok_r(NULL, ":", &saveptr2);
> +
> +			if (vers[count].extra_ver == NULL) {
> +				fprintf(stderr, "Incorrect KVERS format\n");
> +				free(buf);
> +				exit(3);
> +			}
> +
> +			count++;
> +
> +			token1 = strtok_r(NULL, " ", &saveptr1);
> +		}
> +		vers[count].dist_name = NULL;
> +		vers[count].extra_ver = NULL;
> +
> +		exit_value = tst_kvercmp2(atoi(argv[0]), atoi(argv[1]),
> +					atoi(argv[2]), vers);
> +
> +		free(buf);
> +
> +		if (exit_value < 0)
> +			exit_value = 0;
> +		else if (exit_value == 0)
> +			exit_value = 1;
> +		else if (exit_value > 0)
> +			exit_value = 2;
> +		exit(exit_value);

Well the whole ltpapicmd.c code is a bit hairy. I would personaly like
to see the main being split into functions but that may be done in
separate patches.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
