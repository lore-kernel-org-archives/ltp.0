Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ucd7L-0007AU-8A
	for ltp-list@lists.sourceforge.net; Wed, 15 May 2013 14:55:47 +0000
Date: Wed, 15 May 2013 16:56:52 +0200
From: chrubis@suse.cz
Message-ID: <20130515145652.GB25137@rei.suse.cz>
References: <1368610801-25821-1-git-send-email-alexey.kodanev@oracle.com>
	<20130515123826.GA22782@rei> <51939CB6.3020808@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51939CB6.3020808@oracle.com>
Subject: Re: [LTP] [PATCH] New core test of cgroups and extended attributes
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
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > What is this fflush() for?
> >
> kernels 3.7 can crash while unmounting cgroups with xattr,
> so just to make sure all buffered data written before it happens

Ok, let's add simlilar comment to the code as well.

And it would be better to call tst_flush() as you are using tst_resm()
interface.

> > This function is too ugly. You should rather do something like
> > print_xattr() that would both preprare the string and call the
> > tst_resm() so that you don't need to pass allocated buffers around.
> >
> > void print_xattr(const char *msg, const char *val, size_t size)
> > {
> > 	char buf[size + sybm_num + 1];
> > 	...
> >
> > 	tst_resm(TINFO, "%s%s", msg, buf);
> > }
> >
> > Or we can create a tst_xxx function to print a buffer of bytes, I guess
> > that there are more cases where such function could be used. But that
> > would require a little more work to desing the interface right.
> >
> I agree, let's do that

Ok, lets address that in separate patch. I would go for simple function
that would take prefix in printf() format and would dump the hex values
after that. Something like tst_resm_buf(flags, buf, buf_len, fmt, ...)
but perhaps we can come up with better name and/or API.

I do not want to add custom printf() format strings on purpose, as that
would:

1) create confusion

2) possibly break the checks on the format done by compiler

Anybody else has better idea?

> >> +static void fill_test_value(char *id, struct tst_val *val)
> >> +{
> >> +	int i;
> >> +	for (i = 0; i<  VALUE_SIZE; ++i)
> >> +		val->buf[i] = *id;
> > What about using memset()?
> Ok :) further may be remove this function completely and just use memset 
> instead?

Sounds good.

> > What about just defining the id in the walk functions and incrementing
> > it each time fill_test_value() was called?
> >
> The point is to make unique key's values among all hierarchies (there 
> was a bug when files with the same name share the same struct)
> Would it be better to use global id that is incrementing each time when 
> fill_test_value() called,
> and resetting to init value between set and get walk functions?

Global id sounds better to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
