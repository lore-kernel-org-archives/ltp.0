Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Nitin.Yadav@mphasis.com>) id 1SkX92-0006M1-3x
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 09:05:40 +0000
Received: from mpmulip3.mphasis.com ([203.12.222.67])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SkX8v-0004Xt-1y
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 09:05:40 +0000
MIME-Version: 1.0
Content-class: urn:content-classes:message
Date: Fri, 29 Jun 2012 14:33:15 +0530
Message-ID: <E351E450E8B9F54684A699D42DC5ADF222236C0E@MPBAGVEX02.corp.mphasis.com>
In-Reply-To: <4FED6D23.5060500@casparzhang.com>
References: <1c21689296e79eb48004e2f9eb879d717481cf73.1340959271.git.jstancek@redhat.com>
	<4FED6D23.5060500@casparzhang.com>
From: "Nitin Yadav" <Nitin.Yadav@mphasis.com>
Subject: [LTP] getrusage04  FAIL  :  stime increased > 2000us
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
I am getting below error after applying the patch (getrusage04: add
opportunity to increase the max [us]time increment) while running the
getrusage system call in Linux 3.2 kernel.

./getrusage04
getrusage04    0  TINFO  :  Using 1 as multiply factor for max [us]time
increment (1000+1000us)!
getrusage04    0  TINFO  :  utime:           0us; stime:           0us
getrusage04    0  TINFO  :  utime:           0us; stime:        4000us
getrusage04    1  TFAIL  :  stime increased > 2000us:


Please provide some pointers and suggestions.
Thanks!
Nitin Yadav

Information transmitted by this e-mail is proprietary to MphasiS, its associated companies and/ or its customers and is intended 
for use only by the individual or entity to which it is addressed, and may contain information that is privileged, confidential or 
exempt from disclosure under applicable law. If you are not the intended recipient or it appears that this mail has been forwarded 
to you without proper authority, you are notified that any use or dissemination of this information in any manner is strictly 
prohibited. In such cases, please notify us immediately at mailmaster@mphasis.com and delete this mail from your records.


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
