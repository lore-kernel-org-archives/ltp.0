Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <leemgs1@gmail.com>) id 1MGuv2-0003JU-Ok
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 13:11:12 +0000
Received: from mail-yx0-f198.google.com ([209.85.210.198])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MGuut-0006Uz-Fb
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 13:11:07 +0000
Received: by yxe36 with SMTP id 36so355464yxe.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 06:10:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200906170822.27961.sgrubb@redhat.com>
References: <49b7c2350906151813r31a9fe24icee5b1244f560f7a@mail.gmail.com>
	<20090616184148.GA3043@us.ibm.com>
	<49b7c2350906161642y1222c3e5h45f5912a01c77f06@mail.gmail.com>
	<200906170822.27961.sgrubb@redhat.com>
Date: Wed, 17 Jun 2009 22:10:20 +0900
Message-ID: <49b7c2350906170610q775cf031va3dd2e3ae8c868fc@mail.gmail.com>
From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [LTP] Report - make error of ltp-full-20090531.tgz
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
To: Steve Grubb <sgrubb@redhat.com>
Cc: Andrew Morgan <morgan@kernel.org>, ltp-list@lists.sourceforge.net

On Wed, Jun 17, 2009 at 9:22 PM, Steve Grubb<sgrubb@redhat.com> wrote:
> I am not the maintainer, so I don't have that ability. I did record a
> successful test message in bodhi on LTP's behalf to encourage the maintainer
> to ask for it to be marked stable asap.
Steve and Serge, Thanks.

Unfortunately,
If ltp version will not upgrade  current ltp-full-20090531 version for
Fedora11 support,
or If libcap version of fedora11 will not upgrade,
I have to modify some ltp files like belows.
+//#include <sys/capability.h>
+#include <linux/capability.h>

-- 
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
