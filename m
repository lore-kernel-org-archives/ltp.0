From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 23 Apr 2020 14:06:13 +0800
Subject: [LTP] [PATCH v2 09/10] syscalls/ioctl_loop07: Add dio with
 logic block size error test
In-Reply-To: <20200422135856.GB5529@yuki.lan>
References: <20200409075506.GA2828@yuki.lan>
 <1586429086-22975-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1586429086-22975-9-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200422135856.GB5529@yuki.lan>
Message-ID: <124d3b91-2025-d36e-f3b1-6c0b5528ae51@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
> This test fails for me, i.e. the attempt to enabe direct IO succeeds. I
> will have to have a closer look later on.
Now, I use 5.7.0-rc2 kernel to test, this case fails, I guess loop 
driver has changed its logic. I am trying.

ps: when run ioctl_loop01.c, I also met another problem that 
/dev/loop0p1 and  the corresponding sys file doesn't existed. dmesg 
report error "loop_reread_partitions: partition scan of loop0 () failed 
(rc=-16)". Also trying .
> 


