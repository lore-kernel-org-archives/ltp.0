Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1SzgR1-0006KQ-7Y
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 04:02:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SzgQz-000399-Do
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 04:02:51 +0000
Message-ID: <502486C1.3080301@redhat.com>
Date: Fri, 10 Aug 2012 11:57:53 +0800
From: Zhouping Liu <zliu@redhat.com>
MIME-Version: 1.0
References: <cover.1344492473.git.caspar@casparzhang.com>
	<50247C2C.5000104@redhat.com> <50247FC3.50303@casparzhang.com>
In-Reply-To: <50247FC3.50303@casparzhang.com>
Subject: Re: [LTP] [PATCH resend 0/6] NUMA and follow-up fix
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/10/2012 11:28 AM, Caspar Zhang wrote:
> On 08/10/2012 11:12 AM, Zhouping Liu wrote:
>> Hi,
>>
>> On 08/09/2012 02:15 PM, Caspar Zhang wrote:
>>> Resending the whole patch series (including Jan's 2 patches) for easier
>>> reviewing.
>>
>> Caspar, after applying the patch set, I met the bellow compiling error
>> when do  'make install':
>>
>> ... snip ...
>> make[4]: Leaving directory 
>> `/root/ltp_new/testcases/kernel/syscalls/umask'
>> make[3]: Leaving directory `/root/ltp_new/testcases/kernel/syscalls'
>> make[3]: Entering directory `/root/ltp_new/testcases/kernel/lib'
>> ../../../include/mk/env_post.mk:94: warning: overriding recipe for
>> target `/opt/ltp/lib'
>> ../../../include/mk/env_post.mk:94: warning: ignoring old recipe for
>> target `/opt/ltp/lib'
>> ../../../include/mk/env_post.mk:96: warning: overriding recipe for
>> target `/opt/ltp/lib/libkerntest.a'
>> ../../../include/mk/env_post.mk:96: warning: ignoring old recipe for
>> target `/opt/ltp/lib/libkerntest.a'
>> ../../../include/mk/generic_trunk_target.inc:89: CURDIR is:
>> /root/ltp_new/testcases/kernel/lib
>> ../../../include/mk/generic_trunk_target.inc:89: *** SUBDIRS empty --
>> did you want generic_leaf_target instead?.  Stop.
>> make[3]: Leaving directory `/root/ltp_new/testcases/kernel/lib'
>> make[2]: *** [install] Error 2
>> make[2]: Leaving directory `/root/ltp_new/testcases/kernel'
>> make[1]: *** [install] Error 2
>> make[1]: Leaving directory `/root/ltp_new/testcases'
>> make: *** [testcases-install] Error 2
>
> Thanks for trying the patches out, can you try 4/6 v2?

yes, tested the v2, and I confirmed it fixed such above compiling error.

Thanks,
Zhouping

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
