Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NsQ4e-0003EJ-7i
	for ltp-list@lists.sourceforge.net; Fri, 19 Mar 2010 00:28:24 +0000
Received: from mail-iw0-f195.google.com ([209.85.223.195])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NsQ4c-0003RI-3m
	for ltp-list@lists.sourceforge.net; Fri, 19 Mar 2010 00:28:24 +0000
Received: by iwn33 with SMTP id 33so2293747iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Mar 2010 17:27:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E0B6230F32558E43951AF1B0DEBF98102119D20EBF@EUSAACMS0714.eamcs.ericsson.se>
References: <E0B6230F32558E43951AF1B0DEBF98102119CEC9EF@EUSAACMS0714.eamcs.ericsson.se>
	<20100318054409.GA5977@linux.vnet.ibm.com>
	<E0B6230F32558E43951AF1B0DEBF98102119D20C9F@EUSAACMS0714.eamcs.ericsson.se>
	<364299f41003181209j23fc077bm8e214346560f0fd5@mail.gmail.com>
	<E0B6230F32558E43951AF1B0DEBF98102119D20EBF@EUSAACMS0714.eamcs.ericsson.se>
Date: Thu, 18 Mar 2010 17:27:52 -0700
Message-ID: <364299f41003181727g547af140j706e6f296f88db27@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] FW: LTP check_mqns_enable.c missing mqueue.h file
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
To: Anthony Ton <anthony.ton@ericsson.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Thu, Mar 18, 2010 at 5:11 PM, Anthony Ton <anthony.ton@ericsson.com> wro=
te:
>
> Hi Garrett,
> Thanks for your help. =A0I can get the LTP compiling and running now.
> Regards,
> Anthony
> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Thursday, March 18, 2010 12:09 PM
> To: Anthony Ton
> Cc: Rishikesh K Rajak; ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] FW: LTP check_mqns_enable.c missing mqueue.h file
>
> On Thu, Mar 18, 2010 at 10:44 AM, Anthony Ton <anthony.ton@ericsson.com> =
wrote:
>> Hi Rishikesh,
>> I download the version you mentioned; however, the problem still exists.
>> Please see the attached file for trace output.
>> Thanks,
>> Anthony
>>
>> -----Original Message-----
>> From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com]
>> Sent: Wednesday, March 17, 2010 10:44 PM
>> To: Anthony Ton
>> Cc: ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] FW: LTP check_mqns_enable.c missing mqueue.h file
>>
>>
>> Hi Anthony,
>>
>> can you please try latest release which has been released yesterday =A0a=
nd let us know the result. Then we can fix this fast if such problem is sti=
ll there.
>>
>> You can download it from here:
>> https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20100228.1
>> /ltp-full-20100228.1.tgz/download
>>
>> Or You can clone through git also.
>>
>> # git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git
>> ltp-dev
>>
>> Thanks for reporting this failure.
>>
>> -Rishi
>>>Hi,
>>>
>>>I am using the latest version of LTP ltp-full-20100228. =A0During make
>>>all, the compile check_mqns_enable.c complains "mqueue.h: No such file o=
r directory."
>>>Could you please
>>>+tell me how to fix this?
>>>I am greatly appreciate your help.
>>>>
>>>Regards,
>>>Anthony Ton
>>>
>>>Error output:
>>>=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>ar -rc "libclone.a" libclone.o
>>>ranlib "libclone.a"
>>>>make[5]: Leaving directory
>> `/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/con=
tainers/libclone'
>>>>gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>>>-I/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/
>>>i
>>>nclude
>>>+-I/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel
>>>+/
>>>+containers/mqns/../libclone
>>>-I../../../../include -I../../../../include
>>>+-L/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel
>>>+/
>>>+containers/mqns/../libclone
>>>-L../../../../lib =A0check_mqns_enabled.c =A0-lpthread -lrt -lclone -lltp
>>>-o
>>>>+check_mqns_enabled
>>>In file included from check_mqns_enabled.c:25:
>>>mqns.h:5:20: mqueue.h: No such file or directory
>>>check_mqns_enabled.c: In function `main':
>>>check_mqns_enabled.c:35: error: `mqd_t' undeclared (first use in this
>>>function)
>>>>check_mqns_enabled.c:35: error: (Each undeclared identifier is
>>>>reported only
>>>once
>>>check_mqns_enabled.c:35: error: for each function it appears in.)
>>>check_mqns_enabled.c:35: error: syntax error before "mqd"
>>>>check_mqns_enabled.c:40: warning: implicit declaration of function `mq_=
unlink'
>>>check_mqns_enabled.c:41: error: `mqd' undeclared (first use in this
>>>function)
>>>check_mqns_enabled.c:41: warning: implicit declaration of function `mq_o=
pen'
>>>check_mqns_enabled.c:41: error: `O_RDWR' undeclared (first use in this
>>>function)
>>>check_mqns_enabled.c:41: error: `O_CREAT' undeclared (first use in
>>>this
>>>function)
>>>check_mqns_enabled.c:41: error: `O_EXCL' undeclared (first use in this
>>>function)
>>>>check_mqns_enabled.c:46: warning: implicit declaration of function `mq_=
close'
>>>make[4]: *** [check_mqns_enabled] Error 1
>>>make[4]: Leaving directory
>>>`/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/con=
tainers/mqns'
>>>make[3]: *** [all] Error 2
>>>make[3]: Leaving directory
>>>`/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/con=
tainers'
>>>>make[2]: *** [all] Error 2
>>>make[2]: Leaving directory
>>>`/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel'
>>>make[1]: *** [all] Error 2
>>>make[1]: Leaving directory
>>>`/home/etonant/linux-test-project/ltp-full-20100228/testcases'
>>>make: *** [testcases-all] Error 2
>>>etonant@lxlogin-4-300
>
> As Serge so eloquently put it, the problem is that you don't have your gl=
ibc headers installed.

Don't thank me -- thank Serge ;)...
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
