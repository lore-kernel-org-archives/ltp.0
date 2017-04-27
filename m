From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Apr 2017 15:10:33 +0200
Subject: [LTP] [RFC PATCH 1/1] config.mk: Explicitly set used C and C++
 standard
In-Reply-To: <20170414122312.22734-1-pvorel@suse.cz>
References: <20170414122312.22734-1-pvorel@suse.cz>
Message-ID: <20170427131032.GB14404@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> IMHO If we really want to require old standard, we should explicitly say which one.
> I suppose passing a flag is appropriate way than to use c89 as CC variable.

Where do we say that we require old standard?

All I can think of is that we should produce portable code, which is
something completely different that sticking to a single C standard
revision...

-- 
Cyril Hrubis
chrubis@suse.cz
