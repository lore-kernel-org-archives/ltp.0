Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rocklee_104@outlook.com>) id 1ZEYgP-00041c-B0
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 08:01:49 +0000
Received: from blu004-omc1s7.hotmail.com ([65.55.116.18])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEYgO-0001FF-Cb
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 08:01:49 +0000
Message-ID: <BLU436-SMTP2533A9350B9BD99FA2EE294CF9C0@phx.gbl>
Date: Mon, 13 Jul 2015 15:59:33 +0800
From: Rock Lee <rocklee_104@outlook.com>
MIME-Version: 1.0
Subject: [LTP] Purpose of fsync02
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

Hi, all:
	I used ltp to test my linux OS.Sometimes, I get "fsync took too long" 
error.Then I read fsync02 description -- Create a sparse file, fsync it, 
and time the fsync, but I don't know what is the purpose to do this, Any 
ideas or pointers would be greatly appreciated.

Thanks
-- 
Rock Lee

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
