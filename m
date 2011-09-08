Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1R1dwW-00082y-3j
	for ltp-list@lists.sourceforge.net; Thu, 08 Sep 2011 12:42:56 +0000
Date: Thu, 8 Sep 2011 14:43:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110908124331.GB9484@saboteur.suse.cz>
References: <687433967.138713.1314186234789.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<914054194.138810.1314187031554.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <914054194.138810.1314187031554.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH 1/2] mem/lib: add vm tunable file read/write/check
 func
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
> +void set_sys_tune(char *sys_file, long tune)
> +{
> +	int fd;
> +	char buf[BUFSIZ];
> +
> +	fd = open(sys_file, O_WRONLY);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "open");
> +	sprintf(buf, "%ld", tune);
> +	if (write(fd, buf, strlen(buf)) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "write");
> +	close(fd);
> +}

I would use snprintf() here, even if you are sure the result fits into
the buffer.

Also adding name of the file to the tst_brkm() report would be better.

So you would get:

open 'filename': no such file or directory

rather than:

open : no such file or directory


> +long get_sys_tune(char *sys_file)
> +{
> +	int fd;
> +	long tune;
> +	char buf[BUFSIZ], *endptr;
> +
> +	fd = open(sys_file, O_RDONLY);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "open");
> +	if (read(fd, buf, BUFSIZ) < 0)
> +		tst_brkm(TBROK|TERRNO, cleanup, "read");

Here as well.

> +	close(fd);
> +
> +	tune = strtol(buf, &endptr, 10);
> +	if (((tune == LONG_MAX || tune == LONG_MIN) && errno == ERANGE) ||
> +			(errno != 0 && tune == 0))
> +		tst_brkm(TBROK|TERRNO, cleanup, "strtol");

I think you should clear errno before calling the strtol, otherwise you
could get invalid conversion for string "0" when errno was set by some
previous system call.

> +	if (endptr == buf || (*endptr != '\0' && *endptr != '\n'))
> +		tst_brkm(TBROK, cleanup, "Invalid number parameter: %s", buf);
> +
> +	return tune;
> +}
>
> +/*
> + * the function is designed to make sure the value we get from
> + * sys_file is equal to what we set last.
> + */
> +void check_sys_tune(char *sys_file, long tune)
> +{
> +	long val;
> +
> +	val = get_sys_tune(sys_file);
> +	if (val == tune)
> +		tst_resm(TINFO, "val in %s = %ld", sys_file, tune);
> +	else
> +		tst_brkm(TBROK, cleanup, "val in %s = %ld, not %ld",
> +				sys_file, val, tune);
> +}
> +
> +unsigned long read_meminfo(char *item)
> +{
> +	FILE *fp;
> +	char line[BUFSIZ], buf[BUFSIZ];
> +	unsigned long val;
> +
> +	fp = fopen(PATH_MEMINFO, "r");
> +	if (fp == NULL)
> +		tst_brkm(TBROK|TERRNO, cleanup, "fopen %s", PATH_MEMINFO);
> +	while (fgets(line, BUFSIZ, fp) != NULL) {
> +		if (sscanf(line, "%s %lu ", buf, &val) == 2)

Using sscanf() to fill string buffer is potentialy dangerous. You could
either to use GNU extension to hardcode maximal buffer length into the
format string or to go trough the string while you find whitespace (see
isspace()).

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
Doing More with Less: The Next Generation Virtual Desktop 
What are the key obstacles that have prevented many mid-market businesses
from deploying virtual desktops?   How do next-generation virtual desktops
provide companies an easier-to-deploy, easier-to-manage and more affordable
virtual desktop model.http://www.accelacomm.com/jaw/sfnl/114/51426474/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
