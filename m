Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OqhjK-0005Nb-Mw
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 07:27:34 +0000
Received: from mail-bw0-f46.google.com ([209.85.214.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OqhjJ-0001kP-Ro
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 07:27:34 +0000
MIME-Version: 1.0
In-Reply-To: <AANLkTin=MTu4QGB-+zyYQh=qMLprgjx6txisF4r_5xPT@mail.gmail.com>
References: <1282116783.4855.8.camel@PEK-RLIANG-D1>
	<AANLkTikrFeTSbiWY4EhotU7siB_vw8hVF_FWtSNREr8x@mail.gmail.com>
	<1283219506.1778.2.camel@PEK-RLIANG-D1>
	<AANLkTin=MTu4QGB-+zyYQh=qMLprgjx6txisF4r_5xPT@mail.gmail.com>
Date: Wed, 1 Sep 2010 00:27:27 -0700
Message-ID: <AANLkTikH16Evfuj0RXkYLUYy6msPf2DcwD+zXzhhFV_+@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Patch] Fix mtest06 failure: caught unexpected signal -
 11 --- exiting
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: renxiu liang <renxiu.liang@windriver.com>
Cc: ltp-list@lists.sf.net, Suzuki Poulose <suzuki@in.ibm.com>

On Wed, Sep 1, 2010 at 12:26 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Mon, Aug 30, 2010 at 6:51 PM, renxiu liang
> <renxiu.liang@windriver.com> wrote:
>> On Wed, 2010-08-25 at 20:36 -0700, Garrett Cooper wrote:
>>> On Wed, Aug 18, 2010 at 12:33 AM, renxiu liang
>>> <renxiu.liang@windriver.com> wrote:
>>> > Hi,
>>> >
>>> > We met the mtest06 failure several times; this is because in
>>> > mtest06/mmap1.c, when handling the signal 11 in sig_handler, it doesn=
't
>>> > cover another two race conditions:
>>> > one is si_code equals "SEGV_MAPERR" but si_address does not equal to
>>> > map_address; and one is si_code equals to "SEGV_ACCERR";
>>> >
>>> > see below error log:
>>> >
>>> > <<<test_start>>>
>>> > tag=3Dmtest06 stime=3D1270902396
>>> > cmdline=3D" =A0mmap1 -x 0.05"
>>> > contacts=3D""
>>> > analysis=3Dexit
>>> > initiation_status=3D"ok"
>>> > <<<test_output>>>
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0pid[5456]: map, change contents, =
unmap files
>>> > 1000 times
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0created thread[1216369840]
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0pid[5456] - read contents of memo=
ry 0x48002000
>>> > 1000 times
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>>> > ......
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>>> > caught unexpected signal - 11 --- exiting
>>> > <<<execution_status>>>
>>> > duration=3D1 termination_type=3Dexited termination_id=3D255 corefile=
=3Dno
>>> > cutime=3D0 cstime=3D4
>>> > <<<test_end>>>
>>> >
>>> > I made a patch to cover all the three race conditions in one case in
>>> > sig_handler(),
>>> > then run mtest06 repeatedly on different archs, test will not fail by
>>> > catching signal 11.
>>>
>>> Could you print out what the value of info->si_code and info->si_addr
>>> are at the time of the fault? Also, which architecture(s) are you
>>> running into this issue on?
>> Hi Garrett,
>>
>> Sorry for the late reply; See attached mtest06 logs, I printed out the
>> values of si_code, si_addr, map_address;
>> it is reproducible on arm, x86, ppc and mips; though it is not
>> reproducible every time, but can be reproducible if run the case
>> repeatedly.
>
> Nothing is jumping out at me as being incorrect, so I think it's best
> that I bring in a better pair of eyes, just in case.
>
> Suzuki-san,
> =A0 =A0Could you please help review this patch?

CCing Suzuki-san...
-Garrett

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
