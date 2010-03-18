Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NsLA3-0004mK-DN
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 19:13:39 +0000
Received: from mail-pz0-f197.google.com ([209.85.222.197])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NsLA2-0003KO-3v
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 19:13:39 +0000
Received: by pzk35 with SMTP id 35so1877783pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Mar 2010 12:13:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100318145505.GC6287@us.ibm.com>
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
	<20100302152135.GA6691@us.ibm.com>
	<B02F7096-7406-4AAE-8BBF-AD16D5228F47@gmail.com>
	<20100302173535.GA14556@us.ibm.com>
	<5EEDD2C4-6C6C-4008-81AA-65B78FA3E7C8@gmail.com>
	<20100303055619.GA19084@linux.vnet.ibm.com>
	<364299f41003030114x30e251d6x7cd7993f8f75792f@mail.gmail.com>
	<20100318092516.GA16328@linux.vnet.ibm.com>
	<20100318145505.GC6287@us.ibm.com>
Date: Thu, 18 Mar 2010 12:13:31 -0700
Message-ID: <364299f41003181213i7b5bffe3pc1c8ab43fc234ef3@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP's filecaps test gives false positive results
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, Iranna D Ankad <iranna.ankad@in.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Thu, Mar 18, 2010 at 7:55 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Rishikesh K Rajak (risrajak@linux.vnet.ibm.com):
>> On Wed, Mar 03, 2010 at 01:14:12AM -0800, Garrett Cooper wrote:
>> > =A0 =A0 Yes -- and I think this is because the constants no longer have
>> > the same name:
>> >
>> > http://fxr.watson.org/fxr/source/include/linux/prctl.h?v=3Dlinux-2.6#L=
68
>> >
>> > =A0 =A0 Note -- CAP_BSET_DROP should be: PR_CAPBSET_DROP, etc.
>> >
>> > =A0 =A0 Which is why I stress _not_ putting these hardcoded constants =
in
>> > test files (POLLHDRDUP -- or whatever it was in ppoll01 -- is the only
>> > real violation I can remember OTOH that I need to clean up
>> > eventually). We need to be consistent with any and all documentation
>> > provided to end-developers or we [LTP] are going to shoot ourselves in
>> > the foot if and when the underlying functionality changes.
>> > =A0 =A0 I'll update the tests this weekend, but I would like it if som=
eone
>> > test the tests on an outdated distro (RHEL 4.x?) once I provide a
>>
>> Hi Garret,
>>
>> Can you please look this again ?
>
> Wait, what? =A0Was the original complaint just about a #warning? =A0Note
> that it will #warn but then go ahead and define it, so there should not
> be a real problem.
>
> Anyway I'll try to get time tomorrow to rewrite this to use the constants
> from the new securebits.h (which may not be in sys/ yet, but is in linux/
> atm and will show up under sys/ at some point). =A0If Garret could help me
> with doing an automate thingamagiggy to detect whether prctl(CAP_BSET_DRO=
P)
> returns -ENOSYS and not compile/install/run the tests in that case, that'd
> be great.
>
> And maybe I'll finally implement some of the new securebits testcases I
> spelled out a year or two ago.

Hi Serge,
    AC_RUN_IFELSE is what you want :
http://www.gnu.org/software/autoconf/manual/autoconf.html#Runtime --
make sure to write a cross-compile statement with a sensible default
(enabled?).
    I'll help you write up a test once you have something to compile :).
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
