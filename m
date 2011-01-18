Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Pf70W-0004c5-C3
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 08:33:40 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pf70V-0003k3-J4
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 08:33:40 +0000
Received: by wwi18 with SMTP id 18so5776885wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Jan 2011 00:33:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D354F53.8050600@redhat.com>
References: <1294339211-19449-1-git-send-email-czhang@redhat.com>
	<4D354F53.8050600@redhat.com>
Date: Tue, 18 Jan 2011 00:33:33 -0800
Message-ID: <AANLkTin5SC-04QxrrFmAAYA49PZ0uu6wzVjv4=ckOrf0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v4] make pid_list dynamically sized with memory
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jan 18, 2011 at 12:29 AM, Caspar Zhang <czhang@redhat.com> wrote:
> On 01/07/2011 02:40 AM, czhang@redhat.com wrote:
>> From: Caspar Zhang <czhang@redhat.com>
>>
>> We get segfaults during testing mtest01 on a 5TB memory machine, the
>> problem was traced to the array pid_list[] went to overflow and
>> corrupted memory. This fix makes pid_list dynamically sized with
>> correct memory size to avoid overflow.
>>
>> v2: not split into different bits when allocating pid_list.
>> v3: 1) fix optargs: -b and -p should not be used at the same time.
>> =A0 =A0 2) pre_mem maybe not initialized before using if -p option not u=
sed.
>> =A0 =A0 =A0 =A0fix it by moving it outside ``if(maxpercent)'' block.
>> v4: fix code format.
>>
>> Signed-off-by: Caspar Zhang <czhang@redhat.com>
>
> Patch attached.

Doesn't patch:

Patching file testcases/kernel/mem/mtest01/mtest01.c using Plan A...
Hunk #1 failed at 44.
1 out of 1 hunks failed--saving rejects to
testcases/kernel/mem/mtest01/mtest01.c.rej
Hmm...  Ignoring the trailing garbage.
done

Have you updated your sources recently?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand =

malware threats, the impact they can have on your business, and how you =

can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
