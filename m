Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NUN2Q-00033n-Mq
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 16:22:42 +0000
Date: Mon, 11 Jan 2010 17:22:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100111162256.GB19010@saboteur.suse.cz>
References: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d270b4400912250122y371c4d4dq6fa729b60e03f8a5@mail.gmail.com>
Subject: Re: [LTP] Testcase to validate the memory usage limit imposed by
 the topmost memory cgroup
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
To: Mohamed Naufal <naufal11@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!

> /*
> sigusr1: allocate/free memory on receving SIGUSR1
> */
> void sigusr1(int num) {
>   mem_map();
>   flag_allocated = !flag_allocated;
> }
> 
> int main(int argc, char **argv) {
>   signal(SIGINT, sigint);
>   signal(SIGUSR1, sigusr1);
> 
>   process_options(argc, argv);
> 
>   while(!flag_exit)
>     sleep(1);
> 
>   return 0;
> }


You can't allocate memory from signal handler. There is a list of signal safe
functions in 'man 7 signal'. The correct solution for this is to create
something like named pipe and sleep in read() on it (instead of
'while(!flag_exit) sleep(1)').

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
