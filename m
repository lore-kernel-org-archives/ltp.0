Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NjTfD-0006iE-0k
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 08:29:11 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjTfA-0004EE-Fv
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 08:29:10 +0000
Message-ID: <4B824029.7070609@cn.fujitsu.com>
Date: Mon, 22 Feb 2010 16:28:25 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B7BA433.3030206@linux.vnet.ibm.com>
	<364299f41002170908p302cc665g874c89a109ddfd1f@mail.gmail.com>
	<20100218035756.GA13013@rishikesh.in.ibm.com>
In-Reply-To: <20100218035756.GA13013@rishikesh.in.ibm.com>
Subject: Re: [LTP] [PATCH] mail_tests.sh: fix a version problem of Heirloom
 Mail
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

at 2010-2-18 11:57, Rishikesh K Rajak wrote:
> On Wed, Feb 17, 2010 at 09:08:39AM -0800, Garrett Cooper wrote:
>> On Wed, Feb 17, 2010 at 12:09 AM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
>>> Hi Shi,
>>>
>>> Thanks for your patch . It will be merged in feb 2010 release.
>>>
>>> Acked-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
>>>
>>> http://marc.info/?l=ltp-list&m=126440546415559&w=2
>>
>> There's a lot of noise in the patch because of if-else behavior in
>> trying to determine the mail app. That's why I didn't commit this (it
>> requires verification of previous mail applications as well).
> 
> Thanks Garret, Still i have not committed this to CVS repo.
> 
> Shi, can you please verify if this patch does not break with any other
> mail application.

  In fact, i don't know any other mail application.
  When i tested RHEL's alpha version, this ltp bug catched. so tried to fix it.
  
  Maybe, you should knock FOSS community(?).

> 
> Thanks for your support.
> -Rishi
>>
>> The mail test should be resistant to changes like these as a lot of
>> developers in the FOSS community have different opinions on how to do
>> things and don't follow any particular standard. This `heirloom mailx'
>> support is just one said example that needs to be fixed.
>>
>> Thanks,
>> -Garrett
> 
> 

-- 
Shi Weihua

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
