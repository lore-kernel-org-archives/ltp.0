Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Poo9a-0005uH-JK
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 02:27:06 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Poo9Z-0006wf-IR
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 02:27:06 +0000
Received: by wyb40 with SMTP id 40so4130786wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 13 Feb 2011 18:26:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D58916C.6010800@cn.fujitsu.com>
References: <4D58916C.6010800@cn.fujitsu.com>
Date: Sun, 13 Feb 2011 18:26:59 -0800
Message-ID: <AANLkTimrk9YLuPt3zFc00WYHPE6Xr8zSL0=mFrZ8Rfo+@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] cleanup() should not be called before setup() in
 cases dup3_01 and eventfd2_01
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

On Sun, Feb 13, 2011 at 6:20 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
