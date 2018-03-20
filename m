From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Mar 2018 17:07:19 +0100
Subject: [LTP] Redirect old wiki page to new one
In-Reply-To: <20180108111255.GA31448@rei>
References: <20180108083432.5xhfvs4foma3vwcm@dell5510>
 <20180108111255.GA31448@rei>
Message-ID: <20180320160718.GE9226@ai>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I found that some projects [1] point to our old wiki on sourceforge [2].
> > It would be nice to redirect it to new one on github [3] or delete it.
> > 
> > Kind regards,
> > Petr
> > 
> > [1] https://sourceforge.net/p/linux-ima/wiki/Home/
> > [2] http://ltp.sourceforge.net/wiki
> > [3] https://github.com/linux-test-project/ltp/wiki
> 
> I'm afraid that [1] is outside of our controll, the best we can do is to
> try to contact the linux-ima authors.
> 
> But I can to try to add big link on the top of the [2] pointing to [3]
> since we are not in position to fix the rest of the links on the
> internet either. I can try if I actually manage figure out how to do
> that on sf.net, but it's a low prio job.

And I've managed to log in into sf.net and replace the wiki page with a
links to GitHub.

I've also replaced the download link (the big green download button)
that was still pointing to 2015 release with a readme that points to
github release page. Apparently people were still downloading the
tarballs from sf.net, *sigh*.

Anyways it should be all fixed now, if you find a link that points to
the old pages on sf.net just tell me, I will replace it as well.

-- 
chrubis@suse.cz
