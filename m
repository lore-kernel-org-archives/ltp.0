Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UregD-0008BX-6q
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 01:37:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UregB-00074N-BR
	for ltp-list@lists.sourceforge.net; Wed, 26 Jun 2013 01:37:53 +0000
Message-ID: <51CA45A9.9020603@cn.fujitsu.com>
Date: Wed, 26 Jun 2013 09:36:41 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51C95F37.3000409@cn.fujitsu.com>
	<804366117.1964429.1372157275604.JavaMail.root@redhat.com>
In-Reply-To: <804366117.1964429.1372157275604.JavaMail.root@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 06/25/2013 06:47 PM, Jan Stancek wrote:
> 
> ----- Original Message -----
>> From: "DAN LI" <li.dan@cn.fujitsu.com>
>> To: "LTP list" <ltp-list@lists.sourceforge.net>
>> Cc: "Jan Stancek" <jstancek@redhat.com>, chrubis@suse.cz, "Caspar Zhang" <caspar@casparzhang.com>
>> Sent: Tuesday, 25 June, 2013 11:13:27 AM
>> Subject: [LTP] [PATCH v2] mmap/mmap12.c: new case to test MAP_POPULATE of mmap
>>
>>
>> Create test case for MAP_POPULATE of mmap.
>>
>> Verify the following statement
>> "For a file mapping,this causes read-ahead on the file.
>>  Later accesses to the mapping will not be blocked by page faults."
>> by mmap-ing a file and check if all pages are present.
>>
>>
>> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
>> ---
>>  runtest/syscalls                        |   1 +
>>  testcases/kernel/syscalls/mmap/mmap12.c | 194
>>  ++++++++++++++++++++++++++++++++
>>  2 files changed, 195 insertions(+)
>>  create mode 100644 testcases/kernel/syscalls/mmap/mmap12.c
> 
> <snip>
> 
>> +
>> +static int page_check(void)
>> +{
>> +	int pid;
>> +	int ret;
>> +	int pm;
>> +	int num_pages;
>> +	long index;
>> +	off_t offset;
>> +	size_t page_sz;
>> +	char maps_dev[PATHLEN];
>> +	char pagemap_dev[PATHLEN];
>> +	char line[LINELEN];
>> +	FILE *maps;
>> +	unsigned long vm_start;
>> +	unsigned long vm_end;
>> +	unsigned long long pagemap;
>> +
>> +	page_sz = getpagesize();
>> +
>> +	pid = getpid();
>> +	sprintf(maps_dev, "/proc/%d/maps", pid);
>> +	sprintf(pagemap_dev, "/proc/%d/pagemap", pid);
>> +
>> +	maps = fopen(maps_dev, "r");
>> +	if (maps == NULL)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "Open dev maps failed");
>> +
>> +	while (fgets(line, LINELEN, maps) != NULL)
>> +		if (strstr(line, TEMPFILE) != NULL)
>> +			break;
>> +
>> +	ret = sscanf(line, "%lX-%lX", &vm_start, &vm_end);
> 
> Why parsing these 2 from maps? Size is defined by you, and you get vm_start
> from mmap().

Just a force of inertia following pagemap document.

> 
>> +	if (ret != 2)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "Get address space failed");
>> +
>> +	num_pages = (vm_end - vm_start) / page_sz;
>> +	index = (vm_start / page_sz) * sizeof(unsigned long long);
> 
> C99 says long long is _at least_ 64 bits wide. If it's larger than 64, formula
> above would break. How about using type, that's exactly 64 bit (uint64_t)?

Get it.

> 
>> +
>> +	pm = open(pagemap_dev, O_RDONLY);
>> +	if (pm == -1)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "Open dev pagemap failed");
>> +
>> +	offset = lseek(pm, index, SEEK_SET);
>> +	if (offset != index)
>> +		tst_brkm(TFAIL | TERRNO, NULL, "Reposition offset failed");
>> +
>> +	while (num_pages > 0) {
>> +		ret = read(pm, &pagemap, sizeof(unsigned long long));
>> +		if (ret < 0)
>> +			tst_brkm(TFAIL | TERRNO, NULL, "Read pagemap failed");
>> +		/*
>> +		 * Check if the page is present.
>> +		 */
>> +		if (!(pagemap & (1ULL<<63))) {
>> +			close(pm);
>> +			fclose(maps);
>> +			return 1;
>> +		}
>> +		num_pages--;
>> +	}
>> +
>> +	close(pm);
>> +	fclose(maps);
>> +
>> +	return 0;
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	tst_sig(FORK, DEF_HANDLER, cleanup);
>> +
>> +	if ((tst_kvercmp(2, 6, 25)) < 0)
>> +		tst_brkm(TCONF, NULL,
>> +			"This test can only run on kernels that are 2.6.23 and "
> 
> Message says 2.6.23, but check is for 2.6.25.

Wow...


All of the above will be fixed in coming V3.


Thank you for reviewing.

Regards,
DAN LI

> 
>> +			"higher");
>> +
>> +	TEST_PAUSE;
>> +
>> +	tst_tmpdir();
>> +
>> +	fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0766);
>> +	if (fildes < 0)
>> +		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
>> +
>> +	if (ftruncate(fildes, MMAPSIZE) < 0)
>> +		tst_brkm(TFAIL | TERRNO, cleanup, "ftruncate file failed");
>> +
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	close(fildes);
>> +	TEST_CLEANUP;
>> +	tst_rmdir();
>> +}
>> --
>> 1.8.1
>>
> 



------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
