Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Npy7h-0002bP-Jc
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 06:13:25 +0000
Received: from mail-yx0-f190.google.com ([209.85.210.190])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Npy7g-0002io-La
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 06:13:25 +0000
Received: by yxe28 with SMTP id 28so453529yxe.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 11 Mar 2010 22:13:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100311152430.GA3526@linux.vnet.ibm.com>
References: <364299f41003102111u7b24fd76i25b97c292d026af1@mail.gmail.com>
	<1268312580.2518.12.camel@localhost.localdomain>
	<20100311152430.GA3526@linux.vnet.ibm.com>
Date: Thu, 11 Mar 2010 22:13:18 -0800
Message-ID: <364299f41003112213y39b139abr5142ec8d2f1a2964@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Remove libevent?
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
To: Lucas Meneghel Rodrigues <lmr@redhat.com>, Garrett Cooper <yanegomi@gmail.com>, LTP list <ltp-list@lists.sourceforge.net>

On Thu, Mar 11, 2010 at 7:24 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Thu, Mar 11, 2010 at 10:03:00AM -0300, Lucas Meneghel Rodrigues wrote:
>> On Wed, 2010-03-10 at 21:11 -0800, Garrett Cooper wrote:
>> > Hi all,
>> > =A0 =A0 I just looked at the latest libevent, and I'm typically not on=
e to
>> > suggest this, but because libevent switched over to libtool in the 2.x
>> > release (which is a pain in the ass to integrate), I think we just
>> > drop the libevent testcase(s). I assume the maintainers run their
>> > testcases on a subset of Unix machines, so it would just be an
>> > annoying earmark that LTP has to maintain a dead // useless version of
>> > libevent (eventually our version will go out of date and the code that
>> > we have will bear little relevance and may be more buggy than the
>> > latest version which should have appropriate tests and be executed and
>> > triaged appropriately upstream).
>>
>> +1. Of course I am not in a position of saying something about what it
>> should be done, but I totally agree that LTP should strive in keeping
>> only well maintainted tests. It's harmful to keep unmantained code, it
>> bitrots and tends to make everyone's life difficult.

bitrot is fine if something is functionally complete; it's of course
not if it's incomplete or buggy.

> Well said Lucas & garret. We need to really look for some outdated testca=
se
> currently existing with LTP. I can look into it incrementally, but like g=
arret
> if someone come to know about outdated testcase with LTP or some tetssuit=
 which
> need renewal, please let us know. We will work to renew them on high prio=
rity.
>
> Some of the testsuits i am looking are:
> =A0 =A0- cpu hot plug
> =A0 =A0- memory hotplug

Removing testcases just because they're old isn't a good idea. We need
to keep testcases that are still valid on older distros.

I suggested removing libevent's code because they package their own
set of testcases which are more appropriate to the code under test.

Some other things that probably should be removed (and potentially
augmented in the upstream projects are):

Under testcases/:
- ballista - I own developing the code now that I have more spare time
(to some degree) and I was going to rewrite it from scratch because
the current code is a mess, uses a lot of non-standard tools (c++
code, csh, perl, some bourne shell), isn't well designed, not BSD
licensed, and the previous maintainers no longer maintain the code.
- commands - there are much more extensive testcases and test suites
with the implemented command suites themselves; so, why does LTP need
its own set of tests which will have to fudge for each implementation
when folks should be investing time in making sure that the issues in
each of these test suites do conform to the specs (and potentially are
POSIX compliant)?
- libaio testscases (testcases out-of-sync with functionality)
- open_hpi_testcases - why duplicate a stale copy of the test suite in
the LTP repository, that doesn't necessarily match the copy of
open_hpi on the box?? What if I don't need to test open_hpi? (majority
of the folks on here who do embedded or simple validation work, don't
have to.
- pounder* - don't use it; it doesn't get compiled, etc

Under tools/:
top-LTP - doesn't compile; period -- hasn't been updated in years. Not
even sure what in the heck it does.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
