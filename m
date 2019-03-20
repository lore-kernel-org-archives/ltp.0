From: Vineet Gupta <vineet.gupta1@synopsys.com>
Date: Wed, 20 Mar 2019 16:11:05 -0700
Subject: [LTP] [PATCH v2] autodetect fts support and tests depending on
	it
In-Reply-To: <20190320223733.GA5619@dell5510>
References: <20190318181940.GA5494@dell5510>
 <1552938764-15101-1-git-send-email-vgupta@synopsys.com>
 <20190320223733.GA5619@dell5510>
Message-ID: <3601d849-46fa-b9cd-0a6d-882c8ed9c73f@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 3/20/19 3:37 PM, Petr Vorel wrote:
> 
>> +# controllers/cpuset/cpuset_lib/libcpuset.c uses fts
>> +# which may not be available/configured in the libc build
>> +ifndef HAVE_FTS_H
>> +FILTER_OUT_DIRS	+= cpuset
>> +endif
> Have you tested it? 

Absolutely. I verified again. With this patch reverted locally I see errors due to
it trying to build the file

|
| make[5]: Leaving directory
'~/ltp/testcases/kernel/controllers/cpuset/cpuset_exclusive_test'
| make[5]: Entering directory
'~/ltp/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test'
| make -C ../cpuset_lib -f
"~/ltp/testcases/kernel/controllers/cpuset/cpuset_memory_pressure_test/../cpuset_lib/Makefile"
all
| make[6]: Entering directory '~/ltp/testcases/kernel/controllers/cpuset/cpuset_lib'
| arc-linux-uclibc-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../../../../include
-I../../../../../include -I../../../../../include/old/  -c -o meminfo.o meminfo.c
| arc-linux-uclibc-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../../../../include
-I../../../../../include -I../../../../../include/old/  -c -o libbitmask.o
libbitmask.c
| arc-linux-uclibc-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../../../../include
-I../../../../../include -I../../../../../include/old/  -c -o libcpuset.o libcpuset.c
| libcpuset.c:32:10: fatal error: fts.h: No such file or directory
|

With my patch the build runs to completion.

This will not work as HAVE_LIBAIO_H is in include/config.h,

You mean HAVE_FTS_H (LIBAIO stuff is for different patch)

> thus only for C. For Makefile it must be done via autotools (search for AC_SUBST
> in m4/). I thought TST_TEST_TCONF usage, but you're right, that problematic
> source is part of libcontrollers.a (i.e. part of a library, not normal C
> binary).
Umm not sure what u mean. Going to read the next msg in thread.
