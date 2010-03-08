Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NofGc-0005sa-BV
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 15:53:14 +0000
Received: from mail-iw0-f195.google.com ([209.85.223.195])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NofGb-0005T7-Jk
	for ltp-list@lists.sourceforge.net; Mon, 08 Mar 2010 15:53:14 +0000
Received: by iwn33 with SMTP id 33so5206873iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Mar 2010 07:53:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B946761.8030301@cn.fujitsu.com>
References: <4B946761.8030301@cn.fujitsu.com>
Date: Mon, 8 Mar 2010 07:53:08 -0800
Message-ID: <364299f41003080753h78ddb8c0uc20027ccf2e3c990@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [BUG?] container_test.sh: should to delete
	check_for_unshare's source in cvs/git ?
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Sun, Mar 7, 2010 at 6:56 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> Tested the latest cvs version (about Mar 1) on my x86_64 (2.6.33).
> The following message occured:
> --------------------------------
> <<<test_start>>>
> tag=3DContainers stime=3D1267527554
> cmdline=3D"container_test.sh"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> /opt/ltp/testcases/bin/container_test.sh: line 13: check_for_unshare: com=
mand not found
> Running utsns tests.
> unshare tests
> test 1 (unshare)
> test 2 (unshare)
> ......
> --------------------------------
>
> I noticed that check_for_unshare had been deleted in LTP-20091031.
> In ./ChangeLog (from latest cvs version)
> =A0 ...
> =A0 2905 LTP-20091031
> =A0 ...
> =A0 3141 Removed Files:
> =A0 3142 ltp/README.ltp-devel
> =A0 3143 ltp/config.mk.in
> =A0 3144 ltp/ltp-devel.spec
> =A0 3145 ltp/testcases/kernel/containers/check_for_unshare.c
> =A0 ...
> =A0 3997 LTP-20090930
>
> Also, i noticed check_for_unshare commentted in container_test.sh in
> release version of FEBRUARY 2010. pls check the diff between cvs version
> and release version of Feb in attached file.
>
> Now, my question: should to delete check_for_unshare's source in cvs/git ?

There was some discussion and the check was reenabled post the February rel=
ease.
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
