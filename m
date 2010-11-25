Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PLidH-0000EH-Ki
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 20:41:31 +0000
Received: from mail-ew0-f47.google.com ([209.85.215.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLidG-0007vQ-Qs
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 20:41:31 +0000
Received: by ewy6 with SMTP id 6so687031ewy.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Nov 2010 12:41:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1193684080.447321290677035326.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <177873625.447271290676929182.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1193684080.447321290677035326.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Thu, 25 Nov 2010 12:41:24 -0800
Message-ID: <AANLkTi=Nhdg0dRe0D0YSg3sDJWqydvJq5QKCzrzShte1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v2]extend the -I option value
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
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Nov 25, 2010 at 1:23 AM, Zhouping Liu <zliu@redhat.com> wrote:
> Hi,all
> I found it just support a small value for -I option.
> when I run '#./hugemmap04 -I 3600 -H /var/hugetlbfs',the test returned
> immediately.
> the -I option details :
> -I x Execute test for x seconds
> And if you give a much bigger value to -I option such as 3600 or larger, you
> will find the -I option disabled,
> so I changed the lib/parse_opts.c file, and just modified the stop_time
> variable type from 'int' to 'double',
> after changed, it can support a very bigger value for -I option.

    Or maybe this should be time_t or long?
    Honestly, this could potentially introduce a lot of headache if
done improperly in lib/parse_opts.c (especially if you use a double
precisioned time amount as this could seriously impact architectures
without FPUs).
Thanks,
-Garrett

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
