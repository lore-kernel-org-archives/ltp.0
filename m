Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4CHu-0005NQ-I1
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 15:56:38 +0000
Date: Tue, 30 Jul 2013 17:56:23 +0200
From: chrubis@suse.cz
Message-ID: <20130730155622.GA1999@rei.scz.novell.com>
References: <CADyrn+t16kR9FAfQSYUB2aYJej1BEFFZcLwUzDi0nKAjHyZ6Rw@mail.gmail.com>
	<20130716122924.GA21078@rei>
	<CADyrn+vPD7d4o4F4r7HayBJ-Q9iKL4HefbUxkcJVik8yb80o7w@mail.gmail.com>
	<20130717135735.GA27308@rei>
	<CADyrn+sgQJL+0NOFp3GW78LoqmKG1szFbu+C14Dk8SZgu=fe2Q@mail.gmail.com>
	<CADyrn+s2BjHFhT5BnHSHOzQmyqyEf=bofjj+6E-oKhp9OyGohA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADyrn+s2BjHFhT5BnHSHOzQmyqyEf=bofjj+6E-oKhp9OyGohA@mail.gmail.com>
Subject: Re: [LTP] [mtest01w] mtest01w test hangs
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
To: SHASHANK BILGI <shashank192@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> In my case 2 child processes from mtest01w try to allocate 1GB each and
> third one allocates around 100 MB.
> Both of the first 2 child processes throws this error "errno=ENOMEM(12):
> Cannot allocate memory" around 700MB. And third successfully finishes its
> job.
> Here are some details.
> * Actual physical memory: 80MB
> * Swap space is 2GB
> * /proc/sys/vm/overcommit_memory is 1
> * /proc/sys/vm/overcommit_ratio is 50
> 
> Can somebody please tell me why this might be happening?

Hmm, are you aware that in this case you RAM + SWAP is lesser than the
memory the program is trying to allocate, which will not work no matter
what.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
