Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ng17U-0004bX-No
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 19:24:04 +0000
Received: from mail-pz0-f179.google.com ([209.85.222.179])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ng17S-0002o6-UK
	for ltp-list@lists.sourceforge.net; Fri, 12 Feb 2010 19:24:04 +0000
Received: by pzk9 with SMTP id 9so761816pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Feb 2010 11:23:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002121117i4fcc7b5bua47579a6ee2d661a@mail.gmail.com>
References: <000001caabb7$fe895b60$fb9c1220$@co.jp>
	<20100212175125.GC15333@us.ibm.com>
	<364299f41002121117i4fcc7b5bua47579a6ee2d661a@mail.gmail.com>
Date: Fri, 12 Feb 2010 11:23:56 -0800
Message-ID: <364299f41002121123t25450771i262fd5a2250ed20a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "pidns17" problem in "2010-02-11" cvs
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
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Fri, Feb 12, 2010 at 11:17 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Feb 12, 2010 at 9:51 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
>> Quoting Mitani (mitani@ryobi.co.jp):
>>> Hi,
>>>
>>> I tried to test with "2010-02-11" cvs in RHEL5.4 system.
>>> But the test brings termination of connection.
>>>
>>> I examined the phenomenon and discovered that "pidns17" test made
>>> accident and sshd stopped after the test.
>>>
>>>
>>> I had some problems.
>>>
>>> 1. I think that "tst_exit()" must be added last of "cleanup()"
>>> =A0 =A0function.
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- ./testcases/kernel/containers/pidns/pidns17.c =A0 =A0 =A0 2009-12-07
>>> 05:55:16.000000000 +0900
>>> +++ ./testcases/kernel/containers/pidns/pidns17.c.new =A0 2010-02-12
>>> 16:26:31.000000000 +0900
>>> @@ -104,7 +104,6 @@
>>>
>>> =A0 =A0 =A0 =A0 /* cleanup and exit */
>>> =A0 =A0 =A0 =A0 CLEANUP();
>>> - =A0 =A0 =A0 tst_exit();
>>> =A0}
>>>
>>> =A0/*******************************************************************=
****
>>> @@ -136,7 +135,6 @@
>>>
>>> =A0 =A0 =A0 =A0 /* cleanup and exit */
>>> =A0 =A0 =A0 =A0 CLEANUP();
>>> - =A0 =A0 =A0 tst_exit();
>>> =A0} =A0 =A0 =A0/* End main */
>>>
>>> =A0/*
>>> @@ -147,4 +145,5 @@
>>> =A0{
>>> =A0 =A0 =A0 =A0 /* Clean the test testcase as LTP wants*/
>>> =A0 =A0 =A0 =A0 TEST_CLEANUP;
>>> + =A0 =A0 =A0 tst_exit();
>>> =A0}
>>
>> Yeah I'm afraid I don't understand what CLEANUP and tst_exit exactly
>> do. =A0Hopefully Garrett can give an educated answer.
>
> Mitani's correct -- this is what should be done... CLEANUP is a
> constant that maps to cleanup in the event that tst_brkm is called,
> because linux_syscall_numbers.h's copy of syscall calls tst_brkm
> internally if ENOSYS is returned...
>
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> After revision, connection termination didn't occur.
>>>
>>>
>>> 2. I cannot understand the purpose that "kill()" function whose
>>> =A0 =A0first parameter is "-1" is called.
>>> ------------
>>> =A0 =A0 =A0 =A0 if (kill(-1, SIGUSR1) =3D=3D -1) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK | TERRNO, "cinit: kill(-=
1, SIGUSR1) failed");
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CLEANUP();
>>> =A0 =A0 =A0 =A0 }
>>> ------------
>>>
>>> If kill()'s first option is "-1", "man kill" says that
>>> "All processes with pid larger than 1 will be signaled."
>>
>> Right, the test is checking whether kill -1 inside a private pidns
>> kills all processes besides init in the pid namespace.
>
> Yeah, that's just not smart...
>
>>> Therefore, not only the "sshd" but also the other processes were
>>> affected, I think.
>>
>> sshd is not in the private pid namespace and should not be killed.
>> If it is being killed by the pid -1 inside the container, then there
>> is a kernel bug.
>
> No, it isn't. If the test is being run as root it'll force a reboot on th=
e box:
>
> =A0 =A0 If pid is -1:
> =A0 =A0 =A0 =A0 =A0 =A0 If the user has super-user privileges, the signal=
 is sent to all
> =A0 =A0 =A0 =A0 =A0 =A0 processes excluding system processes (with P_SYST=
EM flag set),
> =A0 =A0 =A0 =A0 =A0 =A0 process with ID 1 (usually init(8)), and the proc=
ess sending the
> =A0 =A0 =A0 =A0 =A0 =A0 signal. =A0If the user is not the super user, the=
 signal is sent to
> =A0 =A0 =A0 =A0 =A0 =A0 all processes with the same uid as the user exclu=
ding the process
> =A0 =A0 =A0 =A0 =A0 =A0 sending the signal. =A0No error is returned if an=
y process could be
> =A0 =A0 =A0 =A0 =A0 =A0 signaled.

Oh wait.. containers isolate PIDs and resources, correct (a weak form
of BSD jails or Solaris zones)? If so, then I'd watch the console //
/var/log/messages, etc and see whether or not things stay alive after
the signal is tossed...

>>> I'm glad if I could get some opinions.
>
> =A0 =A0I'll look at fixing this testcase once the cvs tree has been fully
> converted to git by Rishikesh, as the points you've made are important
> and valid...

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
