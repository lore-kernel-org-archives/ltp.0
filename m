From: fixed-term.Islam.Tammam <fixed-term.Islam.Tammam@de.bosch.com>
Date: Thu, 20 Jul 2017 12:58:34 +0200
Subject: [LTP] Build error for LTP project
In-Reply-To: <20170720075944.GA20380@rei>
References: <c8ced4c0-637a-3b95-d5e8-5c521b866dba@de.bosch.com>
 <20170720075944.GA20380@rei>
Message-ID: <ef80b6fc-deef-375c-99bb-d689ac427ae2@de.bosch.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cleaning the lib directory and building it alone had fixed the problem , 
however i am quite wondering why this wasn't the case when building from 
TopSrc Directory itself .

Thank you for helping Cyril
Best regards,

*Islam Tammam
Test Architect and Team Leader
CM/ESO3*

Tel.  +49(5121)49-5911


On 07/20/2017 09:59 AM, Cyril Hrubis wrote:
> Hi!
>> tai1hi@HI-Z0EMX:~/Git_Repos/ltp_git$ make -j8
>> make -C "lib" \
>> 		-f "/home/tai1hi/Git_Repos/ltp_git/lib/Makefile" all
>> if git describe >/dev/null 2>&1; then \
>> 		git describe > "Version"; \
>> 	else \
>> 		cp /home/tai1hi/Git_Repos/ltp_git/VERSION "Version"; \
>> 	fi
>> make[1]: Entering directory `/home/tai1hi/Git_Repos/ltp_git/lib'
>> make[2]: Entering directory
>> `/home/tai1hi/Git_Repos/ltp_git/lib/newlib_tests'
>> arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2
>> -I../../include -I../../include -I../../include/old/   -L../../lib
>> test01.c   -lltp -o test01
>> arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2
>> -I../../include -I../../include -I../../include/old/   -L../../lib
>> test02.c   -lltp -o test02
>> arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2
>> -I../../include -I../../include -I../../include/old/   -L../../lib
>> test03.c   -lltp -o test03
>> arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2
>> -I../../include -I../../include -I../../include/old/   -L../../lib
>> test04.c   -lltp -o test04
>> arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2
>> -I../../include -I../../include -I../../include/old/   -L../../lib
>> test05.c   -lltp -o test05
>> arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2
>> -I../../include -I../../include -I../../include/old/   -L../../lib
>> test06.c   -lltp -o test06
>> arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2
>> -I../../include -I../../include -I../../include/old/   -L../../lib
>> test07.c   -lltp -o test07
>> arm-none-linux-gnueabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition -W -Wall -pthread -D_FORTIFY_SOURCE=2
>> -I../../include -I../../include -I../../include/old/   -L../../lib
>> test08.c   -lltp -o test08
>> /tmp/cc0cEnWR.o: In function `do_test':
>> /home/tai1hi/Git_Repos/ltp_git/lib/newlib_tests/test01.c:29: undefined
>> reference to `tst_exit'
>> ../../lib/libltp.a(tst_test.o): In function `print_result':
>> /home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:213: undefined reference
>> to `tst_color_enabled'
>> /home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:214: undefined reference
>> to `tst_ttype2color'
>> /home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:204: undefined reference
>> to `tst_strerrno'
>> /home/tai1hi/Git_Repos/ltp_git/lib/tst_test.c:207: undefined reference
>> to `tst_strerrno'
>> ../../lib/libltp.a(tst_test.o): In function `snprintf':
>> /opt/tooling/codesourcery/MGC-2014.05-74-arm-gcc-4.8.3/Sourcery_CodeBench_for_ARM_Embedded/arm-none-linux-gnueabi/libc/usr/include/bits/stdio2.h:64:
>> undefined reference to `TEST_ERRNO'
>
> ...
>
> <snapped>
>
> This looks like some kind of file corruption to me. The libltp.a should
> contain all symbols that are listed here as missing.
>
> Also is this log from the first attempt to build LTP after configure
> script was executed? Since if that is so it should have been building
> the libltp.a first, which is not the case here so that it looks like a
> subsequent attempt to me.
>
> Can you try to do a make clean in the lib/ directory and then try to
> rebuild the libltp.a again? Maybe that would help.
>
