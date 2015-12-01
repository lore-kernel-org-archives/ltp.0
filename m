From: $rik@nth  <srikanth007m@gmail.com>
Date: Tue, 1 Dec 2015 07:45:05 +0530
Subject: [LTP] 64bit ld terminates for time01.c & write04.c
In-Reply-To: <20151130171209.GG11935@rei.lan>
References: <CANKSX+E504F87K-3ZhaDPNcFLEVgv1oyRLeVV=vz69fMjSxtOw@mail.gmail.com>
 <20151130171209.GG11935@rei.lan>
Message-ID: <CANKSX+FnfbhDuhCAEf1rnehhO7n=4EBrWWGapQR5T1WmOQYjzw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thank You Cyril. I will follow up with binutils.

On Mon, Nov 30, 2015 at 10:42 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> I'm trying to cross compile the LTP to ARM 64bit and i am using
>> aarch64-linux-gnu- tool chain for cross compiling. Entire LTP got
>> compiled successfully except time01 and write04 tests due to ld
>> returned with signal 11 and core is not dumped either for debugging.
>> So i have collected strace for reference and attached is for time01.
>>
>> aarch64-linux-gnu-gcc-4.8 -static -g -O2 -fno-strict-aliasing -pipe
>> -Wall -W -Wold-style-definition
>> -I/home/Srikanth/ltp-working/testcases/kernel/include
>> -I../../../include -I../../../include -static -pthread  -L../../../lib
>>  time01.c   -lltp -o time01
>> collect2: error: ld terminated with signal 11 [Segmentation fault], core dumped
>> make: *** [time01] Error 1
>
> Most likely you have found a bug in your binutils (which is the package
> the ld comes from) and this is a wrong mailing list to report the
> problem to, try mailing list or bugzilla listed at
> https://www.gnu.org/software/binutils/.
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Thanks & Regards,
M.Srikanth Kumar.
