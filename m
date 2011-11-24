Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <k-mio@sx.jp.nec.com>) id 1RTRS3-0007dQ-G7
	for ltp-list@lists.sourceforge.net; Thu, 24 Nov 2011 05:02:23 +0000
Received: from tyo200.gate.nec.co.jp ([202.32.8.215])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RTRS1-00034m-Mu
	for ltp-list@lists.sourceforge.net; Thu, 24 Nov 2011 05:02:23 +0000
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id pAO2w0JN004108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Nov 2011 11:58:00 +0900 (JST)
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id pAO2rAG4016157
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Nov 2011 11:53:10 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id pAO2rAv07962 for ltp-list@lists.sourceforge.net;
	Thu, 24 Nov 2011 11:53:10 +0900 (JST)
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
	by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id pAO2r9eu014268
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Nov 2011 11:53:10 +0900 (JST)
Message-ID: <4ECDB134.3020706@sx.jp.nec.com>
Date: Thu, 24 Nov 2011 11:51:32 +0900
From: Kazuya Mio <k-mio@sx.jp.nec.com>
MIME-Version: 1.0
Subject: [LTP] ext4-online-defrag test doesn't work due to too old e4defrag
 command
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

I tried to test ext4-online-defrag, but it didn't work well due to
the following errors:

ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 2, block size: 1024
 "/opt/ltp/testcases/bin/mnt_point/data0"
        File is not regular file                [ NG ]
        Failed to defrag:Bad file descriptor    [ NG ]
        Failed to defrag:Bad file descriptor    [ NG ]
<snip>
        Failed to defrag:Bad file descriptor    [ NG ]
        Failed to defrag:Bad file descriptor    [ NG ]
ext4-online-defrag    2  TPASS  :  ext4 online defrag test pass

This is because e4defrag is too old to defrag the file in the latest kernel.
I think we should use the latest e4defrag command that is contained in e2fsprogs.

Regards,
Kazuya Mio

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
