Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WPaVb-0005lk-Kc
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 16:35:27 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WPaVZ-0007b2-Jo
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 16:35:27 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Mon, 17 Mar 2014 16:35:18 +0000
Message-ID: <0247700D01F14443B9209F90AD938CC524366845@sestoex05.enea.se>
References: <531DC318.7060504@gmail.com>,<7hsiqlkawz.fsf@paris.lan>
In-Reply-To: <7hsiqlkawz.fsf@paris.lan>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Testing absence of ticks with nohz_full
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
To: Kevin Hilman <khilman@linaro.org>, Mats Liljegren <liljegren.mats2@gmail.com>
Cc: Linux Test Project General Discussions <ltp-list@lists.sourceforge.net>, Frederic Weisbecker <fweisbec@gmail.com>

Thanks for the script!

I was thinking about using stress as load both on the non-isolated CPUs as well as for the isolated CPUs. I intend to use "--io" and "--vm" for non-isolated part, and "--cpu" for the isolated. This should provoke the system a little bit at least.

Regards
Mats Liljegren
________________________________________
From: Kevin Hilman [khilman@linaro.org]
Sent: Thursday, March 13, 2014 11:10 PM
To: Mats Liljegren
Cc: Linux Test Project General Discussions; Frederic Weisbecker
Subject: Re: [LTP] Testing absence of ticks with nohz_full

Mats Liljegren <liljegren.mats2@gmail.com> writes:

> My company (Enea) wants to create test case(s) that verifies that you
> can run an application without having ticks going on the CPU that the
> application runs on. This would utilize the new nohz_full feature
> available from kernel version 3.10.
>
> I cannot find any existing test case in LTP in this area, so I assume
> I have to create the test case myself.

It's not in LTP, but I have a shell script[1] does some setup and load
generation that I use to validate nohz_full.  The setup and
prerequisites can be a bit tricky, but some of the things it does:

- disables the residual 1Hz (if my patch is applied)
- pinning the unbound "writeback" workqueue to CPU0
- force timer migration using hotplug
- sets up CPUsets and tries to migrate all tasks to CPU0
  (I think this part came from a script from you awhile ago)

It then uses 'stress' to generate load on specific CPUs and uses
trace-cmd to record the traces.

I currently look at the traces manually to see if it worked, but adding
other step to automatially look at the traces would be a good next step.

Kevin


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
