Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1OqyD0-0008HQ-Lb
	for ltp-list@lists.sourceforge.net; Thu, 02 Sep 2010 01:03:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OqyCy-0003a6-Ui
	for ltp-list@lists.sourceforge.net; Thu, 02 Sep 2010 01:03:18 +0000
Message-ID: <4C7EF8FD.6070005@cn.fujitsu.com>
Date: Thu, 02 Sep 2010 09:08:13 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <4C73452A.3020006@cn.fujitsu.com>
	<AANLkTi=Dky57c3S+NS_adO9Z-Tytp0d0hcyxPJA_DqrM@mail.gmail.com>
In-Reply-To: <AANLkTi=Dky57c3S+NS_adO9Z-Tytp0d0hcyxPJA_DqrM@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Add ftrace-stress-test to LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Eugene Teo <eugene@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>

>> --- /dev/null
>> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_kvercmp.c
>> @@ -0,0 +1,37 @@
>> +#include <unistd.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <sys/utsname.h>
>> +
>> +int main(int argc, char **argv)
>> +{
>> +       struct utsname uval;
>> +       int k1, k2, k3;
>> +       int a1, a2, a3;
>> +       unsigned long r1, r2;
>> +
>> +       if (argc != 4) {
>> +               fprintf(stderr, "Wrong arguments!\n");
>> +               return -1;
>> +       }
>> +
>> +       a1 = strtol(argv[1], NULL, 10);
>> +       a2 = strtol(argv[2], NULL, 10);
>> +       a3 = strtol(argv[3], NULL, 10);
>> +
>> +       uname(&uval);
>> +
>> +       sscanf(uval.release, "%d.%d.%d", &k1, &k2, &k3);
>> +
>> +       r1 = (a1 << 16) + (a2 << 8) + a3;
>> +       r2 = (k1 << 16) + (k2 << 8) + k3;
>> +
>> +       if (r1 > r2)
>> +               return 0;
>> +       else if (r1 == r2)
>> +               return 1;
>> +       else
>> +               return 2;
>> +}
> 
> This application could be replaced with tst_kvercmp out of the box;
> there's no reason why another program needs to be created for this.
> 

This stress test was not written for LTP originally, so I had to write
this ftrace_kvercmp.

But I do have a reason to keep this. That is, using tst_kvercmp will
make it harder to run this test without LTP.

Anyway I'll remove it.

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
