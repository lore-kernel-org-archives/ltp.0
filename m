Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nmkeq-000323-03
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:14:20 +0000
Received: from mail-pz0-f203.google.com ([209.85.222.203])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nmkep-00030H-09
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:14:19 +0000
Received: by pzk41 with SMTP id 41so807490pzk.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 01:14:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100303055619.GA19084@linux.vnet.ibm.com>
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
	<20100302152135.GA6691@us.ibm.com>
	<B02F7096-7406-4AAE-8BBF-AD16D5228F47@gmail.com>
	<20100302173535.GA14556@us.ibm.com>
	<5EEDD2C4-6C6C-4008-81AA-65B78FA3E7C8@gmail.com>
	<20100303055619.GA19084@linux.vnet.ibm.com>
Date: Wed, 3 Mar 2010 01:14:12 -0800
Message-ID: <364299f41003030114x30e251d6x7cd7993f8f75792f@mail.gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>, "Serge E. Hallyn" <serue@us.ibm.com>, Rishikesh K Rajak <risrajak@in.ibm.com>, Iranna D Ankad <iranna.ankad@in.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Tue, Mar 2, 2010 at 9:56 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Tue, Mar 02, 2010 at 10:25:23AM -0800, Garrett Cooper wrote:
>> On Mar 2, 2010, at 9:35 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
>>
>> > Quoting Garrett Cooper (yanegomi@gmail.com):
>> >>
>> >> That would be from me; I do that via autoconf and they probably
>> >> fubared the headers on Redhat or something... Do you have
>> >
>> > Oh, ok. =A0Well I suspect we can ditch the check_simple_capset.c
>> > altogether if autoconf is (eventually :) doing the detection for
>> > us. =A0The only point of check_simple_capset.c was to check whether
>> > libcap is there and whether we should run the real tests.
>> >
>> >> libcap-devel installed?
>> >
>> > yup:
>> >
>> > [root@oracer4b ltp-dev]# rpm -qa|grep libcap
>> > libcap-2.10-2.fc10.x86_64
>> > libcap-devel-2.10-2.fc10.x86_64
>> >
>> > [root@oracer4b ltp-dev]# grep CAP_LIB *
>> > config.log:CAP_LIBS=3D''
>> > config.status:S["CAP_LIBS"]=3D""
>> > configure:CAP_LIBS'
>> > configure: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CAP_LIBS=3D"-lcap"
>> >
>> > so somehow -lcap was not detected by configure?
>>
>> Well some of the definitions are there but maybe not all of them.
>> config.log would help...
>>
>
> Here is the config.log snapshot, it seems it has some error:
>
> ...
> configure:5543: checking whether CAP_BSET_DROP is declared
> configure:5574: gcc -c -g -O2 =A0conftest.c >&5
> conftest.c: In function 'main':
> conftest.c:38: error: 'CAP_BSET_DROP' undeclared (first use in this
> function)
> conftest.c:38: error: (Each undeclared identifier is reported only once
> conftest.c:38: error: for each function it appears in.)

    Yes -- and I think this is because the constants no longer have
the same name:

http://fxr.watson.org/fxr/source/include/linux/prctl.h?v=3Dlinux-2.6#L68

    Note -- CAP_BSET_DROP should be: PR_CAPBSET_DROP, etc.

    Which is why I stress _not_ putting these hardcoded constants in
test files (POLLHDRDUP -- or whatever it was in ppoll01 -- is the only
real violation I can remember OTOH that I need to clean up
eventually). We need to be consistent with any and all documentation
provided to end-developers or we [LTP] are going to shoot ourselves in
the foot if and when the underlying functionality changes.
    I'll update the tests this weekend, but I would like it if someone
test the tests on an outdated distro (RHEL 4.x?) once I provide a
patch to ensure that nothing's being regressed. Based on some really
simple inspection it appears that these tests are compatible only with
libcapability 2.x+, but I could be wrong...
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
