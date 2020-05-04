From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 May 2020 13:16:39 +0200
Subject: [LTP] LTP release
In-Reply-To: <6d404805-7f60-bd0b-b8e9-8b0c7c120c53@suse.cz>
References: <20200504104907.GA3567@yuki.lan>
 <6d404805-7f60-bd0b-b8e9-8b0c7c120c53@suse.cz>
Message-ID: <20200504111639.GB3567@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > As usually it's about a time to prepare for the May LTP release.
> > 
> > And as usally I will try to focus on finising and merging everything
> > that should land in the upcomming release this week. If there are
> > patches that you think should really be included, please point them out
> > now.
> 
> I'd like to get my LVM patchset into this release:
> https://patchwork.ozlabs.org/project/ltp/list/?series=170417
> 
> And also the fix/coverage extension for connect02:
> https://patchwork.ozlabs.org/project/ltp/patch/20200427145014.3530-1-mdoucha@suse.cz/

I will have a look.

> > Also lastly but not least, please start your pre-release testing
> > procedure to make sure that the latest git HEAD works fine in your
> > environment.
> 
> What's the earliest release date you have in mind?

If possible I would like to freeze the git for anything but fixes at the
end of the week, then we will have at least another week for pre-release
testing and bugfixing.

-- 
Cyril Hrubis
chrubis@suse.cz
