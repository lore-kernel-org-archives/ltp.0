Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Ppb8p-0006xj-6q
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 06:45:35 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Ppb8o-0003AZ-50
	for ltp-list@lists.sourceforge.net; Wed, 16 Feb 2011 06:45:35 +0000
Received: by wwi18 with SMTP id 18so984922wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Feb 2011 22:45:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D5B7144.9000801@cn.fujitsu.com>
References: <4D58C631.7040508@cn.fujitsu.com>
	<AANLkTinXKnOn7XBWJ=+Pc=5r6ObK68s8K2VNEwpuuvBA@mail.gmail.com>
	<4D58F766.6040208@cn.fujitsu.com>
	<AANLkTikdB=poh8vt8PhoiJxUFz2Zimu9oORiyyMSeu-+@mail.gmail.com>
	<4D5B7144.9000801@cn.fujitsu.com>
Date: Tue, 15 Feb 2011 22:45:27 -0800
Message-ID: <AANLkTim23RXT05JSZHwY0Bhnki4qz2T3vNen35gKFn1=@mail.gmail.com>
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

On Tue, Feb 15, 2011 at 10:40 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Garrett Cooper said the following on 2011-2-15 22:42:
>>>> =A0 =A0 How about this version instead? There were issues with the
>>>
>>> The two "TEST_ERRNO" should be replaced with "errno" in this version,
>>> If not, the version will fail.
>>
>> Other than that I assume things are ok?
>
> Sorry, the child process need exit when success in do_master_child().
> I rewrite a new patch base on your version, please review.
> Thinks.

    This is what the code currently looks like. I assume the same
needs to be done for the other set*suid syscall testcases?
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
