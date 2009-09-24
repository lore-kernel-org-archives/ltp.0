Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1Mqw4j-0000Ef-PZ
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 21:42:05 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mqw4a-0006g1-CY
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2009 21:42:00 +0000
Date: Thu, 24 Sep 2009 23:42:03 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
MIME-Version: 1.0
References: <b9d696240909211602o51c38c2ei41a8622d3250f06b@mail.gmail.com>
	<200909241423.45226.jpalecek@web.de>
	<b9d696240909241155x5be217a3t4564e6b1bb64a9be@mail.gmail.com>
Message-ID: <op.u0r6j4rhu2flwt@debian>
In-Reply-To: <b9d696240909241155x5be217a3t4564e6b1bb64a9be@mail.gmail.com>
Subject: Re: [LTP] Buffer Overflow with ftest03 and ftest07
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, 24 Sep 2009 20:55:57 +0200, K.D. Lucas <kdlucas@gmail.com> wrote:

> Ok, I applied your patch, and it didn't compile initially so I had to  
> clean
> up a few things. They were mostly minor like casting a few vars to  
> integers,
> or changing the format specifiers from %XL to %ld, etc, and adding the
> variable char fuss[40] back into ftest07.c.
>
> After that I tested them. Both ftest03.c and ftest07.c passes when run  
> from
> the command line. But when executed by runltp, they fail with return code
> 11. This is identical to the behavior without your patch.
>
> Thanks for attempting to fix this. Any other ideas?

OK. Could you build with debugging symbols and get a backtrace with them,  
or send a backtrace with the binary that produced it?

   Jiri

