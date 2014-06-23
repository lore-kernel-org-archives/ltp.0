Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wz2n0-0001j4-1X
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 11:51:58 +0000
Date: Mon, 23 Jun 2014 13:51:41 +0200
From: chrubis@suse.cz
Message-ID: <20140623115141.GA6050@rei.Home>
References: <7CF842D49929104A9E5360C8FA9370998CF0D0@POCITMSEXMB03.LntUniverse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7CF842D49929104A9E5360C8FA9370998CF0D0@POCITMSEXMB03.LntUniverse.com>
Subject: Re: [LTP] fstatfs02 issue on mips64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Ajoymon Joseph <AJOY.JOSEPH@LNTTECHSERVICES.COM>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I am testing mips64 with LTP.  The problem is with fstatfs02.c file.
> The test case was failing in my particular arch. For debugging purpose
> I write the same code and executed.
>
> ret = fstatfs( -1,&buf );
> printf("Retrun value =%d, errornumber %d EBADF is %d  %s FD %d pointer %p  \n",ret,errno, EBADF,strerror(errno),-1,&buf);
> 
> it was giving a output like
> 
> Retrun value =-1, errornumber 9 EBADF is 9  Bad file descriptor FD -1 pointer 0x120011130
> 
> But when I executed LTP testcase with some debug print added
> 
> TEST(fstatfs(TC[i].fd, (TC[i]).sbuf));
> if (TEST_RETURN != -1) {
>         tst_resm(TFAIL, "call succeeded unexpectedly return %d %s FD %d, pointer sbuf %p ",TEST_RETURN,strerror(errno),TC[i].fd, TC[i].sbuf);
> 
> I got a print like this
> 
> fstatfs02    1  TFAIL  :  call succeeded unexpectedly return 1690729072 Success FD -1, pointer sbuf 0x12001ba30
> 
> 
> I feel like both are doing the same job... But when I am running it in
> LTP environment I am getting a return as 1690729072. I was not able to
> find any problem in TEST macro. Can anyone please help me out in
> debugging this.

Hmm, that looks like the return value from fstatfs() gets corrupted
before it gets to the if () below. However the code of the TEST() macro
looks too simple for that to happen.

The lines gets expaned (with compiler -E) to:

   do { (*__errno_location ()) = 0; TEST_RETURN = fstatfs(TC[i].fd, TC[i].sbuf); TEST_ERRNO = (*__errno_location ()); } while (0);

   if (TEST_RETURN != -1) {
    tst_resm(1, "call succeeded unexpectedly");
    continue;
   }

Which, as far as I can see, looks correct.

Assuming that the fstatfs() really returns -1 here (have you tried
strace on the testcase?) the only problem I can think of is that the
code gets miscompiled and the value is corrupted in the TEST_RETURN =
fstatfs(TC[i].fd, TC[i].sbuf) part. I would check the disassembly to
make sure that it does what is expected.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
