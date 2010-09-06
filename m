Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OseNf-0001S5-5e
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:15 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OseNa-0001YG-Us
	for ltp-list@lists.sourceforge.net; Mon, 06 Sep 2010 16:17:13 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Mon, 06 Sep 2010 21:46:45 +0530
Message-Id: <1283789806.4947.20.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch] Fix mtest06 failure: caught unexpected signal
	-	11 --- exiting
Reply-To: subrata@linux.vnet.ibm.com
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
To: suzuki <suzuki@in.ibm.con>
Cc: ltp-list <ltp-list@lists.sf.net>

Suzuki,

Can you please review this patch ?

Regards--
Subrata

-------- Forwarded Message --------
From: Garrett Cooper <yanegomi@gmail.com>
To: renxiu liang <renxiu.liang@windriver.com>
Cc: ltp-list@lists.sf.net
Subject: Re: [LTP] [Patch] Fix mtest06 failure: caught unexpected signal
- 11 --- exiting
Date: Wed, 1 Sep 2010 00:26:47 -0700

On Mon, Aug 30, 2010 at 6:51 PM, renxiu liang
<renxiu.liang@windriver.com> wrote:
> On Wed, 2010-08-25 at 20:36 -0700, Garrett Cooper wrote:
>> On Wed, Aug 18, 2010 at 12:33 AM, renxiu liang
>> <renxiu.liang@windriver.com> wrote:
>> > Hi,
>> >
>> > We met the mtest06 failure several times; this is because in
>> > mtest06/mmap1.c, when handling the signal 11 in sig_handler, it doesn't
>> > cover another two race conditions:
>> > one is si_code equals "SEGV_MAPERR" but si_address does not equal to
>> > map_address; and one is si_code equals to "SEGV_ACCERR";
>> >
>> > see below error log:
>> >
>> > <<<test_start>>>
>> > tag=mtest06 stime=1270902396
>> > cmdline="  mmap1 -x 0.05"
>> > contacts=""
>> > analysis=exit
>> > initiation_status="ok"
>> > <<<test_output>>>
>> > mmap1       0  INFO  :  pid[5456]: map, change contents, unmap files
>> > 1000 times
>> > mmap1       0  INFO  :  created thread[1216369840]
>> > mmap1       0  INFO  :  pid[5456] - read contents of memory 0x48002000
>> > 1000 times
>> > mmap1       0  INFO  :  page fault occurred at 0x48002000
>> > mmap1       0  INFO  :  page fault occurred at 0x48002000
>> > mmap1       0  INFO  :  page fault occurred at 0x48002000
>> > mmap1       0  INFO  :  page fault occurred at 0x48002000
>> > ......
>> > mmap1       0  INFO  :  page fault occurred at 0x48002000
>> > mmap1       0  INFO  :  page fault occurred at 0x48002000
>> > caught unexpected signal - 11 --- exiting
>> > <<<execution_status>>>
>> > duration=1 termination_type=exited termination_id=255 corefile=no
>> > cutime=0 cstime=4
>> > <<<test_end>>>
>> >
>> > I made a patch to cover all the three race conditions in one case in
>> > sig_handler(),
>> > then run mtest06 repeatedly on different archs, test will not fail by
>> > catching signal 11.
>>
>> Could you print out what the value of info->si_code and info->si_addr
>> are at the time of the fault? Also, which architecture(s) are you
>> running into this issue on?
> Hi Garrett,
>
> Sorry for the late reply; See attached mtest06 logs, I printed out the
> values of si_code, si_addr, map_address;
> it is reproducible on arm, x86, ppc and mips; though it is not
> reproducible every time, but can be reproducible if run the case
> repeatedly.

Nothing is jumping out at me as being incorrect, so I think it's best
that I bring in a better pair of eyes, just in case.

Suzuki-san,
    Could you please help review this patch?
Thanks!
-Garrett
------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
