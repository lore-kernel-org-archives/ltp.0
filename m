Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TEhkg-0000zd-KW
	for ltp-list@lists.sourceforge.net; Thu, 20 Sep 2012 14:29:14 +0000
Date: Thu, 20 Sep 2012 16:29:05 +0200
From: chrubis@suse.cz
Message-ID: <20120920142905.GC7902@saboteur.suse.cz>
References: <CAD15agakqdqNiZY_rKRyh0GocADu7F2rLdctJpSwdosiNz7CYg@mail.gmail.com>
	<CABhB_e8j2oRbKPererNep1-T5z3sCsvRPW-2rSoPg-tvF4AZoA@mail.gmail.com>
	<CAD15agZmMyu+vWLoRn1NukgaeXvG-v6pbxs=fUVULTQc6DLhgg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD15agZmMyu+vWLoRn1NukgaeXvG-v6pbxs=fUVULTQc6DLhgg@mail.gmail.com>
Subject: Re: [LTP] LTP test reults for kernel 3.0.15 and 3.4
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
To: Ritesh Harjani <ritesh.harjani@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Following are the lines of code where the test case is exiting, for kernel
> 3.0.15 (ICS).
> 
> 128         pm2=pm1;
> 129         free(pm1);
> 130
> 131         if((pm1=(char *)calloc(memsize,1)) == NULL) {
> 132                 tst_resm(TFAIL, "calloc did not alloc memory ");
> 133                              tst_exit();
> 134         }
> 135
> 136         if(pm1 != pm2) {
> 137                 tst_resm(TINFO, "pm1=%p pm2=%p ", pm1,pm2);
> 138                 tst_resm(TFAIL, "free did not dealloc memory ");
> 139
> tst_exit();                                                     // *Here
> code is exited in kernel 3.0.15 while it is passing in case of kernel 3.4
> (ICS)*.
> 140         }
> 
> 
> 
> *LTP version = "LTP-20100630"*
> 
> at line 136 my test is failing. Now isnt this condition of the dangling
> pointer. At line 129 we are freeing pm1 this means that pm2 becomes a
> dangling pointer.
> And how come after doing
> pm1=(char *)calloc(memsize,1)
> pm1 is equal to pm2 for kernel 3.4 (ICS) (Since this test case is passing
> for that)??
> 
> According to me, it should not be equal.

Indeed this test seems to be wrong. My guess is that it was written with
'it works so and so it must be true' attitude as it's not unlikely to
get same pointer if you request chunk of a same size directly after you
free one.

So my conclusion is that the test is broken and should be fixed. Do you
care to send a patch (against latest git tree)?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://ad.doubleclick.net/clk;258768047;13503038;j?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
