From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Mar 2018 14:13:21 +0100
Subject: [LTP] SIGSEGV in faccessat01 and fchmodat01
In-Reply-To: <BY2PR13MB0709FB070D6A4AC6FEEE5DD990D00@BY2PR13MB0709.namprd13.prod.outlook.com>
References: <BY2PR13MB070967D607D2E7F4F797189A90D10@BY2PR13MB0709.namprd13.prod.outlook.com>
 <20180315115518.GB17877@rei>
 <BY2PR13MB0709FB070D6A4AC6FEEE5DD990D00@BY2PR13MB0709.namprd13.prod.outlook.com>
Message-ID: <20180315131321.GA31701@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Here is the result from gdb
> 
> seems like it is getting really deep
> 
> (gdb) r
> Starting program: /opt/ltp/testcases/bin/fchmodat01
> 
> Program received signal SIGSEGV, Segmentation fault.
> strlen () at ../sysdeps/arm/strlen.S:33
> 33              sfi_breg r1, \
> (gdb)

What about the backtrace (bt), does it show the call trace?

However this looks rather suspicious, possibly something is wrong with
glibc there.

-- 
Cyril Hrubis
chrubis@suse.cz
