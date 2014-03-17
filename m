Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ceh@ti.com>) id 1WPWpM-0000fL-Hy
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 12:39:36 +0000
Received: from devils.ext.ti.com ([198.47.26.153])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WPWpH-00071G-O2
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 12:39:36 +0000
Message-ID: <5326ECF8.8040806@ti.com>
Date: Mon, 17 Mar 2014 08:39:20 -0400
From: Carlos Hernandez <ceh@ti.com>
MIME-Version: 1.0
References: <0247700D01F14443B9209F90AD938CC524365A3B@sestoex05.enea.se>
In-Reply-To: <0247700D01F14443B9209F90AD938CC524365A3B@sestoex05.enea.se>
Subject: Re: [LTP] Design question around ltp-list
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Mats,

You may be able to use runltp's -c option to create background load.

Carlos
On 03/17/2014 06:11 AM, Mats Liljegren wrote:
> I'd like to create a time-boxed test case, i.e. the test will run for a certain amount of time and if nothing goes wrong during this time, the test passed.
>
> This would also need to be recursive. So when starting my test, it in turn will start some test cases to be used as a system load. These loads are simple application that will run until killed. My intention was to start them using ltp-pan.
>
> So imagine my test case is started with ltp-pan, where a running time has been specified. My test case in turn will use ltp-pan to start an application that only exits when killed. What will happen when the first ltp-pan invocation times out? Will it automatically kill child ltp-pan instances, and they in turn kill the load applications?
>
> Or how are you supposed to do such a test case?
>
> /Mats
>
> ------------------------------------------------------------------------------
> Learn Graph Databases - Download FREE O'Reilly Book
> "Graph Databases" is the definitive new guide to graph databases and their
> applications. Written by three acclaimed leaders in the field,
> this first edition is now available. Download your free book today!
> http://p.sf.net/sfu/13534_NeoTech
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
