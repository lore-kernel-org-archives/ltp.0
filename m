Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M9DPW-0004rI-HN
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 07:18:50 +0000
Received: from mail-ew0-f168.google.com ([209.85.219.168])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M9DPR-00072r-Nc
	for ltp-list@lists.sourceforge.net; Wed, 27 May 2009 07:18:50 +0000
MIME-Version: 1.0
In-Reply-To: <1243340568.6293.22.camel@subratamodak.linux.ibm.com>
References: <d51f89b0905130216h36e32efbwf48f241f2d961a0a@mail.gmail.com>
	<20090513.225510.104053150.caiqian@cclom.cn>
	<d51f89b0905180455w514b014boedb4670610987533@mail.gmail.com>
	<20090518.192133.233689723.caiqian@cclom.cn>
	<1242729086.5961.43.camel@subratamodak.linux.ibm.com>
	<d51f89b0905252140y39ed0666k7c8ec1ce95807e55@mail.gmail.com>
	<1243340568.6293.22.camel@subratamodak.linux.ibm.com>
Date: Wed, 27 May 2009 00:18:44 -0700
Message-ID: <d51f89b0905270018u1b447334qf38528f8dc0ed7aa@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] Reg: Script to extract description of test case from
	LTPROOT/doc/testcases/*.txt files
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: Mike Frysinger <vapier@gentoo.org>, ltp-list <ltp-list@lists.sf.net>

Hi Subrata,

As the purpose of this document is to brief the description of each
test case to user. I feel that your format would decrease the
readability in document .

So should we include following tags   "test_location",
"test_cmdfile_name", "test_cmdfile_entry",
"Execute_through_commandline", "Execute_through_runltp". or only
description tag would be sufficient.

Regards,
rohit


On Tue, May 26, 2009 at 5:22 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Mon, 2009-05-25 at 21:40 -0700, rohit verma wrote:
>> Hi Subrata,
>>
>> I request you to finalize the format of the documentation ASAP.
>
> I would like to see something like:
>
> <testname=3Dabort(3)>
> =A0<test_description=3D"Basic test for abort(3)">
> =A0<\test_description>
> =A0<test_location=3D"ltp/testcases/kernel/syscalls/abort/abort01.c">
> =A0<\test_location>
> =A0<test_cmdfile_name=3D"ltp/runtest/syscalls">
> =A0<\test_cmdfile_name>
> =A0<test_cmdfile_entry=3D"abort01 ulimit -c 1024;abort01">
> =A0<\test_cmdfile_entry>
> =A0<Execute_through_commandline=3D"ulimit -c
> 1024; ./ltp/testcases/bin/abort01">
> =A0<\Execute_through_commandline>
> =A0<Execute_through_runltp=3D"./runltp -s abort01">
> =A0<\Execute_through_runltp>
> <\testname>
>
> The basic idea is to include all important information as we can when we
> are doing some patching on this. Let me know how others feel, and how we
> can achieve this.
>
> Regards--
> Subrata
>
>>
>> Ltp-list : Please provide the inputs regarding the text documentation fo=
rmat.
>>
>> Regards,
>> rohit
>>
>> On Tue, May 19, 2009 at 3:31 AM, Subrata Modak
>> <subrata@linux.vnet.ibm.com> wrote:
>> > Hi Rohit,
>> >
>> > On Mon, 2009-05-18 at 19:21 +0800, CAI Qian wrote:
>> >> From: rohit verma <rohit.170309@gmail.com>
>> >> Subject: Re: Reg: Script to extract description of test case from LTP=
ROOT/doc/testcases/*.txt files
>> >> Date: Mon, 18 May 2009 04:55:54 -0700
>> >>
>> >> > Dear Subrata/Qian,
>> >> >
>> >> > I am trying to develop script which would extracts description info=
rmation
>> >> > about user required test case from LTPROOT/doc/testcases/ folder.
>> >> >
>> >> > So to make the description text file =A0as standard file, can we re=
present the
>> >> > description as mentioned below.
>> >> >
>> >> > For example in syscalls category:
>> >> >
>> >> > Currently available format of description in LTP as follows.
>> >> >
>> >> > =A0 abort01
>> >> > =A0 =A0Basic test for abort(3).
>> >> >
>> >> > =A0 accept01
>> >> > =A0 =A0Verify that accept() returns the proper errno for various fa=
ilure cases
>> >> >
>> >> >
>> >> > To make it in consistent way, description should be enclosed by exe=
cutables
>> >> > as follows.
>> >> >
>> >> > =A0<abort01>
>> >> > =A0 =A0Basic test for abort(3).
>> >> > =A0<\abort01>
>> >> >
>> >> > =A0<accept01>
>> >> > =A0 =A0Verify that accept() returns the proper errno for various fa=
ilure cases
>> >> > =A0<\accept01>
>> >> >
>> >> > Please confirm if this format is O.K or suggest any other format by=
 which we
>> >> > can easily parse the test cases and extracts the description.
>> >
>> > It=B6 always great to see somebody working on LTP documentation. So, l=
ets
>> > ask the community also for their opinion as well. Can we also include
>> > some more tags for more descriptive info ?
>> >
>> > Regards--
>> > Subrata
>> >
>> >> >
>> >>
>> >> Looks good for me.
>> >>
>> >> CAI Qian
>> >>
>> >> > If this format is O.K , I would send the patch for those text files
>> >> >
>> >> > Regards,
>> >> > Rohit
>> >> >
>> >> >
>> >> >
>> >> > On Wed, May 13, 2009 at 7:55 AM, CAI Qian <caiqian@cclom.cn> wrote:
>> >> >
>> >> >> From: rohit verma <rohit.170309@gmail.com>
>> >> >> Subject: Reg: Script to extract description of test case from
>> >> >> LTPROOT/doc/testcases/*.txt files
>> >> >> Date: Wed, 13 May 2009 02:16:57 -0700
>> >> >>
>> >> >> > Dear Subrata/qian,
>> >> >> >
>> >> >> > As if we run LTP testcases, nowhere LTP test suite populates the
>> >> >> > description of testcases (either in .log, .output, .HTML or .fai=
led
>> >> >> > test cases files).
>> >> >> >
>> >> >> > Description of each test case in category wise is available in
>> >> >> > LTPROOT/doc/testcases folder.
>> >> >> >
>> >> >> > My Question : Is there any ready-made script available to extrac=
t the
>> >> >> > description of user required test case from above specified fold=
er?
>> >> >> >
>> >> >> > If script is not available, could you suggest the direction to e=
xtract
>> >> >> > description of test cases.
>> >> >> >
>> >> >> >
>> >> >> > Regards,
>> >> >> > Rohit.
>> >> >>
>> >> >> Not I am aware of. Subrata or someone in the list might have some =
ideas
>> >> >> for you.
>> >> >>
>> >> >> CAI Qian
>> >> >>
>> >
>> >
>
>

---------------------------------------------------------------------------=
---
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT =

is a gathering of tech-side developers & brand creativity professionals. Me=
et
the minds behind Google Creative Lab, Visual Complexity, Processing, & =

iPhoneDevCamp as they present alongside digital heavyweights like Barbarian =

Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
