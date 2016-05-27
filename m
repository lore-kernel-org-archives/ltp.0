From: Dong ZHu <bluezhudong@gmail.com>
Date: Fri, 27 May 2016 17:36:23 +0800
Subject: [LTP] memcg_memsw_limit_in_bytes_test mlock failed: Resource
	temporarily unavailable
Message-ID: <CAAUgArDNuD89q3dFLxqwjMi-6opiggZhWo_oEL9qUNUxcxCkrA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I ran LTP test "memcg_memsw_limit_in_bytes_test" with kernel 3.10.0-327.el7
always reported the below error:

memcg_memsw_limit_in_bytes_test 2 TFAIL : ltpapicmd.c:193: process 3769 is
killed by error /opt/ltp/testcases/bin/memcg_lib.sh: line 210: 3784 Killed
$TEST_PATH/memcg_process $2 -s $3

In function mmap_lock2() mlock failed just return 1, not the oom killer
kill the process.
And base on the this:
http://marc.info/?l=linux-mm&m=142122902313315&w=2

I think mlock failed it is a expect behavior, so why mask the test as
Failed ?

Thanks !

-- 
Best Regards,
Dong Zhu

My Site: http://bluezd.info
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160527/bd8c874b/attachment.html>
