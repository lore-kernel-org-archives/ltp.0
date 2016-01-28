From: $rik@nth  <srikanth007m@gmail.com>
Date: Thu, 28 Jan 2016 16:57:39 +0530
Subject: [LTP] get_mempolicy failing to compile
In-Reply-To: <86787612.13141304.1453908836303.JavaMail.zimbra@redhat.com>
References: <CANKSX+ENW0PPUWmJ5EjOtCJX+4qGppBvw-uW4W6eEC3WRDiWrw@mail.gmail.com>
 <1328964111.10534362.1453378477201.JavaMail.zimbra@redhat.com>
 <CANKSX+HPL_+G4YWYtS0K7hesk36H+3D=endwvQmzTK1bGqSaYg@mail.gmail.com>
 <898714872.10545516.1453380405909.JavaMail.zimbra@redhat.com>
 <CANKSX+E608-qFt=-_vneFeBL+BH3zjZGsJXyjJ74rv3k507UYw@mail.gmail.com>
 <13368452.10990988.1453451416635.JavaMail.zimbra@redhat.com>
 <CANKSX+Ega5EEVu5N_Zh2QAJRnBokoFy9mD85CjcBbL5=M4hP6g@mail.gmail.com>
 <CANKSX+EDVxxf-KuV4kZmogfmT1m=1pcHgsQ1wtrQjHSjLcwp8A@mail.gmail.com>
 <86787612.13141304.1453908836303.JavaMail.zimbra@redhat.com>
Message-ID: <CANKSX+Eo4xDA+Xwo0-OmgNfAgkeTfusQ7=QKfKaLH88SMj3WJQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks Jan for the patch. It worked and able to compile entire LTP.

On Wed, Jan 27, 2016 at 9:03 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
>
> ----- Original Message -----
>> From: "$rik@nth" <srikanth007m@gmail.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp@lists.linux.it
>> Sent: Wednesday, 27 January, 2016 9:39:26 AM
>> Subject: Re: [LTP] get_mempolicy failing to compile
>>
>> Now it is failing here.. on the same setup i am able to compile the
>> sample numa program statically.
>>
>> make[4]: Leaving directory
>> '/home/linaro/Srikanth/ltp/testcases/kernel/include'
>> gcc -static -g -O2 -fno-strict-aliasing -pipe -Wall -W
>> -Wold-style-definition
>> -I/home/linaro/Srikanth/ltp/testcases/kernel/include -D_GNU_SOURCE
>> -DNUMA_VERSION1_COMPATIBILITY -I../../../include -I../../../include
>> -static -pthread  -L../../../lib  numa_node_size.c   -lltp -lnuma -o
>> numa_node_size
>> numa_node_size.c: In function ?fmt_mem?:
>> numa_node_size.c:44:10: warning: comparison between signed and
>> unsigned integer expressions [-Wsign-compare]
>>   if (mem == -1L)
>>           ^
>> /usr/lib/gcc/aarch64-linux-gnu/4.9/../../../aarch64-linux-gnu/libnuma.a(libnuma.o):(.bss+0x38):
>> multiple definition of `numa_exit_on_error'
>
> That's likely because "numa_exit_on_error" is supposed to be defined
> by libnuma library:
>   http://linux.die.net/man/3/numa_exit_on_error
>
> Test defines it too, which creates conflict. We should consider removing it,
> (and that it doesn't break older libnuma releases):
>
> diff --git a/testcases/kernel/numa/numa_node_size.c b/testcases/kernel/numa/numa_node_size.c
> index 6338bc7..1375193 100644
> --- a/testcases/kernel/numa/numa_node_size.c
> +++ b/testcases/kernel/numa/numa_node_size.c
> @@ -38,7 +38,7 @@
>  #include <numa.h>
>  #endif
>
> -int numa_exit_on_error = 0;
>  char *fmt_mem(unsigned long long mem, char *buf)
>  {
>         if (mem == -1L)
>
> Regards,
> Jan
>
>> /tmp/ccRABETR.o:(.bss+0x0): first defined here
>> /usr/lib/gcc/aarch64-linux-gnu/4.9/../../../aarch64-linux-gnu/libnuma.a(affinity.o):
>> In function `affinity_ip':
>> (.text+0x6dc): warning: Using 'getaddrinfo' in statically linked
>> applications requires at runtime the shared libraries from the glibc
>> version used for linking
>> collect2: error: ld returned 1 exit status
>> <builtin>: recipe for target 'numa_node_size' failed
>> make[3]: *** [numa_node_size] Error 1
>> make[3]: Leaving directory '/home/linaro/Srikanth/ltp/testcases/kernel/numa'
>> ../../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
>> make[2]: *** [all] Error 2
>> make[2]: Leaving directory '/home/linaro/Srikanth/ltp/testcases/kernel'
>> ../include/mk/generic_trunk_target.inc:93: recipe for target 'all' failed
>> make[1]: *** [all] Error 2
>> make[1]: Leaving directory '/home/linaro/Srikanth/ltp/testcases'
>> Makefile:114: recipe for target 'testcases-all' failed
>> make: *** [testcases-all] Error 2
>>
>> On Fri, Jan 22, 2016 at 12:10 PM, $rik@nth <srikanth007m@gmail.com> wrote:
>> > I did an softlink to arm-linux gcc after my initial mail.. So on
>> > latest one you will be not seeing.
>> >
>> > I will try on another development board. This is my 3rd board having
>> > problem :(
>> >
>> > On Fri, Jan 22, 2016 at 2:00 PM, Jan Stancek <jstancek@redhat.com> wrote:
>> >>
>> >>
>> >> ----- Original Message -----
>> >>> From: "$rik@nth" <srikanth007m@gmail.com>
>> >>> To: "Jan Stancek" <jstancek@redhat.com>
>> >>> Sent: Friday, 22 January, 2016 5:25:54 AM
>> >>> Subject: Re: [LTP] get_mempolicy failing to compile
>> >>>
>> >>> My environment is ARM ubuntu and all my libs and packages are in AMR.
>> >>
>> >> config.log you gave us is from x86_64 system named "hyd-lnxbld84".
>> >>
>> >>> Yes able to compile the source  static as well
>> >>> linaro@linaro-alip:~/Srikanth$ gcc -static numatest.c -lnuma
>> >>
>> >> This is a different system, isn't it?
>> >>
>> >> What I meant was "hyd-lnxbld84" system and gcc you use to
>> >> compile LTP:
>> >>   arm-linux-gnueabihf-gcc -static numatest.c -lnuma
>> >
>> >
>> >
>> > --
>> > Thanks & Regards,
>> > M.Srikanth Kumar.
>>
>>
>>
>> --
>> Thanks & Regards,
>> M.Srikanth Kumar.
>>



-- 
Thanks & Regards,
M.Srikanth Kumar.
