Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Y0ppD-00037G-Qq
	for ltp-list@lists.sourceforge.net; Tue, 16 Dec 2014 10:57:55 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Y0ppC-0006Pd-Hg
	for ltp-list@lists.sourceforge.net; Tue, 16 Dec 2014 10:57:55 +0000
Message-ID: <54901027.4040406@oracle.com>
Date: Tue, 16 Dec 2014 13:57:43 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1416240279-7595-1-git-send-email-xuw@redhat.com>
	<645117657.6599944.1416481042396.JavaMail.zimbra@redhat.com>
In-Reply-To: <645117657.6599944.1416481042396.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH V2] library: add tst_system for wrapper system(3)
 without SIGCHLD
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
To: xuw@redhat.com
Cc: ltp-list@lists.sourceforge.net

Hi, George.

I've just found that I'm also motivated to have this bug fixed :)

Are you planning to send an updated version including Jan's comments?

Thanks.

PS: I also tested it with access06 test case:

without the patch:

[root@kholmanskikh access]# LTP_DEV_FS_TYPE=btrfs ./access06
access06    0  TINFO  :  Found free device '/dev/loop0'
access06    1  TBROK  :  tst_sig.c:233: unexpected signal 
SIGCHLD/SIGCLD(17) received (pid = 10671).
access06    2  TBROK  :  tst_sig.c:233: Remaining cases broken

with:
[root@kholmanskikh access]# LTP_DEV_FS_TYPE=btrfs ./access06
access06    0  TINFO  :  Found free device '/dev/loop0'
access06    0  TINFO  :  Appending '-f' flag to mkfs.btrfs
access06    0  TINFO  :  Formatting /dev/loop0 with btrfs extra opts=''
access06    1  TPASS  :  access failed as expected: 
TEST_ERRNO=EROFS(30): Read-only file system



On 11/20/2014 01:57 PM, Jan Stancek wrote:
>
>
> ----- Original Message -----
>> From: xuw@redhat.com
>> To: ltp-list@lists.sourceforge.net
>> Sent: Monday, 17 November, 2014 5:04:39 PM
>> Subject: [LTP] [PATCH V2] library: add tst_system for wrapper system(3)	without SIGCHLD
>>
>> From: George Wang <xuw@redhat.com>
>
> Hi,
>
> Looks good to me, I tested only on single testcase, it work
> as advertised. Couple nits to comments/commit message:
>
>>
>> system(3) will raise SIGCHLD signal to parent process, and most
>> test cases will call tst_sig to poison all signals including the
>> SIGCHLD. So add system(3) wrapper function to temporarily disable
>> the poisoned handler for SIGCHLD, which will make the test cases
>> happy.
>> Replace directly calling system(3) with tst_systm on behalf of
>                                            ^^ tst_system
>> ignorcing SIGCHLG signal posioned handler.
>    ^^ ignoring              ^^ poisoned
> I don't get the "on behalf of" part of that sentence. Maybe:
> "Replace system(3) with tst_system() to ignore SIGCHLG
> signal handler poisoned earlier."
>
>>
>> Signed-off-by: George Wang <xuw@redhat.com>
>> ---
>>   include/test.h    |  5 +++++
>>   lib/tst_mkfs.c    |  2 +-
>>   lib/tst_run_cmd.c | 17 +++++++++++++++++
>>   3 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/test.h b/include/test.h
>> index 775ba39..326b686 100644
>> --- a/include/test.h
>> +++ b/include/test.h
>> @@ -300,6 +300,11 @@ void tst_run_cmd(void (cleanup_fn)(void),
>>   		const char *stdout_path,
>>   		const char *stderr_path);
>>
>> +/* Wrapper function for system(3), ignorcing SIGCLD signal.
>                                        ^^ ignoring
>
>> + * @command: the command to be run.
>> + */
>> +int tst_system(const char *command);
>> +
>>   /* lib/tst_mkfs.c
>>    *
>>    * @dev: path to a device
>> diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
>> index 5eb3392..173347a 100644
>> --- a/lib/tst_mkfs.c
>> +++ b/lib/tst_mkfs.c
>> @@ -45,7 +45,7 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
>>   		/*
>>   		 * The -f option was added to btrfs-progs v3.12
>>   		 */
>> -		if (system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) {
>> +		if (tst_system("mkfs.btrfs 2>&1 | grep '\\-f ' >/dev/null") == 0) {
>
> This line is now too long.
>
> Regards,
> Jan
>
>>   			tst_resm(TINFO, "Appending '-f' flag to mkfs.%s",
>>   				fs_type);
>>   			argv[pos++] = "-f";
>> diff --git a/lib/tst_run_cmd.c b/lib/tst_run_cmd.c
>> index 4eb32e6..5a02db0 100644
>> --- a/lib/tst_run_cmd.c
>> +++ b/lib/tst_run_cmd.c
>> @@ -125,3 +125,20 @@ void tst_run_cmd(void (cleanup_fn)(void),
>>   			"close() on %s failed at %s:%d",
>>   			stderr_path, __FILE__, __LINE__);
>>   }
>> +
>> +int tst_system(const char *command)
>> +{
>> +	int ret = 0;
>> +
>> +	/*
>> +	 *Temporarily disable SIGCHLD of user defined handler, so the
>> +	 *system(3) function will not cause unexpected SIGCHLD signal
>> +	 *callback function for test cases.
>> +	 */
>> +	void *old_handler = signal(SIGCHLD, SIG_DFL);
>> +
>> +	ret = system(command);
>> +
>> +	signal(SIGCHLD, old_handler);
>> +	return ret;
>> +}
>> --
>> 1.8.4.2
>>
>>
>> ------------------------------------------------------------------------------
>> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
>> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
>> with Interactivity, Sharing, Native Excel Exports, App Integration & more
>> Get technology previously reserved for billion-dollar corporations, FREE
>> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
