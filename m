From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Wed, 24 Mar 2021 09:26:53 +0000
Subject: [LTP] kdump failure on x86
In-Reply-To: <cbc294d7-830c-9491-13b1-836be7da043f@jv-coder.de>
References: <BMXPR01MB2870D7110A3D2AD3DF1B495AEE649@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>,
 <cbc294d7-830c-9491-13b1-836be7da043f@jv-coder.de>
Message-ID: <BMXPR01MB28704FBCBB43FA5BE924AF12EE639@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Got it, thanks!

________________________________
From: Joerg Vehlow <lkml@jv-coder.de>
Sent: Wednesday, March 24, 2021 1:57 PM
To: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>; ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] kdump failure on x86

Hi,

On 3/23/2021 3:27 PM, Pankaj Vinodrao Joshi wrote:
> Hi,
> i am trying to run kdump on x86 with 5.5.6 kernel but i am getting
> following errors, can someone please tell whats going wrong here. I
> have lkdtm config in the kernel and installed kexec-tools as well what
> could be the cause of issue ???
It looks like the testcase is hopelessly outdated... The jprobe
interface was removed in linux 4.15 back in 2017 [1]
The tests needs a major rewrite, to work on kernels newer than 4.15.

J?rg


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=590c845930457d25d27dc1fdd964a1ce18ef2d7d
[EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210324/96084398/attachment-0001.htm>
