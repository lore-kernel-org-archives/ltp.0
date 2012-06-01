Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1SaTxM-0003XA-8j
	for ltp-list@lists.sourceforge.net; Fri, 01 Jun 2012 15:40:04 +0000
Received: from mail-qa0-f47.google.com ([209.85.216.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SaTxL-0003HJ-On
	for ltp-list@lists.sourceforge.net; Fri, 01 Jun 2012 15:40:04 +0000
Received: by qabg1 with SMTP id g1so464916qab.13
	for <ltp-list@lists.sourceforge.net>;
	Fri, 01 Jun 2012 08:39:58 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 1 Jun 2012 23:39:58 +0800
Message-ID: <CANoG8sX9dk4ztf=pK0JtFtn=qMMknociKAnN+_VEeQjCT8Wc6w@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] LTP filesystem related tests
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

1) What option should I use with runltp to test different filesystems?
 -d TMPDIR and with TMPDIR on different filesystems?

2) Which tests should I use to test if filesystem is working fine?
I'm using the following:

filecaps
fs
fs_bind
fs_perms_simple
fs_readonly
fsx

Are the above tests a good test suite for filesystem test?  Any other
tests (e.g. aio, dio)?

Thanks
Romu

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
