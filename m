From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 12 Oct 2020 15:22:19 +0800
Subject: [LTP] [PATCH] Add test for send(MSG_MORE)
In-Reply-To: <20200903155030.GA23664@dell5510>
References: <20200828151747.21445-1-mdoucha@suse.cz>
 <20200903155030.GA23664@dell5510>
Message-ID: <5F84042B.9000505@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin, Peter
> Hi Martin,
>
>> The setsockopt05 test will not work properly if kernel handles the MSG_MORE
>> flag incorrectly. Add a new test to detect broken test environment.
>
> Thanks for your patch, merged.
I test this case on centos8.2, it failed, but it passed on centos7.8 and 
fedora31. On upstream kernel (5.9-rc7+,commit 6f2f486d57c4,using kvm,4G 
memory,2 cpus), it also failed. I don't know whether it has some kernel 
parameters or kconfig to affect this. It seems not a kernel bug and like 
a environment bug(I guess).

tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
send02.c:86: TFAIL: recv() error: EAGAIN/EWOULDBLOCK (11)


Best Regards
Yang  Xu
>
> Kind regards,
> Petr
>



