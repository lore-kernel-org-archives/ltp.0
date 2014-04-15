Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1Wa1ic-0003V0-Fq
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 11:40:02 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wa1ia-0000ge-Pf
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 11:40:02 +0000
Message-ID: <534D1A17.7050005@cn.fujitsu.com>
Date: Tue, 15 Apr 2014 19:37:59 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <20140415124717.516e6851@mats-desktop>
In-Reply-To: <20140415124717.516e6851@mats-desktop>
Subject: Re: [LTP] fs_ext4 fails
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi,

On 04/15/2014 06:47 PM, Mats Liljegren wrote:
> I'm just wondering whether fs_ext4 is known to fail. I ran the
> following command line:
>
> ./runltp -f fs_ext4 -z /dev/sda2

I run these tests in Fedora19 and do not have these errors.
Here /dev/sda2 is big enough? I used a 5GB block device.

Regards,
Xiaoguang Wang


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
