From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Nov 2017 12:59:09 +0800
Subject: [LTP] <Failling_on_memcg_usage_in_bytes_test.sh>
In-Reply-To: <CAPiF6Th1sDgRJH2bFb3jX-cBJNVO0s4zmMSH3ezifK7Y9nQCWw@mail.gmail.com>
References: <CAPiF6Th1sDgRJH2bFb3jX-cBJNVO0s4zmMSH3ezifK7Y9nQCWw@mail.gmail.com>
Message-ID: <CAEemH2c08B6QaXuqV=a3FT8V6O-yd8WPqR4=d+yME6iubF70Xw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, Nov 22, 2017 at 1:10 AM, Na Nha <minhnhan0801@gmail.com> wrote:
> Hello LTP team,
>
>
>
> There is an issue as below when I ran “./memcg_usage_in_bytes_test.sh” on my
> ARM board
>
>
>
> mx6q:/opt/ltp/testcases/bin# ./memcg_usage_in_bytes_test.sh
>
> memcg_usage_in_bytes_test 1 TINFO: Starting test 1
>
> memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s
> 4194304
>
> memcg_usage_in_bytes_test 1 TINFO: Warming up pid: 19889
>
> memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up:
> 19889
>
> memcg_usage_in_bytes_test 1 TPASS: memory.usage_in_bytes is 4194304 as
> expected
>
> memcg_usage_in_bytes_test 2 TINFO: Starting test 2
>
> memcg_usage_in_bytes_test 2 TINFO: Running memcg_process --mmap-anon -s
> 4194304
>
> memcg_usage_in_bytes_test 2 TINFO: Warming up pid: 19909
>
> memcg_usage_in_bytes_test 2 TINFO: Process is still here after warm up:
> 19909
>
> memcg_usage_in_bytes_test 2 TFAIL: memory.memsw.usage_in_bytes is 4325376,
> 4194304 expected
>

Did you see any other write errors during the test?
such as:
/opt/ltp/testcases/bin/memcg_lib.sh: line 514: echo: write error:
Device or resource busy


If so, that's probably because the 'memory.use_hierarchy' value is not '0' on
your ARM board, or memcg_lib.sh failed to set it to '0' at the beginning.
AFAIK, if current cgroup directory is not cleanning(include any other
directory),
that would be always failed to set memory.use_hierarchy with device busy return.

Something like:
# mount -t cgroup -omemory memcg /dev/memcg/
# mkdir -p /dev/memcg/ltp-test
# echo 0 >/dev/memcg/memory.use_hierarchy
-bash: echo: write error: Device or resource busy

Regards,
Li Wang

>
>
> It is a dangling falling, sometimes the test result is pass and sometimes is
> fail
>
>
>
> My kernel is
>
> root@mx6q:/dev/shm# uname -a
>
> Linux mx6q 3.14.79-01214-g76b5fd377784 #1 SMP PREEMPT Wed Nov 15 17:06:37
> CET 2017 armv7l GNU/Linux
>
>
>
> Could you please help me to resolve the problem?
>
>
>
> I look forward any reply.
>
>
>
> Thanks / Best regards,
>
> Nhan Le Minh
>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
