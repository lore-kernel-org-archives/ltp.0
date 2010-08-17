Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlUcF-0000yJ-8n
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 22:26:43 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlUcE-0007kv-9m
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 22:26:43 +0000
Received: by fxm6 with SMTP id 6so4835080fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 15:26:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C6B0243.1070306@redhat.com>
References: <4C6AD62B.2010905@redhat.com>
	<AANLkTinp94tZRbNveZO3VzEQ_gOR1jFQadqVnvRR95ak@mail.gmail.com>
	<4C6B0243.1070306@redhat.com>
Date: Tue, 17 Aug 2010 18:26:36 -0400
Message-ID: <AANLkTi=S7Y_GW6uZeBgbfUrxFQ5oCRiXAOkWxahmgjCC@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] problems building lchown02.c for uClinux
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
To: dmarlin@redhat.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 5:42 PM, David Marlin wrote:
> Mike Frysinger wrote:
>> On Tue, Aug 17, 2010 at 2:34 PM, David Marlin wrote:
>>> 'lchown02.c' does not build properly due to calls to mmap and
>>> get_high_address (which references sbrk) when UCLINUX=3D1 is defined.
>>
>> you'll need to clarify. =A0it builds fine for me, it just may not run
>> correctly due to the assumptions of memory placement.
>
> Thank you for the feedback. =A0I'm new to uClinux, so I'm only going on w=
hat
> I've read, but my understanding is that 'sbrk' is not supported in uClinu=
x.

it depends on how you use it.  sbrk(0) should always work since you're
only querying the current size.  sbrk(1+) might work depending on the
current memory layout, but it isnt reliable, so it's recommended
people dont use it when possible on nommu.  technically speaking, it
can even fail under mmu systems, it's just highly unlikely with newly
started processes.

the lib/get_high_address.c usage is valid since it does sbrk(0), but
overall the function is useless since it is assuming that a few pages
after the end of the sbrk() region is unallocated memory.  on nommu
systems, it could easily be valid (either the same process or a
different one or the kernel).

so on nommu/linux, this function should be avoided due to its design
flaws, not because any of the unctions it calls do not work.

> =A0My information may be a bit dated, so a newer (better) reference would=
 be
> welcome.

you will often find nommu stuff undocumented.  my experience is that
the people who know arent interested in writing documentation (why
should they when they already know the answer !?), and there arent
that many people who know :P.  i dont mind writing documentation
though (due to my personal experience of constantly hitting this
problem and making my stomach churn), so feel free to ask questions.

> Much of the syscalls test code that is "#ifdef'd" out for UCLINUX=3D1 inv=
olves
> skipping references (directly or indirectly) to sbrk. get_high_address is
> one of those references, where it directly calls sbrk:
>
> =A0char *get_high_address(void)
> =A0{
> =A0 =A0 =A0 return (char *)sbrk(0) + (4 * getpagesize());
> =A0}
>
> Most of the testcases skip the call to get_high_address when UCLINUX=3D1,=
 so I
> was just following their example.

i like to look forward and start down a better path rather than
continue to hedge overgrown crap ;)
-mike

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
