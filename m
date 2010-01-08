Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ashish.g@teldevice.co.jp>) id 1NT8vp-0001Io-3G
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 07:06:49 +0000
Received: from mail-gw.teldevice.co.jp ([124.215.243.245] helo=teldevice.co.jp)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NT8vn-00011H-BR
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 07:06:48 +0000
Message-ID: <4B46D5F0.3090801@teldevice.co.jp>
Date: Fri, 08 Jan 2010 15:51:28 +0900
From: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
MIME-Version: 1.0
Subject: [LTP] LTP installation  configure Error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: TED ITC Ashish Agarwal <ashish.g@teldevice.co.jp>

Hello All

I am novice for the LTP, just last week i heard something LTP
and feel curious about it so started searching and installations.

"./configure " generates Error to me as written below.

configure: error: Couldn't find functional copy of quota v2 - are you running 2.4.x?


--
i searched over net about quota but i were not lucky this time. :(

I am writing down my environment conditions:
    System : Fedora 3 (kernel 2.6.9-1.667)

Updated the make, bison/yacc, flex, automake, autoconfig, m4 etc as written over INSTALL. (LTP 20091231)

Process i followed till is (./configure -> make -> make install) for the list written above as requirement (make 3.81+ etc)

Then i tried to
 [root LTP-full-20091231] # ./configure

It lands into Error as above "configure: error: Couldn't find functional copy of quota v2 - are you running 2.4.x?"

The quota version i am using is
"
$ rpm -q quota
quota-3.12-5
"
Is there is any such limitation like we cannot install LTP over some machine or lower then that kernel version etc. please guide me.

What i want to do is learn LTP and want to check an Embedded Linux (customized for ARM processor) kernel 2.6.19.2.

--
Agarwal Ashish
アガルワル　アシッシュ

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
