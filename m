Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q2POj-0002O4-3X
	for ltp-list@lists.sourceforge.net; Wed, 23 Mar 2011 14:50:57 +0000
Date: Wed, 23 Mar 2011 16:13:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110323151326.GA8497@saboteur.suse.cz>
References: <AANLkTinnnh7H2fjxSfnnc7JsSFdTBQWCDeWTkzWMDCRO@mail.gmail.com>
	<AANLkTikTwg00-9HVMduSNJwqb1zSu579OvgV=U108M2b@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikTwg00-9HVMduSNJwqb1zSu579OvgV=U108M2b@mail.gmail.com>
Subject: Re: [LTP] New member to mailing list ..
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
To: Naveen Joshi - C and Linux <joshiplns@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
1. You should learn how to create so called unified diff. They
   are standart way of sending changes in code. Please send any
   changes in this format from now on.

2. You should also read aio_*() documentation before trying to change
   randomly values in the test to see if it works. Man pages are usualy
   good source.

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
