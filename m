Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1Wa2Zf-0001mN-5d
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 12:34:51 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-1.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1Wa2Zc-0002Cp-Nc
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 12:34:51 +0000
Date: Tue, 15 Apr 2014 14:34:36 +0200
From: Mats Liljegren <mats.liljegren@enea.com>
Message-ID: <20140415143436.4eca5fed@mats-desktop>
In-Reply-To: <534D1A17.7050005@cn.fujitsu.com>
References: <20140415124717.516e6851@mats-desktop>
	<534D1A17.7050005@cn.fujitsu.com>
MIME-Version: 1.0
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Tue, 15 Apr 2014 19:37:59 +0800
Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com> wrote:

> Hi,
> 
> On 04/15/2014 06:47 PM, Mats Liljegren wrote:
> > I'm just wondering whether fs_ext4 is known to fail. I ran the
> > following command line:
> >
> > ./runltp -f fs_ext4 -z /dev/sda2
> 
> I run these tests in Fedora19 and do not have these errors.
> Here /dev/sda2 is big enough? I used a 5GB block device.
> 
> Regards,
> Xiaoguang Wang
> 

Ok, then maybe there is something wrong with my setup then...

Thanks!

Regards
Mats

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
