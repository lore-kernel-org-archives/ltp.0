Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PZCQ1-0006pf-Df
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 01:07:33 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PZCQ0-0004sf-Ie
	for ltp-list@lists.sourceforge.net; Sun, 02 Jan 2011 01:07:33 +0000
Received: by pzk12 with SMTP id 12so2593084pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Sat, 01 Jan 2011 17:07:27 -0800 (PST)
From: Garrett Cooper <yanegomi@gmail.com>
Date: Sat, 1 Jan 2011 17:07:34 -0800
Message-Id: <7C270326-1338-4AB2-9B34-498AAE779595@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Subject: [LTP] Items needing to be committed
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
To: "ltp-list@lists.sourceforge.net List" <ltp-list@lists.sourceforge.net>

	It's going to take a day or two to work through the wreckage, but if folks with patches that I haven't acked as bogus please reply with subject titles so I can go through and commit them as necessary soon? Subrata is itching for a release and I've forgotten all of the different items that need to be committed (there are somewhere around 20 IIRC).
	Also, if you have something you wish to add to LTP that hasn't been committed, please consolidate all of your patches and send it out for final review (*hint* *hint* :)...) because I don't want to fish through emails to have to patch stuff out of order, and I'll most likely need to doctor up the tests to be correct with the tst_exit/cleanup/whatever consolidation anyhow.
Thanks,
-Garrett
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
