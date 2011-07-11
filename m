Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QgHUJ-000780-7d
	for ltp-list@lists.sourceforge.net; Mon, 11 Jul 2011 14:29:31 +0000
Date: Mon, 11 Jul 2011 16:30:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110711143051.GC26246@saboteur.suse.cz>
References: <1308655951-13647-1-git-send-email-biessmann@corscience.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1308655951-13647-1-git-send-email-biessmann@corscience.de>
Subject: Re: [LTP] [PATCH] t/k/s/eventfd2/eventfd2_03: fix build error
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
To: Andreas =?iso-8859-1?Q?Bie=DFmann?= <biessmann@corscience.de>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Without this patch linking libltp.a complains about missing TEST_ERRNO wh=
en
> building with UCLINUX=3D1.
> =

> Signed-off-by: Andreas Bie=DFmann <biessmann@corscience.de>

Commited, thanks.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security =

threats, fraudulent activity, and more. Splunk takes this data and makes =

sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
