From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Feb 2020 17:45:44 +0100
Subject: [LTP] [PATCH 2/3] Allow acquiring multiple loop devices
In-Reply-To: <20200203152420.GA29586@dell5510>
References: <20200129144913.9889-1-mdoucha@suse.cz>
 <20200129144913.9889-3-mdoucha@suse.cz>
 <20200203152420.GA29586@dell5510>
Message-ID: <20200207164544.GB19681@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > tst_acquire_device__() currently uses a hardcoded filename so only one loop
> > device can be used at a time. Allow setting arbitrary temp filename so that
> > multiple different loop devices can be acquired.
> 
> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Good idea, thanks!
> 
> BTW IMHO DEV_FILE should be #define DEV_FILE "test_dev.%d.img", where %d would
> be PID to fix clash when tests run in paralel (e.g. mkswap01.sh and df01.sh).
> I'll send a patch tomorrow, based on this one.

Huh, do we even attempt to support parallel runs at this point? I doubt
so.

-- 
Cyril Hrubis
chrubis@suse.cz
