From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 17 Aug 2020 10:30:34 +0200
Subject: [LTP] [PATCH] Drop the mem01 test
In-Reply-To: <462582af-8a13-e5c1-a8f7-63a7e03571c7@cn.fujitsu.com>
References: <20200806162356.16920-1-mdoucha@suse.cz>
 <752669298.7180757.1597047872449.JavaMail.zimbra@redhat.com>
 <CAEemH2cCq1LL_91pOavNWHmHGQs6EfFsyGXaOBuqh-CrFxP7Pg@mail.gmail.com>
 <462582af-8a13-e5c1-a8f7-63a7e03571c7@cn.fujitsu.com>
Message-ID: <32f57d39-a38d-69d0-6c38-6856fd83ca35@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17. 08. 20 5:46, Yang Xu wrote:
> [root@localhost ltp]# git grep mem01
> testcases/kernel/syscalls/ioctl/ioctl_sg01.c: * a read-accessible
> SCSI-compatible device (e.g. SATA disk). Running mem01
> [root@localhost ltp]#
> 
> ioctl_sg01.c has such description " Running mem01
> ?* test program before this one may increase the chance of successfully
> ?* reproducing the bug."
> 
> I guess we should also remove this or use oom testcases can also
> increase this rate(I don't try ).

OOM testcases will work fine. ioctl_sg01 is a CVE test checking for
kernel information disclosure bug so it just needs the kernel to reuse
some dirty block of memory for the device buffer that then gets copied
to userspace.

Maybe I should improve the test by dirtying some kernel memory myself in
the test setup...

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
