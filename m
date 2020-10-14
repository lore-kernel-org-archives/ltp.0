From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Oct 2020 11:43:39 +0200
Subject: [LTP] [PATCH] syscalls/ptrace10: Add new regression test
In-Reply-To: <eeeae258-d19b-eaaa-850e-6c6260b2447d@suse.cz>
References: <20200904180030.14838-1-chrubis@suse.cz>
 <6d9b6e46-8337-9614-8fd7-b6ada8fcbe13@suse.cz>
 <20200911153659.GA7234@yuki.lan>
 <eeeae258-d19b-eaaa-850e-6c6260b2447d@suse.cz>
Message-ID: <20201014094339.GB31816@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I would like to avoid triggering the "your system may be vunerable"
> > messages on fixed kernel, hence the separate test.
> 
> Good point, go ahead with a separate test then.

Thanks for the review, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz
