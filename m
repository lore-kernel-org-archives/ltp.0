Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TOPgM-0007Ej-VQ
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 09:12:54 +0000
Date: Wed, 17 Oct 2012 11:10:36 +0200
From: chrubis@suse.cz
Message-ID: <20121017091036.GA26815@rei.Home>
References: <CAD15agakqdqNiZY_rKRyh0GocADu7F2rLdctJpSwdosiNz7CYg@mail.gmail.com>
	<CABhB_e8j2oRbKPererNep1-T5z3sCsvRPW-2rSoPg-tvF4AZoA@mail.gmail.com>
	<CAD15agZmMyu+vWLoRn1NukgaeXvG-v6pbxs=fUVULTQc6DLhgg@mail.gmail.com>
	<20120920142905.GC7902@saboteur.suse.cz>
	<CAD15agaKdae3Xo1YqG_G=Ue_p-MusuPFjcY9fppmhwTR2qufww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAD15agaKdae3Xo1YqG_G=Ue_p-MusuPFjcY9fppmhwTR2qufww@mail.gmail.com>
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
> Sorry for such a long gap. I tried finding out that why that test case was
> failing by running a normal C program with malloc implementation.
> 
> I found that, when I am trying to allocate a smaller memory chunk, memory
> is getting allocated from the same address, but for a larger memory chunk,
> it is allocating from some different address i.e if condition is getting
> true (that means that test is failing).
> Couldn't figure out, why this difference. Any idea on to where should I
> look into?

Well as far as I know very large chunks are not allocated on the heap
but using anonymous mmap() (wikipedia suggests that usual threshold
value is 256KB). In such case having two different addresses would not
idicate a bug as expecting deterministic behavior from mutitasking
preemptive kernel is simply wrong.

> And yes, I will surely try to fix if this is a broken test. But moreover,
> in some other kernel version it was passing. So, need to figure out as to
> what changes has been made for this.

I've been faster than you ;). I've commited a patch that removes this
part of the test yesterday.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
