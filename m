Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MHcGh-0001qF-5u
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 11:28:27 +0000
Received: from mail-ew0-f217.google.com ([209.85.219.217])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHcGc-0002ir-FR
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 11:28:27 +0000
Received: by ewy17 with SMTP id 17so2005004ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Jun 2009 04:28:20 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 19 Jun 2009 16:58:20 +0530
Message-ID: <d51f89b0906190428w1f5127d7mf7d508f52ba7449b@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] Update for the Sun-RPC /TIRPC LTP Test Suite
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
To: subrata@linux.vnet.ibm.com, LTP List <ltp-list@lists.sourceforge.net>

> Re: [LTP] Update for the Sun-RPC /TIRPC LTP Test Suite
> Subrata Modak
> Sun, 30 Nov 2008 07:28:07 -0800
>> >
>>
>>=A0=A0=A0 Hi,
>>=A0=A0=A0 If you don't mind I prefer an integrated patch I join at this m=
ail.
>>=A0=A0=A0 It contents:
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 - contents of the first already sent patch
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 - fix about issues you mentionned on it (ltps=
tress.sh, cconfigure~)
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 - new extensions about the build/install scri=
pts
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 - the adaptation of some rpc scripts to take =
account if rpcbind
>> is used rather than portmap
>
> I think this messed up a little bit. Your last patch was integrated and
> hence this will fail to apply. I am going to do the fresh release soon.
> Send across all the changes w.r.t this new release.
>
> Regards--
> Subrata
>

Hi Subrata,

I am still getting the following compilation error in LTP may release.

#./runtlp -f rpc -g rpc.hml

tests_pack/tirpc_svc_7/tirpc_svc_7.c:29:29: error: tirpc/netconfig.h:
No such file or directory
tests_pack/tirpc_svc_7/tirpc_svc_7.c:31:27: error: tirpc/rpc/rpc.h: No
such file or directory
tests_pack/tirpc_svc_7/tirpc_svc_7.c:32:29: error: tirpc/rpc/types.h:
No such file or directory
tests_pack/tirpc_svc_7/tirpc_svc_7.c:33:27: error: tirpc/rpc/xdr.h: No
such file or directory
tests_pack/tirpc_svc_7/tirpc_svc_7.c:34:27: error: tirpc/rpc/svc.h: No
such file or directory

Any update on the patch, whether its merged OR not?

Regards,
Rohit

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
