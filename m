Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UrTLM-00070V-IC
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 13:31:36 +0000
Date: Tue, 25 Jun 2013 15:33:05 +0200
From: chrubis@suse.cz
Message-ID: <20130625133305.GH31268@rei>
References: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
	<20130624115313.GA1638@rei>
	<CA+icZUXgSW5Ha8ZQSepZXQzFx35nrR96AQ7SZun5zRrHFN_j-w@mail.gmail.com>
	<20130625124803.GC31268@rei>
	<CA+icZUUWAWObVLtPXug1YFFOUhB9P-5W88SbN4CebzOC-yGCwg@mail.gmail.com>
	<20130625131112.GE31268@rei> <20130625132453.GF31268@rei>
	<CA+icZUUFx4+s3fdoqnU0JHQBRn-tth8Bh5AKO9BD83w8pRiMbA@mail.gmail.com>
	<CA+icZUVfYPbvWG8ZaRnMVB3UFSU7QGpOz2DpssamP95f__rmtg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUVfYPbvWG8ZaRnMVB3UFSU7QGpOz2DpssamP95f__rmtg@mail.gmail.com>
Subject: Re: [LTP] How to run only a specific test series like for example
 IPC?
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> Hmm, if I remeber correctly there dash that is used as /bin/sh on Debian
> >> (and supposedly on Ubuntu) that does not understand the &> syntax so the
> >> messages may be reversed because the commands are executed on background
> >> (instead of the output redirected to /dev/null).
> >>
> >
> > Yeah, dash is default.
> > I try with using bash instead.
> >
> 
> YUPP, that worked :-).
> 

I will fix the script to work with dash and commit the fix to git.

Thanks for the testing.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
