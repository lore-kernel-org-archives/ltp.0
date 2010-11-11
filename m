Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PGLRI-0000jF-74
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 00:54:56 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGLRH-0005TD-4S
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 00:54:56 +0000
Received: by wyi11 with SMTP id 11so546379wyi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Nov 2010 16:54:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CDAA3CA020000E80006AF93@novprvoes0310.provo.novell.com>
References: <AANLkTik8zF-X21KAUjYWeB2FhNVX61oc5ptMffXBnukJ@mail.gmail.com>
	<AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com>
	<4CDAA3CA020000E80006AF93@novprvoes0310.provo.novell.com>
Date: Wed, 10 Nov 2010 16:54:48 -0800
Message-ID: <AANLkTimOfSA_9ixATpX32a_7ytz8zdYLjLr_PZiegcmf@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [RFC] Remove testcases/pounder21
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, Nov 10, 2010 at 12:53 PM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>> On 11/10/2010 at 01:28 PM, in message
> <AANLkTink7COs0xpg5QRPxBajHRGfYfnghs2_xn1FBFLk@mail.gmail.com>, Garrett C=
ooper
> <yanegomi@gmail.com> wrote:
>> On Mon, Nov 8, 2010 at 1:57 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>>> =A0 =A0Hasn't compiled for a while, and looks pretty broken. If no one
>>> objects to me removing it in 3 days I'll get rid of it.
>>
>> (retroactively as of yesterday)
>> Going twice...
>
> I thought this was still being used by IBM in particular. =A0I know for a=
 fact it has multiple issues with file versions, missing/changed updates et=
c. =A0Are you talking about removing the whole pounder tree?

Answering my own question:
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09788.html
, I asked this earlier on this year and someone replied saying "don't
remove it". If it's not removed and serves a particular purpose, maybe
it should be moved to a different section of the tree to avoid
confusion in the future (in particular if it's a framework and not
actually a test / test suite).
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
