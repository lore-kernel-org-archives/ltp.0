Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1URfXg-0000qM-Nf
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 09:17:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1URfXf-0007F9-FN
	for ltp-list@lists.sourceforge.net; Mon, 15 Apr 2013 09:17:40 +0000
Message-ID: <516BC5C4.3050006@cn.fujitsu.com>
Date: Mon, 15 Apr 2013 17:17:56 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <fd56c3851c2ada9667af4f51b0887282d5e43279.1366012538.git.jstancek@redhat.com>
	<516BB803.6000603@cn.fujitsu.com>
	<1428475737.306249.1366016603320.JavaMail.root@redhat.com>
In-Reply-To: <1428475737.306249.1366016603320.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v2] sendmsg testcase for
	ded34e0fe8fe8c2d595bfa30626654e4b87621e0
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
Cc: ltp-list@lists.sourceforge.net

On 04/15/2013 05:03 PM, Jan Stancek wrote:
> 
> ----- Original Message -----
>> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Monday, 15 April, 2013 10:19:15 AM
>> Subject: Re: [LTP] [PATCH v2] sendmsg testcase for ded34e0fe8fe8c2d595bfa30626654e4b87621e0
>>
>> On 04/15/2013 03:58 PM, Jan Stancek wrote:
>>> reproducer for:
>>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000250
>>>
>>> fixed in 3.9.0-0.rc5:
>>>   commit ded34e0fe8fe8c2d595bfa30626654e4b87621e0
>>>   Author: Paul Moore <pmoore@redhat.com>
>>>   Date:   Mon Mar 25 03:18:33 2013 +0000
>>>     unix: fix a race condition in unix_release()
>>>
>>> This reproducer should be able to trigger it easily on 4+ CPU systems
>>> just within couple of seconds.
>>
>> I didn't get panic on my v3.9-rc4 system by this test case.
> 
> I double checked if I got that -rc right, and that looks OK:
> $ git tag --contains ded34e0fe8fe8c2d595bfa30626654e4b87621e0
> v3.9-rc5
> v3.9-rc6
> v3.9-rc7

I'm sure that 3.9-rc4 don't contain this fix commit.

> 
> There is a switch "-s" for how many seconds it should run. Can you try to run
> it for couple of minutes, if that makes any difference?

I ran it for 5 minutes again but saw no difference.

Thanks,
Wanlong Gao

> 
> If not, then I'm afraid it's not as reproducible as I thought it would be.
> 
> Regards,
> Jan
> 
> 


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
