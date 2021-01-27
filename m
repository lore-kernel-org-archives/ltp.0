From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 27 Jan 2021 12:46:20 +0100
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
In-Reply-To: <2021012719413722937529@chinatelecom.cn>
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>
 <YBE03REJywKIlM0X@yuki.lan> <2021012718043566596022@chinatelecom.cn>
 <29f6bd4d-bb20-6558-8e23-a29cadc19860@suse.cz>
 <2021012719413722937529@chinatelecom.cn>
Message-ID: <3b9e2152-95ed-ee2a-6b30-180255330188@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27. 01. 21 12:41, liuxp11@chinatelecom.cn wrote:
>     safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
>     now safety margin is 128MB,not 64MB. Right?

Yes, right, sorry.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
