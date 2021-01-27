From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 27 Jan 2021 10:53:13 +0100
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
In-Reply-To: <YBE03REJywKIlM0X@yuki.lan>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
 <YBE03REJywKIlM0X@yuki.lan>
Message-ID: <a49e7375-e7c6-9915-da23-963a4e534e1f@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

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
