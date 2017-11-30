From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Nov 2017 17:20:48 +0100
Subject: [LTP] [PATCH v2 10/13] getdtablesize01: Handle ENFILE errno
In-Reply-To: <87k1y7zr7a.fsf@e105922-lin.cambridge.arm.com>
References: <20171114155929.24237-1-punit.agrawal@arm.com>
 <20171114155929.24237-11-punit.agrawal@arm.com>
 <20171130131259.GB2924@rei>
 <87k1y7zr7a.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20171130162048.GA18365@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>  //Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
> >>  
> >> -	if (count > 0)
> >> -		close(count);
> >>  	if (count == (max_val_opfiles - 1))
> >>  		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
> >
> > We may also check for EMFILE here.
> 
> I don't understand what you're suggesting here.

When process has exhausted the maximal number of file descriptors it can
open we are supposted to fail with EMFILE, when that happened to the
whole system before we hit the per process limit we get ENFILE. So I was
suggesting that we may as well check that we were able to open expected
number of file descriptors and that the last open() failed with EMFILE.

-- 
Cyril Hrubis
chrubis@suse.cz
