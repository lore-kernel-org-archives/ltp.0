Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1X43cN-0007By-Ae
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 07:45:43 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X43cL-0004Z5-A8
	for ltp-list@lists.sourceforge.net; Mon, 07 Jul 2014 07:45:43 +0000
Message-ID: <53BBA1BD.2050902@cn.fujitsu.com>
Date: Tue, 8 Jul 2014 15:46:05 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <20140704031641.GA20446@localhost.localdomain>
	<53BB90C6.9020101@cn.fujitsu.com>
	<20140707065140.GA4421@localhost.localdomain>
In-Reply-To: <20140707065140.GA4421@localhost.localdomain>
Subject: Re: [LTP] [RFC PATCH] regression test for 64bit sendfile capped at
 2G
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
To: hanpt@linux.vnet.ibm.com
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi,

On 07/07/2014 02:51 PM, Han Pingtian wrote:
> On Tue, Jul 08, 2014 at 02:33:42PM +0800, Xiaoguang Wang wrote:
>> Hi,
>>
>> On 07/04/2014 11:16 AM, Han Pingtian wrote:
>>> Hi,
>>>
>>> Please review this patch. Thanks.
>>>
>>> There is a bug on 64bit sendfile() with large file, please see
>>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118128.html
>>> for details.
>>
>> I'd like to ask an irrelevant question about that where can we get such bug report or similar issues
>> about syscalls from a stable place(url), or how did you found this issue, thanks.
>>
>> Give that currently there are 1039 test cases about syscalls in LTP(cat runtest/syscalls | grep -v "^#" | sed -e '/^$/d' | wc -l),
>> we can tell that syscalls is a very big test suite in LTP, so I'd like to add all similar regression test about
>> syscalls to LTP, which will expand ltp's test coverage, thanks. 
>>
>> Regards,
>> Xiaoguang Wang
>>
> Thanks for your reply. I knew this problem just by accidental. It wasn't
> found by me, but someone else. We are asked why we couldn't find it at
> first time though we had run ltp to test the syscalls. So I think it
> would be better to include a regession test for it to ltp. I think we
> can find out all those regressions by mointoring bug report web site and
> kernel's mailing list and something like these.

Yeah, kernel mail list would be the best place to find such issues, but usually
it needs more time to figure them out :)

As for you patch, I don't know whether you have read the test-writing-guidelines.txt first, if not,
please see https://github.com/linux-test-project/ltp/blob/master/doc/test-writing-guidelines.txt.
For example, there are already many safe_* in ltp, you can use them, which will simplify your error checking, thanks.

Regards,
Xiaoguang Wang 



> 
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
