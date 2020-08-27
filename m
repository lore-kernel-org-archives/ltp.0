From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Thu, 27 Aug 2020 09:02:32 +0000
Subject: [LTP] cpu.rt_runtime_us parameter
In-Reply-To: <1327942027.10274674.1598512434120.JavaMail.zimbra@redhat.com>
References: <BMXPR01MB234411A56DB8E43D593FD1F8EE540@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>,
 <1327942027.10274674.1598512434120.JavaMail.zimbra@redhat.com>
Message-ID: <BMXPR01MB234405D1265D8DDDF95D22D1EE550@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am running it as root but when i have checked  /sys/fs/cgroup/cpu,cpuacct/system.slice/system-sshd.slice/cpu.rt_runtime_us the default value is 0 and   /proc/sys/kernel/sched_rt_runtime_us is -1.
When i am manually writing into this the test are getting passed but i am not able to understand why these value are set to 0 and -1 resp. by default it should set to 950000 according to kernel documentation.Since /sys is session persistent i am lossing value after restart what changes i should made so that i will retain the value of cat  /proc/sys/kernel/sched_rt_runtime_us as 950000.

Kindly suggest.

Thanks

________________________________
From: Jan Stancek <jstancek@redhat.com>
Sent: Thursday, August 27, 2020 12:43 PM
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc: Li Wang <liwang@redhat.com>
Subject: Re: cpu.rt_runtime_us parameter



----- Original Message -----
> Hi ,
>
> i was checking  kernel.sched_rt_runtime_us from $ cat
> /sys/fs/cgroup/cpu,cpuacct/system.slice/system-sshd.slice/cpu.rt_runtime_us
> which seems to be 0 ,but according to kernel documentation the default
> value of cpu.rt_runtime_us is set 950000 but i am wondering in my case  how
> i am getting it as 0 with linux kernel 5.5.6 i am not able to understand.I
> am running few test which are related to RT and are failing because value of
> cpu.rt_runtime_us is set to 0.

If you're looking help with LTP, you should CC LTP list.

> when i am echoing  $ echo 950000  >
> /sys/fs/cgroup/cpu,cpuacct/system.slice/system-sshd.slice/cpu.rt_runtime_us
> the test are getting passed.
>
> Can you suggest why i am getting the default value cpu.rt_runtime_us as 0
> instead of 950000 ??

Most common cause is that you are not running in root cgroup, or you're missing
kernel config option.

[EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200827/7afea85d/attachment.htm>
