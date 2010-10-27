Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gowrishankar.m@linux.vnet.ibm.com>)
	id 1PB80c-0000df-M5
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 15:33:50 +0000
Received: from e28smtp07.in.ibm.com ([122.248.162.7])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PB80b-0008NF-5P
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 15:33:50 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp07.in.ibm.com (8.14.4/8.13.1) with ESMTP id o9RFXdrL004290
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Oct 2010 21:03:39 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9RFXdds3395652
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Oct 2010 21:03:39 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9RFXdAq007312
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Oct 2010 21:03:39 +0530
Message-ID: <4CC8464F.80605@linux.vnet.ibm.com>
Date: Wed, 27 Oct 2010 21:03:35 +0530
From: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <AANLkTinKu3Kx0FMdgvvG34rc6tcv4Wt5qV1jaAnGzHnv@mail.gmail.com>
In-Reply-To: <AANLkTinKu3Kx0FMdgvvG34rc6tcv4Wt5qV1jaAnGzHnv@mail.gmail.com>
Subject: Re: [LTP] Realtime tests on embedded target
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
To: David Peverley <pev@sketchymonkey.com>
Cc: ltp-list@lists.sourceforge.net

On Wednesday 27 October 2010 06:13 PM, David Peverley wrote:
> Hi all,
>
> I've managed to get to the point where I should be able to run the
> realtime tests on my target but there are a few issues :
>
>    
Hi David,

We have not encountered such issues in our environment.
I usually do:
ltp:> ./configure
ltp:> make
ltp:> cd testcases/realtime
ltp:> make

and run tests either through test_realtime.sh or run.sh in
testcases/realtime/ .

By the way, I am using last stable (atleast for RT) release 
ltp-full-20100630 .

Can you please let us know which version you are trying atm.
Also, can you please check ltp-full-20100630 ?

Thanks,
Gowrishankar
> 1) The run script "testscripts/test_realtime.sh" sources
> "$LTPROOT/testcases/realtime/scripts/setenv.sh" - this isn't copied by
> make install.
>
> 2) After manually copying in, "setenv.sh" sets up paths to use test
> definitions under "$LTPROOT/testcases/realtime/" - these aren't copied
> by make install either.
>
> 3 ) Generally we now have a bit of a pain as various scripts now try
> to invoke "make" - I think this should really only be a build-time
> thing and not part of the test run scritps? Is this actually necessary
> as most embedded targets aren't likely to have local make/gcc! I've
> commented them out for now for initial testing...
>
> 4) After copying in the whole of "testcases/realtime" I run a
> run_auto.sh script (sched_jitter/run_auto.sh) this fails as it's
> looking for the executable in its working dir (I guess where the
> scripts make pass would have put it). However, the previous build and
> make install put all the executables in $LTPROOT/testcases/bin as
> you'd expect.
>
> I'd be happy to address&  submit changes but these are significant
> changes to make so it would make sense to check with stake-holders
> first if anyone's aware or looking at this actively?
>
> Cheers,
>
> ~Pev
>
> ------------------------------------------------------------------------------
> Nokia and AT&T present the 2010 Calling All Innovators-North America contest
> Create new apps&  games for the Nokia N8 for consumers in  U.S. and Canada
> $10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
> Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store
> http://p.sf.net/sfu/nokia-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>    


------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
