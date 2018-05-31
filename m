From: DOAN MINH HUNG <minhhung290196@gmail.com>
Date: Thu, 31 May 2018 11:12:20 +0700
Subject: [LTP] Fwd: Fail on memory.usage_in_bytes
In-Reply-To: <a8645c9f1bba42cc979489057ba494e0@vn.bosch.com>
References: <a8645c9f1bba42cc979489057ba494e0@vn.bosch.com>
Message-ID: <CALp2AuVhOB+eMuVSnWhVt6ZTopHmHHr2XNTBQz_k+T0tOM85eQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

---------- Forwarded message ---------
From: FIXED-TERM Doan Minh Hung (RBVH/ENG22) <
fixed-term.Hung.DoanMinh@vn.bosch.com>
Date: Thu, 31 May 2018 at 11.10 AM
Subject: Fail on memory.usage_in_bytes
To: minhhung290196@gmail.com <minhhung290196@gmail.com>


Hello,

My name is Hung Doan and I have worked on some LTP tests about Cgroup
memory recently. I’m writing this email to inform an issue from the test
case named memcg_usage_in_bytes_test.

The test case creates a cgroup and checks whether
memory.usage_in_bytes == memory.stat (rss value).

The test mostly passes but sometimes it gets fail, here is the log:





*memcg_usage_in_bytes_test 1 TINFO: Starting test 1
memcg_usage_in_bytes_test 1 TINFO: Running memcg_process --mmap-anon -s
4194304 memcg_usage_in_bytes_test 1 TINFO: Warming up pid: 1583
memcg_usage_in_bytes_test 1 TINFO: Process is still here after warm up:
1583 memcg_usage_in_bytes_test 1 TFAIL: memory.usage_in_bytes is 4325376,
4194304 expected*

Let’s check from a fail case of the test:


































*root@mx6q:~# cat /dev/memcg/1/memory.{usage_in_bytes,stat} 4325376 cache 0
rss 4194304 rss_huge 0 mapped_file 0 writeback 0 swap 0 pgpgin 1024 pgpgout
0 pgfault 1024 pgmajfault 0 inactive_anon 0 active_anon 4194304
inactive_file 0 active_file 0 unevictable 0 hierarchical_memory_limit
18446744073709551615 hierarchical_memsw_limit 18446744073709551615
total_cache 0 total_rss 4194304 total_rss_huge 0 total_mapped_file 0
total_writeback 0 total_swap 0 total_pgpgin 1024 total_pgpgout 0
total_pgfault 1024 total_pgmajfault 0 total_inactive_anon 0
total_active_anon 4194304 total_inactive_file 0 total_active_file 0
total_unevictable 0*

As you can see, the value of memory.usage_in_bytes (4325376) is bigger than
the sum of RSS, CACHE and SWAP (4194304), which is the value the test case
is expecting. The test case can’t correct 100% because RSS + CACHE + SWAP
<= usage_in_bytes.

As I check in a reliable documentation, the memory.usage_in_bytes doesn't
show the exact value of memory (and swap) usage. If you want to know more
exact memory usage, you should use RSS+CACHE(+SWAP) value in memory.stat.

The reason of this is that a cgroup might have some charge associated with
it. Even though all tasks have migrated away from it, file caches can exist
as charge, the charge is dropped when the page is reclaimed. However,
reclaim only occurs when the memory.limit_in_byte is hit, but the test case
doesn’t set this limit so that this limit is very big while testing.

Suggested solution for LTP:

   - Set the memory.limit_in_bytes and memory.memsw.limit_in_bytes equal to
   the size of a process created (PAGESIZE*1024) before running the test. At a
   result, when new process created, the charges will be reclaimed so that the
   limit can't be hit. I tried it and fail cases didn't show up anymore.

Reference: https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180531/4c3f8ef0/attachment.html>
