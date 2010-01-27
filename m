Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1Na4L6-00019e-5k
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 09:37:32 +0000
Received: from mtagate4.de.ibm.com ([195.212.17.164])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Na4L2-0001Nr-MF
	for ltp-list@lists.sourceforge.net; Wed, 27 Jan 2010 09:37:32 +0000
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.1/8.13.1) with ESMTP id o0R9bM0d004759
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Jan 2010 09:37:22 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o0R9bLsX979122
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Jan 2010 10:37:21 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o0R9bLPY016797
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Jan 2010 10:37:21 +0100
Message-ID: <4B60092D.70904@linux.vnet.ibm.com>
Date: Wed, 27 Jan 2010 10:36:45 +0100
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <E1NXttq-0004LT-2Z@h45xhf1.ch3.sourceforge.com>
	<27331504.post@talk.nabble.com>
In-Reply-To: <27331504.post@talk.nabble.com>
Subject: Re: [LTP] [ ltp-Feature Requests-2927507 ] lcov: branch coverage in
 reports
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
To: drberlin <drberlin@aol.com>
Cc: ltp-list@lists.sourceforge.net

On 27.01.2010 00:16, drberlin wrote:
> If branch coverage is implemented in lcov, I will be able test it (and
> indeed MUSTbefore using for our safety critical application). When might it
> be available?

It is implemented now in the CVS version of lcov [*].


Regards,
   Peter Oberparleiter


[*] see http://ltp.sourceforge.net/coverage/lcov.php for instructions on 
how to get the CVS version


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
