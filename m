From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Wed, 27 Jan 2021 19:41:37 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <YBE03REJywKIlM0X@yuki.lan>, 
 <2021012718043566596022@chinatelecom.cn>, 
 <29f6bd4d-bb20-6558-8e23-a29cadc19860@suse.cz>
Message-ID: <2021012719413722937529@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
now safety margin is 128MB,not 64MB. Right?
 

From: Martin Doucha
Date: 2021-01-27 19:28
To: liuxp11@chinatelecom.cn; Cyril Hrubis
CC: ltp
Subject: Re: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked oom-killer
On 27. 01. 21 11:04, liuxp11@chinatelecom.cn wrote:
> [root@test-env-nm05-compute-14e5e72e38 ~]# cat  /proc/sys/vm/min_free_kbytes
> 90112
 
Yep, there it is. min_free_kbytes is 90MB but we only leave 64MB safety
margin. I'll prepare a patch that'll increase safety margin to
2*min_free_kbytes if needed.
 
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
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/43f122fb/attachment.htm>
