Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Tij4O-0005I5-Qm
	for ltp-list@lists.sourceforge.net; Wed, 12 Dec 2012 09:57:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tij4I-0004Zx-IS
	for ltp-list@lists.sourceforge.net; Wed, 12 Dec 2012 09:57:40 +0000
Message-ID: <50C854A5.80509@cn.fujitsu.com>
Date: Wed, 12 Dec 2012 17:55:49 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1272030098.14596289.1355305213874.JavaMail.root@redhat.com>
In-Reply-To: <1272030098.14596289.1355305213874.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] clone05: signal parent when the child terminates
Reply-To: gaowanlong@cn.fujitsu.com
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
Cc: LTP <ltp-list@lists.sourceforge.net>

On 12/12/2012 05:40 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "LTP" <ltp-list@lists.sourceforge.net>
>> Sent: Wednesday, 12 December, 2012 3:41:42 AM
>> Subject: [LTP] [PATCH] clone05: signal parent when the child terminates
>>
>> Add SIGCHLD flag when doing clone to signal parent when the child
>> terminates.
>> This flag is missed by commit c91af2ff.
>>
>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>> ---
>>  testcases/kernel/syscalls/clone/clone05.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/syscalls/clone/clone05.c
>> b/testcases/kernel/syscalls/clone/clone05.c
>> index 4797b46..06b84ed 100644
>> --- a/testcases/kernel/syscalls/clone/clone05.c
>> +++ b/testcases/kernel/syscalls/clone/clone05.c
>> @@ -60,7 +60,7 @@ int main(int ac, char **av)
>>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
>>  		Tst_count = 0;
>>  
>> -		TEST(ltp_clone(CLONE_VM | CLONE_VFORK, child_fn, NULL,
>> +		TEST(ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, child_fn, NULL,
> 
> Good catch.
> Reviewed-by: Jan Stancek <jstancek@redhat.com>

Thank you for review, committed.

Wanlong Gao


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
