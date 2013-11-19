Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vin7y-0000g9-CD
	for ltp-list@lists.sourceforge.net; Tue, 19 Nov 2013 15:22:10 +0000
Date: Tue, 19 Nov 2013 16:21:46 +0100
From: chrubis@suse.cz
Message-ID: <20131119152145.GB2483@rei.nue.novell.com>
References: <CAKq_7Fq4obzNXmzzS8mE6o=6KyQcV_fc2XEDtQ1=BGgz7vtSRw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKq_7Fq4obzNXmzzS8mE6o=6KyQcV_fc2XEDtQ1=BGgz7vtSRw@mail.gmail.com>
Subject: Re: [LTP] how to cross compile ltp for arm with statically linking?
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
To: yesuraj abraham <yesu4tech@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> ------------------------------------------------------------------------------------------------------------------
> 
> /usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi-gcc -g -O2 -g -O2
> -fno-strict-aliasing -pipe -Wall -D_FORTIFY_SOURCE=2
> -I/home/user/test_apps/ltp/arm/ltp-full-20130904/testcases/kernel/include
> -I../../../../include -I../../../../include -static  -L../../../../lib
> mq_notify01.c   -lltp -lpthread -lrt -o mq_notify01
> 
> ----------------------------------------------------------------------------------------------------------------
> 
> obviously I get the same error, but if I rearrange the pthread linker flag
> at the last as follows
> 
> -----------------------------------------------------------------------------------------------------------------
> 
> /usr/local/arm/arm-2009q3/bin/arm-none-linux-gnueabi-gcc -g -O2 -g -O2
> -fno-strict-aliasing -pipe -Wall -D_FORTIFY_SOURCE=2
> -I/home/user/test_apps/ltp/arm/ltp-full-20130904/testcases/kernel/include
> -I../../../../include -I../../../../include -static  -L../../../../lib
> mq_notify01.c   -lltp -lrt -o mq_notify01 -lpthread
> 
> ---------------------------------------------------------------------------------------------------------------
> 
> The compilation succeeds now

You are hitting a linker order problem here. The -lrt introduces
mq_notify() that uses pthread_once() which is not found in any of the
libraries on the right side after the -lrt. So the right order here is
'-lltp -lrt -lpthread -o mq_notify01'.

You can fix this one with just changing the order in the Makefile in the
corresponding directory. Then retry the compilation, find other
problems, if there are any and fix them one by one. And ideally send a
patch after that :)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
