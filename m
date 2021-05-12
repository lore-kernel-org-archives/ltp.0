From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 12 May 2021 16:17:11 +0200
Subject: [LTP] syscalls/mallinfo01 test is broken
Message-ID: <9d5d4dc9-ab51-7218-23f3-2ec835210fcf@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,
the mallinfo01 test is failing on some of our test machines because it
makes wrong assumptions about how malloc() and free() will change the
number of free chunks (ordblks). I recommend we remove the test from
runfiles before the upcoming release and fix it later because part of
the test scenario needs major redesign.

> tst_test.c:1313: TINFO: Timeout per run is 0h 18m 00s
> mallinfo_common.h:16: TINFO: Start...
> mallinfo_common.h:18: TINFO: arena: 135168
> mallinfo_common.h:19: TINFO: ordblks: 1
> mallinfo_common.h:20: TINFO: smblks: 1
> mallinfo_common.h:21: TINFO: hblks: 0
> mallinfo_common.h:22: TINFO: hblkhd: 0
> mallinfo_common.h:23: TINFO: usmblks: 0
> mallinfo_common.h:24: TINFO: fsmblks: 64
> mallinfo_common.h:25: TINFO: uordblks: 128
> mallinfo_common.h:26: TINFO: fordblks: 135040
> mallinfo_common.h:27: TINFO: keepcost: 134976
> mallinfo_common.h:16: TINFO: Test uordblks...
> mallinfo_common.h:18: TINFO: arena: 135168
> mallinfo_common.h:19: TINFO: ordblks: 2
> mallinfo_common.h:20: TINFO: smblks: 0
> mallinfo_common.h:21: TINFO: hblks: 0
> mallinfo_common.h:22: TINFO: hblkhd: 0
> mallinfo_common.h:23: TINFO: usmblks: 0
> mallinfo_common.h:24: TINFO: fsmblks: 0
> mallinfo_common.h:25: TINFO: uordblks: 34048
> mallinfo_common.h:26: TINFO: fordblks: 101120
> mallinfo_common.h:27: TINFO: keepcost: 101056
> mallinfo01.c:46: TPASS: mallinfo() uordblks passed
> mallinfo_common.h:16: TINFO: Test ordblks...
> mallinfo_common.h:18: TINFO: arena: 135168
> mallinfo_common.h:19: TINFO: ordblks: 3
> mallinfo_common.h:20: TINFO: smblks: 0
> mallinfo_common.h:21: TINFO: hblks: 0
> mallinfo_common.h:22: TINFO: hblkhd: 0
> mallinfo_common.h:23: TINFO: usmblks: 0
> mallinfo_common.h:24: TINFO: fsmblks: 0
> mallinfo_common.h:25: TINFO: uordblks: 32432
> mallinfo_common.h:26: TINFO: fordblks: 102736
> mallinfo_common.h:27: TINFO: keepcost: 101056
> mallinfo01.c:58: TFAIL: mallinfo() ordblks failed
> 
> Summary:
> passed   1
> failed   1
> broken   0
> skipped  0
> warnings 0

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
