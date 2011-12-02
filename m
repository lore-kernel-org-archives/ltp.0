Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RWLvO-0004MG-Lq
	for ltp-list@lists.sourceforge.net; Fri, 02 Dec 2011 05:44:42 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RWLvN-0001u5-Nz
	for ltp-list@lists.sourceforge.net; Fri, 02 Dec 2011 05:44:42 +0000
Received: by yenr11 with SMTP id r11so3154726yen.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 01 Dec 2011 21:44:36 -0800 (PST)
Message-ID: <4ED865A9.4080801@casparzhang.com>
Date: Fri, 02 Dec 2011 13:44:09 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1A42CE6F5F474C41B63392A5F80372B212E02C9595@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1A42CE6F5F474C41B63392A5F80372B212E02C9595@shsmsx501.ccr.corp.intel.com>
Subject: Re: [LTP] [Ltp-commits] [patches 1/3]perfcounter api updates
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
To: "Xu, Anhua" <anhua.xu@intel.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, "Song,  Youquan" <youquan.song@intel.com>

On 12/02/2011 12:59 PM, Xu, Anhua wrote:
> Hi, I'm newbie to LTP and I have some patches to submit. Not sure if it is OK to post here.

Hi, ltp-list@lists.sourceforge.net should be the right place to put your
patches. And I suggest to take a look at $LTPROOT/doc/style-guide.txt to
get your patches submitted via git.

Thanks,
Caspar

> Since perfcounter associated test cases had been out of date. I updated data structures used by new apis. 
> And add a header file for both perfcounter01 and perfcounter02
> 



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
