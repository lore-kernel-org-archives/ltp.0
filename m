From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 14 Oct 2020 15:47:40 +0200
Subject: [LTP] [PATCH] Add test for send(MSG_MORE)
In-Reply-To: <5F84042B.9000505@cn.fujitsu.com>
References: <20200828151747.21445-1-mdoucha@suse.cz>
 <20200903155030.GA23664@dell5510> <5F84042B.9000505@cn.fujitsu.com>
Message-ID: <bdafce94-0c61-bee5-d8cb-5f6fe638bd89@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12. 10. 20 9:22, Yang Xu wrote:
> I test this case on centos8.2, it failed, but it passed on centos7.8 and
> fedora31. On upstream kernel (5.9-rc7+,commit 6f2f486d57c4,using kvm,4G
> memory,2 cpus), it also failed. I don't know whether it has some kernel
> parameters or kconfig to affect this. It seems not a kernel bug and like
> a environment bug(I guess).
> 
> tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
> send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)

We have some similar failures on old s390 kernels (v4.4). I can't
reproduce any failures at all on our 4.12 and 5.3 kernels.

Can you add some debug prints and check whether it fails on the first
iteration or after a few successful loops? Also, do you have any test
runs where the TCP test case succeeded?

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
