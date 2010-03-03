Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nmnt8-0002LV-PN
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 12:41:18 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nmnt8-00036p-24
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 12:41:18 +0000
Received: by pvf33 with SMTP id 33so362522pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 04:41:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B8E3B7F.8050301@calsoftinc.com>
References: <4B8E3B7F.8050301@calsoftinc.com>
Date: Wed, 3 Mar 2010 04:41:12 -0800
Message-ID: <364299f41003030441m55fd43f2nf8f8b991573ad97c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Missing test tools in recent ltp builds
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
To: Shwetabh <shwetabh.goel@calsoftinc.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

On Wed, Mar 3, 2010 at 2:35 AM, Shwetabh <shwetabh.goel@calsoftinc.com> wro=
te:
>
> In recent ltp releases, I see quite a few test cases breaking since
> their required tools
> are not being copied over to /opt/ltp/testcases/. I believe this
> behaviour started since
> ltp started compiling and copying the files to /opt/ltp. Here is an examp=
le:

Please provide more concrete examples and patches wherever possible.
We'll get it fixed as soon as feasibly possible, but it helps if
others contribute back as well. Also, not providing examples is
counterproductive and I won't waste my time worrying about issues that
supposedly exist if I don't have a means to reproduce the problem, or
at least a fundamental understanding of what the problem is.

> ----<<snip>>-----------
> remove test cases which require the block device.
> You can specify it with option -b
> COMMAND: =A0 =A0/opt/ltp/bin/ltp-pan =A0-e -S =A0 -a 27204 =A0 =A0 -n 272=
04 =A0-p =A0-f
> /tmp/ltp-gcfmm27210/alltests -l
> /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.log =A0-C
> /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.failed
> LOG File: /opt/ltp/results/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.log
> FAILED COMMAND File:
> /opt/ltp/output/LTP_RUN_ON-2010_Mar_02-22h_24m_38s.failed
> Running tests.......
> <<<test_start>>>
> tag=3DCPUHOTPLUG stime=3D1267586681
> cmdline=3D"(cd $LTPROOT/testcases/kernel/hotplug/cpu_hotplug/; ./runtests=
.sh)"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> incrementing stop
> sh: line 0: cd: /opt/ltp/testcases/kernel/hotplug/cpu_hotplug/: No such
> file or directory
> sh: ./runtests.sh: No such file or directory

And the reason why this is failing is that
/opt/ltp/testcases/kernel/hotplug/cpu_hotplug doesn't exist; the test
still works -- it's just the runtest file itself that's broken. The
tests haven't been touched for months, if not almost 2 years...

> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D127 corefile=3Dno
> cutime=3D0 cstime=3D0
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20100228
>
> =A0 =A0 =A0 =A0##########################################################=
#####"
>
> =A0 =A0 =A0 =A0 =A0 =A0 Done executing testcases."
> =A0 =A0 =A0 =A0 =A0 =A0 LTP Version: =A0LTP-20100228
> =A0 =A0 =A0 =A0##########################################################=
#####"
>
> [root@localhost runtest]# cd /opt/ltp/testcases/
> [root@localhost testcases]# ls
> bin =A0data
> [root@localhost testcases]# pwd
> /opt/ltp/testcases
> [root@localhost testcases]# ls -l
> total 76
> drwxr-xr-x 7 root root 69632 Mar =A02 22:24 bin
> drwxr-xr-x 2 root root =A04096 Mar =A02 22:19 data
>
> --------------------
>
> Please advice if I am doing something wrong here. Do I manually have to
> copy the tools from tarballs' testcases/kernel directory?
> If so, shouldn't this be done by make install?

Just leave it as-is and execute like before, or feel free to submit
patches to fix this (it's a non-blocking issue so it's not a high
priority on my list to `fix').

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
