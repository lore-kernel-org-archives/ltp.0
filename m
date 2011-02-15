Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PpM6q-0007fM-1O
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 14:42:32 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PpM6o-0008BM-HG
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 14:42:32 +0000
Received: by wyb40 with SMTP id 40so218040wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Feb 2011 06:42:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D58F766.6040208@cn.fujitsu.com>
References: <4D58C631.7040508@cn.fujitsu.com>
	<AANLkTinXKnOn7XBWJ=+Pc=5r6ObK68s8K2VNEwpuuvBA@mail.gmail.com>
	<4D58F766.6040208@cn.fujitsu.com>
Date: Tue, 15 Feb 2011 06:42:24 -0800
Message-ID: <AANLkTikdB=poh8vt8PhoiJxUFz2Zimu9oORiyyMSeu-+@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] setfsuid04.c: the child process should exit 0
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Feb 14, 2011 at 1:35 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Garrett Cooper said the following on 2011-2-14 14:23:
>> =A0 =A0 How about this version instead? There were issues with the
>
> The two "TEST_ERRNO" should be replaced with "errno" in this version,
> If not, the version will fail.

Other than that I assume things are ok?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
