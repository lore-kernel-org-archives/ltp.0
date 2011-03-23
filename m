Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q2Q58-00085X-94
	for ltp-list@lists.sourceforge.net; Wed, 23 Mar 2011 15:34:46 +0000
Date: Wed, 23 Mar 2011 16:57:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110323155716.GA9320@saboteur.suse.cz>
References: <4D7FB02B.2040904@redhat.com>
	<20110317165127.GA14723@saboteur.suse.cz>
	<4D8872BF.2060502@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D8872BF.2060502@redhat.com>
Subject: Re: [LTP] [PATCH v2] mm: hugemmap05: fix hardcoded hugepagesize
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
Commited.

It however goes into infinite loop on my machine with hugepagesize 4096,
but that's for further investigation, it seems like it burns cpu in
write_bytes cycling in place.

Note that the patch had trailing whitespaces, I've fixed them manually.

It would be good to use check_patch.pl from linux kernel before sending
patches. It would save us some of the patch ping pong...

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
