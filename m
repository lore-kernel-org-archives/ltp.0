Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R20Ya-000099-7d
	for ltp-list@lists.sourceforge.net; Fri, 09 Sep 2011 12:51:44 +0000
Date: Fri, 9 Sep 2011 14:52:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110909125227.GB5501@saboteur.suse.cz>
References: <1451061279.60877.1315552765119.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1851302698.60887.1315552877010.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1851302698.60887.1315552877010.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v4 2/1] add vm tunable file read/write/check func
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
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index f3983d4..64751fd 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -77,7 +77,7 @@ void write_memcg(void)
>  	snprintf(buf, BUFSIZ, "%d", getpid());
>  	if (write(fd, buf, strlen(buf)) != strlen(buf))
>  		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
> -	close(fd);	
> +	close(fd);
>  }
>  
>  void write_cpusets(void)
> @@ -712,3 +712,82 @@ void check_ksm_options(int *size, int *num, int *unit)
>  				"process number cannot be less 3.");
>  	}
>  }
> +
> +void set_sys_tune(char *sys_file, long long tune)
> +{
> +	int fd;
> +	char buf[BUFSIZ];
> +
> +	tst_resm(TINFO, "set %s to %lld", sys_file, tune);
> +
> +	fd = open(sys_file, O_WRONLY);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "open %s", sys_file);
> +	if (snprintf(buf, BUFSIZ, "%lld", tune) < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "snprintf");
> +	if (write(fd, buf, strlen(buf)) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "write");

Please add the filename into the message that gets printed when write
has failed too. And possibly enclose the %s with ' eg. 
tst_brkm(... "open '%s'", sys_file).

> +	close(fd);
> +}
> +
> +long long get_sys_tune(char *sys_file)
> +{
> +	int fd;
> +	long long tune;
> +	char buf[BUFSIZ], *endptr;
> +
> +	fd = open(sys_file, O_RDONLY);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "open %s", sys_file);
> +	if (read(fd, buf, BUFSIZ) < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "read");

And here into the read branch too.

> +	close(fd);
> +
> +	tune = strtoll(buf, &endptr, 10);
> +	if (tune == LLONG_MAX || tune == LLONG_MIN)
> +		tst_brkm(TBROK|TERRNO, cleanup, "strtoll");
> +	if (endptr == buf || (*endptr != '\0' && *endptr != '\n'))
> +		tst_brkm(TBROK, cleanup, "Invalid tunable: %s", buf);
> +
> +	return tune;
> +}
> +
> +/*
> + * the function is designed to make sure the value we get from
> + * sys_file is equal to what we set last.
> + */
> +void check_sys_tune(char *sys_file, long long tune)
> +{
> +	long long val;
> +
> +	val = get_sys_tune(sys_file);
> +	if (val == tune)
> +		tst_resm(TINFO, "confirmed %s = %lld", sys_file, tune);
> +	else
> +		tst_brkm(TBROK, cleanup, "%s = %lld, is not %lld",
> +				sys_file, val, tune);
> +}
> +
> +long long read_meminfo(char *item)
> +{
> +	FILE *fp;
> +	char line[BUFSIZ], buf[BUFSIZ];
> +	long long val;
> +
> +	fp = fopen(PATH_MEMINFO, "r");
> +	if (fp == NULL)
> +		tst_brkm(TBROK|TERRNO, cleanup, "fopen %s", PATH_MEMINFO);
> +	while (fgets(line, BUFSIZ, fp) != NULL) {
> +		if (sscanf(line, "%s %lld ", buf, &val) == 2)
> +			if (strcmp(buf, item) == 0) {
> +				fclose(fp);
> +				return val;
> +			}
> +		continue;
> +	}
> +	fclose(fp);
> +
> +	tst_brkm(TBROK, cleanup, "cannot find \"%s\" in %s",
> +			item, PATH_MEMINFO);
> +}


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Why Cloud-Based Security and Archiving Make Sense
Osterman Research conducted this study that outlines how and why cloud
computing security and archiving is rapidly being adopted across the IT 
space for its ease of implementation, lower cost, and increased 
reliability. Learn more. http://www.accelacomm.com/jaw/sfnl/114/51425301/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
