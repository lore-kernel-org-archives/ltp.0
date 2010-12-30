Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PYFfE-0007lM-2k
	for ltp-list@lists.sourceforge.net; Thu, 30 Dec 2010 10:23:20 +0000
Date: Thu, 30 Dec 2010 11:38:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101230103842.GE14045@saboteur.suse.cz>
References: <82849215.10223.1292833893533.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<715753312.10226.1292833901212.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <715753312.10226.1292833901212.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH] zram01: add a new test for zram feature.
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +int main(int argc, char *argv[])
> +{
> +	int lc, fd;
> +	char *msg;
> +	char buf[BUFSIZ], size[BUFSIZ];
> +	void *s;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != (char *)NULL)
> +		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);

Once again, useless cast here.

> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0;
> +		tst_resm(TINFO, "create a zram device with %d bytes in size.",
> +			SIZE);
> +		sprintf(buf, "%s/disksize", PATH_ZRAM);
> +		fd = open(buf, O_WRONLY);

And the sprintf() here.

> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> +		sprintf(size, "%d", SIZE);
> +		if (write(fd, size, strlen(size)) != strlen(size))
> +			tst_brkm(TBROK|TERRNO, cleanup, "write %s to %s", size,
> +				buf);
> +		close(fd);
> +
> +		tst_resm(TINFO, "map it into memory.");
> +		fd = open(DEVICE, O_RDWR);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", DEVICE);
> +		s = mmap(NULL, SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> +		if (s == MAP_FAILED)
> +			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
> +
> +		tst_resm(TINFO, "write all the memory.");
> +		memset(s, SIZE, 'a');
> +		close(fd);
> +
> +		dump_info();
> +
> +		tst_resm(TINFO, "reset it.");
> +		sprintf(buf, "%s/reset", PATH_ZRAM);

And here.

> +		fd = open(buf, O_WRONLY);
> +		if (fd == -1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
> +		if (write(fd, "1", 1) != 1)
> +			tst_brkm(TBROK|TERRNO, cleanup, "write 1 to %s", buf);
> +		close(fd);
> +
> +		dump_info();
> +	}
> +	cleanup();
> +}
> +
> +void setup(void)
> +{
> +	if (access(PATH_ZRAM, R_OK|W_OK|X_OK) == -1 && errno == ENOENT) {
> +		system("modprobe zram");
> +		modprobe = 1;
> +		if (access(PATH_ZRAM, R_OK|W_OK|X_OK) == -1 && errno == ENOENT)
> +			tst_brkm(TCONF, tst_exit, "system has no zram device.");
> +		else
> +			tst_brkm(TBROK|TERRNO, tst_exit, "access");
> +	}
> +	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)
> +{
> +	if (modprobe == 1)
> +		system("rmmod zram");
> +
> +	TEST_CLEANUP;
> +	tst_exit();	
> +}
> +
> +void print(char *string)
> +{
> +	FILE *fp;
> +	char buf[BUFSIZ], value[BUFSIZ];
> +
> +	sprintf(buf, "%s/%s", PATH_ZRAM, string);
> +	fp = fopen(buf, "r");
> +	if (fp == NULL)
> +		tst_brkm(TBROK|TERRNO, cleanup, "fopen %s", buf);
> +
> +	if (fgets(value, BUFSIZ, fp) == NULL)
> +		tst_brkm(TBROK|TERRNO, cleanup, "fgets %s", buf);
> +	value[strlen(value) - 1] = '\0';
> +	fclose(fp);
> +
> +	tst_resm(TINFO, "%s is %s", buf, value);
> +}
> +
> +void dump_info(void)
> +{
> +	print("initstate");
> +	print("compr_data_size");
> +	print("orig_data_size");
> +	print("disksize");
> +	print("mem_used_total");
> +	print("num_reads");
> +	print("num_writes");
> +	print("zero_pages");
> +}

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
