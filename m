Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Pzpqn-0001C7-AL
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 12:29:17 +0000
Date: Wed, 16 Mar 2011 13:51:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110316125110.GC2096@saboteur.suse.cz>
References: <4D7E0425.7090509@redhat.com>
	<20110316120758.GA2096@saboteur.suse.cz>
	<4D80A5E1.2020002@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D80A5E1.2020002@redhat.com>
Subject: Re: [LTP] [PATCH] fs: fsstress: make test more POSIX compliant
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> >> -	if (no_xfs) {
> >> -		diob.d_miniosz = stb.st_blksize;
> >> -		diob.d_maxiosz = stb.st_blksize * 256;  /* good number ? */
> >> -		diob.d_mem = stb.st_blksize;
> >> -	}
> >> +	diob.d_miniosz = stb.st_blksize;
> >> +	diob.d_maxiosz = stb.st_blksize * 256;  /* good number ? */
> >> +	diob.d_mem = stb.st_blksize;
> > 
> > Hmm, why you are removing the if (no_xfs) here (I don't say it's wrong,
> > I only want to know why)?
> 
> The compiler gave warning that diob.d_* may not initialized. I don't
> know what the values diob.d_* should be if XFS exists (no_xfs == 0), but
> I guess they should be the same as when XFS not available.
> 
> > 
> >>  #ifndef NO_XFS
> >>  	else if (ioctl(fd, XFS_IOC_DIOINFO, &diob) < 0) {
> >>  		if (v)
> >> @@ -1826,7 +1824,13 @@ dread_f(int opno, long r)
> >>  		len = align;
> >>  	else if (len > diob.d_maxiosz)
> >>  		len = diob.d_maxiosz;
> >> -	buf = memalign(diob.d_mem, len);
> >> +	if (posix_memalign((void **)buf, diob.d_mem, len) != 0) {
> > 
> > The posix_memalign() actually returns pointer to the memory via buf, so
> > instead of (void **)buf, you should write &buf (and that would silence
> > the warning about uninitalized buf too).
> > 
> 
> sorry, my mistake. I'll correct it. Btw, compiler kept silent when I
> missed & sign..

That's because of the (void **) cast. The char * and void ** are
not compatible pointers and copiler should print a warning about
incompatible type. On the other hand void ** and char ** are
incompatible pointers too.

As one wise man said: "C is a Spartan language" ...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
