From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Apr 2021 12:37:24 +0200
Subject: [LTP] kdump failure on x86
In-Reply-To: <cbc294d7-830c-9491-13b1-836be7da043f@jv-coder.de>
References: <BMXPR01MB2870D7110A3D2AD3DF1B495AEE649@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
 <cbc294d7-830c-9491-13b1-836be7da043f@jv-coder.de>
Message-ID: <YG7c5EIgBPyXHy20@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > i am trying to run kdump on x86 with 5.5.6 kernel but i am getting 
> > following errors, can someone please tell whats going wrong here. I 
> > have lkdtm config in the kernel and installed kexec-tools as well what 
> > could be the cause of issue ???
> It looks like the testcase is hopelessly outdated... The jprobe 
> interface was removed in linux 4.15 back in 2017 [1]
> The tests needs a major rewrite, to work on kernels newer than 4.15.

I unless anybody wants to invest time into the rewrite we can remove
these as well.

-- 
Cyril Hrubis
chrubis@suse.cz
