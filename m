Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFIpw-0006XE-Ca
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:32:52 +0000
Received: from mail-vb0-f47.google.com ([209.85.212.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFIpv-0007M5-Rv
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:32:52 +0000
Received: by vbbfr13 with SMTP id fr13so497022vbb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Apr 2012 22:32:46 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 3 Apr 2012 22:32:46 -0700
Message-ID: <CAGH67wT8LYA6XnFWphZ2qfrg48hToXr0DpbsHmD-4=1YidrWww@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 4/4] Replace
 create_kernel_faults_in_loops_and_probability.pl with an awk equivalent
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
To: ltp-list@lists.sourceforge.net

On Tue, Apr 3, 2012 at 10:27 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> Replace create_kernel_faults_in_loops_and_probability.pl with an awk
> equivalent
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> ---
> =A0runltp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 24 +++--
> =A0...eate_kernel_faults_in_loops_and_probability.awk | =A0 40 ++++++++
> =A0...reate_kernel_faults_in_loops_and_probability.pl | =A0100
> --------------------
> =A03 files changed, 58 insertions(+), 106 deletions(-)
> =A0create mode 100644 tools/create_kernel_faults_in_loops_and_probability=
.awk
> =A0delete mode 100755 tools/create_kernel_faults_in_loops_and_probability=
.pl

    The subject line has been corrected.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second =

resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
