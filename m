Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OAJle-0005Jk-Sr
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 09:22:46 +0000
Received: from mail-iw0-f200.google.com ([209.85.223.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OAJle-0004oy-5z
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 09:22:46 +0000
Received: by iwn38 with SMTP id 38so1064042iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 07 May 2010 02:22:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100506183947.GA14900@us.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065657.23879.72093.sendpatchset@subratamodak.linux.ibm.com>
	<0B5AF9FC-8DAA-4995-9166-8EB0FE42F98C@gmail.com>
	<20100506135312.GA12072@us.ibm.com>
	<j2v364299f41005061038ucdbdaf19hcdad19491344e76d@mail.gmail.com>
	<20100506175512.GA25514@us.ibm.com>
	<k2v364299f41005061059rf51273ffk7c8c9755b92427e5@mail.gmail.com>
	<20100506183947.GA14900@us.ibm.com>
Date: Fri, 7 May 2010 02:22:40 -0700
Message-ID: <p2r364299f41005070222t99dbd658l43ba2468382b790e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [04/12 FAILURE] LTP? sysctl03 test fails
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
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, Michael Kerrisk <mtk.manpages@gmail.com>

On Thu, May 6, 2010 at 11:39 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
>> On Thu, May 6, 2010 at 10:55 AM, Serge E. Hallyn <serue@us.ibm.com> wrot=
e:
>> > Quoting Garrett Cooper (yanegomi@gmail.com):
>> > So since we're all member of the doc team, send a patch for sysctl(2)
>> > manpage ERRORS section :)
>> >
>> > (mtk cc:d as this is probably news to him)
>>
>> I already have a bug outstanding for it:
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D15446
>
> That's not what I said :)

    Yeah, I understand. If you guys agree with the content, I will
submit a patch. Otherwise, the item will unfortunately remain dead in
the water :(.

>> >> > An LSM could choose to return -EPERM
>> >> > after all, or perhaps even something different. =A0The thing that
>> >> > should scare us is if the call succeeds. =A0If we give any false
>> >> > positives, then true positives will seem less scary.
>> >>
>> >> This will fail on older kernels as sysctl(2) always returned EPERM due
>> >
>> > Sorry - what will fail?
>>
>> Read through the link, and you will understand why your new proposed
>> patch with fail with a false negative.
>
> I'm not sure that thread means what you think it does.

   Yes, I think it does mean what I think it does. 2.6.32 was
`corrected' to do a lot more things, one of which was to return EPERM
in certain cases where it completely bypassed that return code before.
That's why you're seeing the error now whereas before it was
completely bypassed :/.

> But look, just trying to help. =A0And no time for it really. =A0I'll drop
> this.

    I appreciate your help as do a lot of other folks. I'm just trying
to (in my own pedantic way) be as unflexible as possible because the
requirements for each function call as per the documentation should be
crystal clear, as should the testcases. If not, then the developers
that develop against those requirements won't know what to expect and
bugs will only be introduced by accident into software. I don't want
that to happen and that's why I am the way I am.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
