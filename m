Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nwt5W-0000jF-D7
	for ltp-list@lists.sourceforge.net; Wed, 31 Mar 2010 08:15:46 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nwt5V-0003vu-KA
	for ltp-list@lists.sourceforge.net; Wed, 31 Mar 2010 08:15:46 +0000
Received: by gyb11 with SMTP id 11so3466781gyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 31 Mar 2010 01:15:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100331081225.GA5048@linux.vnet.ibm.com>
References: <4B97AA99.7050406@in.ibm.com>
	<364299f41003102015j42667189x9adbc23f48121e87@mail.gmail.com>
	<4B99CC90.90204@in.ibm.com>
	<364299f41003112333v3c9e5e7wb6160c2c59395b68@mail.gmail.com>
	<4B9A01B8.6040008@in.ibm.com>
	<364299f41003120832g4efc1136sf430dd0bd8f831cd@mail.gmail.com>
	<4B9DDBDB.7090801@in.ibm.com>
	<20100331081225.GA5048@linux.vnet.ibm.com>
Date: Wed, 31 Mar 2010 01:15:39 -0700
Message-ID: <x2r364299f41003310115ud535e212y3cab408feb6a102f@mail.gmail.com>
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
To: Sachin Sant <sachinp@in.ibm.com>, Garrett Cooper <yanegomi@gmail.com>, ltp-list@lists.sourceforge.net

On Wed, Mar 31, 2010 at 1:12 AM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Mon, Mar 15, 2010 at 12:33:55PM +0530, Sachin Sant wrote:
>> Garrett Cooper wrote:
>> >> contacts=3D""
>> >> analysis=3Dexit
>> >> <<<test_output>>>
>> >> incrementing stop
>> >> --- Start env o/p ---
>> >> LESSKEY=3D/etc/lesskey.bin
>> >> NNTPSERVER=3Dnews
>> >> .... SNIP ...
>> >> MAIL=3D/var/mail/root
>> >> PATH=3D/sbin:/usr/sbin:/usr/local/sbin:/root/bin:/usr/local/bin:/usr/=
bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/usr/lib/m=
it/sbin:/opt/ltp/testcases/bin:/opt/ltp/testcases/bin
>> >> CPU=3Dppc64
>> >> _=3D/usr/bin/env
>> >> SSH_SENDS_LOCALE=3Dyes
>> >> INPUTRC=3D/etc/inputrc
>> >> PWD=3D/opt/ltp/testcases/bin
>> >> LANG=3Den_US.UTF-8
>> >> PYTHONSTARTUP=3D/etc/pythonstart
>> >> LTPROOT=3D/opt/ltp
>> >> .... SNIP ...
>> >>
>> >> So the values look okay, but the run still fails.
>> >>
>> >
>> > =A0 =A0 Could you also add a check within childns.sh please?
>> >
>> As the LTP framework is unable to locate childns.sh script(as per the er=
ror
>> message) i cannot print anything from within childns.sh. This script is
>> never invoked during the run.
>
> Can we think on any alternate solution for this ?

    I haven't really dug into this issue; honestly, I would just
commit the fix that Sachin provided which reverted the testcases/bin
removal that I did a few months back. However, I would also add a
comment stating why the hardcoded relative path is required with this
test and point to this post, so someone doesn't make the same mistake
in the future.
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
