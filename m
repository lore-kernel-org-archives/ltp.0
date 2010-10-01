Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P1it1-00015l-Qj
	for ltp-list@lists.sourceforge.net; Fri, 01 Oct 2010 16:55:07 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P1it0-0004ox-MI
	for ltp-list@lists.sourceforge.net; Fri, 01 Oct 2010 16:55:07 +0000
Received: by yxg6 with SMTP id 6so1529080yxg.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 01 Oct 2010 09:55:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100927115849.GA22015@dhcp-27-142.brq.redhat.com>
References: <20100924130014.GB7889@dhcp-27-139.brq.redhat.com>
	<20100924132104.GC7889@dhcp-27-139.brq.redhat.com>
	<AANLkTin2=Hcf-FLqJ=1DFmQg1x+T1o84JH-LkAWXQcRK@mail.gmail.com>
	<20100927115849.GA22015@dhcp-27-142.brq.redhat.com>
Date: Fri, 1 Oct 2010 09:55:00 -0700
Message-ID: <AANLkTikBpayTvyVRxvEh5sXN1oHXjhD58aUhr71jFTe0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix incorrect cleanup after hugeshmget05 test
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
To: Jan Tluka <jtluka@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Sep 27, 2010 at 4:58 AM, Jan Tluka <jtluka@redhat.com> wrote:
> Sat, Sep 25, 2010 at 06:56:44AM CEST, yanegomi@gmail.com wrote:
>>On Fri, Sep 24, 2010 at 6:21 AM, Jan Tluka <jtluka@redhat.com> wrote:
>>> Resending ...
>>>
>>> I've noticed that in some cases the hugeshmget05 testcase is not
>>> cleaning up properly after itself. It leaves hugepages reserved and
>>> does not free them. This could break further test runs.
>>>
>>> I think the problem is with signal handling. The testcase will do
>>> rm_shm() only if it ends up properly. In case it's being killed by
>>> SIGTERM signal (as seen from the testlog) the cleanup() function does
>>> not return shared memory.
>>>
>>> Without the patch I have to use ipcrm to remove all hugepages reserved
>>> and not returned.
>>>
>>> # grep -i unexpected RHEL-hugepage.run.log
>>> hugeshmget05 =A0 =A01 =A0TBROK =A0: =A0Unexpected signal 15 received.
>>> # ipcs -m
>>> ------ Shared Memory Segments --------
>>> key =A0 =A0 =A0 =A0shmid =A0 =A0 =A0owner =A0 =A0 =A0perms =A0 =A0 =A0b=
ytes =A0 =A0 =A0nattch =A0 =A0 status
>>> 0x7400ee08 3932160 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
>>> 0x7400edde 4620289 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
>>> 0x00000000 4980738 =A0 =A0gdm =A0 =A0 =A0 600 =A0 =A0 =A0 =A0393216 =A0=
 =A0 2 =A0 =A0 =A0 =A0 =A0dest
>>> 0x7400eddd 4587523 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
>>> 0x78002a3b 64552964 =A0 root =A0 =A0 =A0600 =A0 =A0 =A0 =A0209715200 =
=A00
>>> 0x78002a38 64520197 =A0 root =A0 =A0 =A0600 =A0 =A0 =A0 =A0209715200 =
=A00
>>> # ipcrm -m 64552964 -m 64520197
>>>
>>> With the patch the test returns hugepages back to the system even if it
>>> gets signal 15.
>>>
>>> Checked on RHEL5.5.
>>>
>>> Thanks, Jan
>>>
>>>
>>> The patch follows,
>>>
>>>
>>> --- ltp-full-20100831/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmge=
t05.c =A0 =A02010-09-14 13:04:33.000000000 +0200
>>> +++ ltp-full-20100831.new/testcases/kernel/mem/hugetlb/hugeshmget/huges=
hmget05.c =A0 =A0 =A0 =A02010-09-24 13:47:19.413177300 +0200
>>> @@ -105,7 +105,6 @@
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_child();
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*NOTREACHED*/
>>> =A0 =A0 =A0 =A0} else { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* parent */
>>> @@ -114,11 +113,10 @@
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(TBROK, cleanup,=
 "waitpid failed");
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if it exists, remove the shared memory=
 resource */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm_shm(shm_id_1);
>>> -
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Remove the temporary directory */
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_rmdir();
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
>>> =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>> @@ -209,6 +207,9 @@
>>> =A0void
>>> =A0cleanup(void)
>>> =A0{
>>> + =A0 =A0 =A0 /* if it exists, remove the shared memory resource */
>>> + =A0 =A0 =A0 rm_shm(shm_id_1);
>>> +
>>> =A0 =A0 =A0 =A0/*
>>> =A0 =A0 =A0 =A0 * print timing stats if that option was specified.
>>> =A0 =A0 =A0 =A0 * print errno log if that option was specified.
>>
>>Hi Jan,
>> =A0 =A0I spotted some other potential issues with the test. Please try
>>this patch and let me know whether or not it works for you .
>>Cheers,
>>-Garrett
>
> Hi Garrett, I ran the hugeshmget05 test with your patch applied and
> it works fine. Did 100 loops with no issues observed.
>
> Thanks.

    Sorry it took so long for me to commit this change (been a bit
preoccupied this week). I'll look into all of the other issues
identified within the past couple of weeks starting tomorrow.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
