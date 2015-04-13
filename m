Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Yheaf-00075a-3f
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 13:39:53 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yheac-0001kM-VD
	for ltp-list@lists.sourceforge.net; Mon, 13 Apr 2015 13:39:53 +0000
Message-ID: <552BC7C7.1010105@oracle.com>
Date: Mon, 13 Apr 2015 16:42:31 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1428672725-13538-1-git-send-email-alexey.kodanev@oracle.com>
	<552B2AFF.20107@cn.fujitsu.com>
In-Reply-To: <552B2AFF.20107@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] syscalls/fallocate04: add new fallocate() test
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
On 04/13/2015 05:33 AM, Xiaoguang Wang wrote:
>> +
>> +#define SEEK_HOLE			4
>> +#define FALLOC_FL_KEEP_SIZE		0x01
>> +#define FALLOC_FL_PUNCH_HOLE		0x02
>> +#define FALLOC_FL_COLLAPSE_RANGE	0x08
>> +#define FALLOC_FL_ZERO_RANGE		0x10
> What about something like this:
> #ifndef	FALLOC_FL_KEEP_SIZE	4
> #define	 FALLOC_FL_KEEP_SIZE	4
> #endif
> In case, glibc have already defines these macro now or in future.

Redefinition with the same values doesn't produce any warnings, but on 
the other hand what if we want to know when they are different?

> We could put these definitions in testcases/kernel/syscalls/fallocate/fallocate.h.

Right, we can put them there.

> And what about we test this case in a specific file system, such
> as ext4 or xfs. Many fs do not support these operations.

If i'm not mistaken we should get 'ENOSUPPORT' errno on filesystems that 
don't support such modes. The test already checks that and exit with TCONF.

> 	
>> +
>> +char *TCID = "fallocate04";
>> +int TST_TOTAL = 3;
>> +
>> +static int fd;
>> +static const char fname[] = "fallocate04.txt";
>> +static size_t block_size;
>> +static size_t buf_size;
>> +enum { NUM_OF_BLOCKS = 3 };
> Why type is enum? I'm not sure, a simple '#define NUM_OF_BLOCKS 3' would be OK.

There is no specific reason why I set enum, I guess either way is fine 
here, it could be 'const int' as well... though they are all different.

>> +
>> +static void get_blocksize(void)
>> +{
>> +	struct stat file_stat;
>> +
>> +	if (fstat(fd, &file_stat) == -1)
>> +		tst_brkm(TFAIL | TERRNO, cleanup, "fstat() failed");
> We have SAFE_FSTAT().

Thanks for noticing, I forgot to check the library.

> +
> +static void test02(void)
> +{
> +	tst_resm(TINFO, "zeroing file space with FALLOC_FL_ZERO_RANGE");
> +
> +	if (tst_kvercmp(3, 14, 0) < 0) {
> +		tst_brkm(TCONF, NULL,
> +			 "Test must be run with kernel 3.14 or newer");
> Here a cleanup is needed, otherwise you will fail to call tst_rmdir()
> to remove the created temporary directory created by tst_tmpdir().

Oh, of course, you are right!

Thanks,
Alexey


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
