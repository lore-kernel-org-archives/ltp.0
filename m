Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YnkOW-0003Ex-Dk
	for ltp-list@lists.sourceforge.net; Thu, 30 Apr 2015 09:04:32 +0000
Date: Thu, 30 Apr 2015 11:03:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150430090357.GA23406@rei.suse.de>
References: <782230467.5857849.1429883677704.JavaMail.zimbra@redhat.com>
	<162165083.8714320.1430382121729.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <162165083.8714320.1430382121729.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] Coverity report for ltp-20150420
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
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> >From what I have read, it should be possible to annotate code to make coverity
> stop complaining. For example by adding following:
>   /* coverity[EVENT_TAG_NAME] */
> 
> I'm not exactly clear where to get "event tag names" yet, as these seem to be
> different from error names that appear in *.err logs.
> 
> Before I dig deeper into this, would anyone be opposed if we start adding
> such annotation to LTP source?

I'm OK with adding a few annotations to places where LTP does something
that needs to be done and what is normally a bug. As far as I remember
we have a few places that dereference NULL to cause segfault that
produce false-possitive warnings as well.

Looking at the BAD_FREE the munmap03.c is nice example of that. However
most of the BAD_FREE, if I understant it correctly, are result of
unmaping only part of the mmaped memory. That is not really bug, but I
guess that I can live with annotations for these as well if you want
them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
