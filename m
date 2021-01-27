From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Wed, 27 Jan 2021 18:07:48 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <YBE03REJywKIlM0X@yuki.lan>, 
 <a49e7375-e7c6-9915-da23-963a4e534e1f@suse.cz>
Message-ID: <2021012718074776349323@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[root@test-env-nm05-compute-14e5e72e38 ~]# w
 18:05:00 up 15 days,  1:06,  3 users,  load average: 0.39, 0.42, 0.47

 
From: Martin Doucha
Date: 2021-01-27 17:53
To: Cyril Hrubis; Xinpeng Liu
CC: ltp
Subject: Re: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked oom-killer
On 27. 01. 21 10:39, Cyril Hrubis wrote:
> Hi!
>> MemTotal:       198101744 kB
>> MemFree:        189303148 kB
>> MemAvailable:   188566732 kB
> 
> This sounds really strange, usually MemFree is smaller than MemAvailable
> since MemFree does not include page cache.
> 
> Is this freshly booted system?
> 
> Can you send the whole meminfo here please?
 
Please also send the contents of /proc/sys/vm/min_free_kbytes. I suspect
that that's where the OOM issues are actually coming from.
 
-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/437569b4/attachment.htm>