> Kelly
>
> 2009/9/24 Jiri Palecek <jpalecek@web.de>
>
>> Hi,
>>
>> On Tuesday 22 September 2009 01:02:29 K.D. Lucas wrote:
>> > Since I started using LTP 20090831 I've been seeing buffer overflow
>> messages
>> > when running ftest03 and ftest07. The back trace is:
>> >
>> > *** buffer overflow detected ***: ftest03 terminated
>> > ======= Backtrace: =========
>> > /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0xa17038]
>> > /lib/tls/i686/cmov/libc.so.6[0xa15140]
>> > /lib/tls/i686/cmov/libc.so.6[0xa14838]
>> > /lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x986d18]
>> > /lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x95981c]
>> > /lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0xa148e4]
>> > /lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0xa1482d]
>> > ftest03[0x804a7d9]
>> > ftest03[0x804a884]
>> > /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x92f7a5]
>> > ftest03[0x8049461]
>> > ======= Memory map: ========
>> > 00919000-00a75000 r-xp 00000000 08:01 132417     /lib/tls/i686/cmov/
>> > libc-2.9.so
>> > 00a75000-00a76000 ---p 0015c000 08:01 132417     /lib/tls/i686/cmov/
>> > libc-2.9.so
>> > 00a76000-00a78000 r--p 0015c000 08:01 132417     /lib/tls/i686/cmov/
>> > libc-2.9.so
>> > 00a78000-00a79000 rw-p 0015e000 08:01 132417     /lib/tls/i686/cmov/
>> > libc-2.9.so
>> > 00a79000-00a7c000 rw-p 00000000 00:00 0
>> > 00a8c000-00aa8000 r-xp 00000000 08:01 367        /lib/ld-2.9.so
>> > 00aa8000-00aa9000 r--p 0001b000 08:01 367        /lib/ld-2.9.so
>> > 00aa9000-00aaa000 rw-p 0001c000 08:01 367        /lib/ld-2.9.so
>> > 00c91000-00cbb000 r-xp 00000000 08:01 409        /lib/libgcc_s.so.1
>> > 00cbb000-00cbc000 r--p 00029000 08:01 409        /lib/libgcc_s.so.1
>> > 00cbc000-00cbd000 rw-p 0002a000 08:01 409        /lib/libgcc_s.so.1
>> > 00cce000-00ccf000 r-xp 00000000 00:00 0          [vdso]
>> > 08048000-08050000 r-xp 00000000 08:01 231138
>> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
>> > 08050000-08051000 r--p 00007000 08:01 231138
>> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
>> > 08051000-08052000 rw-p 00008000 08:01 231138
>> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest03
>> > 08052000-08056000 rw-p 00000000 00:00 0
>> > 09ead000-09ece000 rw-p 00000000 00:00 0          [heap]
>> > b7f8d000-b7f8e000 rw-p 00000000 00:00 0
>> > b7f9b000-b7f9d000 rw-p 00000000 00:00 0
>> > bff91000-bffa6000 rw-p 00000000 00:00 0          [stack]
>> > *** buffer overflow detected ***: ftest07 terminated
>> > ======= Backtrace: =========
>> > /lib/tls/i686/cmov/libc.so.6(__fortify_fail+0x48)[0x20e038]
>> > /lib/tls/i686/cmov/libc.so.6[0x20c140]
>> > /lib/tls/i686/cmov/libc.so.6[0x20b838]
>> > /lib/tls/i686/cmov/libc.so.6(_IO_default_xsputn+0xc8)[0x17dd18]
>> > /lib/tls/i686/cmov/libc.so.6(_IO_vfprintf+0xf4c)[0x15081c]
>> > /lib/tls/i686/cmov/libc.so.6(__vsprintf_chk+0xa4)[0x20b8e4]
>> > /lib/tls/i686/cmov/libc.so.6(__sprintf_chk+0x2d)[0x20b82d]
>> > ftest07[0x804a9d1]
>> > ftest07[0x804aa74]
>> > /lib/tls/i686/cmov/libc.so.6(__libc_start_main+0xe5)[0x1267a5]
>> > ftest07[0x8049421]
>> > ======= Memory map: ========
>> > 00110000-0026c000 r-xp 00000000 08:01 132417     /lib/tls/i686/cmov/
>> > libc-2.9.so
>> > 0026c000-0026d000 ---p 0015c000 08:01 132417     /lib/tls/i686/cmov/
>> > libc-2.9.so
>> > 0026d000-0026f000 r--p 0015c000 08:01 132417     /lib/tls/i686/cmov/
>> > libc-2.9.so
>> > 0026f000-00270000 rw-p 0015e000 08:01 132417     /lib/tls/i686/cmov/
>> > libc-2.9.so
>> > 00270000-00273000 rw-p 00000000 00:00 0
>> > 00642000-0066c000 r-xp 00000000 08:01 409        /lib/libgcc_s.so.1
>> > 0066c000-0066d000 r--p 00029000 08:01 409        /lib/libgcc_s.so.1
>> > 0066d000-0066e000 rw-p 0002a000 08:01 409        /lib/libgcc_s.so.1
>> > 00d7c000-00d7d000 r-xp 00000000 00:00 0          [vdso]
>> > 00dfe000-00e1a000 r-xp 00000000 08:01 367        /lib/ld-2.9.so
>> > 00e1a000-00e1b000 r--p 0001b000 08:01 367        /lib/ld-2.9.so
>> > 00e1b000-00e1c000 rw-p 0001c000 08:01 367        /lib/ld-2.9.so
>> > 08048000-08050000 r-xp 00000000 08:01 231142
>> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
>> > 08050000-08051000 r--p 00007000 08:01 231142
>> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
>> > 08051000-08052000 rw-p 00008000 08:01 231142
>> > /var/tmp/tests/ltp-full-20090831/testcases/bin/ftest07
>> > 08052000-08057000 rw-p 00000000 00:00 0
>> > 09fce000-09fef000 rw-p 00000000 00:00 0          [heap]
>> > b802f000-b8030000 rw-p 00000000 00:00 0
>> > b803d000-b803f000 rw-p 00000000 00:00 0
>> > bfdfb000-bfe10000 rw-p 00000000 00:00 0          [stack]
>> >
>> >
>> > This is running against an Ubuntu Karmic Alpha netbook remix. I don't  
>> see
>> > this issue when testing on dapper or hardy distros. I saw some other
>> posts
>> > about this, but no one has offered any suggestions or solutions yet.
>>
>> It seems the problem is with some sprintf() call, and indeed, there is  
>> one
>> in the code. I propose deleting it (with other code) altogether,  
>> because it
>>  was needed just for creation of a temporary directory and we have
>> tst_tmpdir() for that. See the attachment and please report whether it  
>> works
>> and whether such solution is acceptable.
>>
>> Note that the code was not tested in any way.
>>
>> Regards
>>     Jiri Palecek
>>
>
>
>



-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
