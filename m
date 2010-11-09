Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFhuM-0005gs-C1
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 06:42:18 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFhuL-0005rg-D3
	for ltp-list@lists.sourceforge.net; Tue, 09 Nov 2010 06:42:18 +0000
Received: by wwb29 with SMTP id 29so1021965wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 22:42:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=XWVK8k0kB1XU8n70adHcbVvHsY-w3GCOzK8kN@mail.gmail.com>
References: <AANLkTi=XWVK8k0kB1XU8n70adHcbVvHsY-w3GCOzK8kN@mail.gmail.com>
Date: Mon, 8 Nov 2010 22:42:10 -0800
Message-ID: <AANLkTi=VuxGbNrb6ASDWUpGNP=UuBAjvboFJojE0rp6r@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] check_onlycap()
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
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ltp-list@lists.sourceforge.net, ajay.khandelwal@st.com, hannuxx@gmail.com

On Mon, Nov 8, 2010 at 10:40 PM, ARJIT SHARMA <joyarjit@gmail.com> wrote:
> HI,
>
> =A0=A0=A0=A0 Inside ltp/testcases/kernel/security/smack there is a shell =
named
> smack_common.sh, inside this script there is a function "check_onlycap"
> which is giving error as :---
>
> The smack label reported for /smack/onlycap is "", not the expected ""
> why there is such problem and how can i overcome this?
>
> i made a little change in the code but still the error is same:--
>
> i wrote
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ !z "$onlycap" ];
>
> instead of
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if [ -z "$onlycap" ];
>
> inside check_onlycap() function.

Fixed in a later version.

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
