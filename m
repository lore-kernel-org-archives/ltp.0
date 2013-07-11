Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UxDHf-0004qW-1P
	for ltp-list@lists.sourceforge.net; Thu, 11 Jul 2013 09:35:31 +0000
Date: Thu, 11 Jul 2013 11:37:07 +0200
From: chrubis@suse.cz
Message-ID: <20130711093707.GA6142@rei.suse.cz>
References: <1373356491-15338-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<51DD9B64.7050802@casparzhang.com>
	<1212845049.2016896.1373481206257.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1212845049.2016896.1373481206257.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH V3] lib: add tst_kvercmp2 to compare specific
 vendor extra kernel versions
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP <ltp-list@lists.sourceforge.net>

Hi!
> > > +static int tst_kexvcmp(char *tst_exv, char *cur_ver)
> > > +{
> > > +	int c1 = 0, c2 = 0, t1 = 0, t2 = 0;
> > > +	int ret;
> > > +
> > > +	sscanf(cur_ver, "%*d.%*d.%*d-%d.%d", &c1, &c2);
> > > +	sscanf(tst_exv, "%d.%d", &t1, &t2);
> > > +	if ((ret = c1 - t1))
> > 
> > not sure if the brackets are duplicated...
> 
> What caught my (and checkpatch's) eye is that these are assignments in if condition,
> but I'm not sure how strictly we take checkpatch output.

Assignment inside of condition is generally considered as a tricky
statement which is why checkpatch gives a warning.

I'm personally not against it as long as it's simple statement like this
but if other people here disagree I'm fine with treating it as a wrong
thing to do.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
