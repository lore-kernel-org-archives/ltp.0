From: Abhishek Dasgupta <a10gupta@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 11:17:12 +0530
Subject: [LTP] How to run individual C testcase file like
 ltp/testcases/kernel/containers/pidns/pidns01.c
In-Reply-To: <20150929122442.GA30371@rei.suse.cz>
References: <5608D654.2010400@linux.vnet.ibm.com>
 <20150929092033.GB24796@rei.suse.cz> <560A7046.70803@linux.vnet.ibm.com>
 <20150929122442.GA30371@rei.suse.cz>
Message-ID: <560B7760.3020106@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thank you Cyril for your reply. It helped me a lot.

On Tuesday 29 September 2015 05:54 PM, Cyril Hrubis wrote:
> Hi!
>> I want to compile and run all the individual testcase (like, pidns01.c
>> from ltp/testcases/kernel/containers/pidns/pidns01.c) only from github
>> source files. If there is any way to do this?
> There is an howto for building LTP from git checkout:
>
> https://github.com/linux-test-project/ltp/blob/master/doc/mini-howto-building-ltp-from-git.txt
>
> All you need is basically:
>
> make autotools
> ./configure --prefix=$PREFIX
> make
>
> Which will create binary for each of the pidns testcases. Then you can just run
> them.
>
> [CC: The LTP mailing list, you should always at least CC it when asking
>   questions about LTP]
>

-- 
   Regards,

   ---------------------------------------------------------------------------------------
   Abhishek Dasgupta
   Linux Software Developer - Linux Technology Centre
   IBM Systems Lab,
   IBM India Pvt. Ltd.
   Embassy Golf Link, D Block
   Koramongala - Off Indiranagar Ring Road
   Bangalore - 560 071
   Mobile: +91-8884107981
   ---------------------------------------------------------------------------------------

