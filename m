Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1TYXr3-0004lE-Iv
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 07:57:49 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TYXr2-0001QY-Pl
	for ltp-list@lists.sourceforge.net; Wed, 14 Nov 2012 07:57:49 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id qAE7viRH025461
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 13 Nov 2012 23:57:44 -0800 (PST)
From: <jin.li@windriver.com>
Date: Wed, 14 Nov 2012 15:57:34 +0800
Message-ID: <1352879855-18742-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] Fix cpuhotplug testcase cpuhotplug01
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
To: jin.li@windriver.com, ltp-list@lists.sourceforge.net

Hi Wenlong,

This V2 version remove the variable cpustate which will never used in
case cpuhotplug01

Regards,

Jin

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
