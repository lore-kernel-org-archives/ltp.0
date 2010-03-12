Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nq7nH-0005Bi-Kw
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 16:32:59 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nq7nG-0004pd-Rn
	for ltp-list@lists.sourceforge.net; Fri, 12 Mar 2010 16:32:59 +0000
Received: by iwn6 with SMTP id 6so912183iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Mar 2010 08:32:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B9A01B8.6040008@in.ibm.com>
References: <4B97AA99.7050406@in.ibm.com>
	<364299f41003102015j42667189x9adbc23f48121e87@mail.gmail.com>
	<4B99CC90.90204@in.ibm.com>
	<364299f41003112333v3c9e5e7wb6160c2c59395b68@mail.gmail.com>
	<4B9A01B8.6040008@in.ibm.com>
Date: Fri, 12 Mar 2010 08:32:53 -0800
Message-ID: <364299f41003120832g4efc1136sf430dd0bd8f831cd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP Containers netns test failure.
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
To: Sachin Sant <sachinp@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Mar 12, 2010 at 12:56 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Garrett Cooper wrote:
>>>
>>> Hmm .. i am still not able to execute the test even after exporting the
>>> PATH.
>>>
>>> lp5:/opt/ltp # export LTPROOT=3D/opt/ltp
>>> lp5:/opt/ltp # export PATH=3D$PATH:$LTPROOT/testcases/bin
>>> lp5:/opt/ltp # ./runltp -f containers
>>> ........<SNIP>..........
>>> <<<test_start>>>
>>> tag=3DContainers stime=3D1268369850
>>> cmdline=3D"container_test.sh"
>>> contacts=3D""
>>> analysis=3Dexit
>>> <<<test_output>>>
>>> incrementing stop
>>> Running netns tests.
>>> --: childns.sh '/opt/ltp': No such file or directory
>>>
>>> I feel the problem is: the code is searching childns.sh in LTPROOT
>>> directory instead of LTPROOT/testcases/bin
>>>
>>
>> =A0 =A0Please test your claim by calling env in the script -- what happe=
ns?
>> =A0 =A0Something doesn't necessarily add up with the claim.
>>
>
> You meant calling env from childns.sh or some other script ?
>
> I printed env o/p (just before calling netns tests) from container_test.sh
>
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> incrementing stop
> --- Start env o/p ---
> LESSKEY=3D/etc/lesskey.bin
> NNTPSERVER=3Dnews
> .... SNIP ...
> MAIL=3D/var/mail/root
> PATH=3D/sbin:/usr/sbin:/usr/local/sbin:/root/bin:/usr/local/bin:/usr/bin:=
/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/usr/lib/mit/s=
bin:/opt/ltp/testcases/bin:/opt/ltp/testcases/bin
> CPU=3Dppc64
> _=3D/usr/bin/env
> SSH_SENDS_LOCALE=3Dyes
> INPUTRC=3D/etc/inputrc
> PWD=3D/opt/ltp/testcases/bin
> LANG=3Den_US.UTF-8
> PYTHONSTARTUP=3D/etc/pythonstart
> LTPROOT=3D/opt/ltp
> .... SNIP ...
>
> So the values look okay, but the run still fails.

    Could you also add a check within childns.sh please?
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
