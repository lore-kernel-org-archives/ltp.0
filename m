From: Christian Amann <camann@suse.com>
Date: Fri, 7 Jun 2019 14:25:08 +0200
Subject: [LTP] [PATCH v2] syscalls/acct02: add functional testcase
In-Reply-To: <619a244a-cb0a-6dd9-fdb4-7c4a2fca6640@suse.de>
References: <20190604072228.17513-1-camann@suse.com>
 <20190606121436.GB27083@rei> <7c7bf785-adbd-d69b-c17b-bc65c2228d11@suse.com>
 <20190607113537.GA13869@rei.lan>
 <7824ed12-432a-4a02-395f-a0a2afbb0134@suse.com>
 <20190607121212.GC13869@rei.lan>
 <619a244a-cb0a-6dd9-fdb4-7c4a2fca6640@suse.de>
Message-ID: <cfb154f3-aa67-d148-208c-4f3cf760904e@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 07/06/2019 14:12, Cyril Hrubis wrote:
>> Hi!
>>>>> yes, I have tested it on a system like you describe but I receive a
>>>>> positive output:
>>>>>
>>>>> tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
>>>>> tst_test.c:1111: INFO: Timeout per run is 0h 05m 00s
>>>>> tst_kconfig.c:62: INFO: Parsing kernel config '/proc/config.gz'
>>>>> acct02.c:159: INFO: Verifying using 'struct acct'
>>>>> acct02.c:137: INFO: Number of accounting file entries tested: 1
>>>>> acct02.c:140: PASS: acct() wrote correct file contents!
>>>>>
>>>>> There seems to be something else going wrong. I will investigate this.
>>>> May be something wrong at my end as well, what kernel versions have you
>>>> tested? At my end I tested 4.20.
>>>>
>>> I have a 4.19 kernel x86_64 machine running and I double checked that I
>>> have the same configs as you have provided.
>>>
>>> Still, I have a hard time reproducing the error.
>> Looks like this is very specific error that happens for me since I have
>> /mnt on my rootfs, it works for any other filesystem I've tried though.
>>
>> I guess that we can go ahead and push the test then.
> Maybe we should investigate this a little more, first. I have managed to
> reproduce the error on two of my systems. Both of them have=C2=A0
> CONFIG_BSD_PROCESS_ACCT_V3 enabled and no rootfs mounts.
>
> Kernel is 4.2 in both cases.
>
> One of them is x86, the other x86_64
>
> Really strange...
>
>
