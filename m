From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Nov 2017 17:19:37 +0300
Subject: [LTP] Failling_Zram01&Zram02_LTP_testsuite
In-Reply-To: <CAPiF6TiCjTVGNYH9EDkMFuVKvM-=qscQ0J4d-S8mfxi1-iA8Nw@mail.gmail.com>
References: <CAPiF6TiCjTVGNYH9EDkMFuVKvM-=qscQ0J4d-S8mfxi1-iA8Nw@mail.gmail.com>
Message-ID: <079ad8f2-940f-ea8e-db47-31df346a90af@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/10/2017 08:14 PM, Na Nha wrote:
> Nice to meet you all.
> My name's Nhan. I am using some LTP test cases
>
> I faced 2 problems when running testcase "zram01.sh" & "zram02.sh" on
> my 32-bit ARM board.
>
> - First is regarding *Zram01*:
>
> My target is using a optimized version of dd command.
> In this testcase it use below command:
> " dd conv=notrunc if=/dev/zero of=zram${i}/file oflag=append count=1
> bs=1024 status=none > /dev/null 2>&1 || break "
>
>  However , my "dd --help" output:
>
> /BusyBox v1.24.1 (2017-09-26 20:41:13 CEST) multi-call binary.
> Usage: dd [if=FILE] [of=FILE] [bs=N] [count=N] [skip=N]
> [seek=N]
> Copy a file with converting and formatting
> if=FILE Read from FILE instead of stdin
> of=FILE Write to FILE instead of stdout
> bs=N Read and write N bytes at a time
> count=N Copy only N input blocks
> skip=N Skip N input blocks
> seek=N Skip N output blocks
> N may be suffixed by c (1), w (2), b (512), kB (1000), k (1024), MB,
> M, GB, G/
>
> So I don't have conv, oflag & status" arguments for dd command
> Therefore, when I run "zram01.sh", it is failed
> But when I remove those argument, it is passed.
> Can I remove those arguments. Dose it make sense, still keep the
> meaning of this test case?


We could remove "status=none" since it is redirected to /dev/null
anyway. But the other flags change the test-case. File size in
the test-case incremented by 1KB on each iteration. If you remove
oflag & conv, it always be 1KB, I wonder why it had passed for you
if the flags removed, instead, it should have stuck in the while
loop...

Could you try changing it to the following command that keeps
the test-case:

dd if=/dev/zero count=1 bs=4KB >> zram${i}/file 2>/dev/null || break

or

head -c 1024 /dev/zero >> zram${i}/file 2>/dev/null || break


> - Second is regarding *Zram02*:
> This is the output when I execute this test:
>
> /root@arm:/opt/ltp/testcases/bin# ./zram02.sh
> zram02 1 TINFO: create '1' zram device(s)
> zram02 1 TPASS: test succeeded
> zram02 2 TCONF: The device attribute max_comp_streams was introduced
> in kernel 3.15 and deprecated in 4.7
> zram02 2 TINFO: set disk size to zram device(s)
> /opt/ltp/testcases/bin/zram_lib.sh: line 121: echo: write error:
> Cannot allocate memory
> zram02 2 TFAIL: can't set '107374182400' to /sys/block/zram0/disksize
> zram02 3 TINFO: zram cleanup
> /

Do you have any error message in dmesg? looks like it failed on
allocating zram address table...

>
> I think this testcase is not the kind of Stress test, so we don't need
> to configure disksize of zram with such 100GB (it is so large).
> We only need to confirm that we can configure disksize.
>
> So I think 10GB is fine , Is it OK?

Looks fine.

Thanks,
Alexey
