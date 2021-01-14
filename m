From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 14 Jan 2021 15:14:44 +0100
Subject: [LTP] Holidays and LTP release
In-Reply-To: <CA+G9fYv1UFr+7ePC7tLjCY4JPsoQdBdf-6Jpr40zmsoYRWVrdQ@mail.gmail.com>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
 <20210113095724.214c904a@kmaincent-XPS-13-7390>
 <CA+G9fYv1UFr+7ePC7tLjCY4JPsoQdBdf-6Jpr40zmsoYRWVrdQ@mail.gmail.com>
Message-ID: <db866679-a5e8-35d6-f57a-18a202c7937b@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14. 01. 21 12:12, Naresh Kamboju wrote:
> on x86_64:
> The ioctl_sg01 test killed and reported failed.
> 
> tst_test.c:1263: TINFO: Timeout per run is 0h 15m 00s
> ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
> [  332.383394] ioctl_sg01 invoked oom-killer:

Looks like the safety margin in tst_pollute_memory() is too small. Edit
lib/tst_memutils.c and try setting the "safety" variable on line 23 to a
higher value. I'd recommend something like MAX(4096 pages, 64MB).

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
