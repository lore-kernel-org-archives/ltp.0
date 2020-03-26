From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Mar 2020 14:46:04 +0100
Subject: [LTP] [PATCH 2/2] Avoid zero or negative int results in
 calculations
In-Reply-To: <20200326084504.GB29830@dell5510>
References: <20200324143839.3647c485@daedruan>
 <20200326084504.GB29830@dell5510>
Message-ID: <20200326134603.GA5185@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Define BUF_SIZE smaller than BLOCKSIZE for possitive offset result
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> BTW it significantly prolongs the run, but IMHO ok.

Longer testruns should be avoided unless there is a good reason for it.

-- 
Cyril Hrubis
chrubis@suse.cz
