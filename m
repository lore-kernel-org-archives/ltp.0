Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OxfLQ-0008RC-FW
	for ltp-list@lists.sourceforge.net; Mon, 20 Sep 2010 12:19:40 +0000
Date: Mon, 20 Sep 2010 14:40:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100920124009.GB29485@saboteur.suse.cz>
References: <20100902144720.GA16059@saboteur.suse.cz>
	<1283789797.4947.18.camel@subratamodak.linux.ibm.com>
	<4C851BAD.9080207@linux.vnet.ibm.com>
	<1284020387.29634.4.camel@subratamodak.linux.ibm.com>
	<4C88F433.80301@linux.vnet.ibm.com>
	<1284443154.5001.8.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1284443154.5001.8.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] fix realtime atomic_add() inline asm
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, gowrishankar <gowrishankar.m@linux.vnet.ibm.com>, darren@dvhart.com

Hi!
> > Hi Cyril,
> > Do you wish to ack my patch ?
> 
> Cyril,
> 
> Waiting for your endorsement/rejection !!

Sorry, I've been out of the office for some time.

Using __sync_add_and_fetch() is better solution as far as we use gcc
(1), but we were using gcc extended assembler (2) before, so we should
be safe here. You can add my ack to previous patch.


1) http://gcc.gnu.org/onlinedocs/gcc-4.3.2/gcc/Atomic-Builtins.html

2) http://gcc.gnu.org/onlinedocs/gcc-4.3.2/gcc/Extended-Asm.html#Extended-Asm

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
