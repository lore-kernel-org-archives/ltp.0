From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Jun 2021 15:43:15 +0200
Subject: [LTP] [Automated-testing] [PATCH 3/4] lib: Introduce concept of
 max_test_runtime
In-Reply-To: <YMDKttIQJfdszYgt@pevik>
References: <20210609114659.2445-1-chrubis@suse.cz>
 <20210609114659.2445-4-chrubis@suse.cz> <YMDBFfCZwYDYwWDg@pevik>
 <YMDC/mjGTXxoq9uH@yuki> <YMDKttIQJfdszYgt@pevik>
Message-ID: <YMDFc+T1WNyy/eMK@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Another option would be to redefine the timeout to be timeout per a
> > fork_testrun() instance, which would make the approach slightly easier
> > in some places, however that would mean either changing default test
> > timeout to much smaller value and annotating all long running tests.
> IMHO slightly better approach to me.
> 
> > Hmm, I guess that annotating all long running tests and changing default
> > timeout may be a good idea regardless this approach.
> +1

I can send a v2 if this approach ends up being prefered...

-- 
Cyril Hrubis
chrubis@suse.cz
