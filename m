Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1Pjslb-0003DD-1K
	for ltp-list@lists.sourceforge.net; Mon, 31 Jan 2011 12:21:59 +0000
Received: from mtagate5.uk.ibm.com ([194.196.100.165])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1PjslX-0003Ro-Kp
	for ltp-list@lists.sourceforge.net; Mon, 31 Jan 2011 12:21:59 +0000
Message-ID: <4D46A94E.8000509@linux.vnet.ibm.com>
Date: Mon, 31 Jan 2011 13:21:34 +0100
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <1296415709.29830.8.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1296415709.29830.8.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [Ltp-coverage] Finding True Application Code Coverage in
 case of heteregenous	Executable Environment
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>

Hi Subrata,

On 30.01.2011 20:28, Subrata Modak wrote:
> Is there a way to find true application code coverage for a
> heterogeneous Executable Environment, where the application can consist
> of:

Short answer: no

>       1. C Programs(only for which .gcno and .gcda files can be
>          generated)

Simply use lcov with gcc.

>       2. Shell Scripts,

See http://code.google.com/p/shcov/

>       3. Perl Scripts,

See http://search.cpan.org/~pjcj/Devel-Cover-0.73/lib/Devel/Cover.pm

I've started work on converting code coverage data from that tool into 
lcov format but haven't finished that yet.

>       4. Python Scripts,

I don't have experience with python.

>       5. etc ?

Code coverage measurements all rely on target language specific 
mechanisms. There is no universal mechanism to collect code coverage 
from any language.

> Is there any by which i can also count the no. of lines/ branches/
> Functions executed by the Scripts ??

See the references above.

> Another question. when i tried to execute the following, it took into
> consideration only the .gcda of the C executables invoked by the
> program:
>       1. lcov --directory /root/LTP-GIT/ltp/ --zerocounters
>       2. (cd /opt/ltp/; ./runltp -f math)
>       3. lcov --directory /root/LTP-GIT/ltp/ --capture --output-file
>          app.info
>       4. genhtml app.info
>
> Instead i wanted it consider all C files for which .gcno are present
> and .gcda are not present(as i did not execute the corresponding
> binaries), so to truly find the exact % of C files covered and % left
> out from the whole trickled down /root/LTP-GIT/ltp/ directory.

That is what the --initial option of lcov is for. See the man page of 
lcov for more information.


Regards,
   Peter


------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
