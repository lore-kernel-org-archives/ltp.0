Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLrlp-0003rH-JI
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 05:22:25 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLrlj-0007Qx-4L
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 05:22:25 +0000
Received: by pxi27 with SMTP id 27so848447pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 18 Dec 2009 21:22:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1261152182.8993.22.camel@subratamodak.linux.ibm.com>
References: <76281794.565171261136353220.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1261152182.8993.22.camel@subratamodak.linux.ibm.com>
Date: Fri, 18 Dec 2009 21:22:12 -0800
Message-ID: <364299f40912182122x77b7d35y4bb86a0bb632379b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix lib-not-found error when compile for the
	second time
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 18, 2009 at 8:03 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-12-18 at 06:39 -0500, Caspar Zhang wrote:
>> Hi all, I meet a problem, if I compile and install ltp for the first tim=
e,
>> ltp can pass the compilation, but if I don't delete installation direcot=
ry
>> (originally been /opt/ltp) and try to build ltp for the second time in
>> another ltp source folder, ltp failes in compiling:
>>
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcase=
s/kernel/include
>> -I/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcase=
s/kernel/controllers/cpuctl/../libcontrollers
>> -I../../../../include -I../../../../include
>> -L/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcase=
s/kernel/controllers/cpuctl/../libcontrollers
>> -L../../../../lib =A0cpuctl_def_task01.c =A0 -lltp -lm -lcontrollers -o
>> cpuctl_def_task01
>> cpuctl_def_task01.c: In function =91main=92:
>> cpuctl_def_task01.c:90: warning: =91num_cpus=92 may be used uninitialize=
d in
>> this function
>> cpuctl_def_task01.c:90: warning: =91test_num=92 may be used uninitialize=
d in
>> this function
>> cpuctl_def_task01.c:94: warning: =91my_group_num=92 may be used
>> uninitialized in this function
>> /usr/bin/ld: cannot find -lcontrollers
>> collect2: ld returned 1 exit status
>> make[5]: *** [cpuctl_def_task01] Error 1
>> make[5]: Leaving directory
>> `/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases=
/kernel/controllers/cpuctl'
>> make[4]: *** [all] Error 2
>> make[4]: Leaving directory
>> `/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases=
/kernel/controllers'
>> make[3]: *** [all] Error 2
>> make[3]: Leaving directory
>> `/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases=
/kernel'
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory
>> `/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130/testcases'
>> make[1]: *** [testcases-all] Error 2
>> make[1]: Leaving directory
>> `/mnt/tests/kernel/distribution/ltp/20091130/ltp-full-20091130'
>> make: *** [build] Error 2
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> After investigating, I find the key to solve the problem:
>>
>> Suppose we build ltp to /opt/ltp.
>>
>> In testcases/kernel/controllers/Makefile[1] and testcases/network/sctp/M=
akefile[2],
>> library files which need to be built are defined in /opt/ltp/lib:
>>
>> LIB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D $(DESTDIR)/$(libdir)/libcon=
trollers.a
>>
>> when compiling&linking objects in controllers/ subdirs, the LDFLAGS path=
s are:
>>
>> -L$(topbuilddir)/testcases/kernel/controllers/libcontrollers
>> -L../../../../lib (see the error messages above)
>>
>> /opt/ltp/lib isn't included in LDFLAGS paths here.
>>
>> The first time when you compile ltp, a libcontrollers.a will be generated
>> under $(topbuilddir)/testcases/kernel/controllers/libcontrollers, so we =
can
>> find libcontrollers.a in LDFLAGS paths and the compilation could still p=
ass.
>> But if you don't delete /opt/ltp and try to build ltp in another source
>> directory, error will occur. Since $(LIB) in Makefile[1] and Makefile[2]
>> are already up-to-date, no libcontrollers.a will be generated in
>> $(topbuilddir)/testcases/kernel/controllers/libcontrollers due to makefi=
le
>> policy. Thus, ltp can't find libcontrollers.a in LDFLAGS paths.
>>
>> So we can fix this problem in two ways: add $(DESTDIR)/$(libdir)/lib to
>> LDFLAGS or change $(LIB) paths in Makefile[1] and Makefile[2]. Find deta=
ils
>> in my attachments.
>
> Thanks. I too faced the same thing sometime back. Garret, please apply
> the solution you would like the most.
>
> Caspar,
>
> There was also a problem with the sctp library. Did you check that out ?

Caspar,
    Thanks again for your good eye in spotting these two leftover
issues I didn't resolve earlier. They have just been fixed on HEAD.
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
