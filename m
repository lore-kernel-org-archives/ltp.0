From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Wed, 29 Mar 2017 01:06:48 +0000 (UTC)
Subject: [LTP] memcg_usage_in_bytes sometimes failed
In-Reply-To: <20170328134152.GG1045@rei>
References: <260795063.109541.1490150682697.ref@mail.yahoo.com>
 <260795063.109541.1490150682697@mail.yahoo.com> <20170328134152.GG1045@rei>
Message-ID: <1081797821.5060375.1490749608376@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Cyril,
memcg_usage_in_bytes_test.sh is not changed for long time, so I think I alm=
ost used the latest version of LTP
I resend the log, some EOL issue when I send it with my phone. Sorry for in=
convenience.
Test:memcg_usage_in_bytes Testparm:memcg_usage_in_bytes_test.sh
memcg_usage_in_bytes_test 1 TINFO: Starting test1
memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s4194=
304
memcg_usage_in_bytes_test 1 TINFO: Warming up pid:886
memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up:886
memcg_usage_in_bytes_test 1 TPASS: memory.usage_in_bytes is 4194304 asexpec=
ted
/opt/ltp/testcases/bin/memcg_lib.sh: line 477: echo: write error: Device or=
resource busy
memcg_usage_in_bytes_test 2 TINFO: restore=C2=A0/dev/memcg/memory.use_hiera=
rchy failed
memcg_usage_in_bytes_test 2 TINFO: Starting test2
memcg_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s4194=
304
memcg_usage_in_bytes_test 2 TINFO: Warming up pid:906
memcg_usage_in_bytes_test 2 TINFO: Process is still here after warm up:906
memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is 4325376, =
4194304expected
Result: 1
Best regards,
Hoang

      From: Cyril Hrubis <chrubis@suse.cz>
 To: Hoang Nguyen <the_hoang0709@yahoo.com>=20
Cc: LTP List <ltp@lists.linux.it>
 Sent: Tuesday, 28 March 2017, 20:44
 Subject: Re: [LTP] memcg_usage_in_bytes sometimes failed
  =20
Hi!
> I rarely meet this issue on embedded system, armv7l kernel 3.14, but not =
sure what's going wrong. It can pass on some boards, but fail sometimes on =
others with same config.
> Is there any aditional preparation to make this case always pass? Have an=
yone experienced on this ?
> Test: memcg_usage_in_bytes Testparm: memcg_usage_in_bytes_test.shmemcg_us=
age_in_bytes_test 1 TINFO: Starting test 1memcg_usage_in_bytes_test 1 TINFO=
: Running memcg_process --mmap-anon -s 4194304memcg_usage_in_bytes_test 1 T=
INFO: Warming up pid: 886memcg_usage_in_bytes_test 1 TINFO: Process is stil=
l here after warm up: 886memcg_usage_in_bytes_test 1 TPASS: memory.usage_in=
_bytes is 4194304 as expected/opt/ltp/testcases/bin/memcg_lib.sh: line 477:=
 echo: write error: Device or resource busymemcg_usage_in_bytes_test 2 TINF=
O: restore ??/dev/memcg/memory.use_hierarchy failedmemcg_usage_in_bytes_tes=
t 2 TINFO: Starting test 2memcg_usage_in_bytes_test 2 TINFO: Running memcg_=
process --mmap-anon -s 4194304memcg_usage_in_bytes_test 2 TINFO: Warming up=
 pid: 906memcg_usage_in_bytes_test 2 TINFO: Process is still here after war=
m up: 906memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is =
4325376, 4194304 expectedResult: 1

First of all, which LTP version are you using?

Also please resend the log so that the text is not on a single line.
It's nearly impossible to read it as it is.

--=20
Cyril Hrubis
chrubis@suse.cz


  =20
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20170329/8ef3a1a3/att=
achment-0001.html>
