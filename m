Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NrEB9-0002PP-1o
	for ltp-list@lists.sourceforge.net; Mon, 15 Mar 2010 17:34:11 +0000
Received: from mail-pw0-f46.google.com ([209.85.160.46])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NrEB8-0003DU-1S
	for ltp-list@lists.sourceforge.net; Mon, 15 Mar 2010 17:34:10 +0000
MIME-Version: 1.0
In-Reply-To: <1268662482.7496.2.camel@subratamodak.linux.ibm.com>
References: <1268596049.7567.2.camel@subratamodak.linux.ibm.com>
	<20100315035918.GA2889@linux.vnet.ibm.com>
	<1268662482.7496.2.camel@subratamodak.linux.ibm.com>
Date: Mon, 15 Mar 2010 10:34:03 -0700
Message-ID: <364299f41003151034q2533add0kb6d10e541fb3804e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [BUILD FAILURE] cpuset_syscall_test.c fails to build for
	Feb 2010 release
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
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, Mar 15, 2010 at 7:14 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Mon, 2010-03-15 at 09:29 +0530, Rishikesh K Rajak wrote:
>> Hi Subrata,
>>
>> can you confirm if this error still occurs with latest git and also you =
have
>> numa-devel package installed ?
>>
>> or, just add "numaif.h" to cpuset_syscall_test.c and try to rebuild. Let=
 us
>> know the result too.
>
> With the latest GIT and installation of NUMA-DEVEL, the said problem
> seems to go away:
>
> # ls -l testcases/kernel/controllers/cpuset/cpuset_syscall_test/
> total 168
> -rwxr-xr-x 1 root =A0 =A0 =A0 =A0 root =A0 =A0 =A0 =A0 140039 Mar 15 19:40
> cpuset_syscall_test
> -rw-rw-r-- 1 subratamodak subratamodak =A0 6525 Mar 15 19:37
> cpuset_syscall_test.c
> -rwxrwxr-x 1 subratamodak subratamodak =A0 9191 Mar 15 19:37
> cpuset_syscall_testset.sh
> -rw-rw-r-- 1 subratamodak subratamodak =A0 1073 Mar 15 19:37 Makefile
>
> # rpm -qa | grep -i numa
> numactl-0.9.8-8.el5
> numactl-devel-0.9.8-8.el5

That isn't even remotely close to the latest version of numa-devel
(latest version is 2.x).

> However, a new error is introduced as below:
>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_CHECKOUT_DIRECTORY=
/GIT_CHECKOUT/GIT_DEV_BUILD/testcases/kernel/include -D_GNU_SOURCE -I/home/=
subratamodak/OFFICE_WORKS/LTP_PROJECT_CODE/LTP_CHECKOUT_DIRECTORY/GIT_CHECK=
OUT/GIT_DEV_BUILD/testcases/kernel/hotplug/memory_hotplug -I../../../../inc=
lude -I../../../../include =A0-c -o commands.o commands.c
> commands.c:62: error: conflicting types for =91nodemask_isset=92
> /usr/include/numa.h:55: note: previous definition of =91nodemask_isset=92
> was here
> commands.c:72: error: redefinition of =91nodemask_set=92
> /usr/include/numa.h:44: note: previous definition of =91nodemask_set=92 w=
as
> here
> commands.c: In function =91get_arg_nodeid_list=92:
> commands.c:396: warning: implicit declaration of function
> =91numa_get_membind_compat=92
> commands.c:396: error: incompatible types when assigning to type
> =91nodemask_t=92 from type =91int=92
> commands.c: In function =91get_current_nodeid_list=92:
> commands.c:454: error: incompatible types when assigning to type
> =91nodemask_t=92 from type =91int=92
> commands.c: In function =91show_seg=92:
> commands.c:665: warning: unused variable =91gcp=92
> commands.c: In function =91anon_seg=92:
> commands.c:685: warning: unused variable =91gcp=92
> commands.c: In function =91file_seg=92:
> commands.c:724: warning: unused variable =91gcp=92
> commands.c: In function =91remove_seg=92:
> commands.c:762: warning: unused variable =91gcp=92
> commands.c: In function =91touch_seg=92:
> commands.c:785: warning: unused variable =91gcp=92
> commands.c: In function =91unmap_seg=92:
> commands.c:820: warning: unused variable =91gcp=92
> commands.c: In function =91map_seg=92:
> commands.c:842: warning: unused variable =91gcp=92
> commands.c: In function =91mbind_seg=92:
> commands.c:883: warning: unused variable =91gcp=92
> commands.c: In function =91shmem_seg=92:
> commands.c:949: warning: unused variable =91gcp=92
> commands.c: In function =91where_seg=92:
> commands.c:991: warning: unused variable =91ret=92
> make[4]: *** [commands.o] Error 1

Yes, and this is because some APIs in numa.h changed between pre-1.x,
1.x, and 2.x. A config.log for the new workspace would be especially
helpful.
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
