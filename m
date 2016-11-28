From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Nov 2016 10:32:36 +0100
Subject: [LTP] [PATCH v3 2/2] testcases/clock_nanosleep01: convert to
 use new test library API
In-Reply-To: <20161125090522.njhmnswdk4sm676b@dell5510>
References: <26cbebb57e3e9df7ed9f76b7ccc67d5f104ad376.1480002155.git-series.pvorel@suse.cz>
 <184a4d332234197dc9c1f61ca24f6f15aea4ee0b.1480002155.git-series.pvorel@suse.cz>
 <20161124164832.GH14986@rei.lan>
 <20161125090522.njhmnswdk4sm676b@dell5510>
Message-ID: <20161128093236.GD32359@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Otherwise this version looks very good. Just keep in mind to keep the
> > lines under 80 characters.
> Right! I'm sorry about being relaxed on this so far.
> Just a question about strings: kernel formatting style [1] says about it:
> > However, never break user-visible strings such as
> > printk messages, because that breaks the ability to grep for them.
> And indeed my using plugin forcing kernel coding style [2] doesn't complain on strings
> So I hope string long up to 90 characters are still ok.

As far as I can tell we do not have any hard rules about this in LTP,
some code splits up the strings, some does not. I personally am trying
to keep things as short as possible while including all important bits
and I'm also avoiding unnecessary levels of indentation which keeps
things under 80 chars most of the time. I tend to split the string if
the line goes too long, which seems to be more or less about 130 chars.

-- 
Cyril Hrubis
chrubis@suse.cz
