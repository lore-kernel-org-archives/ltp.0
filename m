From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 15 Mar 2018 09:14:49 -0400 (EDT)
Subject: [LTP] SIGSEGV in faccessat01 and fchmodat01
In-Reply-To: <BY2PR13MB0709FB070D6A4AC6FEEE5DD990D00@BY2PR13MB0709.namprd13.prod.outlook.com>
References: <BY2PR13MB070967D607D2E7F4F797189A90D10@BY2PR13MB0709.namprd13.prod.outlook.com>
 <20180315115518.GB17877@rei>
 <BY2PR13MB0709FB070D6A4AC6FEEE5DD990D00@BY2PR13MB0709.namprd13.prod.outlook.com>
Message-ID: <394159771.7727664.1521119689058.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 
> 
> Hi

> Here is the result from gdb
> seems like it is getting really deep
> 
> 
> 
> (gdb) r
> Starting program: /opt/ltp/testcases/bin/fchmodat01
> 
> Program received signal SIGSEGV, Segmentation fault.
> strlen () at ../sysdeps/arm/strlen.S:33
> 33 sfi_breg r1, \
> (gdb)

Please send the backtrace as well. Type "bt" and hit enter in gdb
after it crashes.

What distro/kernel/LTP version are you using?

Regards,
Jan
