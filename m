Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1M8oSv-0003Mu-Ar
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 04:40:41 +0000
Received: from ey-out-2122.google.com ([74.125.78.27])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M8oSu-0007ez-4E
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 04:40:41 +0000
MIME-Version: 1.0
In-Reply-To: <1242729086.5961.43.camel@subratamodak.linux.ibm.com>
References: <d51f89b0905130216h36e32efbwf48f241f2d961a0a@mail.gmail.com>
	<20090513.225510.104053150.caiqian@cclom.cn>
	<d51f89b0905180455w514b014boedb4670610987533@mail.gmail.com>
	<20090518.192133.233689723.caiqian@cclom.cn>
	<1242729086.5961.43.camel@subratamodak.linux.ibm.com>
Date: Mon, 25 May 2009 21:40:38 -0700
Message-ID: <d51f89b0905252140y39ed0666k7c8ec1ce95807e55@mail.gmail.com>
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

I request you to finalize the format of the documentation ASAP.

Ltp-list : Please provide the inputs regarding the text documentation forma=
t.

Regards,
rohit

On Tue, May 19, 2009 at 3:31 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Hi Rohit,
>
> On Mon, 2009-05-18 at 19:21 +0800, CAI Qian wrote:
>> From: rohit verma <rohit.170309@gmail.com>
>> Subject: Re: Reg: Script to extract description of test case from LTPROO=
T/doc/testcases/*.txt files
>> Date: Mon, 18 May 2009 04:55:54 -0700
>>
>> > Dear Subrata/Qian,
>> >
>> > I am trying to develop script which would extracts description informa=
tion
>> > about user required test case from LTPROOT/doc/testcases/ folder.
>> >
>> > So to make the description text file =A0as standard file, can we repre=
sent the
>> > description as mentioned below.
>> >
>> > For example in syscalls category:
>> >
>> > Currently available format of description in LTP as follows.
>> >
>> > =A0 abort01
>> > =A0 =A0Basic test for abort(3).
>> >
>> > =A0 accept01
>> > =A0 =A0Verify that accept() returns the proper errno for various failu=
re cases
>> >
>> >
>> > To make it in consistent way, description should be enclosed by execut=
ables
>> > as follows.
>> >
>> > =A0<abort01>
>> > =A0 =A0Basic test for abort(3).
>> > =A0<\abort01>
>> >
>> > =A0<accept01>
>> > =A0 =A0Verify that accept() returns the proper errno for various failu=
re cases
>> > =A0<\accept01>
>> >
>> > Please confirm if this format is O.K or suggest any other format by wh=
ich we
>> > can easily parse the test cases and extracts the description.
>
> It=B6 always great to see somebody working on LTP documentation. So, lets
> ask the community also for their opinion as well. Can we also include
> some more tags for more descriptive info ?
>
> Regards--
> Subrata
>
>> >
>>
>> Looks good for me.
>>
>> CAI Qian
>>
>> > If this format is O.K , I would send the patch for those text files
>> >
>> > Regards,
>> > Rohit
>> >
>> >
>> >
>> > On Wed, May 13, 2009 at 7:55 AM, CAI Qian <caiqian@cclom.cn> wrote:
>> >
>> >> From: rohit verma <rohit.170309@gmail.com>
>> >> Subject: Reg: Script to extract description of test case from
>> >> LTPROOT/doc/testcases/*.txt files
>> >> Date: Wed, 13 May 2009 02:16:57 -0700
>> >>
>> >> > Dear Subrata/qian,
>> >> >
>> >> > As if we run LTP testcases, nowhere LTP test suite populates the
>> >> > description of testcases (either in .log, .output, .HTML or .failed
>> >> > test cases files).
>> >> >
>> >> > Description of each test case in category wise is available in
>> >> > LTPROOT/doc/testcases folder.
>> >> >
>> >> > My Question : Is there any ready-made script available to extract t=
he
>> >> > description of user required test case from above specified folder?
>> >> >
>> >> > If script is not available, could you suggest the direction to extr=
act
>> >> > description of test cases.
>> >> >
>> >> >
>> >> > Regards,
>> >> > Rohit.
>> >>
>> >> Not I am aware of. Subrata or someone in the list might have some ide=
as
>> >> for you.
>> >>
>> >> CAI Qian
>> >>
>
>

---------------------------------------------------------------------------=
---
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Me=
et
the minds behind Google Creative Lab, Visual Complexity, Processing, & =

iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
