From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Dec 2017 11:20:27 +0100
Subject: [LTP] [RFC PATCH v3 1/5] travis: Add build script and use it in
 travis
In-Reply-To: <20171204204949.GA7318@x230>
References: <20171204122553.15338-1-pvorel@suse.cz>
 <20171204122553.15338-2-pvorel@suse.cz>
 <20171204171510.GE21055@rei> <20171204204949.GA7318@x230>
Message-ID: <20171206102025.GB13979@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I find this output to be a bit too verbose, frankly I do not remeber
> > checking it content of the config.log ever.
> It is verbose. The reason I added it is, that we can check that travis is doing what we
> want (e.g. header / library is really installed / not installed).
> I didn't realize, that include/config.h would be enough and it's much smaller.
> But I suppose you don't want any output in case of successful configure run, do you?

Dumping config.h sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
