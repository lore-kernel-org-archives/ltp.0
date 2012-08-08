Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1SyyFH-00086u-NS
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 04:51:47 +0000
Received: from mail-vb0-f47.google.com ([209.85.212.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SyyFG-0005bh-Sb
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 04:51:47 +0000
Received: by vbbfr13 with SMTP id fr13so382781vbb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Aug 2012 21:51:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5021EA9F.1090606@cn.fujitsu.com>
References: <CANoG8sX7V5VFgHdm7O2r1E4DXrfFM9jDeP2WDyD7roMXkGe-RA@mail.gmail.com>
	<5021EA9F.1090606@cn.fujitsu.com>
Date: Wed, 8 Aug 2012 12:51:41 +0800
Message-ID: <CANoG8sUiB=+MfOGD8UNtkZh7Gf5X=YOSiAVZN0n=FPbhHm4_5g@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: Re: [LTP]
	=?windows-1252?q?/usr/include/linux/capability=2Eh=3A70=3A_?=
	=?windows-1252?q?error=3A_expected_specifier-qualifier-list_before?=
	=?windows-1252?q?_=91=5F=5Fle32=92?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

I tried the patch, it solves the problem.

Thanks
Romu

2012/8/8 Wanlong Gao <gaowanlong@cn.fujitsu.com>:
> On 07/30/2012 10:58 AM, Romu wrote:
>> Hi,
>>
>> I tried building LTP-20120614 on CentOS5 but it always failed (see
>> error message below).  LTP-20120401 builds fine on CentOS5.
>>
>> make[3]: Entering directory
>> `/dev/shm/ltp-full-20120614/testcases/kernel/security'
>> make[4]: Entering directory
>> `/dev/shm/ltp-full-20120614/testcases/kernel/security/cap_bound'
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I/dev/shm/ltp-full-20120614/testcases/kernel/include
>> -I../../../../include -I../../../../include   -L../../../../lib
>> cap_bounds_r.c   -lltp  -o cap_bounds_r
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I/dev/shm/ltp-full-20120614/testcases/kernel/include
>> -I../../../../include -I../../../../include   -L../../../../lib
>> cap_bounds_rw.c   -lltp  -o cap_bounds_rw
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I/dev/shm/ltp-full-20120614/testcases/kernel/include
>> -I../../../../include -I../../../../include   -L../../../../lib
>> cap_bset_inh_bounds.c   -lltp  -o cap_bset_inh_bounds
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I/dev/shm/ltp-full-20120614/testcases/kernel/include
>> -I../../../../include -I../../../../include   -L../../../../lib
>> check_pe.c   -lltp  -o check_pe
>> In file included from /usr/include/sys/capability.h:34,
>>                  from cap_bset_inh_bounds.c:32:
>> /usr/include/linux/capability.h:70: error: expected
>> specifier-qualifier-list before =91__le32=92
>> In file included from /usr/include/sys/capability.h:34,
>>                  from cap_bounds_rw.c:29:
>> /usr/include/linux/capability.h:70: error: expected
>> specifier-qualifier-list before =91__le32=92
>> In file included from /usr/include/sys/capability.h:34,
>>                  from cap_bounds_r.c:30:
>> /usr/include/linux/capability.h:70: error: expected
>> specifier-qualifier-list before =91__le32=92
>> In file included from /usr/include/sys/capability.h:34,
>>                  from check_pe.c:33:
>> /usr/include/linux/capability.h:70: error: expected
>> specifier-qualifier-list before =91__le32=92
>> cap_bset_inh_bounds.c:128:2: warning: no newline at end of file
>> make[4]: *** [cap_bset_inh_bounds] Error 1
>> make[4]: *** Waiting for unfinished jobs....
>> cap_bounds_rw.c: In function =91main=92:
>> cap_bounds_rw.c:82: warning: unused variable =91i=92
>> cap_bounds_rw.c:81: warning: unused variable =91ret=92
>> make[4]: *** [cap_bounds_rw] Error 1
>> make[4]: *** [cap_bounds_r] Error 1
>> check_pe.c:88:2: warning: no newline at end of file
>> make[4]: *** [check_pe] Error 1
>> make[4]: Leaving directory
>> `/dev/shm/ltp-full-20120614/testcases/kernel/security/cap_bound'
>> make[3]: *** [all] Error 2
>> make[3]: Leaving directory
>> `/dev/shm/ltp-full-20120614/testcases/kernel/security'
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory `/dev/shm/ltp-full-20120614/testcases/kernel'
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory `/dev/shm/ltp-full-20120614/testcases'
>> make: *** [testcases-all] Error 2
>>
>>
>> I found:
>> http://osdir.com/ml/debian-bugs-dist/2009-12/msg00664.html
>> https://bugs.gentoo.org/show_bug.cgi?id=3D264770
>>
>> But still can't figure out how to fix the issue.
>> Any idea?
>
> Can you test this patch ?
> http://marc.info/?l=3Dltp-list&m=3D134392485410819&w=3D2
>
> Thanks,
> Wanlong Gao
>
>>
>> Thanks
>> Romu

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
