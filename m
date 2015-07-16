Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZFYvr-0004oU-IJ
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 02:29:55 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFYvq-0001B5-JT
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 02:29:55 +0000
Message-ID: <1437013824.21784.9.camel@G08FNSTD140232.g08.fujitsu.local>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 16 Jul 2015 10:30:24 +0800
In-Reply-To: <55A680FC.2010807@oracle.com>
References: <55842886.4090202@oracle.com>
	<1436411125-8012-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<55A680FC.2010807@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v4 01/11] SAFE_MACROS: Add socket(), bind(),
 listen(), connect() and getsockname()
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

On Wed, 2015-07-15 at 18:49 +0300, Alexey Kodanev wrote:
> Hi,
> On 07/09/2015 06:05 AM, Zeng Linggang wrote:
> > +int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
> > +	      int socket, const struct sockaddr *address,
> > +	      socklen_t address_len)
> > +{
> > +	int err, ret, i;
> > +
> > +	for (i = 0; i < 30; i++) {
> > +		ret = bind(socket, address, address_len);
> > +		err = errno;
> > +
> > +		if (!ret)
> > +			return 0;
> > +
> > +		tst_resm(TINFO, "bind('%p') failed with %s, try %2i...",
> > +			 address, tst_strerrno(err), i+1);
> > +
> 
> I'd wait only if errno is EADDRINUSE; otherwise exit with TBROK 
> immediately. And waiting for 3 seconds in the loop is too small, please 
> increase the time.
> 

Yeah, you are right.
It is a typo that I missed one zero. :)

Thanks for your comments and
best regards,
zeng

> The rest looks good.
> 
> Thanks,
> Alexey



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
