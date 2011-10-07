Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RC7ak-0007Ml-TU
	for ltp-list@lists.sourceforge.net; Fri, 07 Oct 2011 10:23:46 +0000
Date: Fri, 7 Oct 2011 12:26:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111007102648.GA32707@saboteur.suse.cz>
References: <4E6DF327.7070908@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E6DF327.7070908@linux.vnet.ibm.com>
Subject: Re: [LTP] [Patch v6 3/4] KSM test case fixes - mmap10
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
To: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> # ./mmap10 -s
> mmap10      1  TCONF  :  KSM configuration is not enabled
> mmap10      2  TCONF  :  Remaining cases not appropriate for configuration
> 

Commited, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security
threats, fraudulent activity, and more. Splunk takes this data and makes
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2dcopy2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
