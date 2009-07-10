Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dvhltc@us.ibm.com>) id 1MPL4F-0004Qs-3i
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 18:43:31 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MPL42-00055P-70
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 18:43:26 +0000
Message-ID: <4A57884C.10401@us.ibm.com>
Date: Fri, 10 Jul 2009 11:28:28 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
References: <1224509719.5152.116.camel@subratamodak.linux.ibm.com>
	<1246890698.4887.24.camel@subratamodak.linux.ibm.com>
	<1247076833.5405.48.camel@subratamodak.linux.ibm.com>
	<200907102200.12804.sripathik@in.ibm.com>
	<1247244446.5040.0.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1247244446.5040.0.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] LTP RT Tests (Cyclic, rt-migrate, etc)
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Steven Rostedt <rostedt@goodmis.org>, Gregory Haskins <ghaskins@novell.com>, Clark Williams <clark.williams@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>

Subrata Modak wrote:
> On Fri, 2009-07-10 at 22:00 +0530, Sripathi Kodi wrote:
>> On Wednesday 08 July 2009 23:43:53 Subrata Modak wrote:
>>> Darren/Sri/Gowri,
>>>
>>> Where do you want me to put this exactly inside the RT tree ?
>> Hi Subrata,
>>
>> Going by how the tests are organized currently, I think this should go
>> into it's own directory under testcases/realtime/func. We will need to
>> add a makefile to it. Are you looking at us to help you with this?
> 
> Correct. Please send me a patch which integrates it into RT tests build,
> install & run.

Just got back from a week vacation and am burning through mail as fast 
as I can :-) Haven't had a look yet, but does this test use librttest.h? 
  I suspect not.  We'll need to adapt it to run within the existing ltp 
real-time testing framework, which includes things like buffered output 
as well as mlocking support.

Lastly, I'm not sure this test does anything effectively different than 
prio-wake, already in the tree.  My other concerns with the test are its 
explicit 1ms preemption criteria (as Steven described it anyway).  We 
are trying to move away from criteria being inherent in measurement 
tests, and 1 ms seems like an awfully long priority inversion to be an 
acceptable criteria to many users.

Steven, am I missing something conceptually here?

--
Darren

> 
> Regards--
> Subrata
> 
>> Thanks,
>> Sripathi.
>>
>>> Regards--
>>> Subrata
>>>
>>> On Mon, 2009-07-06 at 20:01 +0530, Subrata Modak wrote: 
>>>> On Mon, 2009-07-06 at 10:26 -0400, Steven Rostedt wrote:
>>>>> On Tue, 23 Jun 2009, Subrata Modak wrote:
>>>>>
>>>>>> Steven,
>>>>>>
>>>>>> Do you remember this ?
>>>>> Yes, and I finally got time to fix it up a little ;-)
>>>> Great. Forwarding to the ltp mailing list as well. Thanks steven.
>>>>
>>>> Regards--
>>>> Subrata
>>>>
>>>>> OK, here it is. To run it, just do:
>>>>>
>>>>>  ./rt-migrate-test -c 
>>>>>
>>>>> You need to be root since it changes the priorities. It will check the 
>>>>> number of processors and create N+1 threads (where N is the number of 
>>>>> processors). Each thread will wake up at the same time and try to do a 
>>>>> busy loop for 20 millisecs. If a lower prio thread runs for 1ms before a 
>>>>> higher prio thread, it will fail. This should test the migration of the 
>>>>> threads to make sure that the higher prio threads run first.
>>>>>
>>>>> Sorry for taking so long.
>>>>>
>>>>> -- Steve
>>>>>
>>>>>
>>>>>
>>>>>> Regards--
>>>>>> Subrata
>>>>>>
>>>>>> On Mon, 2008-12-15 at 08:52 -0500, Steven Rostedt wrote: 
>>>>>>> On Mon, 15 Dec 2008, Subrata Modak wrote:
>>>>>>>>> Lets see, you wanted my rt migration test. I'll clean that up now. Is 
>>>>>>>> Oh yes.
>>>>>>> OK, I'm cleaning it up to be more for production use.
>>>>>>>
>>>>>>>>> there something else I needed to send you? If you remember.
>>>>>>>> I am not quite sure now. Will let you know in future.
>>>>>>> OK, thanks,
>>>>>>>
>>>>>>> -- Steve
>>>>>>>
>>>>>>
>>>> ------------------------------------------------------------------------------
>>>> _______________________________________________
>>>> Ltp-list mailing list
>>>> Ltp-list@lists.sourceforge.net
>>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> 


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
