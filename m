Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PY5QG-0006gi-8v
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 23:27:12 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PY5QD-0006oP-Vu
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 23:27:12 +0000
Received: by pwi8 with SMTP id 8so1290671pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 15:27:04 -0800 (PST)
References: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
	<AAFECAC8-E32A-4241-B201-3EA5F0233FA1@gmail.com>
	<201012291747.35513.vapier@gentoo.org>
In-Reply-To: <201012291747.35513.vapier@gentoo.org>
Mime-Version: 1.0 (iPhone Mail 8C148)
Message-Id: <807498B0-9470-4A83-BD44-443EFFFF7574@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Wed, 29 Dec 2010 15:26:53 -0800
Subject: Re: [LTP] enable pwrite for 64 bits test
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Grep for pwrite under the runtest dir in the got repo.

Sent from my iPhone

On Dec 29, 2010, at 2:47 PM, Mike Frysinger <vapier@gentoo.org> wrote:

> On Wednesday, December 29, 2010 17:10:42 Garrett Cooper wrote:
>> This didn't add the runtest entire though.
> 
> what are you referring to exactly ?  the changes to pwrite's Makefile look 
> like all that's needed as compared to say pselect/Makefile.
> -mike

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
