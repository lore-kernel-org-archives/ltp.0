Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RgLh2-0004EJ-2s
	for ltp-list@lists.sourceforge.net; Thu, 29 Dec 2011 19:31:12 +0000
Date: Thu, 29 Dec 2011 20:41:32 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111229194132.GC330@saboteur.suse.cz>
References: <1324872283-6292-1-git-send-email-eguan@redhat.com>
	<4EFA8B41.1040802@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EFA8B41.1040802@casparzhang.com>
Subject: Re: [LTP] [PATCH 1/2 V2] syscalls/setxattr01: new testcase to test
 setxattr(2) basic function
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > +			tname = tc[i].fname;
> > +			tkey = tc[i].key;
> > +			tvalue = tc[i].value;
> > +			tsize = tc[i].size;
> > +			tflags = tc[i].flags;
> > +			texp_err = tc[i].exp_err;
> > +
> > +			TEST(setxattr(tname, tkey, tvalue, tsize, tflags));
> 
> I wonder whether it's necessary. all of the variables be used once only.

I slightly for removing that too.

So if you wan't to change that, resend new patch, otherwise let me know,
I'll commit this as it is.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
