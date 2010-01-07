Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NShmq-0004EU-H7
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 02:07:44 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NShmp-0002vY-FN
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 02:07:44 +0000
Message-ID: <4B453D1C.3050108@web.de>
Date: Thu, 07 Jan 2010 02:47:08 +0100
From: Jiri Palecek <jpalecek@web.de>
MIME-Version: 1.0
References: <4B41E55D.2020801@st.com> <4B43E52E.4000205@web.de>
	<8368651DACC1964480F951191B94A07801A20EF7@svexch01.mvista.com>
In-Reply-To: <8368651DACC1964480F951191B94A07801A20EF7@svexch01.mvista.com>
Subject: Re: [LTP] mtest01: free memory allocated
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Henry Yei napsal(a):
>> -----Original Message-----
>> From: Jiri Palecek [mailto:jpalecek@web.de]
>> Sent: Tuesday, January 05, 2010 5:20 PM
>> To: Francesco RUNDO
>> Cc: LTP
>> Subject: Re: [LTP] mtest01: free memory allocated
>>
>> Francesco RUNDO napsal(a):
>>> Hi All,
>>>
>>> I'm running LTP (I'm using ltp-full-20090731....but asap I will
>> upgrade
>>> to latest) on SH based platforms.
>>> Now, during a test-session. I've noted that the test "mtest01"
>> reduced
>>> drastically the system memory and after its execution this memory
>> wasn't
>>> de-allocated.
>>>
>>> I've analysed the mtest01.c code and I've noted that no "free()"
>>> istruction was associated to the related malloc:
>>
>> Does this mean the kernel doesn't free processes' allocated memory on
>> exit? Is
>> this intentional (and documented somewhere)?
>>
>>> ......
>>> if((mem = (char*)malloc(chunksize)) == NULL) {
>>> ......
>>>
>>> I've simply added a "free(mem)" of the allocated memory and the issue
>>> was addressed successfully.
>>
>> This isn't complete by far. You don't free all the allocations, and
>> there are
>> code paths which don't pass your line before exit.
>>
>> Regards
>>       Jiri Palecek
>>
>
> We've documented this behavior internally as a low priority issue for a while now.
> This is the root cause one of our developers came back with, which might clarify what Francesco is seeing:
>
> Issue:
>
> Across architectures, mtest tests sometimes report a fail because they won't
> run unless less than 80% of memory is used. This is because the test attempts
> to fill up the memory to the 80% limit specified by the -p option.
>
> Some previous test in the LTP suite is taking up memory it should not have, as
> this happens even on machines with 1GB of memory.
>
> mtest01 runs "mtest01 -p80" which mallocs chunks of memory until 80% of memory
> is used.
> mtest01w runs "mtest01 -p80 -w" which mallocs and writes chunks of memory until
> 80% of memory is used.
>
>
> Response:
>
> mtest01 -p80 -w; mtest01 -p80 -w; free; free; free... ; mtest01 -p80 -w
>
> on the same command line. the second mtest01 always returns with a failure.
> while the mtest01 after enough free(usually 4 or 5) always passes.

Indeed, I reproduced it on a machine without swap (is this reproducible with 
swap?), although the second mtest didn't fail, but just allocated ridiculously 
small amount of memory. However, I'm curious if this is what Francesco is seeing 
(eg. if the memory is eventually freed on his machine).

> Looks like it is because of the aging of the caches, which are not freed yet
> when the second mtest01 is executed and are dropped due to aging by the time
> last mtest01 is executed.
> The information (sysinfo()) mtest is using to determine the amount of memory
> allocated does not include the memory in caches(free). mtest01 sees that 80% of
> the memory is already in use and thus do not go for malloc-ing and returns with
> a failure, however if it had tried, the malloc would have succeeded because of
> the reuse of the free slab caches.

I'm afraid this isn't related to slab caches, as slabinfo between the two tests 
doesn't show anything suspicious (it's logical, too - if the test just before 
consumed 80% of memory in user pages, it's unlikely the memory would be 
allocated to slab after that).

Regards
     Jiri Palecek

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
