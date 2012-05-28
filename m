Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SZ4gP-0004KS-El
	for ltp-list@lists.sourceforge.net; Mon, 28 May 2012 18:28:45 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SZ4gO-0007H1-Q8
	for ltp-list@lists.sourceforge.net; Mon, 28 May 2012 18:28:45 +0000
Received: by obhx4 with SMTP id x4so870293obh.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 May 2012 11:28:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FC363E1.8020702@redhat.com>
References: <4FC363E1.8020702@redhat.com>
Date: Mon, 28 May 2012 11:28:39 -0700
Message-ID: <CAGH67wRQ0rd1gZreTExEwcPLwF752ssa3nN40Xm4359Hn_mdLg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/4] mbind01: dont use hardcoded NUMA node ids
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On Mon, May 28, 2012 at 4:39 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
> =A0testcases/kernel/syscalls/mbind/Makefile =A0| =A0 =A03 +--
> =A0testcases/kernel/syscalls/mbind/mbind01.c | =A0 10 ++++++++--
> =A02 files changed, 9 insertions(+), 4 deletions(-)

+	if ((ret =3D get_allowed_nodes(1, &test_node)) < 0) {
+		tst_brkm(TBROK|TERRNO, cleanup, "get_allowed_nodes(): %d", ret);
+	}

    Is this always guaranteed to set errno to a sane value?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
