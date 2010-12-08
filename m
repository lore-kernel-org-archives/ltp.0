Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PQFzq-000463-QE
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:07:34 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQFzq-0002Yd-1r
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:07:34 +0000
Received: by wwi18 with SMTP id 18so851542wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Dec 2010 01:07:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTim7MX7BdppQMN5mjpGVuGgEqdMULiCd0t-d-zPj@mail.gmail.com>
References: <AANLkTim7MX7BdppQMN5mjpGVuGgEqdMULiCd0t-d-zPj@mail.gmail.com>
Date: Wed, 8 Dec 2010 01:07:27 -0800
Message-ID: <AANLkTinBpW97zVi_79bqf8EnKDM3U84JbhRYAYo3hMae@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Problem about nfs01 and open_files
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Dec 8, 2010 at 1:00 AM, Romu <huruomu@gmail.com> wrote:
> Hi all,
>
> I installed ltp 20100831 on RHEL5u6 beta using the following commands:
>
> ./configure
> make all
> make install
>
> nfs01 always fails during ltp stress test:

It should be fixed now for that test.

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
