Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrU2J-0001bs-NM
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 14:15:59 +0000
Date: Tue, 25 Jun 2013 16:17:27 +0200
From: chrubis@suse.cz
Message-ID: <20130625141727.GK31268@rei>
References: <51C95F37.3000409@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51C95F37.3000409@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] mmap/mmap12.c: new case to test MAP_POPULATE
 of mmap
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
> +static int page_check(void)
> +{
> +	int pid;
> +	int ret;
> +	int pm;
> +	int num_pages;
> +	long index;
> +	off_t offset;
> +	size_t page_sz;
> +	char maps_dev[PATHLEN];
> +	char pagemap_dev[PATHLEN];
> +	char line[LINELEN];
> +	FILE *maps;
> +	unsigned long vm_start;
> +	unsigned long vm_end;
> +	unsigned long long pagemap;
> +
> +	page_sz = getpagesize();
> +
> +	pid = getpid();
> +	sprintf(maps_dev, "/proc/%d/maps", pid);
> +	sprintf(pagemap_dev, "/proc/%d/pagemap", pid);

Just use "/proc/self/maps" and "/proc/self/pagemap" instead.

> +	maps = fopen(maps_dev, "r");
> +	if (maps == NULL)
> +		tst_brkm(TFAIL | TERRNO, NULL, "Open dev maps failed");
> +
> +	while (fgets(line, LINELEN, maps) != NULL)
> +		if (strstr(line, TEMPFILE) != NULL)
> +			break;
> +
> +	ret = sscanf(line, "%lX-%lX", &vm_start, &vm_end);
> +	if (ret != 2)
> +		tst_brkm(TFAIL | TERRNO, NULL, "Get address space failed");

This part of the code does not cope with unlikely condition that
TEMPFILE is missing from /proc/self/maps we should fail the test in this
case with proper error message.

> +	num_pages = (vm_end - vm_start) / page_sz;
> +	index = (vm_start / page_sz) * sizeof(unsigned long long);
> +
> +	pm = open(pagemap_dev, O_RDONLY);
> +	if (pm == -1)
> +		tst_brkm(TFAIL | TERRNO, NULL, "Open dev pagemap failed");
> +
> +	offset = lseek(pm, index, SEEK_SET);
> +	if (offset != index)
> +		tst_brkm(TFAIL | TERRNO, NULL, "Reposition offset failed");
> +
> +	while (num_pages > 0) {
> +		ret = read(pm, &pagemap, sizeof(unsigned long long));
> +		if (ret < 0)
> +			tst_brkm(TFAIL | TERRNO, NULL, "Read pagemap failed");
> +		/*
> +		 * Check if the page is present.
> +		 */
> +		if (!(pagemap & (1ULL<<63))) {
> +			close(pm);
> +			fclose(maps);
> +			return 1;

I would perpahs be more verbose here and go over all of the pages and
list these that are not mapped, but that is a minor nitpick. 

> +		}
> +		num_pages--;
> +	}
> +
> +	close(pm);
> +	fclose(maps);
> +
> +	return 0;
> +}

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
