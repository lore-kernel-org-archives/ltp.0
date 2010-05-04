Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O9PDl-0000KD-8b
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 21:00:01 +0000
Received: from mail-iw0-f181.google.com ([209.85.223.181])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O9PDk-0005Og-JG
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 21:00:01 +0000
Received: by iwn11 with SMTP id 11so3942246iwn.11
	for <ltp-list@lists.sourceforge.net>;
	Tue, 04 May 2010 13:59:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7023CD936D1501409946F382B52DD7FA0C19A3F9@xmb-sjc-228.amer.cisco.com>
References: <7023CD936D1501409946F382B52DD7FA0C19A3F9@xmb-sjc-228.amer.cisco.com>
Date: Tue, 4 May 2010 13:59:55 -0700
Message-ID: <n2i364299f41005041359u8128d5dbj22055b83e9d18e41@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Intra-process test cases
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
To: "Lakshmankumar Mukkavilli (lakshman)" <lakshman@cisco.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, May 4, 2010 at 10:57 AM, Lakshmankumar Mukkavilli (lakshman)
<lakshman@cisco.com> wrote:
> Hi,
>
>
>
> I am looking at LTP and I see that the test cases are external to the =A0=
unit
> under test(UUT). Tests are in a different address space than the UUT. Am I
> wrong in this observation?
>
> Suppose I want to create tests that need to be in the same address space =
as
> the UUT what are the recommendations? I want to refer some global variabl=
es
> and data structures in the UUT. What are my options?

    This message is noise without context. Define `UUT' and what scope
it entails (and no, I'm not asking for the definition of UUT, because
I know it means unit under test).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
