Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ntch0-0001eT-3G
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 08:08:58 +0000
Received: from mail-iw0-f195.google.com ([209.85.223.195])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ntcgz-0002ZL-7e
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 08:08:58 +0000
Received: by iwn33 with SMTP id 33so4138169iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Mar 2010 01:08:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b9d696241003212215y57070683g828dd982d2366872@mail.gmail.com>
References: <b9d696241003212215y57070683g828dd982d2366872@mail.gmail.com>
Date: Mon, 22 Mar 2010 01:08:51 -0700
Message-ID: <364299f41003220108s203f9fcahe5627d156e490744@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] memcg_stress_test.sh hanging system
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Sun, Mar 21, 2010 at 10:15 PM, K.D. Lucas <kdlucas@gmail.com> wrote:
> I just downloaded the latest LTP, ltp-full-20100228.1
>
> I'm running it on Linux Mint Helena x64 Edition.
> Kernel: 2.6.31-14-generic x86_64
>
> I installed it by running:
>
> ./configure
> make
> sudo make install
>
> My entire system just hangs when it gets to the memcg_stress_test.sh test.
>
> I'm running this on an HP Z600 with 12 gb ram and 2 Intel Xeon E5520 2.27
> ghz cpus. These are quad core CPUs with HyperThreading.
>
> What I see in /var/log/syslog is:
>
> Mar 21 20:09:14 daredevil kernel: [17277.016792] Memory cgroup out of
> memory: kill process 28223 (memcg_process) score 99 or a child
> Mar 21 20:09:14 daredevil kernel: [17277.016836] Killed process 28223
> (memcg_process)
>
> Is anyone else seeing this?

    +1 with Ubuntu Karmic Koala and an amd64 machine with 8GB of RAM.
Thanks,
-Garrett

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
