Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UsBjO-0005a1-9K
	for ltp-list@lists.sourceforge.net; Thu, 27 Jun 2013 12:55:22 +0000
Date: Thu, 27 Jun 2013 14:56:52 +0200
From: chrubis@suse.cz
Message-ID: <20130627125455.GE5384@rei>
References: <51CBAFB7.8000508@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51CBAFB7.8000508@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mmap/mmap14.c: new case to test MAP_LOCKED of mmap
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	int ret;
> +	int lock_sz;
> +	char *msg;
> +	char line[LINELEN];
> +	FILE *fstatus = NULL;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
> +		tst_count = 0;
> +
> +		addr = mmap(NULL, MMAPSIZE, PROT_READ | PROT_WRITE,
> +			    MAP_FILE | MAP_PRIVATE | MAP_LOCKED | MAP_ANONYMOUS,
> +			    -1, 0);
> +
> +		if (addr == MAP_FAILED) {
> +			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
> +			continue;
> +		}
> +
> +		if (STD_FUNCTIONAL_TEST) {
> +
> +			fstatus = fopen("/proc/self/status", "r");
> +			if (fstatus == NULL)
> +				tst_brkm(TFAIL | TERRNO, NULL, "Open dev "
> +							       "status failed");
> +
> +			while (fgets(line, LINELEN, fstatus) != NULL)
> +				if (strstr(line, "VmLck") != NULL)
> +					break;
> +
> +			ret = sscanf(line, "%*[^0-9]%d%*[^0-9]", &lock_sz);
> +			if (ret != 1)
> +				tst_brkm(TFAIL | TERRNO, NULL, "Get lock "
> +							       "size failed");
> +
> +			if (lock_sz == MMAPSIZE / 1024)
> +				tst_resm(TPASS, "Functionality of mmap() "
> +						"successful");

I know that it's unlikely that process would have some pages locked
prior the mmap above, but getting the number of locked pages before the
mmap after it and using the difference in the comparsion would be more
robust. And the additional work needed for this is minimal, just move
the part of the code that reads VmLck value into a function and call it
before and after the mmap.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
