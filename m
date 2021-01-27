From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 27 Jan 2021 12:28:36 +0100
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
In-Reply-To: <2021012718043566596022@chinatelecom.cn>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
 <YBE03REJywKIlM0X@yuki.lan> <2021012718043566596022@chinatelecom.cn>
Message-ID: <29f6bd4d-bb20-6558-8e23-a29cadc19860@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27. 01. 21 11:04, liuxp11@chinatelecom.cn wrote:
> [root@test-env-nm05-compute-14e5e72e38 ~]# cat ?/proc/sys/vm/min_free_kbytes
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
