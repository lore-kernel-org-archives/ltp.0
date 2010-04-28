Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O7GIe-0008LA-Fu
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 23:04:12 +0000
Received: from mail-iw0-f196.google.com ([209.85.223.196])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7GId-0008Ef-QA
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 23:04:12 +0000
Received: by iwn34 with SMTP id 34so11415524iwn.23
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Apr 2010 16:04:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100428210906.GA20572@us.ibm.com>
References: <20100428210906.GA20572@us.ibm.com>
Date: Wed, 28 Apr 2010 16:04:06 -0700
Message-ID: <z2v364299f41004281604g2e044ff2g1c50413684753640@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/4] mqns: strip leading / from mq names
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Wed, Apr 28, 2010 at 2:09 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> So the tests can pass
>
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
> ---
> =A0testcases/kernel/containers/mqns/mqns.h =A0 =A0| =A0 =A02 ++
> =A0testcases/kernel/containers/mqns/mqns_01.c | =A0 =A08 ++++----
> =A0testcases/kernel/containers/mqns/mqns_02.c | =A0 =A08 ++++----
> =A0testcases/kernel/containers/mqns/mqns_03.c | =A0 =A02 +-
> =A0testcases/kernel/containers/mqns/mqns_04.c | =A0 =A02 +-
> =A05 files changed, 12 insertions(+), 10 deletions(-)

    Are the SLASH_* equivalents used anywhere still?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
