Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1RB5Sn-000538-Qk
	for ltp-list@lists.sourceforge.net; Tue, 04 Oct 2011 13:55:17 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RB5Si-0006j3-Dv
	for ltp-list@lists.sourceforge.net; Tue, 04 Oct 2011 13:55:17 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p94DdwYJ019315
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Oct 2011 09:39:58 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p94Dt6SO180192
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Oct 2011 09:55:06 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p94Dt6sK010404
	for <ltp-list@lists.sourceforge.net>; Tue, 4 Oct 2011 10:55:06 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
Date: Tue, 04 Oct 2011 19:25:00 +0530
Message-Id: <1317736501.4423.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] ltp-pan: cannot execute binary file
Reply-To: subrata@linux.vnet.ibm.com
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
To: Josh! <joshiplns@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Are you sure that you have the 'glibc'(on linux) type counterpart
installed on your system ??

Without glibc your binaries will not run.

Regards--
Subrata

On Tue, 2011-10-04 at 18:11 +0530, Josh! wrote:
> Hi,
> 
> Any Inputs  ?
> 
> Joshi
> 
> On Fri, Sep 30, 2011 at 2:22 PM, Josh! <joshiplns@gmail.com> wrote:
>         Hi folks ,
>         
>         I am running 3.0 Kernel for armv7a on *Beagle Board* target.
>         
>         Meanwhile I'm testing kernel with ltp-full-20110915. I did the
>         Make and Make Install properly.
>         But while running ./runltp script I am facing following issue.
>         
>         {{{
>         
>         ./runltp: line
>         824: /mnt/HDD/ltp-full-20110915/Joshi_LTP/bin/ltp-pan: cannot
>         execute binary file
>         INFO: ltp-pan reportedAIL
>         
>         }}}
>         
>         Could anyone can share knowledge on this issue ?
>         
>         Kindly
>         Joshi
>         
>         
> 
> 
> 
> -- 
> 
> 
> Stay Cool,
> Joshi"Mera Bhaarath Mahaan"
> 
> 
> ------------------------------------------------------------------------------
> All the data continuously generated in your IT infrastructure contains a
> definitive record of customers, application performance, security
> threats, fraudulent activity and more. Splunk takes this data and makes
> sense of it. Business sense. IT sense. Common sense.
> http://p.sf.net/sfu/splunk-d2dcopy1
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
