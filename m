Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1Shbns-0005pZ-VU
	for ltp-list@lists.sourceforge.net; Thu, 21 Jun 2012 07:27:44 +0000
Received: from mail1.windriver.com ([147.11.146.13])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Shbnn-0002ui-3t
	for ltp-list@lists.sourceforge.net; Thu, 21 Jun 2012 07:27:44 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5L7RXW7006140
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Jun 2012 00:27:33 -0700 (PDT)
Message-ID: <4FE2CCE3.1030500@windriver.com>
Date: Thu, 21 Jun 2012 15:27:31 +0800
From: "Li, Jin" <Jin.Li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [bug report] a typo in runltp script
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
To: ltp-list@lists.sourceforge.net

Hi,

When I use runltp with the option [-b DEVICE], notice the typo as follows:

sed -i "" -e "s|DEVICE_FS_TYPE|$DEVICE_FS_TYPE|"  ${TMP}/alltests

The runltp will hit error and exit.

Is it a typo or I miss something else ?


Thanks,

Jin

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
