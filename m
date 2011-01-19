Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfSky-00016A-95
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:47:04 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfSkw-0003nH-23
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:47:04 +0000
Received: by wwi18 with SMTP id 18so543421wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Jan 2011 23:46:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D368A67.8000105@cn.fujitsu.com>
References: <4D368A67.8000105@cn.fujitsu.com>
Date: Tue, 18 Jan 2011 23:46:55 -0800
Message-ID: <AANLkTi=RtD9cQHx4_Krr3iNSV2Vvy+4zdp4egYb+dHEh@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] dup203: fix error of not using O_ACCMODE
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 18, 2011 at 10:53 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> The file access mode is extracted from the return value of function fcntl() using the mask O_ACCMODE.

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
