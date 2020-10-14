From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 14 Oct 2020 22:35:24 +0800
Subject: [LTP] [PATCH] Add test for send(MSG_MORE)
In-Reply-To: <bdafce94-0c61-bee5-d8cb-5f6fe638bd89@suse.cz>
References: <20200828151747.21445-1-mdoucha@suse.cz>
 <20200903155030.GA23664@dell5510> <5F84042B.9000505@cn.fujitsu.com>
 <bdafce94-0c61-bee5-d8cb-5f6fe638bd89@suse.cz>
Message-ID: <5F870CAC.4050404@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin
> On 12. 10. 20 9:22, Yang Xu wrote:
>> I test this case on centos8.2, it failed, but it passed on centos7.8 and
>> fedora31. On upstream kernel (5.9-rc7+,commit 6f2f486d57c4,using kvm,4G
>> memory,2 cpus), it also failed. I don't know whether it has some kernel
>> parameters or kconfig to affect this. It seems not a kernel bug and like
>> a environment bug(I guess).
>>
>> tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
>> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> We have some similar failures on old s390 kernels (v4.4). I can't
> reproduce any failures at all on our 4.12 and 5.3 kernels.
I try 5.7,5.8 and lastest upstream, it all failed. I didn't figure out 
the reason.
> Can you add some debug prints and check whether it fails on the first
> iteration or after a few successful loops?
It fails after a few successful loops in internal(not using -i 
parameters), and when I lower
the loops into 100, tcp and udp (using send) may succeed
--- a/testcases/kernel/syscalls/send/send02.c
+++ b/testcases/kernel/syscalls/send/send02.c
@@ -129,7 +129,7 @@ static void run(unsigned int n)
         if (tc->needs_accept)
                 SAFE_LISTEN(listen_sock, 1);

-       for (i = 0; i < 1000; i++) {
+       for (i = 0; i < 100; i++) {

./send02
tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
send02.c:166: TPASS: TCP send(MSG_MORE) works correctly
send02.c:166: TPASS: UDP send(MSG_MORE) works correctly
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)


>   Also, do you have any test
> runs where the TCP test case succeeded?
>
Yes, tcp test sometimes succeeded.

ps: I think we can send a patch to  print more output in this case, so 
we know which case fails(tcp,udp, send?or sendto, sendmsg
).

Best Regards
Yang Xu


