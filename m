Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwWLh-0006Kr-PT
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 09:35:45 +0000
Date: Thu, 25 Aug 2011 11:40:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825094054.GA11006@saboteur.suse.cz>
References: <260174ADA4D63F4AA543B9C81F2DE71214D443@POCITMSEXMB02.LntUniverse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <260174ADA4D63F4AA543B9C81F2DE71214D443@POCITMSEXMB02.LntUniverse.com>
Subject: Re: [LTP] Porting of LTP on Android on Beagleboard
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
To: G Rajender <G.Rajender@lnties.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Kumar <Manoj_Kr@hcl.com>, "Anupam Srivastava - ERS,  HCL Tech" <Anupam_Srivastava@hcl.com>, Manoj@suse.de

Hi!
> I want port LTP on android.  I am using android ginger bread. I have generated boot loaders, kernel images for beagleboard.
> 
> Can you please suggest me the procedure of how to execute LTP with android images on beagleboard.
> 
> Thanks in advance.
> 
> Thanks and regards,

First of all (as Garrett suggested) build LTP correctly. The procedure
is described in INSTALL file packed with ltp.

PS: If you want to work on the LTP development, using lastest code from git
    repository is recomended.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
